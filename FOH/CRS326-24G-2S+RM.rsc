# =========================
# FOH Switch
# =========================

# Device Name
/system identity set name=FOH-Switch


# Time Zone
/system clock set time-zone-name=Europe/Rome


# Enable NTP
/system ntp client set enabled=yes mode=unicast
/system ntp client servers
add address=ntp1.lab
add address=ntp.ccpm

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
/interface bonding add name=bond_proxmox mode=802.3ad slaves=ether21,ether22 transmit-hash-policy=layer-2-and-3 lacp-rate=1sec
/interface bonding
set bond_proxmox mtu=1500

# Management Bridge and Enabling VLAN Filtering
/interface bridge add name=bridge mtu=1500 protocol-mode=mstp vlan-filtering=yes ingress-filtering=yes


# Add Switch Ports Access
/interface bridge port
add bridge=bridge interface=ether1 pvid=10 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether6 pvid=40 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether7 pvid=40 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether8 pvid=9  frame-types=admit-only-untagged-and-priority-tagged

add bridge=bridge interface=ether12 pvid=60 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether13 pvid=50 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether14 pvid=40 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether15 pvid=30 frame-types=admit-only-untagged-and-priority-tagged
add bridge=bridge interface=ether16 pvid=20 frame-types=admit-only-untagged-and-priority-tagged

add bridge=bridge interface=ether20 pvid=40 frame-types=admit-only-untagged-and-priority-tagged


# Add Switch Ports Trunk
/interface bridge port
add bridge=bridge interface=ether2 ingress-filtering=yes frame-types=admit-only-vlan-tagged
add bridge=bridge interface=ether3 ingress-filtering=yes frame-types=admit-only-vlan-tagged
add bridge=bridge interface=ether4 ingress-filtering=yes frame-types=admit-only-vlan-tagged

add bridge=bridge interface=ether19      ingress-filtering=yes frame-types=admit-only-vlan-tagged
add bridge=bridge interface=bond_proxmox ingress-filtering=yes frame-types=admit-only-vlan-tagged
add bridge=bridge interface=ether23      ingress-filtering=yes frame-types=admit-only-vlan-tagged
add bridge=bridge interface=ether24      ingress-filtering=yes frame-types=admit-only-vlan-tagged

/interface bridge vlan
add bridge=bridge vlan-ids=9  tagged=bridge,ether2,bond_proxmox,ether23,ether24                       untagged=ether8
add bridge=bridge vlan-ids=10 tagged=bridge,ether2,ether3,ether4,ether19,bond_proxmox,ether23,ether24 untagged=ether1
add bridge=bridge vlan-ids=20 tagged=bridge,ether2,ether19,bond_proxmox,ether23                       untagged=ether16
add bridge=bridge vlan-ids=30 tagged=bridge,ether2,ether19,bond_proxmox,ether24                       untagged=ether15
add bridge=bridge vlan-ids=40 tagged=bridge,ether2,ether3,ether4,ether19,bond_proxmox,ether23,ether24 untagged=ether6,ether7,ether14,ether20
add bridge=bridge vlan-ids=50 tagged=bridge,ether2,ether19,bond_proxmox,ether23,ether24               untagged=ether13
add bridge=bridge vlan-ids=60 tagged=bridge,ether2,bond_proxmox,ether23,ether24                       untagged=ether12


# Adding virtual interface 
/interface vlan
add name=wan_vlan09            interface=bridge vlan-id=9
add name=management_vlan10     interface=bridge vlan-id=10
add name=dante_primary_vlan20  interface=bridge vlan-id=20
add name=dante_backup_vlan30   interface=bridge vlan-id=30
add name=mixer_control_vlan40  interface=bridge vlan-id=40
add name=artnet_vlan50         interface=bridge vlan-id=50
add name=video_vlan60          interface=bridge vlan-id=60

/interface list add name=VLANs
/interface list member
add interface=ether2 list=VLANs
add interface=management_vlan10 list=VLANs
add interface=dante_primary_vlan20 list=VLANs
add interface=dante_backup_vlan30 list=VLANs
add interface=mixer_control_vlan40 list=VLANs
add interface=artnet_vlan50 list=VLANs
add interface=video_vlan60 list=VLANs

# Adding ip address to interfaces
/ip address
add address=10.69.10.151/24 comment=defconf interface=management_vlan10    network=10.69.10.0
add address=10.69.20.151/24 comment=defconf interface=dante_primary_vlan20 network=10.69.20.0
add address=10.69.30.151/24 comment=defconf interface=dante_backup_vlan30  network=10.69.30.0
add address=10.69.40.151/24 comment=defconf interface=mixer_control_vlan40 network=10.69.40.0
add address=10.69.50.151/24 comment=defconf interface=artnet_vlan50        network=10.69.50.0
add address=10.69.60.151/24 comment=defconf interface=video_vlan60         network=10.69.60.0

#Adding route to internet
/ip route add dst-address=0.0.0.0/0 gateway=10.69.10.254

#Adding dns
/ip dns set servers=10.69.10.253

# # VRRP
# /interface vrrp
# add name=vrrp_management_vlan10    interface=management_vlan10    vrid=10 priority=150 preemption-mode=yes authentication=ah password=CHANGE_PASSWORD version=2
# add name=vrrp_dante_primary_vlan20 interface=dante_primary_vlan20 vrid=20 priority=150 preemption-mode=yes authentication=ah password=CHANGE_PASSWORD version=2
# add name=vrrp_dante_backup_vlan30  interface=dante_backup_vlan30  vrid=30 priority=150 preemption-mode=yes authentication=ah password=CHANGE_PASSWORD version=2
# add name=vrrp_mixer_control_vlan40 interface=mixer_control_vlan40 vrid=40 priority=150 preemption-mode=yes authentication=ah password=CHANGE_PASSWORD version=2
# add name=vrrp_artnet_vlan50        interface=artnet_vlan50        vrid=50 priority=150 preemption-mode=yes authentication=ah password=CHANGE_PASSWORD version=2
# add name=vrrp_video_vlan60         interface=video_vlan60         vrid=60 priority=150 preemption-mode=yes authentication=ah password=CHANGE_PASSWORD version=2
# #Ip address vRRP
# /ip address
# add address=10.69.10.254/24 comment=defconf interface=vrrp_management_vlan10    network=10.69.10.0
# add address=10.69.20.254/24 comment=defconf interface=vrrp_dante_primary_vlan20 network=10.69.20.0
# add address=10.69.30.254/24 comment=defconf interface=vrrp_dante_backup_vlan30  network=10.69.30.0
# add address=10.69.40.254/24 comment=defconf interface=vrrp_mixer_control_vlan40 network=10.69.40.0
# add address=10.69.50.254/24 comment=defconf interface=vrrp_artnet_vlan50        network=10.69.50.0
# add address=10.69.60.254/24 comment=defconf interface=vrrp_video_vlan60         network=10.69.60.0



# DHCP Server
/ip pool
add name=management_vlan10    ranges=10.69.10.1-10.69.10.50
add name=dante_primary_vlan20 ranges=10.69.20.1-10.69.20.50
add name=dante_backup_vlan30  ranges=10.69.30.1-10.69.30.50
add name=mixer_control_vlan40 ranges=10.69.40.1-10.69.40.50
add name=artnet_vlan50        ranges=10.69.50.1-10.69.50.50
add name=video_vlan60         ranges=10.69.60.1-10.69.60.50

/ip dhcp-server option
add name=cisco-tftp code=150 value=0x0a4528f9

/ip dhcp-server
add name=dhcp_management    interface=management_vlan10    address-pool=management_vlan10    disabled=no
add name=dhcp_dante_primary interface=dante_primary_vlan20 address-pool=dante_primary_vlan20 disabled=no
add name=dhcp_dante_backup  interface=dante_backup_vlan30  address-pool=dante_backup_vlan30  disabled=no
add name=dhcp_mixer_control interface=mixer_control_vlan40 address-pool=mixer_control_vlan40 disabled=no dhcp-option=cisco-tftp,tftp
add name=dhcp_artnet        interface=artnet_vlan50        address-pool=artnet_vlan50        disabled=no
add name=dhcp_video         interface=video_vlan60         address-pool=video_vlan60         disabled=no

/ip dhcp-server network
add address=10.69.10.0/24 gateway=10.69.10.254 dns-server=10.69.10.253
add address=10.69.20.0/24 gateway=10.69.20.254 dns-server=10.69.10.253
add address=10.69.30.0/24 gateway=10.69.30.254 dns-server=10.69.10.253
add address=10.69.40.0/24 gateway=10.69.40.254 dns-server=10.69.10.253
add address=10.69.50.0/24 gateway=10.69.50.254 dns-server=10.69.10.253
add address=10.69.60.0/24 gateway=10.69.60.254 dns-server=10.69.10.253


# Interface Lists
/interface/list add name=MANAGEMENT
/interface/list/member add interface=management_vlan10 list=MANAGEMENT


# Security
/tool/mac-server/set allowed-interface-list=none
/tool/mac-server/mac-winbox set allowed-interface-list=none

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
add name=dante-ptp   dscp=56 pcp=7 traffic-class=7
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

# Dante Multicast (disabled because problems with clock and for now is not useful)
/interface/bridge set [find name=bridge] igmp-snooping=no multicast-querier=yes query-interval=60s
/interface/bridge/port set [find] fast-leave=yes


# SNMP
/snmp set enabled=yes contact="FOH Network" location="FOH Rack"

# Security
/ip firewall filter
add chain=input action=accept connection-state=established,related
add chain=input action=drop connection-state=invalid
# add chain=input action=accept protocol=112 comment="VRRP"
# add chain=input action=accept protocol=ipsec-ah comment="VRRP AH"
add chain=input action=accept in-interface-list=MANAGEMENT comment="ALLOW all from MANAGEMENT"
add chain=input action=drop log=yes log-prefix="DROP input"
add chain=forward connection-state=invalid action=reject
add chain=forward in-interface-list=VLANs action=reject
/ip service
set ssh address=10.69.10.0/24
set winbox address=10.69.10.0/24


# Setup user
/user/add name=kevin password=CHANGE_PASSWORD group=full
/user ssh-keys add user=kevin key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJJAjDDynjl2BiQVuaxuFBF/LkZnEWHYGJsIQjiGbT9"
