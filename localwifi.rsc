/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk eap-methods="" management-protection=allowed mode=dynamic-keys name=InfraWPA supplicant-identity="" wpa-pre-shared-key=ExampleP@ssword wpa2-pre-shared-key=ExampleP@ssword
/interface wireless set [ find default-name=wlan1 ] band=2ghz-g/n comment=HOMEW1F1 default-authentication=no default-forwarding=no disabled=no mode=ap-bridge name=wlan-users-30 ssid=HOMEW1F1 wireless-protocol=802.11
/interface wireless add comment=HOMEW1F1-INFRA disabled=no master-interface=wlan-users-30 name=wlan-infra-20 ssid=HOMEW1F1-INFRA security-profile=InfraWPA
/interface wireless add comment=HOMEW1F1-GUEST disabled=no master-interface=wlan-users-30 name=wlan-guests-40 ssid=HOMEW1F1-GUEST hide-ssid=yes
/interface wireless access-list
add interface=wlan-users-30 mac-address=11:22:22:33:33:11 vlan-mode=no-tag comment="Example WiFI Person"