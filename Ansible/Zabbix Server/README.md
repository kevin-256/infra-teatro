# Ansible per installare Zabbix Server, Frontend e Agent 2 con Postgres e Nginx
# Requirements
Aggiungere in ~/.ssh/config
```
Host teatro-zabbix
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

# Impostare il refresh della dashboard a 10 secondi
Dall'interfaccia web: `Dashboards`->`Current problems`->Settings icon->`Refresh interval`->`10 seconds`->`Apply`->`Save Changes`

# Aggiungere Trigger per SNMP traps
Dall'interfaccia web: `Data collection`->`Templates`->`MikroTik CRS326-24G-2S+RM by SNMP`->`Triggers`
Crea nuovo trigger:
- Name: `SNMP traps fallback`
- Severity: `High`
- Expression: `change(/MikroTik CRS326-24G-2SRM by SNMP/snmptrap.fallback)<>0`
- Allow manual close: `Enabled`