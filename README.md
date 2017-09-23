# PIA installer for Fedora (UNOFFICIAL)

Automatically setup Private Internet Access VPN v65 for Fedora users. This is an UNOFICIAL installer that originally was based on the OFICCIAL Ubuntu install script. Feel free to check the src.

[Changelog](CHANGELOG.md).

## Versions supported.

* Fedora 22 desktop
* Fedora 23 Workstation.
* Fedora 24 Workstation.
* Fedora 25 Workstation.
* Fedora 26 Workstation.

It may work with other versions. This script has not been tested with Eariler edition Fedora.

_**NOTE**: this script uses dnf._

## Other distros
"drhedberg" reported that the script also works with Opensuse 13.2 by replacing dnf with zypper.

# Install

```
git clone https://github.com/shaynewang/piafedora.git
cd piafedora
chmod +x install_fedora.sh
sudo ./install_fedora.sh
```
