# Ansible per installare Bind9 DNS
# Requirements
Aggiungere in ~/.ssh/config
```
Host teatro-bind9
        Hostname 10.69.10.253
        Username kevin
        IdentityFile ~/.ssh/<chiave ssh>
```

Installare i requirements
```bash
ansible-galaxy install -r requirements.yaml
```

## Run Playbook
```bash
ansible-playbook -i inventory.yaml playbook.yaml -K --ssh-common-args='-o StrictHostKeyChecking=accept-new' -v
```
