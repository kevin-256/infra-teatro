# Rustdesk Server
This install Rustdesk server to remote control devices on this networks
## Requirements
Install required roles:
```bash
ansible-galaxy install -r requirements.yml
```
## Run
```bash
ansible-playbook -i inventory.yaml playbook.yaml -K --ssh-common-args='-o StrictHostKeyChecking=accept-new' -v --ask-vault-pass
```
