/interface bridge add name=bridgeLocal
/interface bridge port
add bridge=bridgeLocal interface=ether1
add bridge=bridgeLocal interface=ether2
/interface wireless cap set bridge=bridgeLocal certificate=request discovery-interfaces=bridgeLocal enabled=yes interfaces=wlan1,wlan2
/ip dhcp-client add comment=defconf dhcp-options=hostname,clientid disabled=no interface=bridgeLocal
/system clock set time-zone-name=America/Boise
/system identity set name=pryor_home_cap1
/system routerboard settings set silent-boot=no