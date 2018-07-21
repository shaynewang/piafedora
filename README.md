# PIA installer for Fedora (UNOFFICIAL)

*Disclaimer: Installation and use of any software made by third party developers is at your own discretion and
liability. I'm sharing all changes made to the official installer and doing my best to make sure. It's safe
to use for fellow fedora users.*

**Pull requests and issues are welcomed here**

[Changelog](CHANGELOG.md).

## Other distros
"drhedberg" reported that the script also works with Opensuse 13.2 by replacing dnf with zypper.
"edouardmenayde" [solution](https://github.com/edouardmenayde/pia-fedora) for v81 support.

## Updated for v81
Based off of the official installer 
[here](https://www.privateinternetaccess.com/installer/download_installer_linux)
I had to do some changes to the original installer to install required packages 
via dnf. Check details below for detailed changes.

### Versions tested

* Fedora 27 Workstation.

Thanks @edouardmenayde for the [solution](https://github.com/edouardmenayde/pia-fedora). 
I was able to put these changes into the installer
to simplify installation process. You can also use this same installer for all ready supported
systems(ubuntu, arch, etc...).

### Instructions
Download installer:

[https://storage.googleapis.com/installers-pia-unofficial/pia-v81-installer-fedora.tar.gz]

Make sure MD5 is: d153b88e20256c53ff4c1ecc4110e535

```
$md5sum pia-v81-installer-fedora.tar.gz 
d153b88e20256c53ff4c1ecc4110e535  pia-v81-installer-fedora.tar.gz
```


then follow official instalation guide 
[here](https://www.privateinternetaccess.com/installer/download_installer_linux)

or
```
tar -xzvf pia-v81-installer-fedora.tar.gz
./pia-v81-installer-fedora.sh
```
then it will prompt for password since it'll install necessary packages via dnf

### Specific Changes
For those of you who care:

In line 155 installer.rb add the following lines:
```
155       elsif system("sudo which dnf > /dev/null 2>&1")
156         command = "sudo dnf install -y GConf2 net-tools libappindicator libXScrnSaver"
157         progress "Running: #{command}"
158         if ! system(command)
159           progress "Package installation failed. Please make sure that your package manager is configured correctly and is still supporte
160           exit 1
161         end
```
These line install dependencies for fedora systems. Official installer supports Pacman(Archlinux). I'm not
sure why fedora is not supported...

## For PIA V61

Automatically setup Private Internet Access VPN v65 for Fedora users. This is an UNOFFICIAL installer that originally was based on the OFFICIAL Ubuntu install script. Feel free to check the src.

## Versions supported.

* Fedora 22 desktop
* Fedora 23 Workstation.
* Fedora 24 Workstation.
* Fedora 25 Workstation.
* Fedora 26 Workstation.
* Fedora 27 Workstation.

It may work with other versions. This script has not been tested with earlier edition Fedora.

_**NOTE**: this script uses dnf._


## Install

```
git clone https://github.com/shaynewang/piafedora.git
cd piafedora
chmod +x install_fedora.sh
sudo ./install_fedora.sh
```
