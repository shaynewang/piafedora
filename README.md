# PIA installer for Fedora

Based on the Ubuntu installer from PIA. Automatically setup Private Internet Access VPN v65 for Fedora users.

[Changelog](CHANGELOG.md).

## Versions supported.

* Fedora 22 desktop
* Fedora 23 Workstation.
* Fedora 24 Workstation.
* Fedora 25 Workstation.

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
