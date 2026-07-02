# Ansible per installare Zabbix Server, Frontend e Agent 2 con Postgres e Nginx
# Requirements
Aggiungere in ~/.ssh/config
```
Host zabbix-teatro
        Hostname 10.69.10.250
        Username kevin
        IdentityFile ~/.ssh/<chiave ssh>
```

Installare la collezione 
```bash
ansible-galaxy collection install community.postgresql
```