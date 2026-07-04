# Ansible per installare Zabbix Server, Frontend e Agent 2 con Postgres e Nginx
# Requirements
Aggiungere in ~/.ssh/config
```
Host zabbix-teatro
        Hostname 10.69.10.250
        Username kevin
        IdentityFile ~/.ssh/<chiave ssh>
```

Installare i requirements
```bash
ansible-galaxy collection install -r requirements.yaml
```

## Run Playbook
```bash
ansible-playbook -i inventory.yaml playbook.yaml -K --ssh-common-args='-o StrictHostKeyChecking=accept-new' -v
```

# Login
Username: Admin
Password: zabbix