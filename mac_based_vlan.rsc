/interface bridge
add name=br-masterport protocol-mode=none
add name=br-infra-20-vlan-wlan
add name=br-users-30-vlan-wlan
add name=br-guests-40-vlan-wlan
/interface vlan
add interface=br-masterport loop-protect=on name=vlan-mgmt-10 vlan-id=10
add interface=br-masterport loop-protect=on name=vlan-infra-20 vlan-id=20
add interface=br-masterport loop-protect=on name=vlan-users-30 vlan-id=30
add interface=br-masterport loop-protect=on name=vlan-guests-40 vlan-id=40
/ip address
add address=192.168.10.1/24 interface=vlan-mgmt-10 network=192.168.10.0
add address=192.168.20.1/24 interface=br-infra-20-vlan-wlan network=192.168.20.0
add address=192.168.30.1/24 interface=br-users-30-vlan-wlan network=192.168.30.0
add address=192.168.40.1/24 interface=br-guests-40-vlan-wlan network=192.168.40.0
/ip pool
add name=pool-vpn ranges=192.168.3.2-192.168.3.254
add name=pool-vlan-infra-20 ranges=192.168.20.2-192.168.20.254
add name=pool-vlan-users-30 ranges=192.168.30.3-192.168.30.254
add name=pool-vlan-guests-40 ranges=192.168.40.2-192.168.40.254
/ip dhcp-server
add address-pool=pool-vlan-infra-20 disabled=no interface=br-infra-20-vlan-wlan lease-time=1d name=dhcp-vlan-infra-20
add address-pool=pool-vlan-users-30 disabled=no interface=br-users-30-vlan-wlan lease-time=1d name=dhcp-vlan-users-30
add address-pool=pool-vlan-guests-40 disabled=no interface=br-guests-40-vlan-wlan name=dhcp-vlan-guests-40
/ip dhcp-server network
add address=192.168.3.0/24 dns-server=1.1.1.1,1.0.0.1 gateway=192.168.3.1
add address=192.168.20.0/24 dns-server=1.1.1.1,1.0.0.1 gateway=192.168.20.1
add address=192.168.30.0/24 dns-server=1.1.1.1,1.0.0.1 gateway=192.168.30.1
add address=192.168.40.0/24 dns-server=1.1.1.1,1.0.0.1 gateway=192.168.40.1
/ip dhcp-server lease
add server=dhcp-vlan-infra-20 mac-address=00:11:22:33:44:55 address=192.168.20.2 comment=nasexample
/interface bridge port
add bridge=br-infra-20-vlan-wlan interface=vlan-infra-20
add bridge=br-infra-20-vlan-wlan interface=wlan-infra-20
add bridge=br-users-30-vlan-wlan interface=vlan-users-30
add bridge=br-users-30-vlan-wlan interface=wlan-users-30
add bridge=br-guests-40-vlan-wlan interface=vlan-guests-40
add bridge=br-guests-40-vlan-wlan interface=wlan-guests-40
add bridge=br-masterport interface=ether2
add bridge=br-masterport interface=ether3
add bridge=br-masterport interface=ether4
add bridge=br-masterport interface=ether5
add bridge=br-masterport interface=ether6
add bridge=br-masterport interface=ether7
add bridge=br-masterport interface=ether8
add bridge=br-masterport interface=ether9
add bridge=br-masterport interface=ether10
add bridge=br-masterport interface=ether11
add bridge=br-masterport interface=ether12
add bridge=br-masterport interface=ether13
add bridge=br-masterport interface=ether14
add bridge=br-masterport interface=ether15
add bridge=br-masterport interface=ether16
add bridge=br-masterport interface=ether17
add bridge=br-masterport interface=ether18
add bridge=br-masterport interface=ether19
add bridge=br-masterport interface=ether20
add bridge=br-masterport interface=ether21
add bridge=br-masterport interface=ether22
add bridge=br-masterport interface=ether23
add bridge=br-masterport interface=ether24
/ip firewall nat
add action=dst-nat chain=dstnat comment=PlexPortForward dst-port=32400 in-interface=ether1 protocol=tcp to-addresses=192.168.20.2
add action=masquerade chain=srcnat comment="PAT VLAN10" out-interface=ether1 src-address=192.168.10.0/24
add action=masquerade chain=srcnat comment="PAT VLAN20" out-interface=ether1 src-address=192.168.20.0/24
add action=masquerade chain=srcnat comment="PAT VLAN30" out-interface=ether1 src-address=192.168.30.0/24
add action=masquerade chain=srcnat comment="PAT VLAN40" out-interface=ether1 src-address=192.168.40.0/24
/ip firewall filter
add action=accept chain=input comment="Allow connections originated from our network" connection-state=established,related
add action=accept chain=input comment=PPTP dst-port=1723 in-interface=ether1 log=yes protocol=tcp
add action=drop chain=input comment="Block Winbox in the public interface" dst-port=8291 in-interface=ether1 log=yes log-prefix="Internet Winbox" protocol=tcp
add action=drop chain=input
/interface ethernet switch port
set 2 allow-fdb-based-vlan-translate=yes
set 3 allow-fdb-based-vlan-translate=yes
set 4 allow-fdb-based-vlan-translate=yes
set 5 allow-fdb-based-vlan-translate=yes
set 6 allow-fdb-based-vlan-translate=yes
set 7 allow-fdb-based-vlan-translate=yes
set 8 allow-fdb-based-vlan-translate=yes
set 9 allow-fdb-based-vlan-translate=yes
set 10 allow-fdb-based-vlan-translate=yes
set 11 allow-fdb-based-vlan-translate=yes
set 12 allow-fdb-based-vlan-translate=yes
set 13 allow-fdb-based-vlan-translate=yes
set 14 allow-fdb-based-vlan-translate=yes
set 15 allow-fdb-based-vlan-translate=yes
set 16 allow-fdb-based-vlan-translate=yes
set 17 allow-fdb-based-vlan-translate=yes
set 18 allow-fdb-based-vlan-translate=yes
set 19 allow-fdb-based-vlan-translate=yes
set 20 allow-fdb-based-vlan-translate=yes
set 21 allow-fdb-based-vlan-translate=yes
set 22 allow-fdb-based-vlan-translate=yes
set 24 allow-fdb-based-vlan-translate=yes
set 25 allow-fdb-based-vlan-translate=yes
/interface ethernet switch mac-based-vlan
add new-customer-vid=20 src-mac-address=11:22:33:44:55:66 comment="nasexample"
/interface ethernet switch egress-vlan-tag
add tagged-ports=ether24,switch1-cpu vlan-id=10
add tagged-ports=ether24,switch1-cpu vlan-id=20
add tagged-ports=ether24,switch1-cpu vlan-id=30
add tagged-ports=ether24,switch1-cpu vlan-id=40
/interface ethernet switch vlan
add ports="ether2,ether3,ether4,ether5,ether6,ether7,ether8,ether9,ether10,ether11,ether12,ether13,ether14,ether15,ether16,ether17,ether18,ether19,ether20,ether21,ether22,ether23,ether24,switch1-cpu" vlan-id=20
add ports="ether2,ether3,ether4,ether5,ether6,ether7,ether8,ether9,ether10,ether11,ether12,ether13,ether14,ether15,ether16,ether17,ether18,ether19,ether20,ether21,ether22,ether23,ether24,switch1-cpu" vlan-id=30
add ports="ether2,ether3,ether4,ether5,ether6,ether7,ether8,ether9,ether10,ether11,ether12,ether13,ether14,ether15,ether16,ether17,ether18,ether19,ether20,ether21,ether22,ether23,ether24,switch1-cpu" vlan-id=40