# PIA installer for Fedora

For linux setup please refer to 

[private internet access wensite](https://helpdesk.privateinternetaccess.com/hc/en-us/articles/219438217-Installing-the-PIA-App-on-Linux)





-This script automatically setup Private Interenet Access VPN for Fedora users.

-Fedora has replaced yum package manager with dnf and this script uses dnf.

-This script has not been tested with Eariler edition Fedora. It has been tested on Fedora 22 desktop and Fedora 23 Workstation.

-"drhedberg" reported that the script also works with Opensuse 13.2 by replacing dnf with zypper.

-Featured universal password

Based on the Ubuntu installer from PIA

run

$ git clone https://github.com/shaynewang/piafedora.git

$ cd piafedora

$ chmod +x install_fedora.sh

$ sudo ./install_fedora.sh

