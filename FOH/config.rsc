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

# Management Bridge
/interface bridge
add name=bridge

# Add Switch Ports
/interface bridge port
add bridge=bridge interface=ether1
add bridge=bridge interface=ether2
add bridge=bridge interface=ether3
add bridge=bridge interface=ether4
add bridge=bridge interface=ether5
add bridge=bridge interface=ether6
add bridge=bridge interface=ether7
add bridge=bridge interface=ether8
add bridge=bridge interface=ether9
add bridge=bridge interface=ether10
add bridge=bridge interface=ether11
add bridge=bridge interface=ether12
add bridge=bridge interface=ether13
add bridge=bridge interface=ether14
add bridge=bridge interface=ether15
add bridge=bridge interface=ether16
add bridge=bridge interface=ether17
add bridge=bridge interface=ether18
add bridge=bridge interface=ether19
add bridge=bridge interface=ether20
add bridge=bridge interface=ether21
add bridge=bridge interface=ether22
add bridge=bridge interface=ether23
add bridge=bridge interface=ether24
add bridge=bridge interface=sfp-sfpplus1
add bridge=bridge interface=sfp-sfpplus2

