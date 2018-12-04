/caps-man channel
add band=2ghz-g/n control-channel-width=20mhz frequency=2412 name=2.4Ghz-Channel1 skip-dfs-channels=no tx-power=-8
add band=2ghz-g/n control-channel-width=20mhz frequency=2437 name=2.4Ghz-Channel6 skip-dfs-channels=no tx-power=-8
add band=2ghz-g/n control-channel-width=20mhz frequency=2462 name=2.4Ghz-Channel11 tx-power=-8
add band=5ghz-n/ac control-channel-width=40mhz-turbo frequency=5180 name=5Ghz-Channel36
add band=5ghz-n/ac control-channel-width=40mhz-turbo frequency=5200 name=5Ghz-Channel40
add band=5ghz-n/ac control-channel-width=40mhz-turbo frequency=5220 name=5Ghz-Channel44
add band=5ghz-n/ac control-channel-width=40mhz-turbo frequency=5240 name=5Ghz-Channel48
/caps-man datapath
add bridge=br-masterport client-to-client-forwarding=yes local-forwarding=yes name=datapath1
add bridge=br-masterport client-to-client-forwarding=no local-forwarding=no name=guestdatapath1
/caps-man rates add basic=12Mbps name=Rates1 supported=12Mbps,18Mbps,24Mbps,36Mbps,48Mbps,54Mbps
/caps-man configuration
add country="united states3" datapath=datapath1 distance=indoors mode=ap name=HOMEW1F1 rates=Rates1 rx-chains=0,1,2 ssid=HOMEW1F1 tx-chains=0,1,2
add country="united states3" datapath=guestdatapath1 hide-ssid=yes mode=ap name=HOMEW1F1-GUEST rates=Rates1 ssid=HOMEW1F1-GUEST
/caps-man security
add authentication-types=wpa-psk,wpa2-psk encryption=aes-ccm group-encryption=aes-ccm name=InfraWPA passphrase=fakepassword
/caps-man configuration
add country="united states3" datapath=datapath1 mode=ap name=HOMEW1F1-INFRA rates=Rates1 security=InfraWPA ssid=HOMEW1F1-INFRA
/caps-man access-list
add interface=pryor_home_cap1-1 action=accept mac-address=64:BC:0C:82:D2:E5 comment="LG V10"
add interface=pryor_home_cap1-1 action=reject comment="Block all unknown MAC addresses"
add interface=pryor_home_cap1-2 action=accept mac-address=64:BC:0C:82:D2:E5 comment="LG V10"
add interface=pryor_home_cap1-2 action=reject comment="Block all unknown MAC addresses"
/caps-man manager set ca-certificate=auto certificate=auto enabled=yes upgrade-policy=require-same-version
/caps-man provisioning add action=create-dynamic-enabled master-configuration=HOMEW1F1 name-format=identity slave-configurations=HOMEW1F1-INFRA,HOMEW1F1-GUEST
