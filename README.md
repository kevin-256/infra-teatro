# Switch Configuration for Dante, Artnet and SQ6 Remote Control

![Network Diagram](Network_diagram.png "Network Diagram")

## wan
**Network**: DHCP\
**VLAN**: 09\
## management
**Network**: 10.69.10.0/24\
**VLAN**: 10\
**Pool DHCP**: 10.69.10.1-100
| ip             | device                 | MAC address |
|----------------|------------------------|-------------|
| 10.69.10.254   | Gateway, DNS           |             |
| 10.69.10.253   | Proxmox                |             |
| 10.69.10.252   | Companion              |             |
| 10.69.10.251   | Centralino             |             |
| 10.69.10.250   | Ubiquiti Controller    |             |
|                |                        |             |
| 10.69.10.162   | Router Palco           |             |
| 10.69.10.161   | Router Regia           |             |
|                |                        |             |
| 10.69.10.153   | Switch Netgear GS305EP |             |
| 10.69.10.152   | Mikrotik Switch Stage  |             |
| 10.69.10.151   | Mikrotik Switch FOH    |             |

## dante_primary
**Network**: 10.69.20.0/24\
**VLAN**: 20\
**Pool DHCP**: 10.69.20.1-100
| ip             | device       | MAC address |
|----------------|--------------|-------------|
| 10.69.20.254   | Gateway, DNS |             |
| 10.69.20.253   | Mixer SQ6    |             |
|                |              |             |
| 10.69.20.101   | StageBox1    |             |
| 10.69.20.102   | StageBox2    |             |

## dante_backup
**Network**: 10.69.30.0/24\
**VLAN**: 30\
**Pool DHCP**: 10.69.30.1-100
| ip             | device       | MAC address |
|----------------|--------------|-------------|
| 10.69.30.254   | Gateway, DNS |             |
| 10.69.30.253   | Mixer SQ6    |             |
|                |              |             |
| 10.69.30.102   | StageBox2    |             |
| 10.69.30.101   | StageBox1    |             |

## mixer_control
**Network**: 10.69.40.0/24\
**VLAN**: 40\
**Pool DHCP**: 10.69.40.1-100
| ip             | device              | MAC address |
|----------------|---------------------|-------------|
| 10.69.40.254   | Gateway, DNS        |             |
| 10.69.40.253   | Mixer SQ6           |             |
| 10.69.40.252   | Companion           |             |
| 10.69.40.251   | Centralino          |             |
| 10.69.40.250   | Ubiquiti Controller |             |
|                |                     |             |
| 10.69.40.163   | Ubiquiti AP         |             |
| 10.69.40.162   | Router Palco        |             |
| 10.69.40.161   | Router Regia        |             |
|                |                     |             |
| 10.69.40.1-100 | Pool DHCP           |             |

> [!NOTE]
> Tablet fabri
> Musicisti
> Centralino

## artnet
**Network**: 10.69.50.0/24\
**VLAN**: 50\
**Pool DHCP**: 10.69.50.1-100
| ip             | device              | MAC address |
|----------------|---------------------|-------------|
| 10.69.50.254   | Gateway, DNS        |             |
| 10.69.50.253   | Mixer SQ6           |             |
| 10.69.50.252   | Companion           |             |
| 10.69.50.251   | Lampy               |             |
|                |                     |             |
| 10.69.50.101   | Mac QLAB            |             |

## video
**Network**: 10.69.60.0/24\
**VLAN**: 60\
**Pool DHCP**: 10.69.60.1-100
| ip             | device              | MAC address |
|----------------|---------------------|-------------|
| 10.69.60.254   | Gateway, DNS        |             |
| 10.69.60.253   | Proiettore          |             |
| 10.69.60.252   | Companion           |             |