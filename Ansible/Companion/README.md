# Companion cluster based on corosync, pacemaker and glusterfs

## Install rtpmidi
Installation of rtpmidi to control midi device remotelly connected. ([Original guide](https://discourse.checkcheckonetwo.com/t/how-to-install-rtpmidi-on-raspberrypi-or-other-linux-sbc/4111))
Get the latest version from [github](https://github.com/davidmoreno/rtpmidid/releases):
```bash
wget https://github.com/davidmoreno/rtpmidid/releases/download/<copy the fyll uri from github above>
sudo dpkg -i rtpmidid*.deb
sudo apt -f install
sudo dpkg -i rtpmidid*.deb
```
