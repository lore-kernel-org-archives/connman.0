Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3A2230F
	for <connman@lists.linux.dev>; Tue, 31 Oct 2023 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 233A3731B2
	for <connman@lists.linux.dev>; Tue, 31 Oct 2023 15:18:08 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03] (unknown [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5F20C73278
	for <connman@lists.linux.dev>; Tue, 31 Oct 2023 15:18:07 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: Update on Chasing Down a Crash in connman_service_get_nameservers
 on Cellular Service Removal
Date: Tue, 31 Oct 2023 12:18:06 -0700
References: <E50A909D-122E-4D14-A330-868A8EF9997F@nuovations.com>
 <A6BF0A08-CDFA-4CF4-A373-B130605030C0@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <A6BF0A08-CDFA-4CF4-A373-B130605030C0@nuovations.com>
Message-Id: <BE0470B2-EB5F-4D6F-8062-0E92C3C48F28@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Oct 19, 2023, at 5:48 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> On Oct 18, 2023, at 8:00 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
>> I know some of you (Denis, I believe from git log history) are =
working on clang static and dynamic analysis for connman.
>>=20
>> To the extent it helps, I have been chasing down an issue in =
top-of-tree (53964711baee916ae163e64d5229e3822935e100) in which when =
Quectel / Nimblelink QMI cellular goes away on my system, I get a =
connman signal 11 abort. Unfortunately, there is no backtrace in this =
case since n_ptrs (0) is less than offset (2) in the print_backtrace =
call.
>>=20
>> Today, doing some other development and debug work, I was able to =
narrow down the downstream cause of the abort. It seems that things are =
crashing somewhere within =
src/service.c:connman_service_get_nameservers().
>>=20
>> When name servers are established for the cellular service from the =
provider, there end up being two (2) name servers. The core problem =
seems to be that g_strv_length(service->nameservers) incorrectly returns =
7 (it really only has two (2)) which results in:
>>=20
>> 		for (i =3D 0; i < len; i++)
>> 			nameservers[i] =3D =
g_strdup(service->nameservers[i]);
>>=20
>> attempting to copy strings that do not exist past the end of the =
actual bounds of service->nameservers. So, it would seem that at some =
point, service->nameservers becomes corrupt with its terminating null =
getting overwritten by something else. I=E2=80=99ve get to zero in on =
the nature of =E2=80=9Cgetting overwritten by something else=E2=80=9D.
>>=20
>> I also periodically get this in the output after an abort:
>>=20
>>   malloc(): smallbin double linked list corrupted
>>=20
>> I am also able to cause the abort, nearly on demand with near 100% =
reproducibility, by issuing =E2=80=98connmanctl disable cellular=E2=80=99.=

>>=20
>> More as I learn and discover it.
>=20
> I configured connman as follows:
>=20
> % configure --disable-bluetooth --disable-debug --disable-dundee =
--disable-gadget --disable-hh2serial-gps --disable-iospm --disable-iwd =
--disable-l2tp --disable-neard --disable-nmcompat --disable-openconnect =
--disable-optimization --disable-pacrunner --disable-polkit =
--disable-pptp --disable-selinux --disable-session-policy-local =
--disable-test --disable-tools --disable-tist --disable-vpnc =
--disable-wireguard --disable-wispr --enable-client --enable-datafiles =
--enable-ethernet --enable-loopback --enable-ofono --enable-openvpn =
--enable-stats --enable-wifi --with-dns-backend=3Dinternal =
--with-firewall=3Dnftables --with-openvpn=3D/usr/sbin/openvpn =
--with-systemdunitdir=3D"" --prefix=3D/usr --sysconfdir=3D/etc =
--localstatedir=3D/var
>=20
> and then ran clang/LLVM scan-build-11 on it and yielding the following =
60 potential issues. I=E2=80=99ll dive in on the most promising leads =
relative to the corruption / failures I am seeing.
>=20
> % scan-build-11 --status-bugs -v make
> scan-build: Using '/usr/lib/llvm-11/bin/clang' for static analysis
> scan-build: Emitting reports for this run to =
'/tmp/scan-build-2023-10-19-172229-1594519-1=E2=80=99.
> [ =E2=80=A6 ]
> scan-build: Analysis run complete.
> scan-build: 60 bugs found.
> scan-build: Run 'scan-view =
/tmp/scan-build-2023-10-19-172229-1594519-1' to examine bug reports.

ConnMan Community:

I was finally able to stand up the address sanitizer on my armv7l =
embedded target and was able to trigger the address sanitizer by pulling =
the Ethernet cable while Ethernet, Wi-Fi, and Cellular were all active. =
Adding `-Og -g3` as the optimizer / debug flags to the package =
compilation, I was able to get full symbolication:

# CONNMAN_RESOLV_DEBUG=3D1 CONNMAN_WEB_DEBUG=3D1 /usr/sbin/connmand -n =
-d -W nl80211
connmand[507]: Connection Manager version 1.42
connmand[507]: src/dbus.c:__connman_dbus_init()=20
connmand[507]: src/main.c:parse_config() parsing main.conf
(connmand:507): GLib-WARNING **: 12:34:09.713: GError set over the top =
of a previous GError or uninitialized memory.
This indicates a bug in someone's code. You must ensure an error is NULL =
before it's set.
The overwriting error message was: Key file does not have key =
?ResolvConf? in group ?General?
connmand[507]: src/inotify.c:__connman_inotify_init()=20
connmand[507]: src/technology.c:__connman_technology_init()=20
connmand[507]: src/notifier.c:__connman_notifier_init()=20
connmand[507]: src/agent.c:__connman_agent_init()=20
connmand[507]: src/service.c:__connman_service_init()=20
connmand[507]: src/agent.c:connman_agent_driver_register() Registering =
driver 0x192be0 name service
connmand[507]: src/peer_service.c:__connman_peer_service_init()=20
connmand[507]: src/peer.c:__connman_peer_init()=20
connmand[507]: src/provider.c:__connman_provider_init()=20
connmand[507]: src/notifier.c:connman_notifier_register() notifier =
0x151340 name provider
connmand[507]: src/network.c:__connman_network_init()=20
connmand[507]: src/config.c:__connman_config_init()=20
connmand[507]: src/inotify.c:create_watch() Add directory watch for =
/var/lib/connman
connmand[507]: src/config.c:read_configs()=20
connmand[507]: src/device.c:__connman_device_init()=20
connmand[507]: src/inet.c:__connman_inet_get_address_netmask() index 4
connmand[507]: src/device.c:cleanup_devices() cleaning up eth0 index 4
connmand[507]: src/inet.c:__connman_inet_get_address_netmask() index 6
connmand[507]: src/device.c:cleanup_devices() cleaning up wwan0 index 6
connmand[507]: src/inet.c:__connman_inet_get_address_netmask() index 7
connmand[507]: src/device.c:cleanup_devices() cleaning up wlan0 index 7
connmand[507]: src/ippool.c:__connman_ippool_init()=20
connmand[507]: src/firewall-nftables.c:__connman_firewall_init()=20
connmand[507]: src/firewall-nftables.c:cleanup_table_and_chains()=20
connmand[507]: src/firewall-nftables.c:create_table_and_chains()=20
connmand[507]: src/nat.c:__connman_nat_init()=20
connmand[507]: src/notifier.c:connman_notifier_register() notifier =
0x16b540 name nat
connmand[507]: src/tethering.c:__connman_tethering_init()=20
connmand[507]: src/counter.c:__connman_counter_init()=20
connmand[507]: src/manager.c:__connman_manager_init()=20
connmand[507]: src/notifier.c:connman_notifier_register() notifier =
0x144000 name manager
connmand[507]: src/stats.c:__connman_stats_init()=20
connmand[507]: src/clock.c:__connman_clock_init()=20
connmand[507]: src/timezone.c:__connman_timezone_init()=20
connmand[507]: src/timezone.c:__connman_timezone_lookup() sysconfig zone =
(null)
connmand[507]: src/timezone.c:__connman_timezone_lookup() localtime zone =
America/Denver
connmand[507]: src/ipconfig.c:__connman_ipconfig_init()=20
connmand[507]: src/rtnl.c:__connman_rtnl_init()=20
connmand[507]: src/task.c:__connman_task_init()=20
connmand[507]: src/proxy.c:__connman_proxy_init()=20
connmand[507]: src/detect.c:__connman_detect_init()=20
connmand[507]: src/rtnl.c:connman_rtnl_register() rtnl 0x199f60 name =
detect
connmand[507]: src/session.c:__connman_session_init()=20
connmand[507]: src/notifier.c:connman_notifier_register() notifier =
0x166b00 name session
connmand[507]: src/timeserver.c:__connman_timeserver_init()=20
connmand[507]: src/notifier.c:connman_notifier_register() notifier =
0x15db40 name timeserver
connmand[507]: src/connection.c:__connman_connection_init()=20
connmand[507]: src/rtnl.c:connman_rtnl_register() rtnl 0x1912c0 name =
connection
connmand[507]: src/plugin.c:__connman_plugin_init()=20
connmand[507]: Can't load /usr/lib/connman/plugins/openvpn.so: =
/usr/lib/connman/plugins/openvpn.so: undefined symbol: =
vpn_provider_get_save_group
connmand[507]: Checking loopback interface settings
connmand[507]: System hostname is fwds
connmand[507]: src/utsname.c:connman_utsname_driver_register() driver =
0x17fa80 name loopback
connmand[507]: src/provider.c:connman_provider_driver_register() driver =
0x18b7c0 name VPN
connmand[507]: plugins/vpn.c:vpnd_created() connection 0x73303100
connmand[507]: plugins/vpn.c:get_connections()=20
connmand[507]: src/notifier.c:connman_notifier_register() notifier =
0x137c60 name vpn
connmand[507]: plugins/ofono.c:ofono_init()=20
connmand[507]: src/network.c:connman_network_driver_register() driver =
0x1871c0 name cellular
connmand[507]: src/network.c:probe_driver() driver 0x1871c0 name =
cellular
connmand[507]: src/device.c:connman_device_driver_register() driver =
0x187160 name modem
connmand[507]: src/device.c:probe_driver() driver 0x187160 name modem
connmand[507]: src/technology.c:connman_technology_driver_register() =
Registering cellular driver
connmand[507]: src/network.c:connman_network_driver_register() driver =
0x180780 name wifi
connmand[507]: src/network.c:probe_driver() driver 0x180780 name wifi
connmand[507]: src/technology.c:connman_technology_driver_register() =
Registering wifi driver
connmand[507]: src/technology.c:connman_technology_driver_register() =
Registering ethernet driver
connmand[507]: src/network.c:connman_network_driver_register() driver =
0x17ffa0 name cable
connmand[507]: src/network.c:probe_driver() driver 0x17ffa0 name cable
connmand[507]: src/device.c:connman_device_driver_register() driver =
0x180000 name ethernet
connmand[507]: src/device.c:probe_driver() driver 0x180000 name ethernet
connmand[507]: src/resolver.c:__connman_resolver_init() dnsproxy 1
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_init()=20
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_add_listener() index 1
connmand[507]: src/inet.c:get_interface_addresses() index 1 interface lo
connmand[507]: src/inet.c:get_interface_addresses() index 1 interface lo
connmand[507]: src/inet.c:get_interface_addresses() index 1 interface lo
connmand[507]: src/inet.c:get_interface_addresses() index 1 interface lo
connmand[507]: src/resolver.c:__connman_resolvfile_append() index 1 =
domain (null) server ::1
connmand[507]: Cannot create /var/run/connman/resolv.conf falling back =
to /etc/resolv.conf
connmand[507]: src/resolver.c:__connman_resolvfile_append() index 1 =
domain (null) server 127.0.0.1
connmand[507]: src/notifier.c:connman_notifier_register() notifier =
0x170a40 name dnsproxy
connmand[507]: src/resolver.c:__connman_resolver_init() server 8.8.8.8
connmand[507]: src/resolver.c:append_resolver() index -1 domain (null) =
server 8.8.8.8 lifetime 0 flags 1
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_append() index -1 =
server 8.8.8.8
connmand[507]: src/dnsproxy.c:create_server() index -1 server 8.8.8.8
connmand[507]: Failed to connect to server 8.8.8.8
connmand[507]: src/resolver.c:__connman_resolver_init() server 8.8.4.4
connmand[507]: src/resolver.c:append_resolver() index -1 domain (null) =
server 8.8.4.4 lifetime 0 flags 1
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_append() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:create_server() index -1 server 8.8.4.4
connmand[507]: Failed to connect to server 8.8.4.4
connmand[507]: src/rtnl.c:__connman_rtnl_start()=20
connmand[507]: src/rtnl.c:send_getlink()=20
connmand[507]: src/rtnl.c:send_request() GETLINK len 20 type 18 flags =
0x0301 seq 0
connmand[507]: src/rtnl.c:send_getaddr()=20
connmand[507]: src/rtnl.c:send_getroute()=20
connmand[507]: src/dhcp.c:__connman_dhcp_init()=20
connmand[507]: src/dhcpv6.c:__connman_dhcpv6_init()=20
connmand[507]: src/wpad.c:__connman_wpad_init()=20
connmand[507]: src/wispr.c:__connman_wispr_init()=20
connmand[507]: src/rfkill.c:__connman_rfkill_init()=20
connmand[507]: src/rfkill.c:rfkill_process()=20
connmand[507]: src/rfkill.c:rfkill_process() idx 0 type 1 op 0 soft 0 =
hard 0
connmand[507]: src/technology.c:__connman_technology_add_rfkill() index =
0 type 3 soft 0 hard 0
connmand[507]: src/technology.c:technology_get() type 3
connmand[507]: src/technology.c:technology_find() type 3
connmand[507]: src/technology.c:technology_get() technology (nil) driver =
0x180720
connmand[507]: src/technology.c:technology_load() technology 0x75503bc0
connmand[507]: src/technology.c:technology_get() technology 0x75503bc0 =
WiFi
connmand[507]: src/technology.c:technology_apply_rfkill_change() =
technology 0x75503bc0 --> 0/0 vs 0/0
connmand[507]: src/technology.c:technology_find() type 9
connmand[507]: src/rfkill.c:rfkill_process()=20
connmand[507]: src/machine.c:__connman_machine_init()=20
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1240 type 16 flags =
0x0002 seq 0 pid 507
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 1
connmand[507]: lo {newlink} index 1 address 00:00:00:00:00:00 mtu 65536
connmand[507]: lo {newlink} index 1 operstate 0 <UNKNOWN>
connmand[507]: src/detect.c:detect_newlink() type 772 index 1
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 768 type 16 flags =
0x0002 seq 0 pid 507
connmand[507]: can0 {newlink} index 2 address 00:00:00:00:00:00 mtu 16
connmand[507]: can0 {newlink} index 2 operstate 2 <DOWN>
connmand[507]: src/detect.c:detect_newlink() type 280 index 2
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 768 type 16 flags =
0x0002 seq 0 pid 507
connmand[507]: can1 {newlink} index 3 address 00:00:00:00:00:00 mtu 16
connmand[507]: can1 {newlink} index 3 operstate 2 <DOWN>
connmand[507]: src/detect.c:detect_newlink() type 280 index 3
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1248 type 16 flags =
0x0002 seq 0 pid 507
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 4
connmand[507]: eth0 {create} index 4 type 1 <ETHER>
connmand[507]: eth0 {RX} 159 packets 22563 bytes
connmand[507]: eth0 {TX} 201 packets 28428 bytes
connmand[507]: eth0 {update} flags 36866 <DOWN>
connmand[507]: eth0 {newlink} index 4 address 00:04:F3:1A:5E:E0 mtu 1500
connmand[507]: eth0 {newlink} index 4 operstate 2 <DOWN>
connmand[507]: src/detect.c:detect_newlink() type 1 index 4
connmand[507]: src/device.c:connman_device_create() node 0004f31a5ee0 =
type 1
connmand[507]: src/device.c:connman_device_create() device 0x73b02a90
connmand[507]: src/device.c:connman_device_set_string() device =
0x73b02a90 key Address value 00:04:F3:1A:5E:E0
connmand[507]: src/device.c:connman_device_register() device 0x73b02a90 =
name Ethernet
connmand[507]: src/device.c:connman_device_register() driver 0x180000 =
name ethernet
connmand[507]: plugins/ethernet.c:eth_dev_probe() device 0x73b02a90
connmand[507]: src/rtnl.c:connman_rtnl_add_newlink_watch() id 1
connmand[507]: plugins/ethernet.c:ethernet_newlink() index 4 flags 36866 =
change 0
connmand[507]: src/technology.c:__connman_technology_add_device() device =
0x73b02a90 type Wired
connmand[507]: src/technology.c:technology_get() type 2
connmand[507]: src/technology.c:technology_find() type 2
connmand[507]: src/technology.c:technology_get() technology (nil) driver =
0x17ff40
connmand[507]: src/technology.c:technology_load() technology 0x755031a0
connmand[507]: src/technology.c:technology_get() technology 0x755031a0 =
Wired
connmand[507]: src/device.c:__connman_device_enable() device 0x73b02a90
Micrel KSZ9031 Gigabit PHY 2188000.ethernet-1:03: attached PHY driver =
[Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=3D2188000.ethernet-1:03, =
irq=3D-1)
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
connmand[507]: plugins/ethernet.c:eth_dev_enable() device 0x73b02a90
connmand[507]: src/device.c:connman_device_set_powered() device =
0x73b02a90 powered 1
connmand[507]: src/technology.c:technology_find() type 2
connmand[507]: src/technology.c:__connman_technology_enabled() =
technology 0x755031a0 type Wired rfkill 0 enabled 0
connmand[507]: src/technology.c:technology_find() type 2
connmand[507]: src/technology.c:__connman_technology_enabled() =
technology 0x755031a0 type Wired rfkill 0 enabled 1
connmand[507]: Adding interface eth0 [ ethernet ]
connmand[507]: src/technology.c:technology_find() type 2
connmand[507]: plugins/ethernet.c:eth_tech_add_interface() index 4 name =
eth0 ident 0004f31a5ee0
connmand[507]: plugins/ethernet.c:ethernet_newlink() index 4 flags 36866 =
change 0
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1356 type 16 flags =
0x0002 seq 0 pid 507
connmand[507]: sit0 {newlink} index 5 address 00:00:00:00:08:00 mtu 1480
connmand[507]: sit0 {newlink} index 5 operstate 2 <DOWN>
connmand[507]: src/detect.c:detect_newlink() type 776 index 5
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1224 type 16 flags =
0x0002 seq 0 pid 507
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 6
connmand[507]: wwan0 {create} index 6 type 65534 <NONE>
connmand[507]: wwan0 {RX} 0 packets 0 bytes
connmand[507]: wwan0 {TX} 1 packets 48 bytes
connmand[507]: wwan0 {update} flags 37008 <DOWN>
connmand[507]: wwan0 {newlink} index 6 address 00:00:00:00:00:00 mtu =
1500
connmand[507]: wwan0 {newlink} index 6 operstate 2 <DOWN>
connmand[507]: src/detect.c:detect_newlink() type 65534 index 6
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1248 type 16 flags =
0x0002 seq 0 pid 507
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 7
connmand[507]: wlan0 {create} index 7 type 1 <ETHER>
connmand[507]: wlan0 {RX} 50 packets 9237 bytes
connmand[507]: wlan0 {TX} 217 packets 18767 bytes
connmand[507]: wlan0 {update} flags 36866 <DOWN>
connmand[507]: wlan0 {newlink} index 7 address 00:04:F3:1A:5E:E1 mtu =
1500
connmand[507]: wlan0 {newlink} index 7 operstate 2 <DOWN>
connmand[507]: src/detect.c:detect_newlink() type 1 index 7
connmand[507]: src/device.c:connman_device_create() node 0004f31a5ee1 =
type 2
connmand[507]: src/device.c:connman_device_create() device 0x73b02780
connmand[507]: src/device.c:connman_device_set_string() device =
0x73b02780 key Address value 00:04:F3:1A:5E:E1
connmand[507]: src/device.c:connman_device_register() device 0x73b02780 =
name Wireless
connmand[507]: Adding interface wlan0 [ wifi ]
connmand[507]: src/technology.c:technology_find() type 3
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1248 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 4
connmand[507]: eth0 {RX} 159 packets 22563 bytes
connmand[507]: eth0 {TX} 201 packets 28428 bytes
connmand[507]: eth0 {update} flags 36931 <UP,RUNNING>
connmand[507]: eth0 {newlink} index 4 address 00:04:F3:1A:5E:E0 mtu 1500
connmand[507]: eth0 {newlink} index 4 operstate 6 <UP>
connmand[507]: src/detect.c:detect_newlink() type 1 index 4
connmand[507]: plugins/ethernet.c:ethernet_newlink() index 4 flags 36931 =
change 1
connmand[507]: plugins/ethernet.c:ethernet_newlink() power on
connmand[507]: src/device.c:connman_device_set_powered() device =
0x73b02a90 powered 1
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1248 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 4
connmand[507]: eth0 {RX} 159 packets 22563 bytes
connmand[507]: eth0 {TX} 201 packets 28428 bytes
connmand[507]: eth0 {update} flags 36867 <UP>
connmand[507]: eth0 {newlink} index 4 address 00:04:F3:1A:5E:E0 mtu 1500
connmand[507]: eth0 {newlink} index 4 operstate 2 <DOWN>
connmand[507]: src/detect.c:detect_newlink() type 1 index 4
connmand[507]: plugins/ethernet.c:ethernet_newlink() index 4 flags 36867 =
change 0
connmand[507]: src/rtnl.c:rtnl_message() DONE len 20 type 3 flags 0x0002 =
seq 0 pid 507
connmand[507]: src/rtnl.c:process_response() seq 0
connmand[507]: src/rtnl.c:send_request() GETADDR len 20 type 22 flags =
0x0301 seq 1
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 76 type 20 flags =
0x0002 seq 1 pid 507
connmand[507]: src/ipconfig.c:__connman_ipconfig_newaddr() index 1
connmand[507]: src/rtnl.c:rtnl_message() DONE len 20 type 3 flags 0x0002 =
seq 1 pid 507
connmand[507]: src/rtnl.c:process_response() seq 1
connmand[507]: src/rtnl.c:send_request() GETROUTE len 20 type 26 flags =
0x0301 seq 2
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0002 seq 2 pid 507
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0002 seq 2 pid 507
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0002 seq 2 pid 507
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0002 seq 2 pid 507
connmand[507]: src/rtnl.c:rtnl_message() DONE len 20 type 3 flags 0x0002 =
seq 2 pid 507
connmand[507]: src/rtnl.c:process_response() seq 2
connmand[507]: src/manager.c:get_properties() conn 0x73303100
connmand[507]: plugins/vpn.c:vpnd_created() connection 0x73303100
connmand[507]: plugins/vpn.c:get_connections()=20
connmand[507]: plugins/vpn.c:get_connections_reply()=20
connmand[507]: plugins/ofono.c:ofono_connect()=20
connmand[507]: plugins/ofono.c:manager_get_modems()=20
connmand[507]: plugins/wifi.c:system_ready()=20
connmand[507]: src/device.c:connman_device_driver_register() driver =
0x180880 name wifi
connmand[507]: src/device.c:probe_driver() driver 0x180880 name wifi
connmand[507]: plugins/wifi.c:wifi_probe() device 0x73b02780
connmand[507]: src/device.c:connman_device_ref_debug() 0x73b02780 ref 2 =
by plugins/wifi.c:799:wifi_probe()
connmand[507]: src/rtnl.c:connman_rtnl_add_newlink_watch() id 2
connmand[507]: plugins/wifi.c:wifi_newlink() index 7 flags 36866 change =
0
connmand[507]: src/technology.c:__connman_technology_add_device() device =
0x73b02780 type WiFi
connmand[507]: src/technology.c:technology_get() type 3
connmand[507]: src/technology.c:technology_find() type 3
connmand[507]: src/device.c:__connman_device_enable() device 0x73b02780
connmand[507]: plugins/wifi.c:wifi_enable() device 0x73b02780 0x73d049c0
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1248 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 7
connmand[507]: wlan0 {RX} 50 packets 9237 bytes
connmand[507]: wlan0 {TX} 217 packets 18767 bytes
connmand[507]: wlan0 {update} flags 36867 <UP>
connmand[507]: wlan0 {newlink} index 7 address 00:04:F3:1A:5E:E1 mtu =
1500
connmand[507]: wlan0 {newlink} index 7 operstate 2 <DOWN>
connmand[507]: src/detect.c:detect_newlink() type 1 index 7
connmand[507]: plugins/wifi.c:wifi_newlink() index 7 flags 36867 change =
1
connmand[507]: plugins/wifi.c:wifi_newlink() interface up
connmand[507]: plugins/vpn.c:get_connections_reply()=20
connmand[507]: plugins/ofono.c:manager_get_modems_reply()=20
connmand[507]: plugins/ofono.c:add_modem() /quectelqmi_0
connmand[507]: plugins/ofono.c:add_modem() /quectelqmi_0 Online 1
connmand[507]: plugins/ofono.c:add_modem() /quectelqmi_0 Powered 1
connmand[507]: plugins/ofono.c:add_modem() /quectelqmi_0 Serial =
862785049605051
connmand[507]: plugins/ofono.c:add_modem() /quectelqmi_0 Interfaces 0x07
connmand[507]: plugins/ofono.c:add_modem() /quectelqmi_0 Type hardware
connmand[507]: plugins/ofono.c:modem_update_interfaces() /quectelqmi_0
connmand[507]: plugins/ofono.c:api_added() sim added
connmand[507]: plugins/ofono.c:get_properties() /quectelqmi_0 path =
/quectelqmi_0 org.ofono.SimManager
connmand[507]: plugins/ofono.c:api_added() cm added
connmand[507]: plugins/ofono.c:api_added() netreg added
connmand[507]: plugins/wifi.c:interface_state() wifi (nil) interface =
state 4
connmand[507]: plugins/wifi.c:scan_finished()=20
connmand[507]: plugins/wifi.c:network_added() hidden_none
connmand[507]: plugins/wifi.c:interface_create_callback() result 0 =
ifname wlan0, wifi 0x73d049c0
connmand[507]: plugins/wifi.c:finalize_interface_creation() interface is =
ready wifi 0x73d049c0 tethering 0
connmand[507]: src/device.c:connman_device_set_powered() device =
0x73b02780 powered 1
connmand[507]: src/technology.c:technology_find() type 3
connmand[507]: src/technology.c:__connman_technology_enabled() =
technology 0x75503bc0 type WiFi rfkill 1 enabled 1
connmand[507]: plugins/wifi.c:wifi_scan() device 0x73b02780 wifi =
0x72d032e0 hidden ssid (null)
connmand[507]: plugins/wifi.c:wifi_scan() max ssids 16
connmand[507]: plugins/wifi.c:get_latest_connections() ssid =
436861726c6965277320467269656e6473 freq 5745 modified 1698777180
connmand[507]: plugins/wifi.c:add_scan_param() SSID =
436861726c6965277320467269656e6473 added to scanned list of 1 entries
connmand[507]: plugins/wifi.c:wifi_update_scanner_type()=20
connmand[507]: plugins/wifi.c:parse_autoscan_params()=20
connmand[507]: plugins/wifi.c:parse_autoscan_params() Setup exponential =
autoscanning
connmand[507]: plugins/wifi.c:parse_autoscan_params() base 3 - limit 300
connmand[507]: src/device.c:connman_device_ref_debug() 0x73b02780 ref 3 =
by plugins/wifi.c:2005:wifi_scan()
connmand[507]: plugins/wifi.c:reset_autoscan()=20
connmand[507]: src/device.c:connman_device_set_scanning() device =
0x73b02780 scanning 1
connmand[507]: src/technology.c:__connman_technology_scan_started() =
device 0x73b02780
connmand[507]: plugins/wifi.c:start_autoscan()=20
connmand[507]: src/device.c:connman_device_ref_debug() 0x73b02780 ref 4 =
by plugins/wifi.c:1442:start_autoscan()
connmand[507]: plugins/wifi.c:autoscan_timeout() interval 3
connmand[507]: plugins/wifi.c:p2p_support()=20
connmand[507]: src/technology.c:connman_technology_driver_register() =
Registering p2p driver
connmand[507]: src/technology.c:technology_get() type 9
connmand[507]: src/technology.c:technology_find() type 9
connmand[507]: src/technology.c:technology_get() technology (nil) driver =
0x1807e0
connmand[507]: src/technology.c:technology_load() technology 0x755046a0
connmand[507]: src/technology.c:technology_find() type 3
connmand[507]: src/technology.c:technology_find() type 9
connmand[507]: src/technology.c:technology_get() technology 0x755046a0 =
P2P
connmand[507]: src/utsname.c:connman_utsname_get_hostname()=20
connmand[507]: src/utsname.c:connman_utsname_get_hostname() driver =
0x17fa80 name loopback
connmand[507]: plugins/wifi.c:scan_started()=20
connmand[507]: plugins/ofono.c:get_properties_reply() /quectelqmi_0 path =
/quectelqmi_0 org.ofono.SimManager
connmand[507]: plugins/ofono.c:sim_properties_reply() /quectelqmi_0
connmand[507]: plugins/ofono.c:sim_update_imsi() /quectelqmi_0 imsi =
311270007006540
connmand[507]: plugins/ofono.c:create_device() /quectelqmi_0
connmand[507]: src/device.c:connman_device_create() node ofono type 4
connmand[507]: src/device.c:connman_device_create() device 0x73b03dd0
connmand[507]: plugins/ofono.c:create_device() device 0x73b03dd0
connmand[507]: src/device.c:connman_device_set_string() device =
0x73b03dd0 key Path value /quectelqmi_0
connmand[507]: src/device.c:connman_device_register() device 0x73b03dd0 =
name Cellular
connmand[507]: src/device.c:connman_device_register() driver 0x187160 =
name modem
connmand[507]: plugins/ofono.c:modem_probe() /quectelqmi_0 device =
0x73b03dd0
connmand[507]: src/technology.c:__connman_technology_add_device() device =
0x73b03dd0 type Cellular
connmand[507]: src/technology.c:technology_get() type 5
connmand[507]: src/technology.c:technology_find() type 5
connmand[507]: src/technology.c:technology_get() technology (nil) driver =
0x187100
connmand[507]: src/technology.c:technology_load() technology 0x75506fe0
connmand[507]: src/technology.c:technology_get() technology 0x75506fe0 =
Cellular
connmand[507]: src/device.c:__connman_device_enable() device 0x73b03dd0
connmand[507]: plugins/ofono.c:modem_enable() /quectelqmi_0 device =
0x73b03dd0
connmand[507]: src/device.c:connman_device_set_powered() device =
0x73b03dd0 powered 1
connmand[507]: src/technology.c:technology_find() type 5
connmand[507]: src/technology.c:__connman_technology_enabled() =
technology 0x75506fe0 type Cellular rfkill 0 enabled 0fec =
2188000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
connmand[507]: src/device.c:connman_device_set_powered() device =
0x73b03dd0 powered 1
connmand[507]: plugins/ofono.c:get_properties() /quectelqmi_0 path =
/quectelqmi_0 org.ofono.ConnectionManager
connmand[507]: plugins/ofono.c:cm_get_contexts() /quectelqmi_0
connmand[507]: plugins/wifi.c:scan_callback() result -5 wifi 0x73d049c0
connmand[507]: src/device.c:connman_device_set_scanning() device =
0x73b02780 scanning 0
connmand[507]: src/technology.c:technology_find() type 3
connmand[507]: src/technology.c:__connman_technology_scan_stopped() =
technology 0x75503bc0 device 0x73b02780
connmand[507]: src/technology.c:reply_scan_pending() technology =
0x75503bc0 err 0
connmand[507]: src/service.c:__connman_service_auto_connect()=20
connmand[507]: plugins/wifi.c:start_autoscan()=20
connmand[507]: src/device.c:connman_device_unref_debug() 0x73b02780 ref =
3 by plugins/wifi.c:1331:scan_callback()
connmand[507]: src/service.c:run_auto_connect()=20
connmand[507]: src/service.c:auto_connect_service() preferred 0 sessions =
0 reason auto
connmand[507]: plugins/ofono.c:get_properties_reply() /quectelqmi_0 path =
/quectelqmi_0 org.ofono.ConnectionManager
connmand[507]: plugins/ofono.c:cm_properties_reply() /quectelqmi_0
connmand[507]: plugins/ofono.c:cm_update_attached() /quectelqmi_0 =
Attached 1
connmand[507]: plugins/ofono.c:get_properties() /quectelqmi_0 path =
/quectelqmi_0 org.ofono.NetworkRegistration
connmand[507]: plugins/ofono.c:cm_update_powered() /quectelqmi_0 =
ConnnectionManager Powered 1
connmand[507]: plugins/ofono.c:cm_get_contexts_reply() /quectelqmi_0
connmand[507]: plugins/ofono.c:add_cm_context() /quectelqmi_0 context =
path /quectelqmi_0/context1
connmand[507]: plugins/ofono.c:add_cm_context() /quectelqmi_0 Active 1
connmand[507]: plugins/ofono.c:add_cm_context() /quectelqmi_0 context =
/quectelqmi_0/context1 type internet
connmand[507]: plugins/ofono.c:add_cm_context() /quectelqmi_0 Protocol =
ip
connmand[507]: plugins/ofono.c:add_cm_context() /quectelqmi_0 =
AccessPointName 'vzwinternet'
connmand[507]: plugins/ofono.c:add_cm_context() /quectelqmi_0 Settings
connmand[507]: plugins/ofono.c:extract_ipv4_settings() Interface wwan0
connmand[507]: plugins/ofono.c:extract_ipv4_settings() index 6
connmand[507]: plugins/ofono.c:extract_ipv4_settings() Method static
connmand[507]: plugins/ofono.c:extract_ipv4_settings() Address =
100.110.85.43
connmand[507]: plugins/ofono.c:extract_ipv4_settings() Netmask =
255.255.255.248
connmand[507]: plugins/ofono.c:extract_ipv4_settings() Gateway =
100.110.85.44
connmand[507]: plugins/ofono.c:extract_ipv4_settings() Nameservers =
198.224.174.135 198.224.173.135
connmand[507]: plugins/ofono.c:add_cm_context() /quectelqmi_0 =
IPv6.Settings
connmand[507]: plugins/ofono.c:set_context_ipconfig() context 0x74305e90 =
protocol ip
connmand[507]: plugins/ofono.c:set_context_ipconfig() ipv4 method 2 ipv6 =
method 1
connmand[507]: plugins/ofono.c:add_network() /quectelqmi_0
connmand[507]: src/network.c:connman_network_create() network 0x73106a20 =
identifier /quectelqmi_0/context1 type cellular
connmand[507]: plugins/ofono.c:add_network() network 0x73106a20
connmand[507]: src/network.c:connman_network_set_name() network =
0x73106a20 name=20
connmand[507]: src/network.c:network_probe() network 0x73106a20 name=20
connmand[507]: src/network.c:network_probe() driver 0x1871c0 name =
cellular
connmand[507]: plugins/ofono.c:network_probe() /quectelqmi_0 network =
0x73106a20
connmand[507]: src/service.c:__connman_service_create_from_network() =
network 0x73106a20
connmand[507]: src/device.c:connman_device_add_network() device =
0x73b03dd0 network 0x73106a20
connmand[507]: src/network.c:connman_network_ref_debug() 0x73106a20 name =
 ref 2 by src/device.c:872:connman_device_add_network()
connmand[507]: src/network.c:network_probe() network 0x73106a20 name=20
connmand[507]: src/network.c:network_probe() driver 0x1871c0 name =
cellular
connmand[507]: plugins/ofono.c:network_probe() /quectelqmi_0 network =
0x73106a20
connmand[507]: src/service.c:__connman_service_create_from_network() =
network 0x73106a20
connmand[507]: src/service.c:connman_service_create() service 0x72703840
connmand[507]: src/service.c:service_initialize() service 0x72703840
connmand[507]: src/service.c:service_get() service 0x72703840
connmand[507]: src/service.c:update_from_network() service 0x72703840 =
network 0x73106a20
connmand[507]: src/network.c:connman_network_ref_debug() 0x73106a20 name =
 ref 3 by src/service.c:7426:update_from_network()
connmand[507]: src/ipconfig.c:__connman_ipconfig_create() ipconfig =
0x74305d90 index 0
connmand[507]: src/ipconfig.c:create_ipv6config() ipconfig 0x74305d50 =
index 0 method auto
connmand[507]: src/service.c:service_register() service 0x72703840
connmand[507]: src/service.c:service_register() path =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/config.c:__connman_config_provision_service() service =
0x72703840 type 5
connmand[507]: src/service.c:service_load() service 0x72703840
connmand[507]: src/ipconfig.c:__connman_ipconfig_load() ipconfig =
0x74305d90 identifier cellular_311270007006540_context1
connmand[507]: src/ipconfig.c:__connman_ipconfig_load() ipconfig =
0x74305d50 identifier cellular_311270007006540_context1
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default (nil)
connmand[507]: src/service.c:service_schedule_added() service 0x72703840
connmand[507]: src/service.c:__connman_service_auto_connect()=20
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 4
connmand[507]: eth0 {add} route ff00:: gw :: scope 0 <UNIVERSE>
connmand[507]: src/service.c:service_send_changed()=20
connmand[507]: src/service.c:service_append_added_foreach() new =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 4
connmand[507]: eth0 {add} route fe80:: gw :: scope 0 <UNIVERSE>
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1248 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 4
connmand[507]: eth0 {RX} 159 packets 22563 bytes
connmand[507]: eth0 {TX} 201 packets 28428 bytes
connmand[507]: eth0 {update} flags 102467 <UP,RUNNING,LOWER_UP>
connmand[507]: eth0 {newlink} index 4 address 00:04:F3:1A:5E:E0 mtu 1500
connmand[507]: eth0 {newlink} index 4 operstate 6 <UP>
connmand[507]: src/detect.c:detect_newlink() type 1 index 4
connmand[507]: plugins/ethernet.c:ethernet_newlink() index 4 flags =
102467 change 0
connmand[507]: plugins/ethernet.c:ethernet_newlink() carrier on
connmand[507]: src/network.c:connman_network_create() network 0x731066a0 =
identifier carrier type ethernet
connmand[507]: src/network.c:connman_network_set_name() network =
0x731066a0 name Wired
connmand[507]: src/device.c:connman_device_add_network() device =
0x73b02a90 network 0x731066a0
connmand[507]: src/network.c:connman_network_ref_debug() 0x731066a0 name =
Wired ref 2 by src/device.c:872:connman_device_add_network()
connmand[507]: src/network.c:network_probe() network 0x731066a0 name =
Wired
connmand[507]: src/network.c:network_probe() driver 0x17ffa0 name cable
connmand[507]: plugins/ethernet.c:eth_network_probe() network 0x731066a0
connmand[507]: src/network.c:network_probe() network 0x731066a0 name =
Wired
connmand[507]: src/network.c:network_probe() driver 0x17ffa0 name cable
connmand[507]: plugins/ethernet.c:eth_network_probe() network 0x731066a0
connmand[507]: src/service.c:__connman_service_create_from_network() =
network 0x731066a0
connmand[507]: src/service.c:connman_service_create() service 0x72703440
connmand[507]: src/service.c:service_initialize() service 0x72703440
connmand[507]: src/service.c:service_get() service 0x72703440
connmand[507]: src/service.c:update_from_network() service 0x72703440 =
network 0x731066a0
connmand[507]: src/network.c:connman_network_ref_debug() 0x731066a0 name =
Wired ref 3 by src/service.c:7426:update_from_network()
connmand[507]: src/ipconfig.c:__connman_ipconfig_create() ipconfig =
0x74308ad0 index 4
connmand[507]: src/ipconfig.c:create_ipv6config() ipconfig 0x74308a90 =
index 4 method auto
connmand[507]: src/service.c:service_register() service 0x72703440
connmand[507]: src/service.c:service_register() path =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: src/config.c:__connman_config_provision_service() service =
0x72703440 type 2
connmand[507]: src/service.c:service_load() service 0x72703440
connmand[507]: src/ipconfig.c:__connman_ipconfig_load() ipconfig =
0x74308ad0 identifier ethernet_0004f31a5ee0_cable
connmand[507]: src/ipconfig.c:__connman_ipconfig_load() ipconfig =
0x74308a90 identifier ethernet_0004f31a5ee0_cable
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default (nil)
connmand[507]: src/service.c:service_schedule_added() service 0x72703440
connmand[507]: src/service.c:__connman_service_connect() service =
0x72703440 state idle connect reason none -> auto
connmand[507]: src/service.c:__connman_service_clear_error() service =
0x72703440
connmand[507]: src/stats.c:__connman_stats_service_register() service =
0x72703440
connmand[507]: src/stats.c:stats_open() file 0x74308950 name =
/var/lib/connman/ethernet_0004f31a5ee0_cable/data
connmand[507]: src/stats.c:stats_file_setup() file 0x74308950 fd 16 name =
/var/lib/connman/ethernet_0004f31a5ee0_cable/data
connmand[507]: src/stats.c:stats_file_remap() file 0x74308950 size 4096 =
addr (nil) len 0
connmand[507]: src/network.c:__connman_network_connect() network =
0x731066a0
connmand[507]: plugins/ethernet.c:eth_network_connect() network =
0x731066a0
connmand[507]: src/network.c:connman_network_set_connected() network =
0x731066a0 connected 0/1 connecting 1 associating 0
connmand[507]: src/network.c:connman_network_set_associating() network =
0x731066a0 associating 0
connmand[507]: src/network.c:set_connected() service 0x72703440 ipv4 =
0x74308ad0 ipv6 0x74308a90
connmand[507]: src/network.c:set_configuration() network 0x731066a0
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 1 (idle) new =
state 3 (configuration) type 1 (IPv4)
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old idle - new configuration/idle =3D> configuration
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72703440 =
state 3
connmand[507]: src/notifier.c:notify_idle_state() idle 0
connmand[507]: src/manager.c:idle_state() idle 0
connmand[507]: src/stats.c:__connman_stats_service_register() service =
0x72703440
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default (nil)
connmand[507]: src/network.c:__connman_network_enable_ipconfig() ipv4 =
ipconfig method 4
connmand[507]: src/network.c:set_connected_dhcp() network 0x731066a0
connmand[507]: src/ipconfig.c:__connman_ipconfig_enable() ipconfig =
0x74308ad0
connmand[507]: src/ipconfig.c:__connman_ipconfig_ref_debug() 0x74308ad0 =
ref 2 by src/ipconfig.c:1720:__connman_ipconfig_enable()
connmand[507]: src/service.c:service_up() eth0 up
connmand[507]: src/service.c:service_lower_up() eth0 lower up
connmand[507]: src/service.c:stats_start() service 0x72703440
connmand[507]: src/dhcp.c:__connman_dhcp_start()=20
connmand[507]: src/ipconfig.c:__connman_ipconfig_ref_debug() 0x74308ad0 =
ref 3 by src/dhcp.c:701:__connman_dhcp_start()
connmand[507]: src/network.c:connman_network_ref_debug() 0x731066a0 name =
Wired ref 4 by src/dhcp.c:705:__connman_dhcp_start()
connmand[507]: src/dhcp.c:dhcp_initialize() dhcp 0x75508420
connmand[507]: src/utsname.c:connman_utsname_get_hostname()=20
connmand[507]: src/utsname.c:connman_utsname_get_hostname() driver =
0x17fa80 name loopback
connmand[507]: src/network.c:set_configuration() network 0x731066a0
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 1 (idle) new =
state 3 (configuration) type 2 (IPv6)
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old configuration - new configuration/configuration =3D> configuration
connmand[507]: src/network.c:__connman_network_enable_ipconfig() ipv6 =
ipconfig method 5
connmand[507]: src/network.c:autoconf_ipv6_set() network 0x731066a0
connmand[507]: src/ipconfig.c:__connman_ipconfig_enable() ipconfig =
0x74308a90
connmand[507]: src/ipconfig.c:__connman_ipconfig_ref_debug() 0x74308a90 =
ref 2 by src/ipconfig.c:1722:__connman_ipconfig_enable()
connmand[507]: src/ipconfig.c:enable_ipv6()=20
connmand[507]: src/ipconfig.c:set_ipv6_state() eth0 0
connmand[507]: src/service.c:service_up() eth0 up
connmand[507]: src/service.c:service_lower_up() eth0 lower up
connmand[507]: src/service.c:stats_start() service 0x72703440
connmand[507]: src/ipconfig.c:enable_ipv6()=20
connmand[507]: src/ipconfig.c:set_ipv6_state() eth0 0
connmand[507]: src/inet.c:connman_inet_clear_ipv6_address() index 4 =
address (null) prefix_len 0
connmand[507]: src/network.c:connman_network_ref_debug() 0x731066a0 name =
Wired ref 5 by src/network.c:907:autoconf_ipv6_set()
connmand[507]: src/inet.c:__connman_inet_ipv6_send_rs() sock 18
connmand[507]: src/inet.c:ndisc_send_unspec()=20
connmand[507]: src/service.c:__connman_service_connect() service =
0x72703440 err 0
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/dhcp.c:lease_available_cb() Lease available
connmand[507]: src/dhcp.c:lease_available_cb() last address 192.168.2.69
connmand[507]: src/dhcp.c:lease_available_cb() c_address (null)
connmand[507]: src/ipconfig.c:__connman_ipconfig_set_gateway()=20
connmand[507]: src/service.c:__connman_service_nameserver_append() =
service 0x72703440 nameserver 192.168.2.1 auto 0
connmand[507]: src/service.c:__connman_service_timeserver_append() =
service 0x72703440 timeserver 192.168.2.1
connmand[507]: src/network.c:dhcp_success() lease acquired for ipconfig =
0x74308ad0
connmand[507]: src/inet.c:connman_inet_set_address() index 4 address =
192.168.2.69 prefix_len 24
connmand[507]: src/inet.c:__connman_inet_modify_address() cmd 0x14 flags =
0x104 index 4 family 2 address 192.168.2.69 peer (null) prefixlen 24 =
broadcast (null) p2p false
connmand[507]: src/ipconfig.c:__connman_ipconfig_gateway_add()=20
connmand[507]: src/ipconfig.c:__connman_ipconfig_gateway_add() type 1 gw =
192.168.2.1 peer (null)
connmand[507]: src/connection.c:__connman_connection_gateway_add() =
service 0x72703440 index 4 gateway 192.168.2.1 vpn ip (null) type 1
connmand[507]: src/service.c:connman_service_ref_debug() 0x72703440 ref =
2 by src/connection.c:416:add_gateway()
connmand[507]: src/connection.c:find_active_gateway()=20
connmand[507]: src/connection.c:__connman_connection_gateway_add() =
active (nil) index -1 new 0x7471ae00
connmand[507]: src/inet.c:connman_inet_add_network_route() index 4 host =
192.168.2.1 gateway (null) netmask (null)
connmand[507]: src/inet.c:connman_inet_add_network_route() ifname eth0
connmand[507]: src/inet.c:connman_inet_compare_subnet() host 192.168.2.1
connmand[507]: src/inet.c:get_interface_addresses() index 4 interface =
eth0
connmand[507]: src/connection.c:set_default_gateway() type 1 gateway =
ipv4 0x7471add0 ipv6 (nil)
connmand[507]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[507]: src/inet.c:__connman_inet_rtnl_open() fd 19
connmand[507]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7e861a60 =
len 44
connmand[507]: src/inet.c:__connman_inet_rtnl_close() handle 0x7e861a60
connmand[507]: src/service.c:__connman_service_indicate_default() =
service 0x72703440 state configuration
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 3 =
(configuration) new state 4 (ready) type 1 (IPv4)
connmand[507]: src/service.c:service_rp_filter() connected =
ethernet_0004f31a5ee0_cable ipconfig 0x74308ad0 method 4 count 1 filter =
0
connmand[507]: src/resolver.c:connman_resolver_append() index 4 domain =
(null) server 192.168.2.1
connmand[507]: src/resolver.c:append_resolver() index 4 domain (null) =
server 192.168.2.1 lifetime 0 flags 0
connmand[507]: src/resolver.c:remove_fallback_nameservers() index -1 =
server 8.8.8.8
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index -1 =
server 8.8.8.8
connmand[507]: src/resolver.c:remove_fallback_nameservers() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_append() index 4 server =
192.168.2.1
connmand[507]: src/dnsproxy.c:create_server() index 4 server 192.168.2.1
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old configuration - new ready/configuration =3D> ready
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72703440 =
state 4
connmand[507]: src/service.c:default_changed() current default (nil)=20
connmand[507]: src/service.c:default_changed() new default 0x72703440 =
ethernet_0004f31a5ee0_cable
connmand[507]: src/service.c:__connman_service_wispr_start() service =
0x72703440 type IPv4
connmand[507]: src/wispr.c:__connman_wispr_start() service 0x72703440 =
IPv4
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b01430 =
ref 1 by src/wispr.c:233:create_wispr_portal_context()
connmand[507]: src/wispr.c:wispr_portal_detect() wispr/portal context =
0x72b01430 service 0x72703440
connmand[507]: src/wispr.c:wispr_portal_detect() interface eth0
connmand[507]: WEB: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02d80 setting nameserver 192.168.2.1
connmand[507]: src/proxy.c:connman_proxy_lookup() interface eth0 url =
http://ipv4.connman.net/online/status.html
connmand[507]: src/service.c:connman_service_ref_debug() 0x72703440 ref =
3 by src/proxy.c:124:connman_proxy_lookup()
connmand[507]: src/proxy.c:connman_proxy_lookup() token 1
connmand[507]: src/service.c:default_changed() running vpn_auto_connect
connmand[507]: src/dnsproxy.c:dnsproxy_default_changed() service =
0x72703440
connmand[507]: src/dnsproxy.c:dnsproxy_default_changed() Enabling DNS =
server 192.168.2.1
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/timeserver.c:timeserver_start() service 0x72703440
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 192.168.2.1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 192.168.2.1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 192.168.2.1
connmand[507]: src/timeserver.c:sync_next() Using timeserver 192.168.2.1
connmand[507]: src/ntp.c:start_ntp() server 192.168.2.1 family 2
connmand[507]: src/nat.c:update_default_interface() interface eth0
connmand[507]: src/service.c:service_save() service 0x72703440 new 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74308ad0 identifier ethernet_0004f31a5ee0_cable method dhcp
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74308a90 identifier ethernet_0004f31a5ee0_cable method auto
connmand[507]: src/notifier.c:__connman_notifier_connect() type 2
connmand[507]: src/technology.c:technology_find() type 2
connmand[507]: src/technology.c:__connman_technology_set_connected() =
technology 0x755031a0 connected 1
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/connection.c:set_default_gateway() type 1 gateway =
ipv4 0x7471add0 ipv6 (nil)
connmand[507]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[507]: src/inet.c:__connman_inet_rtnl_open() fd 23
connmand[507]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7e861900 =
len 44
connmand[507]: src/inet.c:__connman_inet_rtnl_close() handle 0x7e861900
connmand[507]: src/service.c:__connman_service_indicate_default() =
service 0x72703440 state ready
connmand[507]: src/service.c:service_save() service 0x72703440 new 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74308ad0 identifier ethernet_0004f31a5ee0_cable method dhcp
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74308a90 identifier ethernet_0004f31a5ee0_cable method auto
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 56 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: plugins/wifi.c:throw_wifi_scan() device 0x73b02780 =
0x72d032e0
connmand[507]: src/device.c:connman_device_ref_debug() 0x73b02780 ref 4 =
by plugins/wifi.c:1242:throw_wifi_scan()
connmand[507]: src/device.c:connman_device_unref_debug() 0x73b02780 ref =
3 by plugins/wifi.c:1250:throw_wifi_scan()
connmand[507]: plugins/wifi.c:autoscan_timeout() interval 9
connmand[507]: src/service.c:service_send_changed()=20
connmand[507]: src/service.c:service_append_added_foreach() new =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/ntp.c:decode_msg() flags      : 0x24
connmand[507]: src/ntp.c:decode_msg() stratum    : 3
connmand[507]: src/ntp.c:decode_msg() poll       : 1024.000000 seconds =
(10)
connmand[507]: src/ntp.c:decode_msg() precision  : 0.000122 seconds =
(-13)
connmand[507]: src/ntp.c:decode_msg() root delay : 0 seconds (fraction =
37127)
connmand[507]: src/ntp.c:decode_msg() root disp. : 0 seconds (fraction =
7173)
connmand[507]: src/ntp.c:decode_msg() reference  : 0x48a8064a
connmand[507]: src/ntp.c:decode_msg() org=3D3907766056.894917 =
rec=3D3907766057.360369 xmt=3D3907766057.360946 dst=3D3907766057.364244
connmand[507]: src/ntp.c:decode_msg() offset=3D0.231077 delay=3D0.468750
connmand[507]: src/ntp.c:decode_msg() Timeserver 192.168.2.1, next sync =
in 1024 seconds
connmand[507]: ntp: adjust (slew): +0.231077 sec
connmand[507]: src/ntp.c:decode_msg() interval/delta/delay/drift =
1024.000000s/+0.231s/0.469s/+18ppm
connmand[507]: src/timeserver.c:ntp_callback() success 1
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 184 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 160 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 68 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1248 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 7
connmand[507]: wlan0 {RX} 50 packets 9237 bytes
connmand[507]: wlan0 {TX} 254 packets 19869 bytes
connmand[507]: wlan0 {update} flags 102403 <UP,LOWER_UP>
connmand[507]: wlan0 {newlink} index 7 address 00:04:F3:1A:5E:E1 mtu =
1500
connmand[507]: wlan0 {newlink} index 7 operstate 5 <DORMANT>
connmand[507]: src/detect.c:detect_newlink() type 1 index 7
connmand[507]: plugins/wifi.c:wifi_newlink() index 7 flags 102403 change =
0
connmand[507]: plugins/wifi.c:wifi_newlink() carrier on
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0400 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 7
connmand[507]: wlan0 {add} route ff00:: gw :: scope 0 <UNIVERSE>
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0400 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 7
connmand[507]: wlan0 {add} route fe80:: gw :: scope 0 <UNIVERSE>
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1248 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 7
connmand[507]: wlan0 {RX} 52 packets 9569 bytes
connmand[507]: wlan0 {TX} 264 packets 20310 bytes
connmand[507]: wlan0 {update} flags 102467 <UP,RUNNING,LOWER_UP>
connmand[507]: wlan0 {newlink} index 7 address 00:04:F3:1A:5E:E1 mtu =
1500
connmand[507]: wlan0 {newlink} index 7 operstate 6 <UP>
connmand[507]: src/detect.c:detect_newlink() type 1 index 7
connmand[507]: plugins/wifi.c:wifi_newlink() index 7 flags 102467 change =
0
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 72 type 20 flags =
0x0000 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 72 type 20 flags =
0x0000 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 4
connmand[507]: eth0 {add} route 2601:647:5a00:15c2:: gw :: scope 0 =
<UNIVERSE>
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0400 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0400 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 7
connmand[507]: wlan0 {add} route 2601:647:5a00:15c2:: gw :: scope 0 =
<UNIVERSE>
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 88 type 20 flags =
0x0000 seq 1 pid 2698885967
connmand[507]: src/ipconfig.c:__connman_ipconfig_newaddr() index 4
connmand[507]: eth0 {add} address 192.168.2.69/24 label eth0 family 2
connmand[507]: src/service.c:service_ip_bound() eth0 ip bound
connmand[507]: src/service.c:service_ip_bound() service 0x72703440 =
ipconfig 0x74308ad0 type 1 method 4
connmand[507]: src/session.c:ipconfig_changed() service 0x72703440 =
ipconfig 0x74308ad0
connmand[507]: src/resolver.c:connman_resolver_remove() index 4 domain =
(null) server 192.168.2.1
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index 4 server =
192.168.2.1
connmand[507]: =
src/resolver.c:__connman_resolver_append_fallback_nameservers() index -1 =
server 8.8.8.8
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_append() index -1 =
server 8.8.8.8
connmand[507]: src/dnsproxy.c:create_server() index -1 server 8.8.8.8
connmand[507]: src/dnsproxy.c:create_server() Adding fallback DNS server =
8.8.8.8
connmand[507]: =
src/resolver.c:__connman_resolver_append_fallback_nameservers() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_append() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:create_server() index -1 server 8.8.4.4
connmand[507]: src/dnsproxy.c:create_server() Adding fallback DNS server =
8.8.4.4
connmand[507]: src/resolver.c:connman_resolver_append() index 4 domain =
(null) server 192.168.2.1
connmand[507]: src/resolver.c:append_resolver() index 4 domain (null) =
server 192.168.2.1 lifetime 0 flags 0
connmand[507]: src/resolver.c:remove_fallback_nameservers() index -1 =
server 8.8.8.8
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index -1 =
server 8.8.8.8
connmand[507]: src/dnsproxy.c:enable_fallback() Enabling fallback DNS =
server 8.8.4.4
connmand[507]: src/resolver.c:remove_fallback_nameservers() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_append() index 4 server =
192.168.2.1
connmand[507]: src/dnsproxy.c:create_server() index 4 server 192.168.2.1
connmand[507]: src/dnsproxy.c:create_server() Adding DNS server =
192.168.2.1
connmand[507]: src/wpad.c:__connman_wpad_start() service 0x72703440
connmand[507]: src/service.c:__connman_service_wispr_start() service =
0x72703440 type IPv4
connmand[507]: src/wispr.c:__connman_wispr_start() service 0x72703440 =
IPv4
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b01430 =
ref 0 by src/wispr.c:1041:__connman_wispr_start()
connmand[507]: src/proxy.c:connman_proxy_lookup_cancel() token 1
connmand[507]: src/service.c:connman_service_unref_debug() 0x72703440 =
ref 2 by src/proxy.c:52:remove_lookup()
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b01220 =
ref 1 by src/wispr.c:233:create_wispr_portal_context()
connmand[507]: src/wispr.c:wispr_portal_detect() wispr/portal context =
0x72b01220 service 0x72703440
connmand[507]: src/wispr.c:wispr_portal_detect() interface eth0
connmand[507]: WEB: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02480 setting nameserver 192.168.2.1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 192.168.2.1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 192.168.2.1
connmand[507]: src/timeserver.c:sync_next() Using timeserver 192.168.2.1
connmand[507]: src/ntp.c:start_ntp() server 192.168.2.1 family 2
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 4
connmand[507]: eth0 {add} route 192.168.2.0 gw 0.0.0.0 scope 253 <LINK>
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/ntp.c:decode_msg() flags      : 0x24
connmand[507]: src/ntp.c:decode_msg() stratum    : 3
connmand[507]: src/ntp.c:decode_msg() poll       : 1024.000000 seconds =
(10)
connmand[507]: src/ntp.c:decode_msg() precision  : 0.000122 seconds =
(-13)
connmand[507]: src/ntp.c:decode_msg() root delay : 0 seconds (fraction =
37127)
connmand[507]: src/ntp.c:decode_msg() root disp. : 0 seconds (fraction =
7685)
connmand[507]: src/ntp.c:decode_msg() reference  : 0x48a8064a
connmand[507]: src/ntp.c:decode_msg() org=3D3907766058.546574 =
rec=3D3907766058.875699 xmt=3D3907766058.876276 dst=3D3907766058.880363
connmand[507]: src/ntp.c:decode_msg() offset=3D0.162519 delay=3D0.333212
connmand[507]: src/ntp.c:decode_msg() Timeserver 192.168.2.1, next sync =
in 1024 seconds
connmand[507]: ntp: adjust (slew): +0.162519 sec
connmand[507]: src/ntp.c:decode_msg() interval/delta/delay/drift =
1024.000000s/+0.163s/0.333s/+18ppm
connmand[507]: src/timeserver.c:ntp_callback() success 1
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 52 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 4
connmand[507]: eth0 {add} route 192.168.2.1 gw 0.0.0.0 scope 253 <LINK>
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 52 type 24 flags =
0x0600 seq 1698777257 pid 3039862813
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 4
connmand[507]: src/service.c:service_route_changed() eth0 route changed
connmand[507]: src/session.c:ipconfig_changed() service 0x72703440 =
ipconfig 0x74308ad0
connmand[507]: eth0 {add} route 0.0.0.0 gw 192.168.2.1 scope 0 =
<UNIVERSE>
connmand[507]: src/connection.c:connection_newgateway() index 4 gateway =
192.168.2.1
connmand[507]: src/connection.c:set_default_gateway() type 1 gateway =
ipv4 0x7471add0 ipv6 (nil)
connmand[507]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[507]: src/inet.c:__connman_inet_rtnl_open() fd 22
connmand[507]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7e861180 =
len 44
connmand[507]: src/inet.c:__connman_inet_rtnl_close() handle 0x7e861180
connmand[507]: src/service.c:__connman_service_indicate_default() =
service 0x72703440 state ready
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 72 type 20 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newaddr() index 4
connmand[507]: eth0 {add} address =
2601:647:5a00:15c2:204:f3ff:fe1a:5ee0/64 label (null) family 10
connmand[507]: src/service.c:service_ip_bound() eth0 ip bound
connmand[507]: src/service.c:service_ip_bound() service 0x72703440 =
ipconfig 0x74308a90 type 2 method 5
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 3 =
(configuration) new state 4 (ready) type 2 (IPv6)
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old ready - new ready/ready =3D> ready
connmand[507]: src/session.c:ipconfig_changed() service 0x72703440 =
ipconfig 0x74308a90
connmand[507]: src/service.c:__connman_service_wispr_start() service =
0x72703440 type IPv6
connmand[507]: src/wispr.c:__connman_wispr_start() service 0x72703440 =
IPv6
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b01170 =
ref 1 by src/wispr.c:233:create_wispr_portal_context()
connmand[507]: src/wispr.c:wispr_portal_detect() wispr/portal context =
0x72b01170 service 0x72703440
connmand[507]: src/wispr.c:wispr_portal_detect() interface eth0
connmand[507]: WEB: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02180 setting nameserver 192.168.2.1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 192.168.2.1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 192.168.2.1
connmand[507]: src/timeserver.c:sync_next() Using timeserver 192.168.2.1
connmand[507]: src/ntp.c:start_ntp() server 192.168.2.1 family 2
connmand[507]: src/resolver.c:__connman_resolver_redo_servers() index 4
connmand[507]: src/inet.c:icmpv6_event()=20
connmand[507]: src/inet.c:icmpv6_recv()=20
connmand[507]: src/inet.c:icmpv6_recv() code 0 len 56 hdr 16
connmand[507]: src/network.c:check_dhcpv6() reply 0x7e8623b0
connmand[507]: src/inet.c:__connman_inet_ipv6_get_prefixes() prefix =
2601:647:5a00:15c2::/64
connmand[507]: src/service.c:connman_service_create_ip6config() ipv6 =
0x74308a90
connmand[507]: src/network.c:connman_network_set_associating() network =
0x731066a0 associating 0
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 4 (ready) new =
state 3 (configuration) type 2 (IPv6)
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old ready - new ready/configuration =3D> ready
connmand[507]: src/network.c:connman_network_unref_debug() 0x731066a0 =
name Wired ref 4 by src/network.c:816:check_dhcpv6()
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/ntp.c:decode_msg() flags      : 0x24
connmand[507]: src/ntp.c:decode_msg() stratum    : 3
connmand[507]: src/ntp.c:decode_msg() poll       : 1024.000000 seconds =
(10)
connmand[507]: src/ntp.c:decode_msg() precision  : 0.000122 seconds =
(-13)
connmand[507]: src/ntp.c:decode_msg() root delay : 0 seconds (fraction =
37127)
connmand[507]: src/ntp.c:decode_msg() root disp. : 0 seconds (fraction =
7685)
connmand[507]: src/ntp.c:decode_msg() reference  : 0x48a8064a
connmand[507]: src/ntp.c:decode_msg() org=3D3907766059.252780 =
rec=3D3907766059.583727 xmt=3D3907766059.584320 dst=3D3907766059.588972
connmand[507]: src/ntp.c:decode_msg() offset=3D0.163147 delay=3D0.335600
connmand[507]: src/ntp.c:decode_msg() Timeserver 192.168.2.1, next sync =
in 1024 seconds
connmand[507]: ntp: adjust (slew): +0.163147 sec
connmand[507]: src/ntp.c:decode_msg() interval/delta/delay/drift =
1024.000000s/+0.163s/0.336s/+18ppm
connmand[507]: src/timeserver.c:ntp_callback() success 1
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 72 type 20 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newaddr() index 7
connmand[507]: wlan0 {add} address =
2601:647:5a00:15c2:204:f3ff:fe1a:5ee1/64 label (null) family 10
connmand[507]: src/resolver.c:__connman_resolver_redo_servers() index 7
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 116 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 72 type 20 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newaddr() index 4
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 72 type 20 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newaddr() index 7
connmand[507]: src/service.c:run_auto_connect()=20
connmand[507]: src/service.c:preferred_tech_add_by_type() type 2 service =
0x72703440 Wired
connmand[507]: src/service.c:preferred_tech_add_by_type() type 5 service =
0x72703840=20
connmand[507]: src/service.c:auto_connect_service() preferred 1 sessions =
0 reason auto
connmand[507]: src/service.c:auto_connect_service() service 0x72703440 =
type ethernet busy
connmand[507]: src/service.c:auto_connect_service() service 0x72703840  =
preferred
connmand[507]: src/service.c:__connman_service_connect() service =
0x72703840 state idle connect reason none -> auto
connmand[507]: src/service.c:__connman_service_clear_error() service =
0x72703840
connmand[507]: src/stats.c:__connman_stats_service_register() service =
0x72703840
connmand[507]: src/stats.c:stats_open() file 0x7430aa50 name =
/var/lib/connman/cellular_311270007006540_context1/data
connmand[507]: src/stats.c:stats_file_setup() file 0x7430aa50 fd 18 name =
/var/lib/connman/cellular_311270007006540_context1/data
connmand[507]: src/stats.c:stats_file_remap() file 0x7430aa50 size 4096 =
addr (nil) len 0
connmand[507]: src/network.c:__connman_network_connect() network =
0x73106a20
connmand[507]: plugins/ofono.c:network_connect() /quectelqmi_0 network =
0x73106a20
connmand[507]: plugins/ofono.c:get_context_with_network() network =
0x73106a20
connmand[507]: plugins/ofono.c:context_set_active() /quectelqmi_0 active =
1
connmand[507]: plugins/ofono.c:set_property() /quectelqmi_0 path =
/quectelqmi_0/context1 org.ofono.ConnectionContext.Active
connmand[507]: plugins/ofono.c:network_context_ref() 0x74305e90 ref 2
connmand[507]: src/network.c:connman_network_set_associating() network =
0x73106a20 associating 1
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703840 (cellular_311270007006540_context1) old state 1 =
(idle) new state 2 (association) type 1 (IPv4)
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 8.8.8.8
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 8.8.4.4
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 8.8.8.8
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 8.8.4.4
connmand[507]: src/timeserver.c:sync_next() Resolving timeserver =
0.pool.ntp.org
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b02a80 hostname 0.pool.ntp.org
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b02a80 =
sending 32 bytes
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b02a80 =
lookup 0x7430a810 id 1 query 0x7471c900
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b02a80 =
sending 32 bytes
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b02a80 =
lookup 0x7430a810 id 1 query 0x7471c870
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b02a80 lookup 0x7430a810 id 1
connmand[507]: src/service.c:service_indicate_state() service 0x72703840 =
old idle - new association/idle =3D> association
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72703840 =
state 2
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: ipconfig state 2 ipconfig method 1
connmand[507]: src/service.c:__connman_service_connect() service =
0x72703840 err -115
connmand[507]: plugins/ofono.c:get_properties_reply() /quectelqmi_0 path =
/quectelqmi_0 org.ofono.NetworkRegistration
connmand[507]: plugins/ofono.c:netreg_properties_reply() /quectelqmi_0
connmand[507]: plugins/ofono.c:netreg_update_regdom() /quectelqmi_0 =
MobileContryCode 311
connmand[507]: src/device.c:connman_device_ref_debug() 0x73b02780 ref 4 =
by plugins/wifi.c:2064:wifi_set_regdom()
connmand[507]: plugins/ofono.c:netreg_update_name() /quectelqmi_0 Name =
311480
connmand[507]: src/network.c:connman_network_set_name() network =
0x73106a20 name 311480
connmand[507]: plugins/ofono.c:netreg_update_strength() /quectelqmi_0 =
Strength 80
connmand[507]: plugins/ofono.c:add_network() /quectelqmi_0
connmand[507]: plugins/ofono.c:set_connected() /quectelqmi_0
connmand[507]: src/service.c:connman_service_create_ip4config() ipv4 =
0x74305d90
connmand[507]: src/network.c:connman_network_set_ipaddress() network =
0x73106a20
connmand[507]: src/ipconfig.c:__connman_ipconfig_set_gateway()=20
connmand[507]: src/service.c:connman_service_create_ip6config() ipv6 =
0x74305d50
connmand[507]: src/network.c:connman_network_set_nameservers() network =
0x73106a20 nameservers 198.224.174.135 198.224.173.135
connmand[507]: src/service.c:__connman_service_nameserver_append() =
service 0x72703840 nameserver 198.224.174.135 auto 0
connmand[507]: src/service.c:__connman_service_nameserver_append() =
service 0x72703840 nameserver 198.224.173.135 auto 0
connmand[507]: src/network.c:connman_network_set_index() index 0 service =
0x72703840 ip4config 0x74305d90
connmand[507]: src/network.c:connman_network_set_index() index 0 service =
0x72703840 ip6config 0x74305d50
connmand[507]: src/network.c:connman_network_set_connected() network =
0x73106a20 connected 0/1 connecting 1 associating 1
connmand[507]: src/network.c:connman_network_set_associating() network =
0x73106a20 associating 0
connmand[507]: src/network.c:set_connected() service 0x72703840 ipv4 =
0x74305d90 ipv6 0x74305d50
connmand[507]: src/network.c:set_configuration() network 0x73106a20
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703840 (cellular_311270007006540_context1) old state 2 =
(association) new state 3 (configuration) type 1 (IPv4)
connmand[507]: src/service.c:service_indicate_state() service 0x72703840 =
old association - new configuration/idle =3D> configuration
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72703840 =
state 3
connmand[507]: src/stats.c:__connman_stats_service_register() service =
0x72703840
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/network.c:__connman_network_enable_ipconfig() ipv4 =
ipconfig method 2
connmand[507]: src/network.c:set_connected_manual() network 0x73106a20
connmand[507]: src/ipconfig.c:__connman_ipconfig_enable() ipconfig =
0x74305d90
connmand[507]: src/ipconfig.c:__connman_ipconfig_ref_debug() 0x74305d90 =
ref 2 by src/ipconfig.c:1720:__connman_ipconfig_enable()
connmand[507]: src/service.c:service_lower_down() wwan0 lower down
connmand[507]: src/service.c:stats_stop() service 0x72703840
connmand[507]: src/service.c:service_save() service 0x72703840 new 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74305d90 identifier cellular_311270007006540_context1 method fixed
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74305d50 identifier cellular_311270007006540_context1 method off
connmand[507]: src/service.c:service_down() wwan0 down
connmand[507]: src/inet.c:connman_inet_set_address() index 6 address =
100.110.85.43 prefix_len 29
connmand[507]: src/inet.c:__connman_inet_modify_address() cmd 0x14 flags =
0x104 index 6 family 2 address 100.110.85.43 peer (null) prefixlen 29 =
broadcast (null) p2p false
connmand[507]: src/ipconfig.c:__connman_ipconfig_gateway_add()=20
connmand[507]: src/ipconfig.c:__connman_ipconfig_gateway_add() type 1 gw =
100.110.85.44 peer (null)
connmand[507]: src/connection.c:__connman_connection_gateway_add() =
service 0x72703840 index 6 gateway 100.110.85.44 vpn ip (null) type 1
connmand[507]: src/service.c:connman_service_ref_debug() 0x72703840 ref =
2 by src/connection.c:416:add_gateway()
connmand[507]: src/connection.c:find_active_gateway()=20
connmand[507]: src/connection.c:__connman_connection_gateway_add() =
active 0x7471ae00 index 4 new 0x7471d470
connmand[507]: src/inet.c:connman_inet_add_network_route() index 6 host =
100.110.85.44 gateway (null) netmask (null)
connmand[507]: src/inet.c:connman_inet_add_network_route() ifname wwan0
connmand[507]: Adding host route failed (Network is down)
connmand[507]: src/inet.c:connman_inet_compare_subnet() host =
198.224.174.135
connmand[507]: src/inet.c:get_interface_addresses() index 6 interface =
wwan0
connmand[507]: src/inet.c:connman_inet_add_network_route() index 6 host =
198.224.174.135 gateway 100.110.85.44 netmask (null)
connmand[507]: src/inet.c:connman_inet_add_network_route() ifname wwan0
connmand[507]: Adding host route failed (Network is unreachable)
connmand[507]: src/inet.c:connman_inet_add_network_route() index 6 host =
198.224.174.135 gateway (null) netmask (null)
connmand[507]: src/inet.c:connman_inet_add_network_route() ifname wwan0
connmand[507]: Adding host route failed (Network is down)
connmand[507]: src/inet.c:connman_inet_compare_subnet() host =
198.224.173.135
connmand[507]: src/inet.c:get_interface_addresses() index 6 interface =
wwan0
connmand[507]: src/inet.c:connman_inet_add_network_route() index 6 host =
198.224.173.135 gateway 100.110.85.44 netmask (null)
connmand[507]: src/inet.c:connman_inet_add_network_route() ifname wwan0
connmand[507]: Adding host route failed (Network is unreachable)
connmand[507]: src/inet.c:connman_inet_add_network_route() index 6 host =
198.224.173.135 gateway (null) netmask (null)
connmand[507]: src/inet.c:connman_inet_add_network_route() ifname wwan0
connmand[507]: Adding host route failed (Network is down)
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703840 (cellular_311270007006540_context1) old state 3 =
(configuration) new state 4 (ready) type 1 (IPv4)
connmand[507]: rp_filter set to 2 (loose mode routing), old value was 2
connmand[507]: src/service.c:service_rp_filter() connected =
cellular_311270007006540_context1 ipconfig 0x74305d90 method 2 count 2 =
filter 2
connmand[507]: src/resolver.c:connman_resolver_append() index 6 domain =
(null) server 198.224.174.135
connmand[507]: src/resolver.c:append_resolver() index 6 domain (null) =
server 198.224.174.135 lifetime 0 flags 0
connmand[507]: src/resolver.c:remove_fallback_nameservers() index -1 =
server 8.8.8.8
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index -1 =
server 8.8.8.8
connmand[507]: src/resolver.c:remove_fallback_nameservers() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_append() index 6 server =
198.224.174.135
connmand[507]: src/dnsproxy.c:create_server() index 6 server =
198.224.174.135
connmand[507]: Failed to connect to server 198.224.174.135
connmand[507]: src/resolver.c:connman_resolver_append() index 6 domain =
(null) server 198.224.173.135
connmand[507]: src/resolver.c:append_resolver() index 6 domain (null) =
server 198.224.173.135 lifetime 0 flags 0
connmand[507]: src/resolver.c:remove_fallback_nameservers() index -1 =
server 8.8.8.8
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index -1 =
server 8.8.8.8
connmand[507]: src/resolver.c:remove_fallback_nameservers() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_append() index 6 server =
198.224.173.135
connmand[507]: src/dnsproxy.c:create_server() index 6 server =
198.224.173.135
connmand[507]: Failed to connect to server 198.224.173.135
connmand[507]: src/service.c:service_indicate_state() service 0x72703840 =
old configuration - new ready/idle =3D> ready
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72703840 =
state 4
connmand[507]: src/service.c:service_save() service 0x72703840 new 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74305d90 identifier cellular_311270007006540_context1 method fixed
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74305d50 identifier cellular_311270007006540_context1 method off
connmand[507]: src/notifier.c:__connman_notifier_connect() type 5
connmand[507]: src/technology.c:technology_find() type 5
connmand[507]: src/technology.c:__connman_technology_set_connected() =
technology 0x75506fe0 connected 1
connmand[507]: src/ipconfig.c:disable_ipv6()=20
connmand[507]: src/ipconfig.c:set_ipv6_state() wwan0 1
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/network.c:set_configuration() network 0x73106a20
connmand[507]: ipconfig state 3 ipconfig method 1
connmand[507]: src/network.c:__connman_network_enable_ipconfig() ipv6 =
ipconfig method 1
connmand[507]: src/ipconfig.c:disable_ipv6()=20
connmand[507]: src/ipconfig.c:set_ipv6_state() wwan0 1
connmand[507]: plugins/wifi.c:scan_finished()=20
connmand[507]: plugins/wifi.c:scan_finished()=20
connmand[507]: plugins/wifi.c:network_added() =
66726f6e746c696e65_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 66726f6e746c696e65_managed_psk
connmand[507]: src/network.c:connman_network_create() network 0x73106160 =
identifier 66726f6e746c696e65_managed_psk type wifi
connmand[507]: src/device.c:connman_device_add_network() device =
0x73b02780 network 0x73106160
connmand[507]: src/network.c:connman_network_ref_debug() 0x73106160 name =
(null) ref 2 by src/device.c:872:connman_device_add_network()
connmand[507]: src/network.c:network_probe() network 0x73106160 name =
(null)
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x73106160
connmand[507]: src/network.c:connman_network_set_name() network =
0x73106160 name frontline
connmand[507]: src/network.c:connman_network_set_available() network =
0x73106160 available 1
connmand[507]: src/network.c:network_probe() network 0x73106160 name =
frontline
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x73106160
connmand[507]: src/service.c:__connman_service_create_from_network() =
network 0x73106160
connmand[507]: src/service.c:connman_service_create() service 0x72703240
connmand[507]: src/service.c:service_initialize() service 0x72703240
connmand[507]: src/service.c:service_get() service 0x72703240
connmand[507]: src/service.c:update_from_network() service 0x72703240 =
network 0x73106160
connmand[507]: src/network.c:connman_network_ref_debug() 0x73106160 name =
frontline ref 3 by src/service.c:7426:update_from_network()
connmand[507]: src/ipconfig.c:__connman_ipconfig_create() ipconfig =
0x7430af10 index 7
connmand[507]: src/ipconfig.c:create_ipv6config() ipconfig 0x7430aed0 =
index 7 method auto
connmand[507]: src/service.c:service_register() service 0x72703240
connmand[507]: src/service.c:service_register() path =
/net/connman/service/wifi_0004f31a5ee1_66726f6e746c696e65_managed_psk
connmand[507]: src/config.c:__connman_config_provision_service() service =
0x72703240 type 3
connmand[507]: src/service.c:service_load() service 0x72703240
connmand[507]: src/storage.c:storage_load() Unable to load =
/var/lib/connman/wifi_0004f31a5ee1_66726f6e746c696e65_managed_psk/settings=
: No such file or directory
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/service.c:service_schedule_added() service 0x72703240
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320506c616365_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/network.c:connman_network_create() network 0x73105fa0 =
identifier 436861726c6965277320506c616365_managed_psk type wifi
connmand[507]: src/device.c:connman_device_add_network() device =
0x73b02780 network 0x73105fa0
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105fa0 name =
(null) ref 2 by src/device.c:872:connman_device_add_network()
connmand[507]: src/network.c:network_probe() network 0x73105fa0 name =
(null)
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x73105fa0
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105fa0 name Charlie's Place
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105fa0 available 1
connmand[507]: src/network.c:network_probe() network 0x73105fa0 name =
Charlie's Place
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x73105fa0
connmand[507]: src/service.c:__connman_service_create_from_network() =
network 0x73105fa0
connmand[507]: src/service.c:connman_service_create() service 0x72703040
connmand[507]: src/service.c:service_initialize() service 0x72703040
connmand[507]: src/service.c:service_get() service 0x72703040
connmand[507]: src/service.c:update_from_network() service 0x72703040 =
network 0x73105fa0
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105fa0 name =
Charlie's Place ref 3 by src/service.c:7426:update_from_network()
connmand[507]: src/ipconfig.c:__connman_ipconfig_create() ipconfig =
0x7430acd0 index 7
connmand[507]: src/ipconfig.c:create_ipv6config() ipconfig 0x7430ac90 =
index 7 method auto
connmand[507]: src/service.c:service_register() service 0x72703040
connmand[507]: src/service.c:service_register() path =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320506c616365_mana=
ged_psk
connmand[507]: src/config.c:__connman_config_provision_service() service =
0x72703040 type 3
connmand[507]: src/service.c:service_load() service 0x72703040
connmand[507]: src/storage.c:storage_load() Unable to load =
/var/lib/connman/wifi_0004f31a5ee1_436861726c6965277320506c616365_managed_=
psk/settings: No such file or directory
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/service.c:service_schedule_added() service 0x72703040
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320546f7973_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: src/network.c:connman_network_create() network 0x73105d00 =
identifier 436861726c6965277320546f7973_managed_psk type wifi
connmand[507]: src/device.c:connman_device_add_network() device =
0x73b02780 network 0x73105d00
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105d00 name =
(null) ref 2 by src/device.c:872:connman_device_add_network()
connmand[507]: src/network.c:network_probe() network 0x73105d00 name =
(null)
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x73105d00
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105d00 name Charlie's Toys
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105d00 available 1
connmand[507]: src/network.c:network_probe() network 0x73105d00 name =
Charlie's Toys
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x73105d00
connmand[507]: src/service.c:__connman_service_create_from_network() =
network 0x73105d00
connmand[507]: src/service.c:connman_service_create() service 0x72702e40
connmand[507]: src/service.c:service_initialize() service 0x72702e40
connmand[507]: src/service.c:service_get() service 0x72702e40
connmand[507]: src/service.c:update_from_network() service 0x72702e40 =
network 0x73105d00
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105d00 name =
Charlie's Toys ref 3 by src/service.c:7426:update_from_network()
connmand[507]: src/ipconfig.c:__connman_ipconfig_create() ipconfig =
0x7430aa90 index 7
connmand[507]: src/ipconfig.c:create_ipv6config() ipconfig 0x7430c950 =
index 7 method auto
connmand[507]: src/service.c:service_register() service 0x72702e40
connmand[507]: src/service.c:service_register() path =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320546f7973_manage=
d_psk
connmand[507]: src/config.c:__connman_config_provision_service() service =
0x72702e40 type 3
connmand[507]: src/service.c:service_load() service 0x72702e40
connmand[507]: src/storage.c:storage_load() Unable to load =
/var/lib/connman/wifi_0004f31a5ee1_436861726c6965277320546f7973_managed_ps=
k/settings: No such file or directory
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/service.c:service_schedule_added() service 0x72702e40
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/network.c:connman_network_create() network 0x73105980 =
identifier 436861726c6965277320467269656e6473_managed_psk type wifi
connmand[507]: src/device.c:connman_device_add_network() device =
0x73b02780 network 0x73105980
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105980 name =
(null) ref 2 by src/device.c:872:connman_device_add_network()
connmand[507]: src/network.c:network_probe() network 0x73105980 name =
(null)
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x73105980
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105980 name Charlie's Friends
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105980 available 1
connmand[507]: src/network.c:network_probe() network 0x73105980 name =
Charlie's Friends
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x73105980
connmand[507]: src/service.c:__connman_service_create_from_network() =
network 0x73105980
connmand[507]: src/service.c:connman_service_create() service 0x72702c40
connmand[507]: src/service.c:service_initialize() service 0x72702c40
connmand[507]: src/service.c:service_get() service 0x72702c40
connmand[507]: src/service.c:update_from_network() service 0x72702c40 =
network 0x73105980
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105980 name =
Charlie's Friends ref 3 by src/service.c:7426:update_from_network()
connmand[507]: src/ipconfig.c:__connman_ipconfig_create() ipconfig =
0x7430c750 index 7
connmand[507]: src/ipconfig.c:create_ipv6config() ipconfig 0x7430c710 =
index 7 method auto
connmand[507]: src/service.c:service_register() service 0x72702c40
connmand[507]: src/service.c:service_register() path =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_=
managed_psk
connmand[507]: src/config.c:__connman_config_provision_service() service =
0x72702c40 type 3
connmand[507]: src/service.c:service_load() service 0x72702c40
connmand[507]: src/ipconfig.c:__connman_ipconfig_load() ipconfig =
0x7430c750 identifier =
wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/ipconfig.c:__connman_ipconfig_load() ipconfig =
0x7430c710 identifier =
wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/service.c:service_schedule_added() service 0x72702c40
connmand[507]: src/service.c:__connman_service_auto_connect()=20
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: plugins/wifi.c:network_added() =
48502d5072696e742d38432d4f66666963656a65742050726f2038363130_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier =
48502d5072696e742d38432d4f66666963656a65742050726f2038363130_managed_psk
connmand[507]: src/network.c:connman_network_create() network 0x731057c0 =
identifier =
48502d5072696e742d38432d4f66666963656a65742050726f2038363130_managed_psk =
type wifi
connmand[507]: src/device.c:connman_device_add_network() device =
0x73b02780 network 0x731057c0
connmand[507]: src/network.c:connman_network_ref_debug() 0x731057c0 name =
(null) ref 2 by src/device.c:872:connman_device_add_network()
connmand[507]: src/network.c:network_probe() network 0x731057c0 name =
(null)
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x731057c0
connmand[507]: src/network.c:connman_network_set_name() network =
0x731057c0 name HP-Print-8C-Officejet Pro 8610
connmand[507]: src/network.c:connman_network_set_available() network =
0x731057c0 available 1
connmand[507]: src/network.c:network_probe() network 0x731057c0 name =
HP-Print-8C-Officejet Pro 8610
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x731057c0
connmand[507]: src/service.c:__connman_service_create_from_network() =
network 0x731057c0
connmand[507]: src/service.c:connman_service_create() service 0x72702a40
connmand[507]: src/service.c:service_initialize() service 0x72702a40
connmand[507]: src/service.c:service_get() service 0x72702a40
connmand[507]: src/service.c:update_from_network() service 0x72702a40 =
network 0x731057c0
connmand[507]: src/network.c:connman_network_ref_debug() 0x731057c0 name =
HP-Print-8C-Officejet Pro 8610 ref 3 by =
src/service.c:7426:update_from_network()
connmand[507]: src/ipconfig.c:__connman_ipconfig_create() ipconfig =
0x7430c490 index 7
connmand[507]: src/ipconfig.c:create_ipv6config() ipconfig 0x7430c450 =
index 7 method auto
connmand[507]: src/service.c:service_register() service 0x72702a40
connmand[507]: src/service.c:service_register() path =
/net/connman/service/wifi_0004f31a5ee1_48502d5072696e742d38432d4f666669636=
56a65742050726f2038363130_managed_psk
connmand[507]: src/config.c:__connman_config_provision_service() service =
0x72702a40 type 3
connmand[507]: src/service.c:service_load() service 0x72702a40
connmand[507]: src/storage.c:storage_load() Unable to load =
/var/lib/connman/wifi_0004f31a5ee1_48502d5072696e742d38432d4f66666963656a6=
5742050726f2038363130_managed_psk/settings: No such file or directory
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/service.c:service_schedule_added() service 0x72702a40
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: plugins/wifi.c:interface_state() wifi 0x73d049c0 =
interface state 6
connmand[507]: plugins/wifi.c:interface_state() wifi 0x73d049c0 =
interface state 8
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Friends
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: plugins/wifi.c:network_associated()=20
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: plugins/wifi.c:network_associated() Reconnecting to =
previous network 0x73105980 from wpa_s
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105980 name =
Charlie's Friends ref 4 by plugins/wifi.c:3090:network_associated()
connmand[507]: plugins/wifi.c:interface_state() wifi 0x73d049c0 =
interface state 8
connmand[507]: plugins/wifi.c:interface_state() DONE
connmand[507]: plugins/wifi.c:interface_state() wifi 0x73d049c0 =
interface state 10
connmand[507]: plugins/wifi.c:reset_autoscan()=20
connmand[507]: src/device.c:connman_device_unref_debug() 0x73b02780 ref =
3 by plugins/wifi.c:866:reset_autoscan()
connmand[507]: src/device.c:connman_device_set_scanning() device =
0x73b02780 scanning 0
connmand[507]: src/network.c:connman_network_set_connected() network =
0x73105980 connected 0/1 connecting 0 associating 0
connmand[507]: src/network.c:connman_network_set_associating() network =
0x73105980 associating 0
connmand[507]: src/network.c:set_connected() service 0x72702c40 ipv4 =
0x7430c750 ipv6 0x7430c710
connmand[507]: src/network.c:set_configuration() network 0x73105980
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72702c40 =
(wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk) old =
state 1 (idle) new state 3 (configuration) type 1 (IPv4)
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b02a80 lookup id 1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b02a80 lookup 0x7430a810
connmand[507]: RESOLV: gweb/gresolv.c:destroy_lookup() resolv 0x71b02a80 =
lookup 0x7430a810 id 1 ipv4 0x7471c900 ipv6 0x7471c870
connmand[507]: RESOLV: gweb/gresolv.c:destroy_query() resolv 0x71b02a80 =
query 0x7471c900 timeout 165
connmand[507]: RESOLV: gweb/gresolv.c:destroy_query() resolv 0x71b02a80 =
query 0x7471c870 timeout 166
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 8.8.8.8
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 8.8.4.4
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b02a80 lookup id 1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 8.8.8.8
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 8.8.4.4
connmand[507]: src/timeserver.c:sync_next() Resolving timeserver =
0.pool.ntp.org
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b02a80 hostname 0.pool.ntp.org
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b02a80 =
sending 32 bytes
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b02a80 =
lookup 0x7430bd90 id 2 query 0x747212e0
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b02a80 =
sending 32 bytes
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b02a80 =
lookup 0x7430bd90 id 2 query 0x74721280
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b02a80 lookup 0x7430bd90 id 2
connmand[507]: src/service.c:service_indicate_state() service 0x72702c40 =
old idle - new configuration/idle =3D> configuration
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72702c40 =
state 3
connmand[507]: src/stats.c:__connman_stats_service_register() service =
0x72702c40
connmand[507]: src/stats.c:stats_open() file 0x7430bd50 name =
/var/lib/connman/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_mana=
ged_psk/data
connmand[507]: src/stats.c:stats_file_setup() file 0x7430bd50 fd 23 name =
/var/lib/connman/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_mana=
ged_psk/data
connmand[507]: src/stats.c:stats_file_remap() file 0x7430bd50 size 4096 =
addr (nil) len 0
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/network.c:__connman_network_enable_ipconfig() ipv4 =
ipconfig method 4
connmand[507]: src/network.c:set_connected_dhcp() network 0x73105980
connmand[507]: src/ipconfig.c:__connman_ipconfig_enable() ipconfig =
0x7430c750
connmand[507]: src/ipconfig.c:__connman_ipconfig_ref_debug() 0x7430c750 =
ref 2 by src/ipconfig.c:1720:__connman_ipconfig_enable()
connmand[507]: src/service.c:service_up() wlan0 up
connmand[507]: src/service.c:service_lower_up() wlan0 lower up
connmand[507]: src/service.c:stats_start() service 0x72702c40
connmand[507]: src/dhcp.c:__connman_dhcp_start()=20
connmand[507]: src/ipconfig.c:__connman_ipconfig_ref_debug() 0x7430c750 =
ref 3 by src/dhcp.c:701:__connman_dhcp_start()
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105980 name =
Charlie's Friends ref 5 by src/dhcp.c:705:__connman_dhcp_start()
connmand[507]: src/dhcp.c:dhcp_initialize() dhcp 0x7550cf80
connmand[507]: src/utsname.c:connman_utsname_get_hostname()=20
connmand[507]: src/utsname.c:connman_utsname_get_hostname() driver =
0x17fa80 name loopback
connmand[507]: src/network.c:set_configuration() network 0x73105980
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72702c40 =
(wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk) old =
state 1 (idle) new state 3 (configuration) type 2 (IPv6)
connmand[507]: src/service.c:service_indicate_state() service 0x72702c40 =
old configuration - new configuration/configuration =3D> configuration
connmand[507]: src/network.c:__connman_network_enable_ipconfig() ipv6 =
ipconfig method 5
connmand[507]: src/network.c:autoconf_ipv6_set() network 0x73105980
connmand[507]: src/ipconfig.c:__connman_ipconfig_enable() ipconfig =
0x7430c710
connmand[507]: src/ipconfig.c:__connman_ipconfig_ref_debug() 0x7430c710 =
ref 2 by src/ipconfig.c:1722:__connman_ipconfig_enable()
connmand[507]: src/ipconfig.c:enable_ipv6()=20
connmand[507]: src/ipconfig.c:set_ipv6_state() wlan0 0
connmand[507]: src/service.c:service_up() wlan0 up
connmand[507]: src/service.c:service_lower_up() wlan0 lower up
connmand[507]: src/service.c:stats_start() service 0x72702c40
connmand[507]: src/ipconfig.c:enable_ipv6()=20
connmand[507]: src/ipconfig.c:set_ipv6_state() wlan0 0
connmand[507]: src/inet.c:connman_inet_clear_ipv6_address() index 7 =
address (null) prefix_len 0
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105980 name =
Charlie's Friends ref 6 by src/network.c:907:autoconf_ipv6_set()
connmand[507]: src/inet.c:__connman_inet_ipv6_send_rs() sock 25
connmand[507]: src/inet.c:ndisc_send_unspec()=20
connmand[507]: plugins/wifi.c:interface_state() DONE
connmand[507]: src/service.c:nameservers_changed_cb() service 0x72703440
connmand[507]: src/wispr.c:proxy_callback() proxy DIRECT
connmand[507]: WEB: gweb/gweb.c:set_accept_option() web 0x755074c0 =
clearing accept option
connmand[507]: WEB: gweb/gweb.c:set_user_agent() web 0x755074c0 setting =
user agent ConnMan/1.42 wispr
connmand[507]: src/wispr.c:wispr_portal_request_portal() wp_context =
0x72b01220 IPv4
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b01220 =
ref 2 by src/wispr.c:543:wispr_portal_request_portal()
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x755074c0 request =
http://ipv4.connman.net/online/status.html
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x755074c0 proxy host =
(null)
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x755074c0 port 80
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x755074c0 host =
ipv4.connman.net
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x755074c0 flags 0
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x755074c0 request =
/online/status.html
connmand[507]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b02480 hostname ipv4.connman.net
connmand[507]: WEB: gweb/gresolv.c:add_query() resolv 0x71b02480 sending =
34 bytes
connmand[507]: WEB: gweb/gresolv.c:add_query() resolv 0x71b02480 lookup =
0x7430bb90 id 1 query 0x74720b30
connmand[507]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b02480 lookup 0x7430bb90 id 1
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b01220 =
ref 1 by src/wispr.c:901:proxy_callback()
connmand[507]: src/wispr.c:proxy_callback() proxy DIRECT
connmand[507]: WEB: gweb/gweb.c:set_accept_option() web 0x75509f80 =
clearing accept option
connmand[507]: WEB: gweb/gweb.c:set_user_agent() web 0x75509f80 setting =
user agent ConnMan/1.42 wispr
connmand[507]: src/wispr.c:wispr_portal_request_portal() wp_context =
0x72b01170 IPv6
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b01170 =
ref 2 by src/wispr.c:543:wispr_portal_request_portal()
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x75509f80 request =
http://ipv6.connman.net/online/status.html
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x75509f80 proxy host =
(null)
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x75509f80 port 80
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x75509f80 host =
ipv6.connman.net
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x75509f80 flags 0
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x75509f80 request =
/online/status.html
connmand[507]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b02180 hostname ipv6.connman.net
connmand[507]: WEB: gweb/gresolv.c:add_query() resolv 0x71b02180 sending =
34 bytes
connmand[507]: WEB: gweb/gresolv.c:add_query() resolv 0x71b02180 lookup =
0x7430bad0 id 1 query 0x74722060
connmand[507]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b02180 lookup 0x7430bad0 id 1
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b01170 =
ref 1 by src/wispr.c:901:proxy_callback()
connmand[507]: src/dhcp.c:lease_available_cb() Lease available
connmand[507]: src/dhcp.c:lease_available_cb() last address 192.168.2.46
connmand[507]: src/dhcp.c:lease_available_cb() c_address (null)
connmand[507]: src/ipconfig.c:__connman_ipconfig_set_gateway()=20
connmand[507]: src/service.c:__connman_service_nameserver_append() =
service 0x72702c40 nameserver 192.168.2.1 auto 0
connmand[507]: src/service.c:__connman_service_timeserver_append() =
service 0x72702c40 timeserver 192.168.2.1
connmand[507]: src/network.c:dhcp_success() lease acquired for ipconfig =
0x7430c750
connmand[507]: src/inet.c:connman_inet_set_address() index 7 address =
192.168.2.46 prefix_len 24
connmand[507]: src/inet.c:__connman_inet_modify_address() cmd 0x14 flags =
0x104 index 7 family 2 address 192.168.2.46 peer (null) prefixlen 24 =
broadcast (null) p2p false
connmand[507]: src/ipconfig.c:__connman_ipconfig_gateway_add()=20
connmand[507]: src/ipconfig.c:__connman_ipconfig_gateway_add() type 1 gw =
192.168.2.1 peer (null)
connmand[507]: src/connection.c:__connman_connection_gateway_add() =
service 0x72702c40 index 7 gateway 192.168.2.1 vpn ip (null) type 1
connmand[507]: src/service.c:connman_service_ref_debug() 0x72702c40 ref =
2 by src/connection.c:416:add_gateway()
connmand[507]: src/connection.c:find_active_gateway()=20
connmand[507]: src/connection.c:__connman_connection_gateway_add() =
active 0x7471ae00 index 4 new 0x74721eb0
connmand[507]: src/inet.c:connman_inet_add_network_route() index 7 host =
192.168.2.1 gateway (null) netmask (null)
connmand[507]: src/inet.c:connman_inet_add_network_route() ifname wlan0
connmand[507]: src/inet.c:connman_inet_compare_subnet() host 192.168.2.1
connmand[507]: src/inet.c:get_interface_addresses() index 7 interface =
wlan0
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72702c40 =
(wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk) old =
state 3 (configuration) new state 4 (ready) type 1 (IPv4)
connmand[507]: src/service.c:service_rp_filter() connected =
wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk =
ipconfig 0x7430c750 method 4 count 3 filter 2
connmand[507]: src/resolver.c:connman_resolver_append() index 7 domain =
(null) server 192.168.2.1
connmand[507]: src/resolver.c:append_resolver() index 7 domain (null) =
server 192.168.2.1 lifetime 0 flags 0
connmand[507]: src/resolver.c:remove_fallback_nameservers() index -1 =
server 8.8.8.8
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index -1 =
server 8.8.8.8
connmand[507]: src/resolver.c:remove_fallback_nameservers() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index -1 =
server 8.8.4.4
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_append() index 7 server =
192.168.2.1
connmand[507]: src/dnsproxy.c:create_server() index 7 server 192.168.2.1
connmand[507]: src/service.c:service_indicate_state() service 0x72702c40 =
old configuration - new ready/configuration =3D> ready
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72702c40 =
state 4
connmand[507]: src/service.c:service_save() service 0x72702c40 new 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x7430c750 identifier =
wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk method =
dhcp
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x7430c710 identifier =
wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk method =
auto
connmand[507]: src/notifier.c:__connman_notifier_connect() type 3
connmand[507]: src/technology.c:technology_find() type 3
connmand[507]: src/technology.c:__connman_technology_set_connected() =
technology 0x75503bc0 connected 1
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/service.c:service_save() service 0x72702c40 new 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x7430c750 identifier =
wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk method =
dhcp
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x7430c710 identifier =
wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk method =
auto
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 88 type 20 flags =
0x0000 seq 1 pid 3651361706
connmand[507]: src/ipconfig.c:__connman_ipconfig_newaddr() index 6
connmand[507]: wwan0 {add} address 100.110.85.43/29 label wwan0 family 2
connmand[507]: WEB: gweb/gresolv.c:parse_response() resolv 0x71b02480 =
response from 192.168.2.1
connmand[507]: WEB: gweb/gresolv.c:parse_response() resolv 0x71b02480 =
msg id: 0xddf8 rcode: 0 count: 1
connmand[507]: WEB: gweb/gresolv.c:destroy_query() resolv 0x71b02480 =
query 0x74720b30 timeout 194
connmand[507]: WEB: gweb/gresolv.c:sort_and_return_results() resolv =
0x71b02480 lookup 0x7430bb90 received 1 results
connmand[507]: WEB: gweb/gresolv.c:destroy_lookup() resolv 0x71b02480 =
lookup 0x7430bb90 id 1 ipv4 (nil) ipv6 (nil)
connmand[507]: WEB: gweb/gweb.c:handle_resolved_address() web 0x755074c0 =
address 82.165.8.211
connmand[507]: src/wispr.c:wispr_route_request() address 82.165.8.211 if =
4 gw 192.168.2.1
connmand[507]: src/inet.c:connman_inet_add_network_route() index 4 host =
82.165.8.211 gateway 192.168.2.1 netmask (null)
connmand[507]: src/inet.c:connman_inet_add_network_route() ifname eth0
connmand[507]: WEB: gweb/gweb.c:connect_session_transport() web =
0x755074c0 no encryption
connmand[507]: WEB: gweb/gweb.c:create_transport() web 0x755074c0 =
creating session 82.165.8.211:80
connmand[507]: WEB: gweb/gresolv.c:parse_response() resolv 0x71b02180 =
response from 192.168.2.1
connmand[507]: WEB: gweb/gresolv.c:parse_response() resolv 0x71b02180 =
msg id: 0x901f rcode: 0 count: 1
connmand[507]: WEB: gweb/gresolv.c:destroy_query() resolv 0x71b02180 =
query 0x74722060 timeout 195
connmand[507]: WEB: gweb/gresolv.c:sort_and_return_results() resolv =
0x71b02180 lookup 0x7430bad0 received 1 results
connmand[507]: WEB: gweb/gresolv.c:destroy_lookup() resolv 0x71b02180 =
lookup 0x7430bad0 id 1 ipv4 (nil) ipv6 (nil)
connmand[507]: WEB: gweb/gweb.c:handle_resolved_address() web 0x75509f80 =
address 2001:8d8:8b4:c861:5826:fa5f:6690:0
connmand[507]: src/wispr.c:wispr_route_request() address =
2001:8d8:8b4:c861:5826:fa5f:6690:0 if 4 gw (null)
connmand[507]: WEB: gweb/gweb.c:connect_session_transport() web =
0x75509f80 no encryption
connmand[507]: WEB: gweb/gweb.c:create_transport() web 0x75509f80 =
creating session 2001:8d8:8b4:c861:5826:fa5f:6690:0:80
connmand[507]: src/service.c:service_send_changed()=20
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: src/service.c:service_append_added_foreach() new =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_=
managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/service.c:service_append_added_foreach() new =
/net/connman/service/wifi_0004f31a5ee1_66726f6e746c696e65_managed_psk
connmand[507]: src/service.c:service_append_added_foreach() new =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320506c616365_mana=
ged_psk
connmand[507]: src/service.c:service_append_added_foreach() new =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320546f7973_manage=
d_psk
connmand[507]: src/service.c:service_append_added_foreach() new =
/net/connman/service/wifi_0004f31a5ee1_48502d5072696e742d38432d4f666669636=
56a65742050726f2038363130_managed_psk
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b02a80 =
response from 8.8.8.8
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b02a80 =
msg id: 0xe489 rcode: 0 count: 4
connmand[507]: RESOLV: gweb/gresolv.c:destroy_query() resolv 0x71b02a80 =
query 0x747212e0 timeout 188
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b02a80 =
response from 8.8.4.4
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b02a80 =
msg id: 0x9380 rcode: 0 count: 0
connmand[507]: src/inet.c:icmpv6_event()=20
connmand[507]: src/inet.c:icmpv6_recv()=20
connmand[507]: src/inet.c:icmpv6_recv() code 0 len 56 hdr 16
connmand[507]: src/network.c:check_dhcpv6() reply 0x7e8623b0
connmand[507]: src/inet.c:__connman_inet_ipv6_get_prefixes() prefix =
2601:647:5a00:15c2::/64
connmand[507]: src/service.c:connman_service_create_ip6config() ipv6 =
0x7430c710
connmand[507]: src/network.c:connman_network_set_associating() network =
0x73105980 associating 0
connmand[507]: src/network.c:connman_network_unref_debug() 0x73105980 =
name Charlie's Friends ref 5 by src/network.c:816:check_dhcpv6()
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b02a80 =
response from 8.8.8.8
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b02a80 =
msg id: 0x9380 rcode: 0 count: 0
connmand[507]: RESOLV: gweb/gresolv.c:destroy_query() resolv 0x71b02a80 =
query 0x74721280 timeout 189
connmand[507]: RESOLV: gweb/gresolv.c:sort_and_return_results() resolv =
0x71b02a80 lookup 0x7430bd90 received 4 results
connmand[507]: RESOLV: gweb/gresolv.c:destroy_lookup() resolv 0x71b02a80 =
lookup 0x7430bd90 id 2 ipv4 (nil) ipv6 (nil)
connmand[507]: src/timeserver.c:resolv_result() status 0
connmand[507]: src/timeserver.c:resolv_result() result[3]: =
198.137.202.32
connmand[507]: src/timeserver.c:resolv_result() result[2]: 173.71.75.37
connmand[507]: src/timeserver.c:resolv_result() result[1]: 172.93.52.73
connmand[507]: src/timeserver.c:resolv_result() result[0]: 198.30.92.2
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b02a80 lookup id 2
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 192.168.2.1
connmand[507]: src/timeserver.c:sync_next() Using timeserver 198.30.92.2
connmand[507]: src/ntp.c:start_ntp() server 198.30.92.2 family 2
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 72 type 20 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newaddr() index 4
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 72 type 20 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newaddr() index 7
connmand[507]: src/rtnl.c:rtnl_message() NEWADDR len 88 type 20 flags =
0x0000 seq 1 pid 2974607882
connmand[507]: src/ipconfig.c:__connman_ipconfig_newaddr() index 7
connmand[507]: wlan0 {add} address 192.168.2.46/24 label wlan0 family 2
connmand[507]: src/service.c:service_ip_bound() wlan0 ip bound
connmand[507]: src/service.c:service_ip_bound() service 0x72702c40 =
ipconfig 0x7430c750 type 1 method 4
connmand[507]: src/session.c:ipconfig_changed() service 0x72702c40 =
ipconfig 0x7430c750
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/ntp.c:decode_msg() flags      : 0x24
connmand[507]: src/ntp.c:decode_msg() stratum    : 2
connmand[507]: src/ntp.c:decode_msg() poll       : 1024.000000 seconds =
(10)
connmand[507]: src/ntp.c:decode_msg() precision  : 0.000001 seconds =
(-20)
connmand[507]: src/ntp.c:decode_msg() root delay : 0 seconds (fraction =
32264)
connmand[507]: src/ntp.c:decode_msg() root disp. : 0 seconds (fraction =
22280)
connmand[507]: src/ntp.c:decode_msg() reference  : 0xf0f4cf82
connmand[507]: src/ntp.c:decode_msg() org=3D3907766067.608073 =
rec=3D3907766067.907775 xmt=3D3907766067.907823 dst=3D3907766067.948937
connmand[507]: src/ntp.c:decode_msg() offset=3D0.129294 delay=3D0.340816
connmand[507]: src/ntp.c:decode_msg() Timeserver 198.30.92.2, next sync =
in 1024 seconds
connmand[507]: ntp: adjust (slew): +0.129294 sec
connmand[507]: src/ntp.c:decode_msg() interval/delta/delay/drift =
1024.000000s/+0.129s/0.341s/+19ppm
connmand[507]: src/timeserver.c:ntp_callback() success 1
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0c00 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0c00 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 7
connmand[507]: wlan0 {add} route 192.168.2.0 gw 0.0.0.0 scope 253 <LINK>
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0c00 seq 0 pid 0
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 52 type 24 flags =
0x0400 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 7
connmand[507]: wlan0 {add} route 192.168.2.1 gw 0.0.0.0 scope 253 <LINK>
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 4
connmand[507]: eth0 {add} route 82.165.8.211 gw 192.168.2.1 scope 0 =
<UNIVERSE>
connmand[507]: src/service.c:nameservers_changed_cb() service 0x72703840
connmand[507]: src/service.c:run_auto_connect()=20
connmand[507]: src/service.c:preferred_tech_add_by_type() type 2 service =
0x72703440 Wired
connmand[507]: src/service.c:preferred_tech_add_by_type() type 3 service =
0x72702c40 Charlie's Friends
connmand[507]: src/service.c:preferred_tech_add_by_type() type 3 service =
0x72703240 frontline
connmand[507]: src/service.c:preferred_tech_add_by_type() type 3 service =
0x72703040 Charlie's Place
connmand[507]: src/service.c:preferred_tech_add_by_type() type 3 service =
0x72702e40 Charlie's Toys
connmand[507]: src/service.c:preferred_tech_add_by_type() type 3 service =
0x72702a40 HP-Print-8C-Officejet Pro 8610
connmand[507]: src/service.c:preferred_tech_add_by_type() type 5 service =
0x72703840 311480
connmand[507]: src/service.c:auto_connect_service() preferred 1 sessions =
0 reason auto
connmand[507]: src/service.c:auto_connect_service() service 0x72703440 =
type ethernet busy
connmand[507]: src/service.c:auto_connect_service() service 0x72702c40 =
type wifi busy
connmand[507]: src/service.c:auto_connect_service() service 0x72703240 =
type wifi ignore
connmand[507]: src/service.c:auto_connect_service() service 0x72703040 =
type wifi ignore
connmand[507]: src/service.c:auto_connect_service() service 0x72702e40 =
type wifi ignore
connmand[507]: src/service.c:auto_connect_service() service 0x72702a40 =
type wifi ignore
connmand[507]: src/service.c:auto_connect_service() service 0x72703840 =
type cellular busy
connmand[507]: src/service.c:nameservers_changed_cb() service 0x72702c40
connmand[507]: src/service.c:run_vpn_auto_connect() stopping, no =
autoconnectable VPNs found
connmand[507]: plugins/ofono.c:set_property_reply() /quectelqmi_0 path =
/quectelqmi_0/context1 org.ofono.ConnectionContext.Active
connmand[507]: plugins/ofono.c:context_set_active_reply() =
/quectelqmi_0/context1
connmand[507]: plugins/ofono.c:network_context_unref() 0x74305e90 ref 1
connmand[507]: src/technology.c:technology_find() type 3
connmand[507]: src/technology.c:connman_technology_regdom_notify()=20
connmand[507]: src/technology.c:connman_technology_regdom_notify() =
Regulatory domain set to US
connmand[507]: src/device.c:connman_device_unref_debug() 0x73b02780 ref =
2 by plugins/wifi.c:2053:wifi_regdom_callback()
connmand[507]: plugins/wifi.c:network_added() =
66726f6e746c696e65_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 66726f6e746c696e65_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73106160 name frontline
connmand[507]: src/network.c:connman_network_set_available() network =
0x73106160 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105980 name Charlie's Friends
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105980 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320506c616365_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105fa0 name Charlie's Place
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105fa0 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320546f7973_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105d00 name Charlie's Toys
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105d00 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105980 name Charlie's Friends
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105980 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320546f7973_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105d00 name Charlie's Toys
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105d00 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320506c616365_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105fa0 name Charlie's Place
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105fa0 available 1
connmand[507]: plugins/wifi.c:network_added() =
66726f6e746c696e65_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 66726f6e746c696e65_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73106160 name frontline
connmand[507]: src/network.c:connman_network_set_available() network =
0x73106160 available 1
connmand[507]: plugins/wifi.c:network_added() =
48502d5072696e742d38432d4f66666963656a65742050726f2038363130_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier =
48502d5072696e742d38432d4f66666963656a65742050726f2038363130_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x731057c0 name HP-Print-8C-Officejet Pro 8610
connmand[507]: src/network.c:connman_network_set_available() network =
0x731057c0 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320546f7973_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105d00 name Charlie's Toys
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105d00 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105980 name Charlie's Friends
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105980 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320506c616365_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105fa0 name Charlie's Place
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105fa0 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320546f7973_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105d00 name Charlie's Toys
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105d00 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105980 name Charlie's Friends
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105980 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320506c616365_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105fa0 name Charlie's Place
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105fa0 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320546f7973_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105d00 name Charlie's Toys
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105d00 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105980 name Charlie's Friends
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105980 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320506c616365_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105fa0 name Charlie's Place
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105fa0 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320506c616365_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105fa0 name Charlie's Place
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105fa0 available 1
connmand[507]: plugins/wifi.c:network_added() hidden_none
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier hidden_none
connmand[507]: src/network.c:connman_network_create() network 0x73105440 =
identifier hidden_none type wifi
connmand[507]: src/device.c:connman_device_add_network() device =
0x73b02780 network 0x73105440
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105440 name =
(null) ref 2 by src/device.c:872:connman_device_add_network()
connmand[507]: src/network.c:network_probe() network 0x73105440 name =
(null)
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x73105440
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105440 available 1
connmand[507]: src/network.c:network_probe() network 0x73105440 name =
(null)
connmand[507]: src/network.c:network_probe() driver 0x180780 name wifi
connmand[507]: plugins/wifi.c:network_probe() network 0x73105440
connmand[507]: src/service.c:__connman_service_create_from_network() =
network 0x73105440
connmand[507]: src/service.c:connman_service_create() service 0x72702840
connmand[507]: src/service.c:service_initialize() service 0x72702840
connmand[507]: src/service.c:service_get() service 0x72702840
connmand[507]: src/service.c:update_from_network() service 0x72702840 =
network 0x73105440
connmand[507]: src/network.c:connman_network_ref_debug() 0x73105440 name =
(null) ref 3 by src/service.c:7426:update_from_network()
connmand[507]: src/ipconfig.c:__connman_ipconfig_create() ipconfig =
0x7430e750 index 7
connmand[507]: src/ipconfig.c:create_ipv6config() ipconfig 0x7430e710 =
index 7 method auto
connmand[507]: src/service.c:service_register() service 0x72702840
connmand[507]: src/service.c:service_register() path =
/net/connman/service/wifi_0004f31a5ee1_hidden_none
connmand[507]: src/config.c:__connman_config_provision_service() service =
0x72702840 type 3
connmand[507]: src/service.c:service_load() service 0x72702840
connmand[507]: src/storage.c:storage_load() Unable to load =
/var/lib/connman/wifi_0004f31a5ee1_hidden_none/settings: No such file or =
directory
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/service.c:service_schedule_added() service 0x72702840
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105980 name Charlie's Friends
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105980 available 1
connmand[507]: plugins/wifi.c:network_added() hidden_none
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier hidden_none
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105440 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320546f7973_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105d00 name Charlie's Toys
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105d00 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105980 name Charlie's Friends
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105980 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320506c616365_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105fa0 name Charlie's Place
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105fa0 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320546f7973_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105d00 name Charlie's Toys
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105d00 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320546f7973_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105d00 name Charlie's Toys
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105d00 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105980 name Charlie's Friends
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105980 available 1
connmand[507]: plugins/wifi.c:network_added() =
436861726c6965277320506c616365_managed_psk
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/network.c:connman_network_set_name() network =
0x73105fa0 name Charlie's Place
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105fa0 available 1
connmand[507]: plugins/wifi.c:network_added() hidden_none
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier hidden_none
connmand[507]: src/network.c:connman_network_set_available() network =
0x73105440 available 1
connmand[507]: plugins/wifi.c:scan_callback() result 0 wifi 0x73d049c0
connmand[507]: plugins/wifi.c:start_autoscan()=20
connmand[507]: src/service.c:service_send_changed()=20
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_=
managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_66726f6e746c696e65_managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320506c616365_mana=
ged_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320546f7973_manage=
d_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_48502d5072696e742d38432d4f666669636=
56a65742050726f2038363130_managed_psk
connmand[507]: src/service.c:service_append_added_foreach() new =
/net/connman/service/wifi_0004f31a5ee1_hidden_none
connmand[507]: src/wispr.c:wispr_portal_web_result()=20
connmand[507]: src/wispr.c:wispr_portal_web_result() status: 400
connmand[507]: src/service.c:__connman_service_online_check() service =
0x72703440 type IPv4 success 0
connmand[507]: src/service.c:downgrade_state() service 0x72703440 state4 =
4 state6 3
connmand[507]: src/service.c:__connman_service_online_check() service =
0x72703440 type IPv4 interval 1
connmand[507]: src/service.c:connman_service_ref_debug() 0x72703440 ref =
3 by src/service.c:6416:__connman_service_online_check()
connmand[507]: src/wispr.c:free_wispr_routes() free route to =
82.165.8.211 if 4 type 1
connmand[507]: src/inet.c:connman_inet_del_network_route() index 4 host =
82.165.8.211
connmand[507]: src/inet.c:connman_inet_del_network_route() ifname eth0
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b01220 =
ref 0 by src/wispr.c:842:wispr_portal_web_result()
connmand[507]: WEB: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b02480 lookup id 1
connmand[507]: src/wispr.c:wispr_portal_web_result()=20
connmand[507]: src/wispr.c:wispr_portal_web_result() status: 400
connmand[507]: src/service.c:__connman_service_online_check() service =
0x72703440 type IPv6 success 0
connmand[507]: src/service.c:downgrade_state() service 0x72703440 state4 =
4 state6 3
connmand[507]: src/service.c:__connman_service_online_check() service =
0x72703440 type IPv6 interval 1
connmand[507]: src/service.c:connman_service_ref_debug() 0x72703440 ref =
4 by src/service.c:6416:__connman_service_online_check()
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b01170 =
ref 0 by src/wispr.c:842:wispr_portal_web_result()
connmand[507]: WEB: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b02180 lookup id 1
connmand[507]: src/rtnl.c:rtnl_message() DELROUTE len 60 type 25 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_delroute() index 4
connmand[507]: eth0 {del} route 82.165.8.211 gw 192.168.2.1 scope 0 =
<UNIVERSE>
connmand[507]: src/service.c:redo_wispr() Retrying IPv4 WISPr for =
0x72703440 Wired
connmand[507]: src/wispr.c:__connman_wispr_start() service 0x72703440 =
IPv4
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b00930 =
ref 1 by src/wispr.c:233:create_wispr_portal_context()
connmand[507]: src/wispr.c:wispr_portal_detect() wispr/portal context =
0x72b00930 service 0x72703440
connmand[507]: src/wispr.c:wispr_portal_detect() interface eth0
connmand[507]: WEB: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b01e80 setting nameserver 192.168.2.1
connmand[507]: src/service.c:connman_service_unref_debug() 0x72703440 =
ref 3 by src/service.c:6351:redo_wispr()
connmand[507]: src/service.c:redo_wispr() Retrying IPv6 WISPr for =
0x72703440 Wired
connmand[507]: src/wispr.c:__connman_wispr_start() service 0x72703440 =
IPv6
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b00880 =
ref 1 by src/wispr.c:233:create_wispr_portal_context()
connmand[507]: src/wispr.c:wispr_portal_detect() wispr/portal context =
0x72b00880 service 0x72703440
connmand[507]: src/wispr.c:wispr_portal_detect() interface eth0
connmand[507]: WEB: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b01b80 setting nameserver 192.168.2.1
connmand[507]: src/service.c:connman_service_unref_debug() 0x72703440 =
ref 2 by src/service.c:6351:redo_wispr()
connmand[507]: src/wispr.c:proxy_callback() proxy DIRECT
connmand[507]: WEB: gweb/gweb.c:set_accept_option() web 0x7550d880 =
clearing accept option
connmand[507]: WEB: gweb/gweb.c:set_user_agent() web 0x7550d880 setting =
user agent ConnMan/1.42 wispr
connmand[507]: src/wispr.c:wispr_portal_request_portal() wp_context =
0x72b00930 IPv4
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b00930 =
ref 2 by src/wispr.c:543:wispr_portal_request_portal()
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d880 request =
http://ipv4.connman.net/online/status.html
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d880 proxy host =
(null)
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d880 port 80
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d880 host =
ipv4.connman.net
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d880 flags 0
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d880 request =
/online/status.html
connmand[507]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b01e80 hostname ipv4.connman.net
connmand[507]: WEB: gweb/gresolv.c:add_query() resolv 0x71b01e80 sending =
34 bytes
connmand[507]: WEB: gweb/gresolv.c:add_query() resolv 0x71b01e80 lookup =
0x7430e4d0 id 1 query 0x74723b90
connmand[507]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b01e80 lookup 0x7430e4d0 id 1
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b00930 =
ref 1 by src/wispr.c:901:proxy_callback()
connmand[507]: src/wispr.c:proxy_callback() proxy DIRECT
connmand[507]: WEB: gweb/gweb.c:set_accept_option() web 0x7550d760 =
clearing accept option
connmand[507]: WEB: gweb/gweb.c:set_user_agent() web 0x7550d760 setting =
user agent ConnMan/1.42 wispr
connmand[507]: src/wispr.c:wispr_portal_request_portal() wp_context =
0x72b00880 IPv6
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b00880 =
ref 2 by src/wispr.c:543:wispr_portal_request_portal()
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d760 request =
http://ipv6.connman.net/online/status.html
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d760 proxy host =
(null)
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d760 port 80
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d760 host =
ipv6.connman.net
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d760 flags 0
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550d760 request =
/online/status.html
connmand[507]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b01b80 hostname ipv6.connman.net
connmand[507]: WEB: gweb/gresolv.c:add_query() resolv 0x71b01b80 sending =
34 bytes
connmand[507]: WEB: gweb/gresolv.c:add_query() resolv 0x71b01b80 lookup =
0x7430e410 id 1 query 0x747250c0
connmand[507]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b01b80 lookup 0x7430e410 id 1
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b00880 =
ref 1 by src/wispr.c:901:proxy_callback()
connmand[507]: WEB: gweb/gresolv.c:parse_response() resolv 0x71b01e80 =
response from 192.168.2.1
connmand[507]: WEB: gweb/gresolv.c:parse_response() resolv 0x71b01e80 =
msg id: 0x2c8d rcode: 0 count: 1
connmand[507]: WEB: gweb/gresolv.c:destroy_query() resolv 0x71b01e80 =
query 0x74723b90 timeout 220
connmand[507]: WEB: gweb/gresolv.c:sort_and_return_results() resolv =
0x71b01e80 lookup 0x7430e4d0 received 1 results
connmand[507]: WEB: gweb/gresolv.c:destroy_lookup() resolv 0x71b01e80 =
lookup 0x7430e4d0 id 1 ipv4 (nil) ipv6 (nil)
connmand[507]: WEB: gweb/gweb.c:handle_resolved_address() web 0x7550d880 =
address 82.165.8.211
connmand[507]: src/wispr.c:wispr_route_request() address 82.165.8.211 if =
4 gw 192.168.2.1
connmand[507]: src/inet.c:connman_inet_add_network_route() index 4 host =
82.165.8.211 gateway 192.168.2.1 netmask (null)
connmand[507]: src/inet.c:connman_inet_add_network_route() ifname eth0
connmand[507]: WEB: gweb/gweb.c:connect_session_transport() web =
0x7550d880 no encryption
connmand[507]: WEB: gweb/gweb.c:create_transport() web 0x7550d880 =
creating session 82.165.8.211:80
connmand[507]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0600 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newroute() index 4
connmand[507]: eth0 {add} route 82.165.8.211 gw 192.168.2.1 scope 0 =
<UNIVERSE>
connmand[507]: WEB: gweb/gresolv.c:parse_response() resolv 0x71b01b80 =
response from 192.168.2.1
connmand[507]: WEB: gweb/gresolv.c:parse_response() resolv 0x71b01b80 =
msg id: 0xfaba rcode: 0 count: 1
connmand[507]: WEB: gweb/gresolv.c:destroy_query() resolv 0x71b01b80 =
query 0x747250c0 timeout 221
connmand[507]: WEB: gweb/gresolv.c:sort_and_return_results() resolv =
0x71b01b80 lookup 0x7430e410 received 1 results
connmand[507]: WEB: gweb/gresolv.c:destroy_lookup() resolv 0x71b01b80 =
lookup 0x7430e410 id 1 ipv4 (nil) ipv6 (nil)
connmand[507]: WEB: gweb/gweb.c:handle_resolved_address() web 0x7550d760 =
address 2001:8d8:8b4:c861:5826:fa5f:6690:0
connmand[507]: src/wispr.c:wispr_route_request() address =
2001:8d8:8b4:c861:5826:fa5f:6690:0 if 4 gw (null)
connmand[507]: WEB: gweb/gweb.c:connect_session_transport() web =
0x7550d760 no encryption
connmand[507]: WEB: gweb/gweb.c:create_transport() web 0x7550d760 =
creating session 2001:8d8:8b4:c861:5826:fa5f:6690:0:80
connmand[507]: WEB: gweb/gweb.c:start_request() web 0x7550d880 request =
/online/status.html from ipv4.connman.net
connmand[507]: WEB: gweb/gweb.c:process_send_buffer() web 0x7550d880 =
status 1 bytes to write 111 bytes written 111
connmand[507]: WEB: gweb/gweb.c:received_data() web 0x7550d880 bytes =
read 206
connmand[507]: WEB: gweb/gweb.c:received_data() web 0x7550d880 [header] =
HTTP/1.1 200 OK
connmand[507]: WEB: gweb/gweb.c:received_data() web 0x7550d880 [header] =
Server: nginx
connmand[507]: WEB: gweb/gweb.c:received_data() web 0x7550d880 [header] =
Date: Tue, 31 Oct 2023 18:37:45 GMT
connmand[507]: WEB: gweb/gweb.c:received_data() web 0x7550d880 [header] =
Content-Type: text/html
connmand[507]: WEB: gweb/gweb.c:received_data() web 0x7550d880 [header] =
Content-Length: 45
connmand[507]: WEB: gweb/gweb.c:received_data() web 0x7550d880 [header] =
Connection: close
connmand[507]: WEB: gweb/gweb.c:received_data() web 0x7550d880 [header] =
X-ConnMan-Status: online
connmand[507]: WEB: gweb/gweb.c:handle_body() web 0x7550d880 [body] =
length 45
connmand[507]: src/wispr.c:wispr_portal_web_result()=20
connmand[507]: WEB: gweb/gweb.c:received_data() web 0x7550d880 bytes =
read 0
connmand[507]: src/wispr.c:wispr_portal_web_result()=20
connmand[507]: src/wispr.c:wispr_portal_web_result() status: 200
connmand[507]: src/wispr.c:portal_manage_status()=20
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 4 (ready) new =
state 5 (online) type 1 (IPv4)
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b02a80 lookup id 2
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 192.168.2.1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b02a80 lookup id 2
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b02a80 setting nameserver 192.168.2.1
connmand[507]: src/timeserver.c:sync_next() Using timeserver 192.168.2.1
connmand[507]: src/ntp.c:start_ntp() server 192.168.2.1 family 2
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old ready - new online/configuration =3D> online
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72703440 =
state 5
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/notifier.c:__connman_notifier_enter_online() type 2
connmand[507]: src/service.c:__connman_service_online_check() service =
0x72703440 type IPv4 success 1
connmand[507]: src/service.c:__connman_service_online_check() service =
0x72703440 type IPv4 interval 12
connmand[507]: src/service.c:connman_service_ref_debug() 0x72703440 ref =
3 by src/service.c:6416:__connman_service_online_check()
connmand[507]: src/wispr.c:free_wispr_routes() free route to =
82.165.8.211 if 4 type 1
connmand[507]: src/inet.c:connman_inet_del_network_route() index 4 host =
82.165.8.211
connmand[507]: src/inet.c:connman_inet_del_network_route() ifname eth0
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b00930 =
ref 0 by src/wispr.c:842:wispr_portal_web_result()
connmand[507]: WEB: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b01e80 lookup id 1
connmand[507]: src/rtnl.c:rtnl_message() DELROUTE len 60 type 25 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_delroute() index 4
connmand[507]: eth0 {del} route 82.165.8.211 gw 192.168.2.1 scope 0 =
<UNIVERSE>
connmand[507]: src/ntp.c:decode_msg() flags      : 0x24
connmand[507]: src/ntp.c:decode_msg() stratum    : 3
connmand[507]: src/ntp.c:decode_msg() poll       : 1024.000000 seconds =
(10)
connmand[507]: src/ntp.c:decode_msg() precision  : 0.000122 seconds =
(-13)
connmand[507]: src/ntp.c:decode_msg() root delay : 0 seconds (fraction =
37127)
connmand[507]: src/ntp.c:decode_msg() root disp. : 0 seconds (fraction =
59653)
connmand[507]: src/ntp.c:decode_msg() reference  : 0x48a8064a
connmand[507]: src/ntp.c:decode_msg() org=3D3907766265.271398 =
rec=3D3907766265.539168 xmt=3D3907766265.539745 dst=3D3907766265.616362
connmand[507]: src/ntp.c:decode_msg() offset=3D0.095577 delay=3D0.344387
connmand[507]: src/ntp.c:decode_msg() Timeserver 192.168.2.1, next sync =
in 1024 seconds
connmand[507]: ntp: adjust (slew): +0.095577 sec
connmand[507]: src/ntp.c:decode_msg() interval/delta/delay/drift =
1024.000000s/+0.096s/0.344s/+37ppm
connmand[507]: src/timeserver.c:ntp_callback() success 1
connmand[507]: src/service.c:service_send_changed()=20
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_=
managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_66726f6e746c696e65_managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320506c616365_mana=
ged_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320546f7973_manage=
d_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_48502d5072696e742d38432d4f666669636=
56a65742050726f2038363130_managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_hidden_none
connmand[507]: plugins/wifi.c:network_changed() name=20
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier hidden_none
connmand[507]: plugins/wifi.c:network_removed() name=20
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier hidden_none
connmand[507]: src/device.c:connman_device_remove_network() device =
0x73b02780 network 0x73105440
connmand[507]: src/device.c:free_network() network 0x73105440
connmand[507]: src/network.c:network_remove() network 0x73105440 name =
(null)
connmand[507]: src/service.c:__connman_service_remove_from_network() =
network 0x73105440 service 0x72702840
connmand[507]: src/connection.c:__connman_connection_gateway_remove() =
service 0x72702840 type 3
connmand[507]: src/service.c:connman_service_unref_debug() 0x72702840 =
ref 0 by src/service.c:7655:__connman_service_remove_from_network()
connmand[507]: src/service.c:__connman_service_disconnect() service =
0x72702840
connmand[507]: src/agent.c:connman_agent_cancel() context 0x72702840
connmand[507]: src/stats.c:__connman_stats_service_unregister() service =
0x72702840
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x73105440
connmand[507]: src/service.c:service_free() service 0x72702840
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/service.c:service_schedule_removed() service =
0x72702840 /net/connman/service/wifi_0004f31a5ee1_hidden_none
connmand[507]: src/wispr.c:__connman_wispr_stop() service 0x72702840
connmand[507]: src/service.c:stats_stop() service 0x72702840
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x73105440
connmand[507]: src/network.c:connman_network_unref_debug() 0x73105440 =
name (null) ref 2 by src/service.c:5114:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430e750 ref 0 by src/service.c:5124:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430e750
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430e710 ref 0 by src/service.c:5131:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430e710
connmand[507]: plugins/wifi.c:network_remove() network 0x73105440
connmand[507]: src/network.c:connman_network_unref_debug() 0x73105440 =
name (null) ref 1 by src/device.c:400:free_network()
connmand[507]: src/network.c:connman_network_unref_debug() 0x73105440 =
name (null) ref 0 by plugins/wifi.c:2984:network_removed()
connmand[507]: src/network.c:network_destruct() network 0x73105440 name =
(null)
connmand[507]: src/service.c:service_send_changed()=20
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_=
managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_66726f6e746c696e65_managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320506c616365_mana=
ged_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320546f7973_manage=
d_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_48502d5072696e742d38432d4f666669636=
56a65742050726f2038363130_managed_psk
connmand[507]: src/service.c:append_removed() removed =
/net/connman/service/wifi_0004f31a5ee1_hidden_none
connmand[507]: src/wispr.c:wispr_portal_web_result()=20
connmand[507]: src/wispr.c:wispr_portal_web_result() status: 400
connmand[507]: src/service.c:__connman_service_online_check() service =
0x72703440 type IPv6 success 0
connmand[507]: src/service.c:downgrade_state() service 0x72703440 state4 =
5 state6 3
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 5 (online) =
new state 4 (ready) type 1 (IPv4)
connmand[507]: src/service.c:service_rp_filter() connected =
ethernet_0004f31a5ee0_cable ipconfig 0x74308ad0 method 4 count 4 filter =
2
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old online - new ready/configuration =3D> ready
connmand[507]: src/notifier.c:__connman_notifier_leave_online() type 2
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72703440 =
state 4
connmand[507]: src/service.c:service_save() service 0x72703440 new 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74308ad0 identifier ethernet_0004f31a5ee0_cable method dhcp
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74308a90 identifier ethernet_0004f31a5ee0_cable method auto
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/service.c:__connman_service_online_check() service =
0x72703440 type IPv6 interval 1
connmand[507]: src/service.c:connman_service_ref_debug() 0x72703440 ref =
4 by src/service.c:6416:__connman_service_online_check()
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b00880 =
ref 0 by src/wispr.c:842:wispr_portal_web_result()
connmand[507]: WEB: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b01b80 lookup id 1
connmand[507]: src/service.c:run_vpn_auto_connect() stopping, no =
autoconnectable VPNs found
connmand[507]: src/service.c:service_send_changed()=20
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_=
managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_66726f6e746c696e65_managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320506c616365_mana=
ged_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320546f7973_manage=
d_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_48502d5072696e742d38432d4f666669636=
56a65742050726f2038363130_managed_psk
connmand[507]: src/service.c:redo_wispr() Retrying IPv6 WISPr for =
0x72703440 Wired
connmand[507]: src/wispr.c:__connman_wispr_start() service 0x72703440 =
IPv6
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b00720 =
ref 1 by src/wispr.c:233:create_wispr_portal_context()
connmand[507]: src/wispr.c:wispr_portal_detect() wispr/portal context =
0x72b00720 service 0x72703440
connmand[507]: src/wispr.c:wispr_portal_detect() interface eth0
connmand[507]: WEB: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b01880 setting nameserver 192.168.2.1
connmand[507]: src/service.c:connman_service_unref_debug() 0x72703440 =
ref 3 by src/service.c:6351:redo_wispr()
connmand[507]: src/wispr.c:proxy_callback() proxy DIRECT
connmand[507]: WEB: gweb/gweb.c:set_accept_option() web 0x7550f740 =
clearing accept option
connmand[507]: WEB: gweb/gweb.c:set_user_agent() web 0x7550f740 setting =
user agent ConnMan/1.42 wispr
connmand[507]: src/wispr.c:wispr_portal_request_portal() wp_context =
0x72b00720 IPv6
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b00720 =
ref 2 by src/wispr.c:543:wispr_portal_request_portal()
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550f740 request =
http://ipv6.connman.net/online/status.html
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550f740 proxy host =
(null)
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550f740 port 80
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550f740 host =
ipv6.connman.net
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550f740 flags 0
connmand[507]: WEB: gweb/gweb.c:do_request() web 0x7550f740 request =
/online/status.html
connmand[507]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b01880 hostname ipv6.connman.net
connmand[507]: WEB: gweb/gresolv.c:add_query() resolv 0x71b01880 sending =
34 bytes
connmand[507]: WEB: gweb/gresolv.c:add_query() resolv 0x71b01880 lookup =
0x7430dcd0 id 1 query 0x747252d0
connmand[507]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b01880 lookup 0x7430dcd0 id 1
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b00720 =
ref 1 by src/wispr.c:901:proxy_callback()
connmand[507]: WEB: gweb/gresolv.c:parse_response() resolv 0x71b01880 =
response from 192.168.2.1
connmand[507]: WEB: gweb/gresolv.c:parse_response() resolv 0x71b01880 =
msg id: 0x2c3d rcode: 0 count: 1
connmand[507]: WEB: gweb/gresolv.c:destroy_query() resolv 0x71b01880 =
query 0x747252d0 timeout 247
connmand[507]: WEB: gweb/gresolv.c:sort_and_return_results() resolv =
0x71b01880 lookup 0x7430dcd0 received 1 results
connmand[507]: WEB: gweb/gresolv.c:destroy_lookup() resolv 0x71b01880 =
lookup 0x7430dcd0 id 1 ipv4 (nil) ipv6 (nil)
connmand[507]: WEB: gweb/gweb.c:handle_resolved_address() web 0x7550f740 =
address 2001:8d8:8b4:c861:5826:fa5f:6690:0
connmand[507]: src/wispr.c:wispr_route_request() address =
2001:8d8:8b4:c861:5826:fa5f:6690:0 if 4 gw (null)
connmand[507]: WEB: gweb/gweb.c:connect_session_transport() web =
0x7550f740 no encryption
connmand[507]: WEB: gweb/gweb.c:create_transport() web 0x7550f740 =
creating session 2001:8d8:8b4:c861:5826:fa5f:6690:0:80
connmand[507]: plugins/wifi.c:network_changed() name frontline
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 66726f6e746c696e65_managed_psk
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Place
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Toys
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: plugins/wifi.c:network_removed() name frontline
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 66726f6e746c696e65_managed_psk
connmand[507]: src/device.c:connman_device_remove_network() device =
0x73b02780 network 0x73106160
connmand[507]: src/device.c:free_network() network 0x73106160
connmand[507]: src/network.c:network_remove() network 0x73106160 name =
frontline
connmand[507]: src/service.c:__connman_service_remove_from_network() =
network 0x73106160 service 0x72703240
connmand[507]: src/connection.c:__connman_connection_gateway_remove() =
service 0x72703240 type 3
connmand[507]: src/service.c:connman_service_unref_debug() 0x72703240 =
ref 0 by src/service.c:7655:__connman_service_remove_from_network()
connmand[507]: src/service.c:__connman_service_disconnect() service =
0x72703240
connmand[507]: src/agent.c:connman_agent_cancel() context 0x72703240
connmand[507]: src/stats.c:__connman_stats_service_unregister() service =
0x72703240
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x73106160
connmand[507]: src/service.c:service_free() service 0x72703240
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/service.c:service_schedule_removed() service =
0x72703240 =
/net/connman/service/wifi_0004f31a5ee1_66726f6e746c696e65_managed_psk
connmand[507]: src/wispr.c:__connman_wispr_stop() service 0x72703240
connmand[507]: src/service.c:stats_stop() service 0x72703240
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x73106160
connmand[507]: src/network.c:connman_network_unref_debug() 0x73106160 =
name frontline ref 2 by src/service.c:5114:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430af10 ref 0 by src/service.c:5124:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430af10
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430aed0 ref 0 by src/service.c:5131:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430aed0
connmand[507]: plugins/wifi.c:network_remove() network 0x73106160
connmand[507]: src/network.c:connman_network_unref_debug() 0x73106160 =
name frontline ref 1 by src/device.c:400:free_network()
connmand[507]: src/network.c:connman_network_unref_debug() 0x73106160 =
name frontline ref 0 by plugins/wifi.c:2984:network_removed()
connmand[507]: src/network.c:network_destruct() network 0x73106160 name =
frontline
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Place
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Toys
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: plugins/wifi.c:network_removed() name =
HP-Print-8C-Officejet Pro 8610
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier =
48502d5072696e742d38432d4f66666963656a65742050726f2038363130_managed_psk
connmand[507]: src/device.c:connman_device_remove_network() device =
0x73b02780 network 0x731057c0
connmand[507]: src/device.c:free_network() network 0x731057c0
connmand[507]: src/network.c:network_remove() network 0x731057c0 name =
HP-Print-8C-Officejet Pro 8610
connmand[507]: src/service.c:__connman_service_remove_from_network() =
network 0x731057c0 service 0x72702a40
connmand[507]: src/connection.c:__connman_connection_gateway_remove() =
service 0x72702a40 type 3
connmand[507]: src/service.c:connman_service_unref_debug() 0x72702a40 =
ref 0 by src/service.c:7655:__connman_service_remove_from_network()
connmand[507]: src/service.c:__connman_service_disconnect() service =
0x72702a40
connmand[507]: src/agent.c:connman_agent_cancel() context 0x72702a40
connmand[507]: src/stats.c:__connman_stats_service_unregister() service =
0x72702a40
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x731057c0
connmand[507]: src/service.c:service_free() service 0x72702a40
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/service.c:service_schedule_removed() service =
0x72702a40 =
/net/connman/service/wifi_0004f31a5ee1_48502d5072696e742d38432d4f666669636=
56a65742050726f2038363130_managed_psk
connmand[507]: src/wispr.c:__connman_wispr_stop() service 0x72702a40
connmand[507]: src/service.c:stats_stop() service 0x72702a40
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x731057c0
connmand[507]: src/network.c:connman_network_unref_debug() 0x731057c0 =
name HP-Print-8C-Officejet Pro 8610 ref 2 by =
src/service.c:5114:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430c490 ref 0 by src/service.c:5124:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430c490
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430c450 ref 0 by src/service.c:5131:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430c450
connmand[507]: plugins/wifi.c:network_remove() network 0x731057c0
connmand[507]: src/network.c:connman_network_unref_debug() 0x731057c0 =
name HP-Print-8C-Officejet Pro 8610 ref 1 by =
src/device.c:400:free_network()
connmand[507]: src/network.c:connman_network_unref_debug() 0x731057c0 =
name HP-Print-8C-Officejet Pro 8610 ref 0 by =
plugins/wifi.c:2984:network_removed()
connmand[507]: src/network.c:network_destruct() network 0x731057c0 name =
HP-Print-8C-Officejet Pro 8610
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Toys
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Place
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Toys
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Place
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/service.c:service_send_changed()=20
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_=
managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320506c616365_mana=
ged_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320546f7973_manage=
d_psk
connmand[507]: src/service.c:append_removed() removed =
/net/connman/service/wifi_0004f31a5ee1_48502d5072696e742d38432d4f666669636=
56a65742050726f2038363130_managed_psk
connmand[507]: src/service.c:append_removed() removed =
/net/connman/service/wifi_0004f31a5ee1_66726f6e746c696e65_managed_psk
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Place
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Place
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: plugins/wifi.c:network_changed() name Charlie's Place
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: plugins/wifi.c:network_removed() name Charlie's Place
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320506c616365_managed_psk
connmand[507]: src/device.c:connman_device_remove_network() device =
0x73b02780 network 0x73105fa0
connmand[507]: src/device.c:free_network() network 0x73105fa0
connmand[507]: src/network.c:network_remove() network 0x73105fa0 name =
Charlie's Place
connmand[507]: src/service.c:__connman_service_remove_from_network() =
network 0x73105fa0 service 0x72703040
connmand[507]: src/connection.c:__connman_connection_gateway_remove() =
service 0x72703040 type 3
connmand[507]: src/service.c:connman_service_unref_debug() 0x72703040 =
ref 0 by src/service.c:7655:__connman_service_remove_from_network()
connmand[507]: src/service.c:__connman_service_disconnect() service =
0x72703040
connmand[507]: src/agent.c:connman_agent_cancel() context 0x72703040
connmand[507]: src/stats.c:__connman_stats_service_unregister() service =
0x72703040
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x73105fa0
connmand[507]: src/service.c:service_free() service 0x72703040
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/service.c:service_schedule_removed() service =
0x72703040 =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320506c616365_mana=
ged_psk
connmand[507]: src/wispr.c:__connman_wispr_stop() service 0x72703040
connmand[507]: src/service.c:stats_stop() service 0x72703040
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x73105fa0
connmand[507]: src/network.c:connman_network_unref_debug() 0x73105fa0 =
name Charlie's Place ref 2 by src/service.c:5114:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430acd0 ref 0 by src/service.c:5124:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430acd0
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430ac90 ref 0 by src/service.c:5131:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430ac90
connmand[507]: plugins/wifi.c:network_remove() network 0x73105fa0
connmand[507]: src/network.c:connman_network_unref_debug() 0x73105fa0 =
name Charlie's Place ref 1 by src/device.c:400:free_network()
connmand[507]: src/network.c:connman_network_unref_debug() 0x73105fa0 =
name Charlie's Place ref 0 by plugins/wifi.c:2984:network_removed()
connmand[507]: src/network.c:network_destruct() network 0x73105fa0 name =
Charlie's Place
connmand[507]: plugins/wifi.c:network_removed() name Charlie's Toys
connmand[507]: src/device.c:connman_device_get_network() device =
0x73b02780 identifier 436861726c6965277320546f7973_managed_psk
connmand[507]: src/device.c:connman_device_remove_network() device =
0x73b02780 network 0x73105d00
connmand[507]: src/device.c:free_network() network 0x73105d00
connmand[507]: src/network.c:network_remove() network 0x73105d00 name =
Charlie's Toys
connmand[507]: src/service.c:__connman_service_remove_from_network() =
network 0x73105d00 service 0x72702e40
connmand[507]: src/connection.c:__connman_connection_gateway_remove() =
service 0x72702e40 type 3
connmand[507]: src/service.c:connman_service_unref_debug() 0x72702e40 =
ref 0 by src/service.c:7655:__connman_service_remove_from_network()
connmand[507]: src/service.c:__connman_service_disconnect() service =
0x72702e40
connmand[507]: src/agent.c:connman_agent_cancel() context 0x72702e40
connmand[507]: src/stats.c:__connman_stats_service_unregister() service =
0x72702e40
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x73105d00
connmand[507]: src/service.c:service_free() service 0x72702e40
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/service.c:service_schedule_removed() service =
0x72702e40 =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320546f7973_manage=
d_psk
connmand[507]: src/wispr.c:__connman_wispr_stop() service 0x72702e40
connmand[507]: src/service.c:stats_stop() service 0x72702e40
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471ae00
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x73105d00
connmand[507]: src/network.c:connman_network_unref_debug() 0x73105d00 =
name Charlie's Toys ref 2 by src/service.c:5114:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430aa90 ref 0 by src/service.c:5124:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430aa90
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430c950 ref 0 by src/service.c:5131:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430c950
connmand[507]: plugins/wifi.c:network_remove() network 0x73105d00
connmand[507]: src/network.c:connman_network_unref_debug() 0x73105d00 =
name Charlie's Toys ref 1 by src/device.c:400:free_network()
connmand[507]: src/network.c:connman_network_unref_debug() 0x73105d00 =
name Charlie's Toys ref 0 by plugins/wifi.c:2984:network_removed()
connmand[507]: src/network.c:network_destruct() network 0x73105d00 name =
Charlie's Toys
connmand[507]: src/service.c:service_send_changed()=20
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_=
managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/service.c:append_removed() removed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320506c616365_mana=
ged_psk
connmand[507]: src/service.c:append_removed() removed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320546f7973_manage=
d_psk
fec 2188000.ethernet eth0: Link is Down
connmand[507]: src/rtnl.c:rtnl_message() NEWLINK len 1248 type 16 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_newlink() index 4
connmand[507]: eth0 {RX} 440 packets 67361 bytes
connmand[507]: eth0 {TX} 425 packets 58028 bytes
connmand[507]: src/ipconfig.c:update_stats() service 0x72703440
connmand[507]: src/service.c:stats_update() service 0x72703440
connmand[507]: eth0 {update} flags 36867 <UP>
connmand[507]: src/service.c:service_lower_down() eth0 lower down
connmand[507]: src/service.c:stats_stop() service 0x72703440
connmand[507]: src/service.c:service_save() service 0x72703440 new 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74308ad0 identifier ethernet_0004f31a5ee0_cable method dhcp
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74308a90 identifier ethernet_0004f31a5ee0_cable method auto
connmand[507]: src/service.c:service_lower_down() eth0 lower down
connmand[507]: src/service.c:stats_stop() service 0x72703440
connmand[507]: src/service.c:service_save() service 0x72703440 new 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74308ad0 identifier ethernet_0004f31a5ee0_cable method dhcp
connmand[507]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x74308a90 identifier ethernet_0004f31a5ee0_cable method auto
connmand[507]: eth0 {newlink} index 4 address 00:04:F3:1A:5E:E0 mtu 1500
connmand[507]: eth0 {newlink} index 4 operstate 2 <DOWN>
connmand[507]: src/detect.c:detect_newlink() type 1 index 4
connmand[507]: plugins/ethernet.c:ethernet_newlink() index 4 flags 36867 =
change 0
connmand[507]: plugins/ethernet.c:ethernet_newlink() carrier off
connmand[507]: src/device.c:connman_device_remove_network() device =
0x73b02a90 network 0x731066a0
connmand[507]: src/device.c:free_network() network 0x731066a0
connmand[507]: src/network.c:network_remove() network 0x731066a0 name =
Wired
connmand[507]: src/network.c:set_disconnected() service 0x72703440 ipv4 =
0x74308ad0 ipv6 0x74308a90
connmand[507]: src/network.c:set_disconnected() method ipv4 4 ipv6 5
connmand[507]: src/dhcpv6.c:__connman_dhcpv6_stop()=20
connmand[507]: src/dhcp.c:__connman_dhcp_stop() ipconfig_table =
0x74907048 ipconfig 0x74308ad0
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x74308ad0 ref 2 by src/dhcp.c:738:__connman_dhcp_stop()
connmand[507]: src/network.c:connman_network_unref_debug() 0x731066a0 =
name Wired ref 3 by src/dhcp.c:740:__connman_dhcp_stop()
connmand[507]: src/dhcp.c:dhcp_release() dhcp 0x75508420
connmand[507]: src/dhcp.c:dhcp_invalidate() dhcp 0x75508420 callback 0
connmand[507]: src/6to4.c:__connman_6to4_remove() tunnel ip address =
(null)
connmand[507]: src/service.c:__connman_service_timeserver_remove() =
service 0x72703440 timeserver 192.168.2.1
connmand[507]: src/service.c:__connman_service_nameserver_remove() =
service 0x72703440 nameserver 192.168.2.1 auto 0
connmand[507]: src/resolver.c:connman_resolver_remove() index 4 domain =
(null) server 192.168.2.1
connmand[507]: src/dnsproxy.c:__connman_dnsproxy_remove() index 4 server =
192.168.2.1
connmand[507]: src/dhcp.c:dhcp_invalidate() last address 192.168.2.69
connmand[507]: src/inet.c:connman_inet_clear_address() index 4 address =
192.168.2.69 prefix_len 24 peer (null) broadcast (null)
connmand[507]: src/inet.c:__connman_inet_modify_address() cmd 0x15 flags =
0 index 4 family 2 address 192.168.2.69 peer (null) prefixlen 24 =
broadcast (null) p2p false
connmand[507]: src/ipconfig.c:__connman_ipconfig_set_gateway()=20
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 4 (ready) new =
state 6 (disconnect) type 1 (IPv4)
connmand[507]: src/service.c:service_rp_filter() disconnected =
ethernet_0004f31a5ee0_cable ipconfig 0x74308ad0 method 4 count 3 filter =
2
connmand[507]: src/service.c:connman_service_unref_debug() 0x72703440 =
ref 2 by src/service.c:1446:cancel_online_check()
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old ready - new disconnect/configuration =3D> configuration
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72703440 =
state 3
connmand[507]: src/stats.c:__connman_stats_service_register() service =
0x72703440
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x74721eb0
connmand[507]: src/connection.c:unset_default_gateway() type 1 gateway =
ipv4 0x7471add0 ipv6 (nil)
connmand[507]: src/inet.c:connman_inet_clear_gateway_address() index 4 =
gateway 192.168.2.1
connmand[507]: src/inet.c:connman_inet_clear_gateway_address() ifname =
eth0
connmand[507]: src/connection.c:set_default_gateway() type 1 gateway =
ipv4 0x74721e80 ipv6 (nil)
connmand[507]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[507]: src/inet.c:__connman_inet_rtnl_open() fd 17
connmand[507]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7e860f60 =
len 44
connmand[507]: src/inet.c:__connman_inet_rtnl_close() handle 0x7e860f60
connmand[507]: src/service.c:__connman_service_indicate_default() =
service 0x72702c40 state ready
connmand[507]: src/service.c:default_changed() current default =
0x72703440 ethernet_0004f31a5ee0_cable
connmand[507]: src/service.c:default_changed() new default 0x72702c40 =
wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk
connmand[507]: src/service.c:__connman_service_wispr_start() service =
0x72702c40 type IPv4
connmand[507]: src/wispr.c:__connman_wispr_start() service 0x72702c40 =
IPv4
connmand[507]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b003b0 =
ref 1 by src/wispr.c:233:create_wispr_portal_context()
connmand[507]: src/wispr.c:wispr_portal_detect() wispr/portal context =
0x72b003b0 service 0x72702c40
connmand[507]: src/wispr.c:wispr_portal_detect() interface wlan0
connmand[507]: WEB: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b01280 setting nameserver 192.168.2.1
connmand[507]: src/proxy.c:connman_proxy_lookup() interface wlan0 url =
http://ipv4.connman.net/online/status.html
connmand[507]: src/service.c:connman_service_ref_debug() 0x72702c40 ref =
3 by src/proxy.c:124:connman_proxy_lookup()
connmand[507]: src/proxy.c:connman_proxy_lookup() token 2
connmand[507]: src/service.c:default_changed() running vpn_auto_connect
connmand[507]: src/dnsproxy.c:dnsproxy_default_changed() service =
0x72702c40
connmand[507]: src/dnsproxy.c:dnsproxy_default_changed() Enabling DNS =
server 192.168.2.1
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/timeserver.c:timeserver_start() service 0x72702c40
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b00f80 lookup id 2
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b00f80 setting nameserver 192.168.2.1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b00f80 lookup id 2
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b00f80 setting nameserver 192.168.2.1
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b00f80 lookup id 2
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b00f80 setting nameserver 192.168.2.1
connmand[507]: src/timeserver.c:sync_next() Using timeserver 192.168.2.1
connmand[507]: src/ntp.c:start_ntp() server 192.168.2.1 family 2
connmand[507]: src/nat.c:update_default_interface() interface wlan0
connmand[507]: src/notifier.c:__connman_notifier_disconnect() type 2
connmand[507]: src/technology.c:technology_find() type 2
connmand[507]: src/technology.c:__connman_technology_set_connected() =
technology 0x755031a0 connected 0
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 3 =
(configuration) new state 6 (disconnect) type 2 (IPv6)
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b00f80 lookup id 2
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b00f80 setting nameserver 8.8.8.8
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b00f80 setting nameserver 8.8.4.4
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b00f80 lookup id 2
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b00f80 setting nameserver 8.8.8.8
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71b00f80 setting nameserver 8.8.4.4
connmand[507]: src/timeserver.c:sync_next() Resolving timeserver =
0.pool.ntp.org
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b00f80 hostname 0.pool.ntp.org
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b00f80 =
sending 32 bytes
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b00f80 =
lookup 0x7430e950 id 1 query 0x74728720
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b00f80 =
sending 32 bytes
connmand[507]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71b00f80 =
lookup 0x7430e950 id 1 query 0x747286c0
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71b00f80 lookup 0x7430e950 id 1
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old configuration - new disconnect/disconnect =3D> disconnect
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72703440 =
state 6
connmand[507]: src/provider.c:provider_service_changed() service =
0x72703440 ethernet_0004f31a5ee0_cable state 6 index 4/-1
connmand[507]: src/wispr.c:__connman_wispr_stop() service 0x72703440
connmand[507]: src/wispr.c:free_connman_wispr_portal()=20
connmand[507]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b00720 =
ref 0 by src/wispr.c:247:free_connman_wispr_portal()
connmand[507]: WEB: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b01880 lookup id 1
connmand[507]: src/wpad.c:__connman_wpad_stop() service 0x72703440
connmand[507]: src/service.c:downgrade_state() service 0x72702c40 state4 =
4 state6 3
connmand[507]: src/service.c:downgrade_state() service 0x72703840 state4 =
4 state6 1
connmand[507]: src/service.c:__connman_service_auto_connect()=20
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x74721eb0
connmand[507]: src/connection.c:unset_default_gateway() type 1 gateway =
ipv4 0x7471add0 ipv6 (nil)
connmand[507]: src/inet.c:connman_inet_clear_gateway_address() index 4 =
gateway 192.168.2.1
connmand[507]: src/inet.c:connman_inet_clear_gateway_address() ifname =
eth0
connmand[507]: src/connection.c:set_default_gateway() type 1 gateway =
ipv4 0x74721e80 ipv6 (nil)
connmand[507]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[507]: src/inet.c:__connman_inet_rtnl_open() fd 19
conIPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
nmand[507]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7e860f60 len =
44
connmand[507]: src/inet.c:__connman_inet_rtnl_close() handle 0x7e860f60
connmand[507]: src/service.c:__connman_service_indicate_default() =
service 0x72702c40 state ready
connmand[507]: src/connection.c:__connman_connection_gateway_remove() =
service 0x72703440 type 3
connmand[507]: src/connection.c:__connman_connection_gateway_remove() =
ipv4 gateway 192.168.2.1 ipv6 gateway <null> vpn 0/0
connmand[507]: src/connection.c:disable_gateway() type 3 active 1
connmand[507]: src/inet.c:connman_inet_del_network_route() index 4 host =
192.168.2.1
connmand[507]: src/inet.c:connman_inet_del_network_route() ifname eth0
connmand[507]: src/inet.c:connman_inet_clear_gateway_address() index 4 =
gateway 192.168.2.1
connmand[507]: src/inet.c:connman_inet_clear_gateway_address() ifname =
eth0
connmand[507]: src/connection.c:remove_gateway() gateway ipv4 0x7471add0 =
ipv6 (nil)
connmand[507]: src/service.c:connman_service_unref_debug() 0x72703440 =
ref 1 by src/connection.c:707:remove_gateway()
connmand[507]: src/inet.c:connman_inet_clear_address() index 4 address =
(null) prefix_len 0 peer (null) broadcast (null)
connmand[507]: src/inet.c:connman_inet_clear_ipv6_address() index 4 =
address (null) prefix_len 0
connmand[507]: src/ipconfig.c:disable_ipv6()=20
connmand[507]: src/ipconfig.c:set_ipv6_state() eth0 1
connmand[507]: src/ipconfig.c:enable_ipv6()=20
connmand[507]: src/ipconfig.c:set_ipv6_state() eth0 0
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 6 =
(disconnect) new state 1 (idle) type 1 (IPv4)
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x74308ad0
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x74308ad0 ref 1 by src/ipconfig.c:1777:__connman_ipconfig_disable()
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old disconnect - new idle/disconnect =3D> disconnect
connmand[507]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72703440 (ethernet_0004f31a5ee0_cable) old state 6 =
(disconnect) new state 1 (idle) type 2 (IPv6)
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x74308a90
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x74308a90 ref 1 by src/ipconfig.c:1790:__connman_ipconfig_disable()
connmand[507]: src/service.c:service_indicate_state() service 0x72703440 =
old disconnect - new idle/idle =3D> idle
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/session.c:service_state_changed() service 0x72703440 =
state 1
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x74721eb0
connmand[507]: src/connection.c:set_default_gateway() type 1 gateway =
ipv4 0x74721e80 ipv6 (nil)
connmand[507]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[507]: src/inet.c:__connman_inet_rtnl_open() fd 19
connmand[507]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7e860f60 =
len 44
connmand[507]: src/inet.c:__connman_inet_rtnl_close() handle 0x7e860f60
connmand[507]: src/service.c:__connman_service_indicate_default() =
service 0x72702c40 state ready
connmand[507]: src/network.c:connman_network_set_associating() network =
0x731066a0 associating 0
connmand[507]: src/service.c:__connman_service_remove_from_network() =
network 0x731066a0 service 0x72703440
connmand[507]: src/connection.c:__connman_connection_gateway_remove() =
service 0x72703440 type 3
connmand[507]: src/service.c:connman_service_unref_debug() 0x72703440 =
ref 0 by src/service.c:7655:__connman_service_remove_from_network()
connmand[507]: src/service.c:__connman_service_disconnect() service =
0x72703440
connmand[507]: src/agent.c:connman_agent_cancel() context 0x72703440
connmand[507]: src/stats.c:__connman_stats_service_unregister() service =
0x72703440
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x731066a0
connmand[507]: src/service.c:service_free() service 0x72703440
connmand[507]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[507]: src/service.c:service_schedule_removed() service =
0x72703440 /net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: src/wispr.c:__connman_wispr_stop() service 0x72703440
connmand[507]: src/service.c:stats_stop() service 0x72703440
connmand[507]: src/connection.c:__connman_connection_update_gateway() =
default 0x74721eb0
connmand[507]: src/connection.c:set_default_gateway() type 1 gateway =
ipv4 0x74721e80 ipv6 (nil)
connmand[507]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[507]: src/inet.c:__connman_inet_rtnl_open() fd 16
connmand[507]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7e860fa0 =
len 44
connmand[507]: src/inet.c:__connman_inet_rtnl_close() handle 0x7e860fa0
connmand[507]: src/service.c:__connman_service_indicate_default() =
service 0x72702c40 state ready
connmand[507]: src/network.c:__connman_network_disconnect() network =
0x731066a0
connmand[507]: src/network.c:connman_network_unref_debug() 0x731066a0 =
name Wired ref 2 by src/service.c:5114:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x74308ad0 ref 0 by src/service.c:5124:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x74308ad0
connmand[507]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x74308a90 ref 0 by src/service.c:5131:service_free()
connmand[507]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x74308a90
connmand[507]: plugins/ethernet.c:eth_network_remove() network =
0x731066a0
connmand[507]: src/network.c:connman_network_unref_debug() 0x731066a0 =
name Wired ref 1 by src/device.c:400:free_network()
connmand[507]: src/network.c:connman_network_unref_debug() 0x731066a0 =
name Wired ref 0 by plugins/ethernet.c:230:remove_network()
connmand[507]: src/network.c:network_destruct() network 0x731066a0 name =
Wired
connmand[507]: src/rtnl.c:rtnl_message() DELADDR len 88 type 21 flags =
0x0000 seq 1 pid 3663125789
connmand[507]: src/ipconfig.c:__connman_ipconfig_deladdr() index 4
connmand[507]: eth0 {del} address 192.168.2.69/24 label eth0
connmand[507]: src/service.c:service_send_changed()=20
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_=
managed_psk
connmand[507]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/cellular_311270007006540_context1
connmand[507]: src/service.c:append_removed() removed =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b00f80 =
response from 8.8.8.8
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b00f80 =
msg id: 0x7a0b rcode: 0 count: 4
connmand[507]: RESOLV: gweb/gresolv.c:destroy_query() resolv 0x71b00f80 =
query 0x74728720 timeout 284
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b00f80 =
response from 8.8.4.4
connmand[507]: src/rtnl.c:rtnl_message() DELROUTE len 60 type 25 flags =
0x0000 seq 0 pid 0
connmand[507]: src/ipconfig.c:__connman_ipconfig_delroute() index 4
connmand[507]: eth0 {del} route 192.168.2.0 gw 0.0.0.0 scope 253 <LINK>
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b00f80 =
response from 8.8.8.8
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b00f80 =
msg id: 0xf377 rcode: 0 count: 0
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b00f80 =
response from 8.8.4.4
connmand[507]: RESOLV: gweb/gresolv.c:parse_response() resolv 0x71b00f80 =
msg id: 0xf377 rcode: 0 count: 0
connmand[507]: RESOLV: gweb/gresolv.c:destroy_query() resolv 0x71b00f80 =
query 0x747286c0 timeout 285
connmand[507]: RESOLV: gweb/gresolv.c:sort_and_return_results() resolv =
0x71b00f80 lookup 0x7430e950 received 4 results
connmand[507]: RESOLV: gweb/gresolv.c:destroy_lookup() resolv 0x71b00f80 =
lookup 0x7430e950 id 1 ipv4 (nil) ipv6 (nil)
connmand[507]: src/timeserver.c:resolv_result() status 0
connmand[507]: src/timeserver.c:resolv_result() result[3]: 162.159.200.1
connmand[507]: src/timeserver.c:resolv_result() result[2]: 64.142.54.12
connmand[507]: src/timeserver.c:resolv_result() result[1]: =
192.189.65.187
connmand[507]: src/timeserver.c:resolv_result() result[0]: =
199.68.201.236
connmand[507]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71b00f80 lookup id 1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D507=3D=3DERROR: AddressSanitizer: heap-use-after-free on address =
0x7270349c at pc 0x00093f03 bp 0x7e8612a0 sp 0x7e8612a4
READ of size 4 at 0x7270349c thread T0
    #0 0x93f00 in connman_service_get_nameservers:service.c:2826 =
(/usr/sbin/connmand+0x93f00)
    #1 0xd3b46 in ts_set_nameservers:timeserver.c:387 =
(/usr/sbin/connmand+0xd3b46)
    #2 0xd3c18 in sync_next:timeserver.c:187 =
(/usr/sbin/connmand+0xd3c18)
    #3 0xd4152 in resolv_result:timeserver.c:141 =
(/usr/sbin/connmand+0xd4152)
    #4 0x37b5a in sort_and_return_results:gresolv.c:522 =
(/usr/sbin/connmand+0x37b5a)
    #5 0x3829c in parse_response:gresolv.c:751 =
(/usr/sbin/connmand+0x3829c)
    #6 0x383de in received_udp_data:gresolv.c:772 =
(/usr/sbin/connmand+0x383de)

0x7270349c is located 92 bytes inside of 408-byte region =
[0x72703440,0x727035d8)
freed by thread T0 here:
    #0 0x76ac8264  (/lib/libasan.so.8+0x8d264)

previously allocated by thread T0 here:
    #0 0x76ac8a6c in calloc (/lib/libasan.so.8+0x8da6c)
    #1 0x95bee  in connman_service_create:service.c:5238 =
(/usr/sbin/connmand+0x95bee)
    #2 0x95e68  in service_get:service.c:6991 =
(/usr/sbin/connmand+0x95e68)
    #3 0x9db1e  in __connman_service_create_from_network:service.c:7504 =
(/usr/sbin/connmand+0x9db1e)
    #4 0x7dda6  in network_probe:network.c:1107 =
(/usr/sbin/connmand+0x7dda6)
    #5 0x7ea18  in connman_network_set_group:network.c:1450 =
(/usr/sbin/connmand+0x7ea18)
    #6 0x3da36  in add_network:ethernet.c:216 =
(/usr/sbin/connmand+0x3da36)
    #7 0x3db56  in ethernet_newlink:ethernet.c:255 (discriminator 3) =
(/usr/sbin/connmand+0x3db56)
    #8 0xcf864  in process_newlink:rtnl.c:506 =
(/usr/sbin/connmand+0xcf864)
    #9 0xcfb6a  in rtnl_newlink:rtnl.c:976 (/usr/sbin/connmand+0xcfb6a)
    #10 0xd1bc2 in rtnl_message:rtnl.c:1417 (/usr/sbin/connmand+0xd1bc2)
    #11 0xd1f8c in netlink_event:rtnl.c:1477 =
(/usr/sbin/connmand+0xd1f8c)

SUMMARY: AddressSanitizer: heap-use-after-free =
(/usr/sbin/connmand+0x93f00) in connman_service_get_nameservers
Shadow bytes around the buggy address:
  0x2e4e0640: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x2e4e0650: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x2e4e0660: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x2e4e0670: fd fd fd fd fd fd fd fd fd fd fd fa fa fa fa fa
  0x2e4e0680: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
=3D>0x2e4e0690: fd fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd fd
  0x2e4e06a0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x2e4e06b0: fd fd fd fd fd fd fd fd fd fd fd fa fa fa fa fa
  0x2e4e06c0: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x2e4e06d0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x2e4e06e0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07=20
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D507=3D=3DABORTING

I am also tracking this issue here =
https://github.com/Nuovations/connman/issues/3.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

