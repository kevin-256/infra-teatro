# Ansible per installare Grafana, Prometheus
# Requirements
Aggiungere in ~/.ssh/config
```
Host teatro-monitoring
        Hostname 10.69.10.244
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
