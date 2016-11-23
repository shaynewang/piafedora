#! /bin/sh -
#
# Install OpenVPN connections for all available
# regions to NetworkManager
#
# Requirements:
#   should be run as root
#   python and openvpn (will be installed if not present)
#
# Usage:
#  install [--version]

IFS='
	 '
SERVER_INFO=/tmp/server_info
SPLIT_TOKEN=':'

error( )
{
  echo "$@" 1>&2
  exit 1
}

error_and_usage( )
{
  echo "$@" 1>&2
  usage_and_exit 1
}

usage( )
{
  echo "Usage: sudo `dirname $0`/$PROGRAM"
}

usage_and_exit( )
{
  usage
  exit $1
}

version( )
{
  echo "$PROGRAM version $VERSION"
}

read_user_login( )
{
  echo -n "Please enter your login: "
  read LOGIN
  if [ -z $LOGIN ]; then
    error "A login must be provided for the installation to proceed"
  fi

  echo "Do you want to include your password?"

  select yn in "Yes" "No"; do
	  case $yn in
		  "Yes" )	echo -n "Please enter your password: "
				read PASS
				break;;
		  "No" )	exit;;
	  esac
  done

  echo $PASS
}

verify_running_as_root( )
{
  if [ `/usr/bin/id -u` -ne 0 ]; then
      error_and_usage "$0 must be run as root"
  fi
}

install_python_version( )
{
  if ! python -V; then
    echo -n 'Package python2.7 required. Install? (y/n): '
    read install_python
    if [ $install_python = 'y' ]; then
      echo "Installing python2.7.."
      if ! dnf install python; then
        error "Error installing python2.7 Aborting.."
      fi
    else
      error "Package python2.7 is required for installation. Aborting.."
    fi
  else
    echo "Package python2.7 already installed"
  fi
}

install_open_vpn( )
{
  if ! dnf search NetworkManager-openvpn-gnome; then
    echo -n 'Package NetworkManager-openvpn-gnome required. Install? (y/n): '
    read install_openvpn
    if [ $install_openvpn = 'y' ]; then
      echo "Installing network-manager-openvpn.."
      if ! dnf install NetworkManager-openvpn-gnome; then
        error "Error installing network-manager-openvpn. Aborting.."
      fi
    else
      error "Package network-manager-openvpn is required for installation. Aborting.."
    fi
  else
    echo "Package network-manager-openvpn already installed"
  fi
}

install_crt( )
{
  echo 'Downloading certificate..'
  wget -O - https://www.privateinternetaccess.com/openvpn/openvpn.zip > /tmp/openvpn.zip
  echo 'Installing certificate..'
  mkdir -p /etc/openvpn
  unzip -p /tmp/openvpn.zip ca.rsa.2048.crt > /etc/openvpn/ca.rsa.2048.crt
}

fix_conflict( )
{
  semanage fcontext -a -t home_cert_t /etc/openvpn/ca.rsa.2048.crt
  restorecon -R -v /etc/openvpn/ca.rsa.2048.crt
}

parse_server_info( )
{
  echo 'Loading servers information..'
  json=`wget -q -O - 'https://privateinternetaccess.com/vpninfo/servers?version=24' | head -1`

  python > $SERVER_INFO <<EOF
payload = '$json'
import json
d = json.loads(payload)
print "\n".join([d[k]['name']+'$SPLIT_TOKEN'+d[k]['dns'] for k in d.keys() if k != 'info'])
EOF
}

write_config_files( )
{
  echo 'Removing previous config files if existing..'
  rm -f /etc/NetworkManager/system-connections/PIA\ -\ *

  echo 'Creating config files..'
  IFS='
'
  while read server_info; do
    name="PIA - `echo $server_info | awk -F: '{print $1}'`"
    dns=`echo $server_info | awk -F: '{print $2}'`
    cat <<EOF > /etc/NetworkManager/system-connections/$name
[connection]
id=$name
uuid=`uuidgen`
type=vpn
autoconnect=false

[vpn]
service-type=org.freedesktop.NetworkManager.openvpn
username=$LOGIN
comp-lzo=yes
remote=$dns
connection-type=password
password-flags=0
ca=/etc/openvpn/ca.rsa.2048.crt
cipher=AES-128-CBC
port=1198

[vpn-secrets]
password=$PASS

[ipv4]
method=auto
EOF
  chmod 600 /etc/NetworkManager/system-connections/$name
  done < $SERVER_INFO
  rm $SERVER_INFO
  IFS='
 	'
}

restart_network_manager( )
{
  echo 'Restarting network manager..'
  systemctl restart NetworkManager
}

EXITCODE=0
PROGRAM=`basename $0`
VERSION=1.0

while test $# -gt 0
do
  case $1 in
  --usage | --help | -h )
    usage_and_exit 0
    ;;
  --version | -v )
    version
    exit 0
    ;;
  *)
    error_and_usage "Unrecognized option: $1"
    ;;
  esac
  shift
done


verify_running_as_root
install_python_version
install_open_vpn
read_user_login
install_crt
fix_conflict
parse_server_info
write_config_files
restart_network_manager

echo "Install successful!"
exit 0
