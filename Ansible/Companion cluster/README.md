# Companion cluster based on corosync, pacemaker and glusterfs

## ✅ Checks before running the Playbook
Before running the ansible check this thins:
- [ ] check the data disk
    - [ ] there is another disk (*data disk*) other than the one wich the machine boots
    - [ ] the *data disk* is mounted on /dev/sdb

## Running Ansible Playbook
After checking the things above set the variables in [inventory.yaml](inventory.yaml) run the playbook with
```bash
ansible-playbook playbook.yaml -i inventory.yaml -K --ssh-common-args='-o StrictHostKeyChecking=accept-new' -v
```

## Optional Install rtpmidi
Installation of rtpmidi to control midi device remotelly connected. ([Original guide](https://discourse.checkcheckonetwo.com/t/how-to-install-rtpmidi-on-raspberrypi-or-other-linux-sbc/4111))
Get the latest version from [github](https://github.com/davidmoreno/rtpmidid/releases):
```bash
wget https://github.com/davidmoreno/rtpmidid/releases/download/<copy the fyll uri from github above>
sudo dpkg -i rtpmidid*.deb
sudo apt -f install
sudo dpkg -i rtpmidid*.deb
```
