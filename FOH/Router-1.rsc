# =========================
# FOH Router 1
# =========================

# Device Name
/system identity set name=FOH-Router-1
/system clock set time-zone-name=Europe/Rome

/system ntp client set enabled=yes mode=unicast
/system ntp client servers
add address=ntp1.lab
add address=ntp.ccpm

#interfaces
/interface ethernet
set [find default-name=ether1] name=wan
set [find default-name=ether2] name=management
set [find default-name=ether3] name=dante_primary
set [find default-name=ether4] name=dante_backup
set [find default-name=ether5] name=mixer_control
set [find default-name=ether6] name=artnet
set [find default-name=ether7] name=video

#VRRP interfaces
/interface vrrp
add name=vrrp_management     interface=management     vrid=10 priority=254 preemption-mode=no sync-connection-tracking=yes group-authority=self

add name=vrrp_dante_primary  interface=dante_primary  vrid=20 group-authority=vrrp_management
add name=vrrp_dante_backup   interface=dante_backup   vrid=30 group-authority=vrrp_management
add name=vrrp_mixer_control  interface=mixer_control  vrid=40 group-authority=vrrp_management
add name=vrrp_artnet         interface=artnet         vrid=50 group-authority=vrrp_management
add name=vrrp_video          interface=video          vrid=60 group-authority=vrrp_management


/interface vrrp
set vrrp_management sync-connection-tracking=yes

#Interfaces IP addresses
/ip address
add address=10.69.10.221/24 interface=management     comment="Management Physical IP"
add address=10.69.20.221/24 interface=dante_primary
add address=10.69.30.221/24 interface=dante_backup
add address=10.69.40.221/24 interface=mixer_control
add address=10.69.50.221/24 interface=artnet
add address=10.69.60.221/24 interface=video

add address=10.69.10.254/32 interface=vrrp_management     comment="Gateway Management Gateway"
add address=10.69.20.254/32 interface=vrrp_dante_primary  comment="Gateway Dante Primary Gateway"
add address=10.69.30.254/32 interface=vrrp_dante_backup   comment="Gateway Dante Backup Gateway"
add address=10.69.40.254/32 interface=vrrp_mixer_control  comment="Gateway Mixer Control Gateway"
add address=10.69.50.254/32 interface=vrrp_artnet         comment="Gateway Art-Net Gateway"
add address=10.69.60.254/32 interface=vrrp_video          comment="Gateway Video Gateway"

#Adding dns
/ip dns set servers=10.69.10.253

#DHCP on WAN interface
/ip dhcp-client
add interface=wan disabled=no

#Static address on WAN
# /ip address
# add address=<WAN-IP>/<PREFIX> interface=wan

# /ip route
# add dst-address=0.0.0.0/0 gateway=<WAN-GATEWAY>

#Firewall
/interface list
add name=LAN
add name=MANAGEMENT

/interface list member
add interface=management     list=LAN
add interface=dante_primary  list=LAN
add interface=dante_backup   list=LAN
add interface=mixer_control  list=LAN
add interface=artnet         list=LAN
add interface=video          list=LAN
add interface=management     list=MANAGEMENT


/ip firewall connection
tracking set enabled=yes

/ip firewall nat
add chain=srcnat out-interface=wan action=masquerade

/ip firewall filter
add chain=forward   action=fasttrack-connection connection-state=established,related comment="FASTTRACK established/related"
add chain=input     action=accept connection-state=established,related
add chain=input     action=drop connection-state=invalid
add chain=input     action=accept in-interface=management comment="Router management from management VLAN"
add chain=input     action=drop log=yes log-prefix="DROP INPUT"
add chain=forward   action=accept connection-state=established,related comment="Established/related"
add chain=forward   action=drop connection-state=invalid
add chain=forward   action=accept in-interface=management out-interface-list=LAN
add chain=forward   action=accept in-interface-list=LAN  out-interface=wan comment="LAN -> Internet"
add chain=forward   action=drop in-interface-list=LAN out-interface-list=LAN log=yes log-prefix="BLOCK INTER-VLAN"
add chain=forward   action=drop log=yes log-prefix="DROP FORWARD"

/ip service
set ssh address=10.69.10.0/24
set winbox address=10.69.10.0/24

# SNMP
/snmp set enabled=yes contact="Management Network" location="FOH Rack" trap-generators=interfaces,temp-exception trap-interfaces=all trap-target=10.69.10.244 trap-version=2

# Setup user
/user/add name=kevin password=CHANGE_PASSWORD group=full
/user ssh-keys add user=kevin key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJJAjDDynjl2BiQVuaxuFBF/LkZnEWHYGJsIQjiGbT9"
