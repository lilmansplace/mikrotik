/ip firewall filter
add action=reject chain=input dst-port=53 protocol=udp reject-with=icmp-port-unreachable log=yes log-prefix="Reject Internet trying to use us as a DNS server"
add action=reject chain=input dst-port=53 protocol=tcp reject-with=icmp-port-unreachable log=yes log-prefix="Reject Internet trying to use us as a DNS server"
add action=reject chain=input dst-port=8291 protocol=tcp reject-with=icmp-port-unreachable in-interface=ether1 log=yes log-prefix="Internet Winbox" comment="Block Winbox in the public interface"
add action=accept chain=input connection-state=established,related comment="Allow connections originated from our network"
add action=drop chain=input
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www address=192.168.10.0/24,192.168.20.0/24,192.168.30.0/24
set ssh address=192.168.10.0/24,192.168.20.0/24,192.168.30.0/24
set api disabled=yes
set api-ssl disabled=yes