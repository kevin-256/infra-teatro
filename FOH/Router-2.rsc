# =========================
# FOH Router-2
# =========================

# Device Name
/system identity set name=FOH-Router-2
/system clock set time-zone-name=Europe/Rome

/system ntp server set enabled=yes manycast=no

/system ntp client set enabled=yes mode=unicast
/system ntp client servers
add address=ntp.ccpm
add address=0.pool.ntp.org
add address=1.pool.ntp.org
add address=ntp1.lab

# VLAN Interfaces on ether1
/interface vlan
add name=vlan09_wan           vlan-id=9  interface=ether1
add name=vlan10_management    vlan-id=10 interface=ether1
add name=vlan20_dante_primary vlan-id=20 interface=ether1
add name=vlan30_dante_backup  vlan-id=30 interface=ether1
add name=vlan40_mixer_control vlan-id=40 interface=ether1
add name=vlan50_artnet        vlan-id=50 interface=ether1
add name=vlan60_video         vlan-id=60 interface=ether1

# VRRP Interfaces
/interface vrrp
add name=vrrp_management    interface=vlan10_management    vrid=10 priority=128 preemption-mode=no sync-connection-tracking=yes group-authority=self
add name=vrrp_dante_primary interface=vlan20_dante_primary vrid=20 group-authority=vrrp_management
add name=vrrp_dante_backup  interface=vlan30_dante_backup  vrid=30 group-authority=vrrp_management
add name=vrrp_mixer_control interface=vlan40_mixer_control vrid=40 group-authority=vrrp_management
add name=vrrp_artnet        interface=vlan50_artnet        vrid=50 group-authority=vrrp_management
add name=vrrp_video         interface=vlan60_video         vrid=60 group-authority=vrrp_management


/interface vrrp
set vrrp_management sync-connection-tracking=yes

# Interfaces IP addresses
/ip address
add address=10.69.10.222/24 interface=vlan10_management    comment="Management Physical IP"
add address=10.69.20.222/24 interface=vlan20_dante_primary
add address=10.69.30.222/24 interface=vlan30_dante_backup
add address=10.69.40.222/24 interface=vlan40_mixer_control
add address=10.69.50.222/24 interface=vlan50_artnet
add address=10.69.60.222/24 interface=vlan60_video

add address=10.69.10.254/32 interface=vrrp_management     comment="Gateway Management Gateway"
add address=10.69.20.254/32 interface=vrrp_dante_primary  comment="Gateway Dante Primary Gateway"
add address=10.69.30.254/32 interface=vrrp_dante_backup   comment="Gateway Dante Backup Gateway"
add address=10.69.40.254/32 interface=vrrp_mixer_control  comment="Gateway Mixer Control Gateway"
add address=10.69.50.254/32 interface=vrrp_artnet         comment="Gateway Art-Net Gateway"
add address=10.69.60.254/32 interface=vrrp_video          comment="Gateway Video Gateway"

#Adding dns
/ip dns set servers=10.69.10.253

#DHCP on WAN interface
# ip dhcp-client
# add interface=wan disabled=no

#Static address on WAN
# /ip address
# add address=<WAN-IP>/<PREFIX> interface=wan

# /ip route
# add dst-address=0.0.0.0/0 gateway=<WAN-GATEWAY>

# Interface Lists
/interface list
add name=LAN
add name=MANAGEMENT
add name=WAN

/interface list member
add interface=vlan09_wan           list=WAN
add interface=vlan10_management    list=LAN
add interface=vlan20_dante_primary list=LAN
add interface=vlan30_dante_backup  list=LAN
add interface=vlan40_mixer_control list=LAN
add interface=vlan50_artnet        list=LAN
add interface=vlan60_video         list=LAN
add interface=vrrp_dante_primary   list=LAN
add interface=vrrp_dante_backup    list=LAN
add interface=vrrp_mixer_control   list=LAN
add interface=vrrp_artnet          list=LAN
add interface=vrrp_video           list=LAN
add interface=vrrp_management      list=LAN
add interface=vrrp_management      list=MANAGEMENT
add interface=vlan10_management    list=MANAGEMENT


# Firewall & Connection Tracking
/ip firewall connection
tracking set enabled=yes

/ip firewall nat
add chain=srcnat out-interface-list=WAN action=masquerade comment="NAT for Internet access"

/ip firewall filter
remove [find dynamic=no]
# add chain=forward   action=fasttrack-connection connection-state=established,related comment="FASTTRACK established/related"
add chain=input     action=accept connection-state=established,related
add chain=input     action=drop connection-state=invalid
add chain=input     action=accept in-interface-list=MANAGEMENT comment="Router management from management VLAN"
add chain=input     action=drop log=yes log-prefix="DROP INPUT"
add chain=forward   action=accept connection-state=established,related comment="Established/related"
add chain=forward   action=drop connection-state=invalid
add chain=forward   action=accept in-interface-list=MANAGEMENT out-interface-list=LAN
add chain=forward   action=accept in-interface-list=LAN out-interface-list=WAN comment="LAN -> Internet"
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