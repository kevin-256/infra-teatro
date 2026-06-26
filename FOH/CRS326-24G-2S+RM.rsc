# =========================
# FOH Switch
# =========================

# Device Name
/system identity set name=FOH-Switch


# Time Zone
/system clock set time-zone-name=Europe/Rome


# Enable NTP
/system ntp client set enabled=yes


# NTP Servers
/system ntp client servers
add address=time.cloudflare.com
add address=time.google.com
add address=ntp1.lab

# Interface Lists
/interface/list add name=MANAGEMENT
/interface/list/member add interface=management_vlan10 list=MGMT

# Disabling useless ports
/interface ethernet set ether5 disabled=yes

/interface ethernet set ether9 disabled=yes
/interface ethernet set ether10 disabled=yes
/interface ethernet set ether11 disabled=yes

/interface ethernet set ether17 disabled=yes
/interface ethernet set ether18 disabled=yes

/interface ethernet set sfp-sfpplus1 disabled=yes
/interface ethernet set sfp-sfpplus2 disabled=yes


# Link Aggregation interfaces
/interface bonding add name=bond_proxmox mode=balance-tlb slaves=ether21,ether22 primary=ether21


# Management Bridge
/interface bridge add name=bridge


# Add Switch Ports Access
/interface bridge port
add bridge=bridge interface=ether6 pvid=40 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether7 pvid=40 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether8 pvid=9  frame-types=admit-only-untagged-and-priority-tagged

add bridge=bridge interface=ether12 pvid=60 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether13 pvid=50 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether14 pvid=40 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether15 pvid=30 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether16 pvid=20 frame-types=admit-only-untagged-and-priority-tagged

add bridge=bridge interface=ether20 pvid=40 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether24 pvid=20 frame-types=admit-only-untagged-and-priority-tagged


# Add Switch Ports Trunk
/interface bridge port
add bridge=bridge interface=ether2 frame-types=admit-only-vlan-tagged
add bridge=bridge interface=ether3 frame-types=admit-only-vlan-tagged
add bridge=bridge interface=ether4 frame-types=admit-only-vlan-tagged

add bridge=bridge interface=ether19      frame-types=admit-only-vlan-tagged
add bridge=bridge interface=bond_proxmox frame-types=admit-only-vlan-tagged
add bridge=bridge interface=ether23      frame-types=admit-only-vlan-tagged

/interface bridge vlan
add bridge=bridge vlan-ids=9  tagged=bridge,ether2,bond_proxmox
add bridge=bridge vlan-ids=10 tagged=bridge,ether2,ether3,ether4,ether19,bond_proxmox,ether23
add bridge=bridge vlan-ids=20 tagged=bridge,ether2,ether19,bond_proxmox
add bridge=bridge vlan-ids=30 tagged=bridge,ether2,ether19,bond_proxmox
add bridge=bridge vlan-ids=40 tagged=bridge,ether2,ether3,ether4,ether19,bond_proxmox,ether23
add bridge=bridge vlan-ids=50 tagged=bridge,ether2,ether19,bond_proxmox,ether23
add bridge=bridge vlan-ids=60 tagged=bridge,ether2,bond_proxmox


# Adding virtual interface 
/interface vlan
add name=wan_vlan09            interface=bridge vlan-id=9
add name=management_vlan10     interface=bridge vlan-id=10
add name=dante_primary_vlan20  interface=bridge vlan-id=20
add name=dante_backup_vlan30   interface=bridge vlan-id=30
add name=mixer_control_vlan40  interface=bridge vlan-id=40
add name=artnet_vlan50         interface=bridge vlan-id=50
add name=video_vlan60          interface=bridge vlan-id=60


# Enabling VLAN Filtering
/interface bridge
set bridge vlan-filtering=yes


# Security
# set configuration only from MANAGEMENT
/tool/mac-server/set allowed-interface-list=MANAGEMENT
/tool/mac-server/mac-winbox set allowed-interface-list=MANAGEMENT

# disable discovery
/ip/neighbor/discovery-settings/set discover-interface-list=none

# disable bandwidth server
/tool/bandwidth-server/set enabled=no 

# disable caching proxy
/ip/proxy/set enabled=no

# disable SOCKS
/ip/socks/set enabled=no

# disable UPnP
/ip/upnp/set enabled=no

# disable MikroTik Cloud services
/ip/cloud/set ddns-enabled=auto update-time=no

# disable useless services
/ip/service/disable telnet,ftp

# enable more secure SSH access
/ip/ssh/set strong-crypto=yes


# QOS
# QoS profiles to match Dante traffic classes
/interface/ethernet/switch/qos/profile
add name=dante-ptp dscp=56 pcp=7 traffic-class=7
add name=dante-audio dscp=46 pcp=5 traffic-class=5

# Hardware queue to enforce QoS on Dante traffic
/interface/ethernet/switch/qos/tx-manager/queue
set [find where traffic-class=7] schedule=strict-priority
set [find where traffic-class=5] schedule=strict-priority

# Enable trust mode for incoming Layer 3 packets (IP DSCP field)
/interface/ethernet/switch/qos/port
set [find] trust-l3=keep

# Enable QoS hardware offloading
/interface/ethernet/switch
set switch1 qos-hw-offloading=yes

# Only for Dante Multicast
# /interface/bridge
# set [find name=bridge] igmp-snooping=yes multicast-querier=yes query-interval=60s
# /interface/bridge/port
# set [find] fast-leave=yes


# SNMP
/snmp/set enabled=yes location="Front of House"
/snmp community add name=public addresses=10.69.10.0/24 read-access=yes

# Setup user
/user/add name=kevin password=CHANGE_THIS_PASSWORD group=full
