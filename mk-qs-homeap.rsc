/interface bridge add name=bridge
/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n channel-width=20/40mhz-Ce disabled=no distance=indoors frequency=auto mode=ap-bridge ssid=MikroTik-920A8D wireless-protocol=802.11
/interface list
add name=WAN
add name=LAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool add name=default-dhcp ranges=192.168.88.10-192.168.88.254
/ip dhcp-server add address-pool=default-dhcp disabled=no interface=bridge name=defconf
/interface bridge port
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
add bridge=bridge interface=sfp1
add bridge=bridge interface=wlan1
/ip neighbor discovery-settings set discover-interface-list=LAN
/interface list member
add interface=bridge list=LAN
add interface=ether1 list=WAN
/ip address add address=192.168.88.1/24 interface=bridge network=192.168.88.0
/ip dhcp-client add dhcp-options=hostname,clientid disabled=no interface=ether1
/ip dhcp-server network add address=192.168.88.0/24 gateway=192.168.88.1
/ip dns set allow-remote-requests=yes
/ip dns static add address=192.168.88.1 name=router.lan
/ip firewall filter
add action=accept chain=input comment="accept established,related,untracked" connection-state=established,related,untracked
add action=drop chain=input comment="drop invalid" connection-state=invalid
add action=accept chain=input comment="accept ICMP" protocol=icmp
add action=drop chain=input comment="drop all not coming from LAN" in-interface-list=!LAN
add action=accept chain=forward comment="accept in ipsec policy" ipsec-policy=in,ipsec
add action=accept chain=forward comment="accept out ipsec policy" ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="fasttrack" connection-state=established,related
add action=accept chain=forward comment="accept established,related, untracked" connection-state=established,related,untracked
add action=drop chain=forward comment="drop invalid" connection-state=invalid
add action=drop chain=forward comment="drop all from WAN not DSTNATed" connection-nat-state=!dstnat connection-state=new in-interface-list=WAN
/ip firewall nat add action=masquerade chain=srcnat comment="masquerade" ipsec-policy=out,none out-interface-list=WAN
/ipv6 firewall address-list
add address=::/128 comment="unspecified address" list=bad_ipv6
add address=::1/128 comment="lo" list=bad_ipv6
add address=fec0::/10 comment="site-local" list=bad_ipv6
add address=::ffff:0.0.0.0/96 comment="ipv4-mapped" list=bad_ipv6
add address=::/96 comment="ipv4 compat" list=bad_ipv6
add address=100::/64 comment="discard only " list=bad_ipv6
add address=2001:db8::/32 comment="documentation" list=bad_ipv6
add address=2001:10::/28 comment="ORCHID" list=bad_ipv6
add address=3ffe::/16 comment="6bone" list=bad_ipv6
add address=::224.0.0.0/100 comment="other" list=bad_ipv6
add address=::127.0.0.0/104 comment="other" list=bad_ipv6
add address=::/104 comment="other" list=bad_ipv6
add address=::255.0.0.0/104 comment="other" list=bad_ipv6
/ipv6 firewall filter
add action=accept chain=input comment="accept established,related,untracked" connection-state=established,related,untracked
add action=drop chain=input comment="drop invalid" connection-state=invalid
add action=accept chain=input comment="accept ICMPv6" protocol=icmpv6
add action=accept chain=input comment="accept UDP traceroute" port=33434-33534 protocol=udp
add action=accept chain=input comment="accept DHCPv6-Client prefix delegation." dst-port=546 protocol=udp src-address=fe80::/16
add action=accept chain=input comment="accept IKE" dst-port=500,4500 protocol=udp
add action=accept chain=input comment="accept ipsec AH" protocol=ipsec-ah
add action=accept chain=input comment="accept ipsec ESP" protocol=ipsec-esp
add action=accept chain=input comment="accept all that matches ipsec policy" ipsec-policy=in,ipsec
add action=drop chain=input comment="drop everything else not coming from LAN" in-interface-list=!LAN
add action=accept chain=forward comment="accept established,related,untracked" connection-state=established,related,untracked
add action=drop chain=forward comment="drop invalid" connection-state=invalid
add action=drop chain=forward comment="drop packets with bad src ipv6" src-address-list=bad_ipv6
add action=drop chain=forward comment="drop packets with bad dst ipv6" dst-address-list=bad_ipv6
add action=drop chain=forward comment="rfc4890 drop hop-limit=1" hop-limit=equal:1 protocol=icmpv6
add action=accept chain=forward comment="accept ICMPv6" protocol=icmpv6
add action=accept chain=forward comment="accept HIP" protocol=139
add action=accept chain=forward comment="accept IKE" dst-port=500,4500 protocol=udp
add action=accept chain=forward comment="accept ipsec AH" protocol=ipsec-ah
add action=accept chain=forward comment="accept ipsec ESP" protocol=ipsec-esp
add action=accept chain=forward comment="accept all that matches ipsec policy" ipsec-policy=in,ipsec
add action=drop chain=forward comment="drop everything else not coming from LAN" in-interface-list=!LAN
/system routerboard settings set silent-boot=no
/tool mac-server set allowed-interface-list=LAN
/tool mac-server mac-winbox set allowed-interface-list=LAN