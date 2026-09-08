# =========================
# FOH Router
# =========================

# Device Name
/system identity set name=FOH-Router
/system clock set time-zone-name=Europe/Rome

/system ntp client set enabled=yes mode=unicast
/system ntp client servers
add address=ntp1.lab
add address=ntp.ccpm

#VLAN interfaces
/interface vlan
add name=wan_vlan09 interface=ether1 vlan-id=9
add name=management_vlan10 interface=ether1 vlan-id=10
add name=dante_primary_vlan20 interface=ether1 vlan-id=20
add name=dante_backup_vlan30 interface=ether1 vlan-id=30
add name=mixer_control_vlan40 interface=ether1 vlan-id=40
add name=artnet_vlan50 interface=ether1 vlan-id=50
add name=video_vlan60 interface=ether1 vlan-id=60

#Interfaces IP addresses
/ip address
add address=10.69.10.254/24 interface=management_vlan10 comment="Management Gateway"
add address=10.69.20.254/24 interface=dante_primary_vlan20 comment="Dante Primary Gateway"
add address=10.69.30.254/24 interface=dante_backup_vlan30 comment="Dante Backup Gateway"
add address=10.69.40.254/24 interface=mixer_control_vlan40 comment="Mixer Control Gateway"
add address=10.69.50.254/24 interface=artnet_vlan50 comment="Art-Net Gateway"
add address=10.69.60.254/24 interface=video_vlan60 comment="Video Gateway"

#Adding dns
/ip dns set servers=10.69.10.253

#DHCP on WAN interface
/ip dhcp-client
add interface=wan_vlan09 disabled=no

#Static address on WAN
# /ip address
# add address=<WAN-IP>/<PREFIX> interface=wan_vlan09

# /ip route
# add dst-address=0.0.0.0/0 gateway=<WAN-GATEWAY>

#Firewall
/interface list
add name=LAN
add name=MANAGEMENT

/interface list member
add interface=management_vlan10 list=LAN
add interface=dante_primary_vlan20 list=LAN
add interface=dante_backup_vlan30 list=LAN
add interface=mixer_control_vlan40 list=LAN
add interface=artnet_vlan50 list=LAN
add interface=video_vlan60 list=LAN
add interface=management_vlan10 list=MANAGEMENT


/ip firewall nat
add chain=srcnat out-interface=wan_vlan09 action=masquerade

/ip firewall filter
add chain=forward action=fasttrack-connection connection-state=established,related comment="FASTTRACK established/related"
add chain=input action=accept connection-state=established,related
add chain=input action=drop connection-state=invalid
add chain=input action=accept in-interface=management_vlan10 comment="Router management from management VLAN"
add chain=input action=drop log=yes log-prefix="DROP INPUT"
add chain=forward action=accept connection-state=established,related comment="Established/related"
add chain=forward action=drop connection-state=invalid
add chain=forward action=accept in-interface=management_vlan10 out-interface-list=LAN
add chain=forward action=accept in-interface-list=LAN  out-interface=wan_vlan09 comment="LAN -> Internet"
add chain=forward action=drop in-interface-list=LAN out-interface-list=LAN log=yes log-prefix="BLOCK INTER-VLAN"
add chain=forward action=drop log=yes log-prefix="DROP FORWARD"

/ip service
set ssh address=10.69.10.0/24
set winbox address=10.69.10.0/24

# SNMP
/snmp set enabled=yes contact="Management Network" location="FOH Rack" trap-generators=interfaces,temp-exception trap-interfaces=all trap-target=10.69.10.244 trap-version=2

# Setup user
/user/add name=kevin password=CHANGE_PASSWORD group=full
/user ssh-keys add user=kevin key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJJAjDDynjl2BiQVuaxuFBF/LkZnEWHYGJsIQjiGbT9"