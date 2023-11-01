Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4E36B
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 00:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C9D3C7334F
	for <connman@lists.linux.dev>; Tue, 31 Oct 2023 20:44:22 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03] (unknown [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4E5CD73366
	for <connman@lists.linux.dev>; Tue, 31 Oct 2023 20:44:22 -0400 (EDT)
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
Date: Tue, 31 Oct 2023 17:44:21 -0700
References: <E50A909D-122E-4D14-A330-868A8EF9997F@nuovations.com>
 <A6BF0A08-CDFA-4CF4-A373-B130605030C0@nuovations.com>
 <BE0470B2-EB5F-4D6F-8062-0E92C3C48F28@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <BE0470B2-EB5F-4D6F-8062-0E92C3C48F28@nuovations.com>
Message-Id: <FE5E3686-1DFC-4216-9A57-90A6114F279D@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Oct 31, 2023, at 12:18 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> On Oct 19, 2023, at 5:48 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
>> On Oct 18, 2023, at 8:00 PM, Grant Erickson =
<gerickson@nuovations.com> wrote:
>>> I know some of you (Denis, I believe from git log history) are =
working on clang static and dynamic analysis for connman.
>>>=20
>>> To the extent it helps, I have been chasing down an issue in =
top-of-tree (53964711baee916ae163e64d5229e3822935e100) in which when =
Quectel / Nimblelink QMI cellular goes away on my system, I get a =
connman signal 11 abort. Unfortunately, there is no backtrace in this =
case since n_ptrs (0) is less than offset (2) in the print_backtrace =
call.
>>>=20
>>> Today, doing some other development and debug work, I was able to =
narrow down the downstream cause of the abort. It seems that things are =
crashing somewhere within =
src/service.c:connman_service_get_nameservers().
>>>=20
>>> When name servers are established for the cellular service from the =
provider, there end up being two (2) name servers. The core problem =
seems to be that g_strv_length(service->nameservers) incorrectly returns =
7 (it really only has two (2)) which results in:
>>>=20
>>> 		for (i =3D 0; i < len; i++)
>>> 			nameservers[i] =3D =
g_strdup(service->nameservers[i]);
>>>=20
>>> attempting to copy strings that do not exist past the end of the =
actual bounds of service->nameservers. So, it would seem that at some =
point, service->nameservers becomes corrupt with its terminating null =
getting overwritten by something else. I=E2=80=99ve get to zero in on =
the nature of =E2=80=9Cgetting overwritten by something else=E2=80=9D.
>>>=20
>>> I also periodically get this in the output after an abort:
>>>=20
>>>  malloc(): smallbin double linked list corrupted
>>>=20
>>> I am also able to cause the abort, nearly on demand with near 100% =
reproducibility, by issuing =E2=80=98connmanctl disable cellular=E2=80=99.=

>>>=20
>>> More as I learn and discover it.
>>=20
>> I configured connman as follows:
>>=20
>> % configure --disable-bluetooth --disable-debug --disable-dundee =
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
>>=20
>> and then ran clang/LLVM scan-build-11 on it and yielding the =
following 60 potential issues. I=E2=80=99ll dive in on the most =
promising leads relative to the corruption / failures I am seeing.
>>=20
>> % scan-build-11 --status-bugs -v make
>> scan-build: Using '/usr/lib/llvm-11/bin/clang' for static analysis
>> scan-build: Emitting reports for this run to =
'/tmp/scan-build-2023-10-19-172229-1594519-1=E2=80=99.
>> [ =E2=80=A6 ]
>> scan-build: Analysis run complete.
>> scan-build: 60 bugs found.
>> scan-build: Run 'scan-view =
/tmp/scan-build-2023-10-19-172229-1594519-1' to examine bug reports.
>=20
> ConnMan Community:
>=20
> I was finally able to stand up the address sanitizer on my armv7l =
embedded target and was able to trigger the address sanitizer by pulling =
the Ethernet cable while Ethernet, Wi-Fi, and Cellular were all active. =
Adding `-Og -g3` as the optimizer / debug flags to the package =
compilation, I was able to get full symbolication:
>=20
> [ =E2=80=A6 ]
>=20
> I am also tracking this issue here =
https://github.com/Nuovations/connman/issues/3.

ConnMan Community:

I now have a smoking gun. As a service about-to-be-freed unconditionally =
invokes __connman_timeserver_sync with =
CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE, it displaces the =
newly-promoted service for time services that was put in place earlier =
via __connman_notifier_default_changed.

As time services reanimate as the outgoing-service is exiting, the =
heap-use-after-free fault occurs:

2023-10-31T18:03:09-0600 [19205453]# CONNMAN_RESOLV_DEBUG=3D1 =
CONNMAN_WEB_DEBUG=3D1 /usr/sbin/connmand -n -d -W nl80211
connmand[508]: Connection Manager version 1.42
connmand[508]: src/dbus.c:__connman_dbus_init()=20
connmand[508]: src/main.c:parse_config() parsing main.conf
(connmand:508): GLib-WARNING **: 18:03:18.861: GError set over the top =
of a previous GError or uninitialized memory.
This indicates a bug in someone's code. You must ensure an error is NULL =
before it's set.
The overwriting error message was: Key file does not have key =
?ResolvConf? in group ?General?
connmand[508]: src/inotify.c:__connman_inotify_init()=20
connmand[508]: src/technology.c:__connman_technology_init()=20
connmand[508]: src/notifier.c:__connman_notifier_init()=20
connmand[508]: src/agent.c:__connman_agent_init()=20
connmand[508]: src/service.c:__connman_service_init()=20
connmand[508]: src/agent.c:connman_agent_driver_register() Registering =
driver 0x194be0 name service
connmand[508]: src/peer_service.c:__connman_peer_service_init()=20
connmand[508]: src/peer.c:__connman_peer_init()=20
connmand[508]: src/provider.c:__connman_provider_init()=20
connmand[508]: src/notifier.c:connman_notifier_register() notifier =
0x152e80 name provider
connmand[508]: src/network.c:__connman_network_init()=20
connmand[508]: src/config.c:__connman_config_init()=20
connmand[508]: src/inotify.c:create_watch() Add directory watch for =
/var/lib/connman
connmand[508]: src/config.c:read_configs()=20
connmand[508]: src/device.c:__connman_device_init()=20
connmand[508]: src/inet.c:__connman_inet_get_address_netmask() index 6
connmand[508]: src/device.c:cleanup_devices() cleaning up wwan0 index 6
connmand[508]: src/inet.c:__connman_inet_get_address_netmask() index 7
connmand[508]: src/device.c:cleanup_devices() cleaning up wlan0 index 7
connmand[508]: src/ippool.c:__connman_ippool_init()=20
connmand[508]: src/firewall-nftables.c:__connman_firewall_init()=20
connmand[508]: src/firewall-nftables.c:cleanup_table_and_chains()=20
connmand[508]: src/firewall-nftables.c:create_table_and_chains()=20
connmand[508]: src/nat.c:__connman_nat_init()=20
connmand[508]: src/notifier.c:connman_notifier_register() notifier =
0x16d460 name nat
connmand[508]: src/tethering.c:__connman_tethering_init()=20
connmand[508]: src/counter.c:__connman_counter_init()=20
connmand[508]: src/manager.c:__connman_manager_init()=20
connmand[508]: src/notifier.c:connman_notifier_register() notifier =
0x144fc0 name manager
connmand[508]: src/stats.c:__connman_stats_init()=20
connmand[508]: src/clock.c:__connman_clock_init()=20
connmand[508]: src/timezone.c:__connman_timezone_init()=20
connmand[508]: src/timezone.c:__connman_timezone_lookup() sysconfig zone =
(null)
connmand[508]: src/timezone.c:__connman_timezone_lookup() localtime zone =
US/Mountain
connmand[508]: src/ipconfig.c:__connman_ipconfig_init()=20
connmand[508]: src/rtnl.c:__connman_rtnl_init()=20
connmand[508]: src/task.c:__connman_task_init()=20
connmand[508]: src/proxy.c:__connman_proxy_init()=20
connmand[508]: src/detect.c:__connman_detect_init()=20
connmand[508]: src/rtnl.c:connman_rtnl_register() rtnl 0x19c3c0 name =
detect
connmand[508]: src/session.c:__connman_session_init()=20
connmand[508]: src/notifier.c:connman_notifier_register() notifier =
0x168a20 name session
connmand[508]: src/timeserver.c:__connman_timeserver_init()=20
connmand[508]: src/notifier.c:connman_notifier_register() notifier =
0x15fa60 name timeserver
connmand[508]: src/connection.c:__connman_connection_init()=20
connmand[508]: src/rtnl.c:connman_rtnl_register() rtnl 0x1932c0 name =
connection
connmand[508]: src/plugin.c:__connman_plugin_init()=20
connmand[508]: Can't load /usr/lib/connman/plugins/openvpn.so: =
/usr/lib/connman/plugins/openvpn.so: undefined symbol: =
vpn_provider_get_save_group
connmand[508]: Checking loopback interface settings

[ =E2=80=A6 ]

### Ethernet cable is removed roughly here.

fec 2188000.ethernet eth0: Link is Down
connmand[508]: src/rtnl.c:rtnl_message() NEWLINK len 1248 type 16 flags =
0x0000 seq 0 pid 0
connmand[508]: src/ipconfig.c:__connman_ipconfig_newlink() index 4
connmand[508]: eth0 {RX} 44 packets 7167 bytes
connmand[508]: eth0 {TX} 87 packets 13260 bytes
connmand[508]: src/ipconfig.c:update_stats() service 0x72702840
connmand[508]: src/service.c:stats_update() service 0x72702840
connmand[508]: eth0 {update} flags 36867 <UP>
connmand[508]: src/service.c:service_lower_down() eth0 lower down
connmand[508]: src/service.c:stats_stop() service 0x72702840
connmand[508]: src/service.c:service_save() service 0x72702840 new 0
connmand[508]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x7430d390 identifier ethernet_0004f31a5ee0_cable method dhcp
connmand[508]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x7430d350 identifier ethernet_0004f31a5ee0_cable method auto
connmand[508]: src/service.c:service_lower_down() eth0 lower down
connmand[508]: src/service.c:stats_stop() service 0x72702840
connmand[508]: src/service.c:service_save() service 0x72702840 new 0
connmand[508]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x7430d390 identifier ethernet_0004f31a5ee0_cable method dhcp
connmand[508]: src/ipconfig.c:__connman_ipconfig_save() ipconfig =
0x7430d350 identifier ethernet_0004f31a5ee0_cable method auto
connmand[508]: eth0 {newlink} index 4 address 00:04:F3:1A:5E:E0 mtu 1500
connmand[508]: eth0 {newlink} index 4 operstate 2 <DOWN>
connmand[508]: src/detect.c:detect_newlink() type 1 index 4
connmand[508]: plugins/ethernet.c:ethernet_newlink() index 4 flags 36867 =
change 0
connmand[508]: plugins/ethernet.c:ethernet_newlink() carrier off
connmand[508]: src/device.c:connman_device_remove_network() device =
0x73b02b00 network 0x73105de0
connmand[508]: src/device.c:free_network() network 0x73105de0
connmand[508]: src/network.c:network_remove() network 0x73105de0 name =
Wired
connmand[508]: src/network.c:set_disconnected() service 0x72702840 ipv4 =
0x7430d390 ipv6 0x7430d350
connmand[508]: src/network.c:set_disconnected() method ipv4 4 ipv6 5
connmand[508]: src/dhcpv6.c:__connman_dhcpv6_stop()=20
connmand[508]: src/dhcp.c:__connman_dhcp_stop() ipconfig_table =
0x74907048 ipconfig 0x7430d390
connmand[508]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430d390 ref 2 by src/dhcp.c:738:__connman_dhcp_stop()
connmand[508]: src/network.c:connman_network_unref_debug() 0x73105de0 =
name Wired ref 3 by src/dhcp.c:740:__connman_dhcp_stop()
connmand[508]: src/dhcp.c:dhcp_release() dhcp 0x7550bf00
connmand[508]: src/dhcp.c:dhcp_invalidate() dhcp 0x7550bf00 callback 0
connmand[508]: src/6to4.c:__connman_6to4_remove() tunnel ip address =
(null)
connmand[508]: src/service.c:__connman_service_timeserver_remove() =
service 0x72702840 timeserver 192.168.2.1
connmand[508]: src/service.c:__connman_service_nameserver_remove() =
service 0x72702840 nameserver 192.168.2.1 auto 0
connmand[508]: src/service.c:__connman_service_nameserver_remove() =
service 0x72702840 (ethernet_0004f31a5ee0_cable) deallocating =
nameservers 0x7513af10
connmand[508]: src/service.c:__connman_service_nameserver_remove() =
service 0x72702840 (ethernet_0004f31a5ee0_cable) assigned nameservers =
(nil)
connmand[508]: src/resolver.c:connman_resolver_remove() index 4 domain =
(null) server 192.168.2.1
connmand[508]: src/dnsproxy.c:__connman_dnsproxy_remove() index 4 server =
192.168.2.1
connmand[508]: src/dhcp.c:dhcp_invalidate() last address 192.168.2.69
connmand[508]: src/inet.c:connman_inet_clear_address() index 4 address =
192.168.2.69 prefix_len 24 peer (null) broadcast (null)
connmand[508]: src/inet.c:__connman_inet_modify_address() cmd 0x15 flags =
0 index 4 family 2 address 192.168.2.69 peer (null) prefixlen 24 =
broadcast (null) p2p false
connmand[508]: src/ipconfig.c:__connman_ipconfig_set_gateway()=20
connmand[508]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72702840 (ethernet_0004f31a5ee0_cable) old state 4 (ready) new =
state 6 (disconnect) type 1 (IPv4)
connmand[508]: src/service.c:service_rp_filter() disconnected =
ethernet_0004f31a5ee0_cable ipconfig 0x7430d390 method 4 count 3 filter =
2
connmand[508]: src/timeserver.c:__connman_timeserver_sync() service =
0x72702840 reason 2 (state update)
connmand[508]: src/service.c:service_indicate_state() service 0x72702840 =
old ready - new disconnect/ready =3D> ready
connmand[508]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72702840 (ethernet_0004f31a5ee0_cable) old state 4 (ready) new =
state 6 (disconnect) type 2 (IPv6)
connmand[508]: src/timeserver.c:__connman_timeserver_sync() service =
0x72702840 reason 2 (state update)
connmand[508]: src/service.c:service_indicate_state() service 0x72702840 =
old ready - new disconnect/disconnect =3D> disconnect
connmand[508]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[508]: src/session.c:service_state_changed() service 0x72702840 =
state 6
connmand[508]: src/provider.c:provider_service_changed() service =
0x72702840 ethernet_0004f31a5ee0_cable state 6 index 4/-1
connmand[508]: src/service.c:default_changed() current default =
0x72702840 ethernet_0004f31a5ee0_cable
connmand[508]: src/service.c:default_changed() new default (nil)=20
connmand[508]: src/dnsproxy.c:dnsproxy_default_changed() service (nil)
connmand[508]: src/dnsproxy.c:dnsproxy_offline_mode() enabled 1
connmand[508]: src/dnsproxy.c:dnsproxy_offline_mode() Disabling DNS =
server 192.168.2.1
connmand[508]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[508]: src/timeserver.c:default_changed() default_service (nil)
connmand[508]: src/timeserver.c:timeserver_stop() =20
connmand[508]: src/timeserver.c:timeserver_stop() ts_service 0x72702840
connmand[508]: src/nat.c:update_default_interface() interface (null)
connmand[508]: src/wispr.c:__connman_wispr_stop() service 0x72702840
connmand[508]: src/wispr.c:free_connman_wispr_portal()=20
connmand[508]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b00880 =
ref 0 by src/wispr.c:246:free_connman_wispr_portal()
connmand[508]: WEB: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71502180 lookup id 1
connmand[508]: src/wispr.c:free_wispr_routes() free route to =
82.165.8.211 if 4 type 1
connmand[508]: src/inet.c:connman_inet_del_network_route() index 4 host =
82.165.8.211
connmand[508]: src/inet.c:connman_inet_del_network_route() ifname eth0
connmand[508]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b007d0 =
ref 0 by src/wispr.c:247:free_connman_wispr_portal()
connmand[508]: WEB: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71501e80 lookup id 1
connmand[508]: src/wpad.c:__connman_wpad_stop() service 0x72702840
connmand[508]: src/service.c:downgrade_state() service 0x72702e40 state4 =
4 state6 3
connmand[508]: src/service.c:downgrade_state() service 0x72703840 state4 =
4 state6 1
connmand[508]: src/service.c:__connman_service_auto_connect()=20
connmand[508]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471eeb0
connmand[508]: src/connection.c:unset_default_gateway() type 1 gateway =
ipv4 0x74723980 ipv6 (nil)
connmand[508]: src/inet.c:connman_inet_clear_gateway_address() index 4 =
gateway 192.168.2.1
connmand[508]: src/inet.c:connman_inet_clear_gateway_address() ifname =
eth0
connmand[508]: src/connection.c:set_default_gateway() type 1 gateway =
ipv4 0x7471ee80 ipv6 (nil)
connmand[508]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[508]: src/inet.c:__connman_inet_rtnl_open() fd 17
connmand[508]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7ed30f60 =
len 44
connmand[508]: src/inet.c:__connman_inet_rtnl_close() handle 0x7ed30f60
connmand[508]: src/service.c:__connman_service_indicate_default() =
service 0x72702e40 state ready
connmand[508]: src/service.c:default_changed() current default (nil)=20
connmand[508]: src/service.c:default_changed() new default 0x72702e40 =
wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk
connmand[508]: src/service.c:__connman_service_wispr_start() service =
0x72702e40 type IPv4
connmand[508]: src/wispr.c:__connman_wispr_start() service 0x72702e40 =
IPv4
connmand[508]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b005c0 =
ref 1 by src/wispr.c:233:create_wispr_portal_context()
connmand[508]: src/wispr.c:wispr_portal_detect() wispr/portal context =
0x72b005c0 service 0x72702e40
connmand[508]: src/wispr.c:wispr_portal_detect() interface wlan0
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers        0x75131870 offset 88
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers_config (nil) offset 92
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers_auto   (nil) offset 96
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 =
(wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk) =
copying nameservers 0x75131870
connmand[508]: WEB: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71501b80 setting nameserver 192.168.2.1
connmand[508]: src/service.c:default_changed() running vpn_auto_connect
connmand[508]: src/dnsproxy.c:dnsproxy_default_changed() service =
0x72702e40
connmand[508]: src/dnsproxy.c:dnsproxy_default_changed() Enabling DNS =
server 192.168.2.1
connmand[508]: plugins/vpn.c:vpn_disconnect_check()=20

### The Wi-Fi service 0x72702e40, now the default service, is =
communicated
### to the timeservice code via the .default_changed notifier method.
### All good!

connmand[508]: src/timeserver.c:default_changed() default_service =
0x72702e40
connmand[508]: src/timeserver.c:timeserver_start() service 0x72702e40
connmand[508]: src/timeserver.c:ts_setup_resolv() service 0x72702e40
connmand[508]: src/timeserver.c:ts_set_nameservers() service 0x72702e40
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71501880 lookup id 1
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers        0x75131870 offset 88
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers_config (nil) offset 92
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers_auto   (nil) offset 96
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 =
(wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk) =
copying nameservers 0x75131870
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71501880 setting nameserver 192.168.2.1
connmand[508]: src/timeserver.c:__connman_timeserver_sync() service =
0x72702e40 reason 0 (start)
connmand[508]: src/timeserver.c:ts_reset() service 0x72702e40
connmand[508]: src/timeserver.c:ts_set_nameservers() service 0x72702e40
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71501880 lookup id 1
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers        0x75131870 offset 88
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers_config (nil) offset 92
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers_auto   (nil) offset 96
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 =
(wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk) =
copying nameservers 0x75131870
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71501880 setting nameserver 192.168.2.1
connmand[508]: src/timeserver.c:ts_reset() ts_service 0x72702e40
connmand[508]: src/timeserver.c:sync_next() ts_current (nil) ts_service =
0x72702e40
connmand[508]: src/timeserver.c:sync_next() ts_service 0x72702e40
connmand[508]: src/timeserver.c:ts_set_nameservers() service 0x72702e40
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71501880 lookup id 1
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers        0x75131870 offset 88
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers_config (nil) offset 92
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers_auto   (nil) offset 96
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 =
(wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk) =
copying nameservers 0x75131870
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71501880 setting nameserver 192.168.2.1
connmand[508]: src/timeserver.c:sync_next() Using timeserver 192.168.2.1
connmand[508]: src/ntp.c:start_ntp() server 192.168.2.1 family 2
connmand[508]: src/nat.c:update_default_interface() interface wlan0
connmand[508]: src/notifier.c:__connman_notifier_disconnect() type 2
connmand[508]: src/technology.c:technology_find() type 2
connmand[508]: src/technology.c:__connman_technology_set_connected() =
technology 0x755033e0 connected 0
connmand[508]: src/connection.c:__connman_connection_gateway_remove() =
service 0x72702840 type 3
connmand[508]: src/connection.c:__connman_connection_gateway_remove() =
ipv4 gateway 192.168.2.1 ipv6 gateway <null> vpn 0/0
connmand[508]: src/connection.c:disable_gateway() type 3 active 1
connmand[508]: src/inet.c:connman_inet_del_network_route() index 4 host =
192.168.2.1
connmand[508]: src/inet.c:connman_inet_del_network_route() ifname eth0
connmand[508]: src/inet.c:connman_inet_clear_gateway_address() index 4 =
gateway 192.168.2.1
connmand[508]: src/inet.c:connman_inet_clear_gateway_address() ifname =
eth0
connmand[508]: src/connection.c:remove_gateway() gateway ipv4 0x74723980 =
ipv6 (nil)
connmand[508]: src/service.c:connman_service_unref_debug() 0x72702840 =
ref 1 by src/connection.c:707:remove_gateway()
connmand[508]: src/inet.c:connman_inet_clear_address() index 4 address =
(null) prefix_len 0 peer (null) broadcast (null)
connmand[508]: src/inet.c:connman_inet_clear_ipv6_address() index 4 =
address (null) prefix_len 0
connmand[508]: src/ipconfig.c:disable_ipv6()=20
connmand[508]: src/ipconfig.c:set_ipv6_state() eth0 1
connmand[508]: src/ipconfig.c:enable_ipv6()=20
connmand[508]: src/ipconfig.c:set_ipv6_state() eth0 0

### The Ethernet service 0x72702840 finally registers a DISCONNECT state
### change.

connmand[508]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72702840 (ethernet_0004f31a5ee0_cable) old state 6 =
(disconnect) new state 1 (idle) type 1 (IPv4)
connmand[508]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430d390
connmand[508]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430d390 ref 1 by src/ipconfig.c:1777:__connman_ipconfig_disable()

### The Ethernet service 0x72702840 calls __connman_timeserver_sync to
### signal a state change with =
CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE.
###
### While this is technically correct, this is where things go off the
### rails as this invokes ts_reset and incorrectly displaces the Wi-Fi
### service 0x72702e40 as the current service used for time services.

connmand[508]: src/timeserver.c:__connman_timeserver_sync() service =
0x72702840 reason 2 (state update)
connmand[508]: src/timeserver.c:ts_reset() service 0x72702840
connmand[508]: src/timeserver.c:ts_set_nameservers() service 0x72702840
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71501880 lookup id 1
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702840 service->nameservers        (nil) offset 88
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702840 service->nameservers_config (nil) offset 92
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702840 service->nameservers_auto   (nil) offset 96
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71501880 setting nameserver 8.8.8.8
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71501880 setting nameserver 8.8.4.4
connmand[508]: src/timeserver.c:ts_reset() ts_service 0x72702840
connmand[508]: src/timeserver.c:sync_next() ts_current (nil) ts_service =
0x72702840
connmand[508]: src/timeserver.c:sync_next() ts_service 0x72702840
connmand[508]: src/timeserver.c:ts_set_nameservers() service 0x72702840
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71501880 lookup id 1
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702840 service->nameservers        (nil) offset 88
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702840 service->nameservers_config (nil) offset 92
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702840 service->nameservers_auto   (nil) offset 96
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71501880 setting nameserver 8.8.8.8
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71501880 setting nameserver 8.8.4.4
connmand[508]: src/timeserver.c:sync_next() Resolving timeserver =
0.pool.ntp.org
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71501880 hostname 0.pool.ntp.org
connmand[508]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71501880 =
sending 32 bytes
connmand[508]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71501880 =
lookup 0x7430ff90 id 1 query 0x747279a0
connmand[508]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71501880 =
sending 32 bytes
connmand[508]: RESOLV: gweb/gresolv.c:add_query() resolv 0x71501880 =
lookup 0x7430ff90 id 1 query 0x74727940
connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71501880 lookup 0x7430ff90 id 1
connmand[508]: src/service.c:service_indicate_state() service 0x72702840 =
old disconnect - new idle/disconnect =3D> disconnect
connmand[508]: src/service.c:__connman_service_ipconfig_indicate_state() =
service 0x72702840 (ethernet_0004f31a5ee0_cable) old state 6 =
(disconnect) new state 1 (idle) type 2 (IPv6)
connmand[508]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430d350
connmand[508]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430d350 ref 1 by src/ipconfig.c:1790:__connman_ipconfig_disable()
connmand[508]: src/timeserver.c:__connman_timeserver_sync() service =
0x72702840 reason 2 (state update)
connmand[508]: src/service.c:service_indicate_state() service 0x72702840 =
old disconnect - new idle/idle =3D> idle
connmand[508]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[508]: src/session.c:service_state_changed() service 0x72702840 =
state 1
connmand[508]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471eeb0
connmand[508]: src/connection.c:set_default_gateway() type 1 gateway =
ipv4 0x7471ee80 ipv6 (nil)
connmand[508]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[508]: src/inet.c:__connman_inet_rtnl_open() fd 23
connmand[508]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7ed30f60 =
len 44
connmand[508]: src/inet.c:__connman_inet_rtnl_close() handle 0x7ed30f60
connmand[508]: src/service.c:__connman_service_indicate_default() =
service 0x72702e40 state ready
connmand[508]: src/network.c:connman_network_set_associating() network =
0x73105de0 associating 0
connmand[508]: src/service.c:__connman_service_remove_from_network() =
network 0x73105de0 service 0x72702840
connmand[508]: src/connection.c:__connman_connection_gateway_remove() =
service 0x72702840 type 3
connmand[508]: src/service.c:connman_service_unref_debug() 0x72702840 =
ref 0 by src/service.c:7779:__connman_service_remove_from_network()
connmand[508]: src/service.c:__connman_service_disconnect() service =
0x72702840
connmand[508]: src/agent.c:connman_agent_cancel() context 0x72702840
connmand[508]: src/stats.c:__connman_stats_service_unregister() service =
0x72702840
connmand[508]: src/network.c:__connman_network_disconnect() network =
0x73105de0

### service_free() is being invoked on the Ethernet service 0x72702840.
### At this point, anything that does not involve the teardown of that
### service will invoke a heap-use-after-free fault.

connmand[508]: src/service.c:service_free() service 0x72702840
connmand[508]: plugins/vpn.c:vpn_disconnect_check()=20
connmand[508]: src/service.c:service_schedule_removed() service =
0x72702840 /net/connman/service/ethernet_0004f31a5ee0_cable
connmand[508]: src/wispr.c:__connman_wispr_stop() service 0x72702840
connmand[508]: src/service.c:stats_stop() service 0x72702840
connmand[508]: src/connection.c:__connman_connection_update_gateway() =
default 0x7471eeb0
connmand[508]: src/connection.c:set_default_gateway() type 1 gateway =
ipv4 0x7471ee80 ipv6 (nil)
connmand[508]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[508]: src/inet.c:__connman_inet_rtnl_open() fd 20
connmand[508]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7ed30fa0 =
len 44
connmand[508]: src/inet.c:__connman_inet_rtnl_close() handle 0x7ed30fa0
connmand[508]: src/service.c:__connman_service_indicate_default() =
service 0x72702e40 state ready
connmand[508]: src/network.c:__connman_network_disconnect() network =
0x73105de0
connmand[508]: src/network.c:connman_network_unref_debug() 0x73105de0 =
name Wired ref 2 by src/service.c:5219:service_free()
connmand[508]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430d390 ref 0 by src/service.c:5229:service_free()
connmand[508]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430d390
connmand[508]: src/ipconfig.c:__connman_ipconfig_unref_debug() =
0x7430d350 ref 0 by src/service.c:5236:service_free()
connmand[508]: src/ipconfig.c:__connman_ipconfig_disable() ipconfig =
0x7430d350
connmand[508]: src/service.c:service_free() service 0x72702840 =
(ethernet_0004f31a5ee0_cable) deallocating nameservers (nil)
connmand[508]: src/service.c:service_free() service 0x72702840 =
(ethernet_0004f31a5ee0_cable) deallocating nameservers_config (nil)

### The nameserver data for the Ethernet service 0x72702840 is now gone.

connmand[508]: plugins/ethernet.c:eth_network_remove() network =
0x73105de0
connmand[508]: src/network.c:connman_network_unref_debug() 0x73105de0 =
name Wired ref 1 by src/device.c:400:free_network()
connmand[508]: src/network.c:connman_network_unref_debug() 0x73105de0 =
name Wired ref 0 by plugins/ethernet.c:249:remove_network()
connmand[508]: src/network.c:network_destruct() network 0x73105de0 name =
Wired
connmand[508]: src/rtnl.c:rtnl_message() DELADDR len 88 type 21 flags =
0x0000 seq 1 pid 3856280549
connmand[508]: src/ipconfig.c:__connman_ipconfig_deladdr() index 4
connmand[508]: eth0 {del} address 192.168.2.69/24 label eth0
connmand[508]: src/service.c:service_send_changed()=20
connmand[508]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320467269656e6473_=
managed_psk
connmand[508]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/cellular_311270007006540_context1
connmand[508]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_66726f6e746c696e65_managed_psk
connmand[508]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320546f7973_manage=
d_psk
connmand[508]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_436861726c6965277320506c616365_mana=
ged_psk
connmand[508]: src/service.c:service_append_added_foreach() changed =
/net/connman/service/wifi_0004f31a5ee1_48502d5072696e742d38432d4f666669636=
56a65742050726f2038363130_managed_psk
connmand[508]: src/service.c:append_removed() removed =
/net/connman/service/ethernet_0004f31a5ee0_cable
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 60 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/ipconfig.c:__connman_ipconfig_delroute() index 4
connmand[508]: eth0 {del} route 192.168.2.0 gw 0.0.0.0 scope 253 <LINK>
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 60 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 60 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 60 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/rtnl.c:rtnl_message() NEWROUTE len 52 type 24 flags =
0x0600 seq 1698797185 pid 3980602421
connmand[508]: src/ipconfig.c:__connman_ipconfig_newroute() index 7
connmand[508]: src/service.c:service_route_changed() wlan0 route changed
connmand[508]: src/session.c:ipconfig_changed() service 0x72702e40 =
ipconfig 0x74309ed0
connmand[508]: wlan0 {add} route 0.0.0.0 gw 192.168.2.1 scope 0 =
<UNIVERSE>
connmand[508]: src/connection.c:connection_newgateway() index 7 gateway =
192.168.2.1
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 52 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/ipconfig.c:__connman_ipconfig_delroute() index 7
connmand[508]: src/service.c:service_route_changed() wlan0 route changed
connmand[508]: src/session.c:ipconfig_changed() service 0x72702e40 =
ipconfig 0x74309ed0
connmand[508]: wlan0 {del} route 0.0.0.0 gw 192.168.2.1 scope 0 =
<UNIVERSE>
connmand[508]: src/connection.c:connection_delgateway() index 7 gateway =
192.168.2.1
connmand[508]: src/connection.c:set_default_gateway() type 3 gateway =
ipv4 0x7471ee80 ipv6 (nil)
connmand[508]: src/inet.c:iproute_default_modify() gateway 192.168.2.1/0 =
table 254
connmand[508]: src/inet.c:__connman_inet_rtnl_open() fd 20
connmand[508]: src/inet.c:__connman_inet_rtnl_talk() handle 0x7ed31220 =
len 44
connmand[508]: src/inet.c:__connman_inet_rtnl_close() handle 0x7ed31220
connmand[508]: src/service.c:__connman_service_indicate_default() =
service 0x72702e40 state ready
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 116 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/ipconfig.c:__connman_ipconfig_delroute() index 4
connmand[508]: eth0 {del} route 2601:647:5a00:15c2:: gw :: scope 0 =
<UNIVERSE>
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 116 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/ipconfig.c:__connman_ipconfig_delroute() index 4
connmand[508]: eth0 {del} route fe80:: gw :: scope 0 <UNIVERSE>
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 116 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/ipconfig.c:__connman_ipconfig_delroute() index 4
connmand[508]: eth0 {del} route ff00:: gw :: scope 0 <UNIVERSE>
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 128 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/rtnl.c:rtnl_message() DELADDR len 72 type 21 flags =
0x0000 seq 0 pid 0
connmand[508]: src/ipconfig.c:__connman_ipconfig_deladdr() index 4
connmand[508]: eth0 {del} address =
2601:647:5a00:15c2:204:f3ff:fe1a:5ee0/64 label (null)
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 116 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/rtnl.c:rtnl_message() DELADDR len 72 type 21 flags =
0x0000 seq 0 pid 0
connmand[508]: src/service.c:redo_wispr() Retrying IPv4 WISPr for =
0x72702e40 Charlie's Friends
connmand[508]: src/wispr.c:__connman_wispr_start() service 0x72702e40 =
IPv4
connmand[508]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b005c0 =
ref 0 by src/wispr.c:1041:__connman_wispr_start()
connmand[508]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b00510 =
ref 1 by src/wispr.c:233:create_wispr_portal_context()
connmand[508]: src/wispr.c:wispr_portal_detect() wispr/portal context =
0x72b00510 service 0x72702e40
connmand[508]: src/wispr.c:wispr_portal_detect() interface wlan0
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers        0x75131870 offset 88
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers_config (nil) offset 92
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 service->nameservers_auto   (nil) offset 96
connmand[508]: src/service.c:connman_service_get_nameservers() service =
0x72702e40 =
(wifi_0004f31a5ee1_436861726c6965277320467269656e6473_managed_psk) =
copying nameservers 0x75131870
connmand[508]: WEB: gweb/gresolv.c:g_resolv_add_nameserver() resolv =
0x71501580 setting nameserver 192.168.2.1
connmand[508]: src/service.c:connman_service_unref_debug() 0x72702e40 =
ref 2 by src/service.c:6475:redo_wispr()
connmand[508]: src/rtnl.c:rtnl_message() DELROUTE len 116 type 25 flags =
0x0000 seq 0 pid 0
connmand[508]: src/rtnl.c:rtnl_message() NEWROUTE len 52 type 24 flags =
0x0600 seq 1698797187 pid 2420600124
connmand[508]: src/ipconfig.c:__connman_ipconfig_newroute() index 7
connmand[508]: src/service.c:service_route_changed() wlan0 route changed
connmand[508]: src/session.c:ipconfig_changed() service 0x72702e40 =
ipconfig 0x74309ed0
connmand[508]: wlan0 {add} route 0.0.0.0 gw 192.168.2.1 scope 0 =
<UNIVERSE>
connmand[508]: src/connection.c:connection_newgateway() index 7 gateway =
192.168.2.1
connmand[508]: src/service.c:run_auto_connect()=20
connmand[508]: src/service.c:preferred_tech_add_by_type() type 3 service =
0x72702e40 Charlie's Friends
connmand[508]: src/service.c:preferred_tech_add_by_type() type 3 service =
0x72703240 frontline
connmand[508]: src/service.c:preferred_tech_add_by_type() type 3 service =
0x72703040 Charlie's Toys
connmand[508]: src/service.c:preferred_tech_add_by_type() type 3 service =
0x72702c40 Charlie's Place
connmand[508]: src/service.c:preferred_tech_add_by_type() type 3 service =
0x72702a40 HP-Print-8C-Officejet Pro 8610
connmand[508]: src/service.c:preferred_tech_add_by_type() type 5 service =
0x72703840 311480
connmand[508]: src/service.c:auto_connect_service() preferred 1 sessions =
0 reason auto
connmand[508]: src/service.c:auto_connect_service() service 0x72702e40 =
type wifi busy
connmand[508]: src/service.c:auto_connect_service() service 0x72703240 =
type wifi ignore
connmand[508]: src/service.c:auto_connect_service() service 0x72703040 =
type wifi ignore
connmand[508]: src/service.c:auto_connect_service() service 0x72702c40 =
type wifi ignore
connmand[508]: src/service.c:auto_connect_service() service 0x72702a40 =
type wifi ignore
connmand[508]: src/service.c:auto_connect_service() service 0x72703840 =
type cellular busy
connmand[508]: src/service.c:run_vpn_auto_connect() stopping, no =
autoconnectable VPNs found
connmand[508]: src/wispr.c:proxy_callback() proxy DIRECT
connmand[508]: WEB: gweb/gweb.c:set_accept_option() web 0x7550ee40 =
clearing accept option
connmand[508]: WEB: gweb/gweb.c:set_user_agent() web 0x7550ee40 setting =
user agent ConnMan/1.42 wispr
connmand[508]: src/wispr.c:wispr_portal_request_portal() wp_context =
0x72b00510 IPv4
connmand[508]: src/wispr.c:wispr_portal_context_ref_debug() 0x72b00510 =
ref 2 by src/wispr.c:543:wispr_portal_request_portal()
connmand[508]: WEB: gweb/gweb.c:do_request() web 0x7550ee40 request =
http://ipv4.connman.net/online/status.html
connmand[508]: WEB: gweb/gweb.c:do_request() web 0x7550ee40 proxy host =
(null)
connmand[508]: WEB: gweb/gweb.c:do_request() web 0x7550ee40 port 80
connmand[508]: WEB: gweb/gweb.c:do_request() web 0x7550ee40 host =
ipv4.connman.net
connmand[508]: WEB: gweb/gweb.c:do_request() web 0x7550ee40 flags 0
connmand[508]: WEB: gweb/gweb.c:do_request() web 0x7550ee40 request =
/online/status.html
connmand[508]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71501580 hostname ipv4.connman.net
connmand[508]: WEB: gweb/gresolv.c:add_query() resolv 0x71501580 sending =
34 bytes
connmand[508]: WEB: gweb/gresolv.c:add_query() resolv 0x71501580 lookup =
0x7430fc10 id 1 query 0x74728960
connmand[508]: WEB: gweb/gresolv.c:g_resolv_lookup_hostname() resolv =
0x71501580 lookup 0x7430fc10 id 1
connmand[508]: src/wispr.c:wispr_portal_context_unref_debug() 0x72b00510 =
ref 1 by src/wispr.c:901:proxy_callback()
connmand[508]: WEB: gweb/gresolv.c:parse_response() resolv 0x71501580 =
response from 192.168.2.1
connmand[508]: WEB: gweb/gresolv.c:parse_response() resolv 0x71501580 =
msg id: 0xdb52 rcode: 0 count: 1
connmand[508]: WEB: gweb/gresolv.c:destroy_query() resolv 0x71501580 =
query 0x74728960 timeout 277
connmand[508]: WEB: gweb/gresolv.c:sort_and_return_results() resolv =
0x71501580 lookup 0x7430fc10
connmand[508]: WEB: gweb/gresolv.c:sort_and_return_results() resolv =
0x71501580 lookup 0x7430fc10 received 1 results
connmand[508]: WEB: gweb/gresolv.c:destroy_lookup() resolv 0x71501580 =
lookup 0x7430fc10 id 1 ipv4 (nil) ipv6 (nil)
connmand[508]: WEB: gweb/gweb.c:handle_resolved_address() web 0x7550ee40 =
address 82.165.8.211
connmand[508]: src/wispr.c:wispr_route_request() address 82.165.8.211 if =
7 gw 192.168.2.1
connmand[508]: src/inet.c:connman_inet_add_network_route() index 7 host =
82.165.8.211 gateway 192.168.2.1 netmask (null)
connmand[508]: src/inet.c:connman_inet_add_network_route() ifname wlan0
connmand[508]: WEB: gweb/gweb.c:connect_session_transport() web =
0x7550ee40 no encryption
connmand[508]: WEB: gweb/gweb.c:create_transport() web 0x7550ee40 =
creating session 82.165.8.211:80
connmand[508]: src/rtnl.c:rtnl_message() NEWROUTE len 60 type 24 flags =
0x0600 seq 0 pid 0
connmand[508]: src/ipconfig.c:__connman_ipconfig_newroute() index 7
connmand[508]: wlan0 {add} route 82.165.8.211 gw 192.168.2.1 scope 0 =
<UNIVERSE>
connmand[508]: RESOLV: gweb/gresolv.c:destroy_query() resolv 0x71501880 =
query 0x747279a0 timeout 0
connmand[508]: RESOLV: gweb/gresolv.c:destroy_query() resolv 0x71501880 =
query 0x74727940 timeout 0
connmand[508]: RESOLV: gweb/gresolv.c:sort_and_return_results() resolv =
0x71501880 lookup 0x7430ff90
connmand[508]: RESOLV: gweb/gresolv.c:sort_and_return_results() resolv =
0x71501880 lookup 0x7430ff90 received 0 results
connmand[508]: RESOLV: gweb/gresolv.c:destroy_lookup() resolv 0x71501880 =
lookup 0x7430ff90 id 1 ipv4 (nil) ipv6 (nil)

### Timed out, no results returned queries from the time service are
### about to tickle sync_next and fault the process.

connmand[508]: src/timeserver.c:resolv_result() status 2

### The timeservice module still has cached reference to the Ethernet
### service 0x72702840 from the prior incorrect displacement of the
### default Wi-Fi service 0x72702e40. Faults loom ahead.

connmand[508]: src/timeserver.c:sync_next() ts_current 0x75144a30 =
ts_service 0x72702840
connmand[508]: src/timeserver.c:sync_next() ts_service 0x72702840
connmand[508]: src/timeserver.c:ts_set_nameservers() service 0x72702840

### There is our heap-use-after-free fault for the Ethernet service
### 0x72702840.

connmand[508]: RESOLV: gweb/gresolv.c:g_resolv_cancel_lookup() resolv =
0x71501880 lookup id 1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D508=3D=3DERROR: AddressSanitizer: heap-use-after-free on address =
0x72702898 at pc 0x0009b499 bp 0x7ed328f0 sp 0x7ed328f4
READ of size 4 at 0x72702898 thread T0
    #0 0x9b496 in connman_service_get_nameservers:service.c:2896 =
(/usr/sbin/connmand+0x9b496)
    #1 0xd48fa in ts_set_nameservers:timeserver.c:394 =
(/usr/sbin/connmand+0xd48fa)
    #2 0xd4a0c in sync_next:timeserver.c:190 (discriminator 3) =
(/usr/sbin/connmand+0xd4a0c)
    #3 0xd5010 in resolv_result:timeserver.c:141 =
(/usr/sbin/connmand+0xd5010)
    #4 0x37ba2 in sort_and_return_results:gresolv.c:524 =
(/usr/sbin/connmand+0x37ba2)
    #5 0x3862c in query_timeout:gresolv.c:549 =
(/usr/sbin/connmand+0x3862c)

0x72702898 is located 88 bytes inside of 408-byte region =
[0x72702840,0x727029d8)
freed by thread T0 here:
    #0 0x76a4e264  (/lib/libasan.so.8+0x8d264)

previously allocated by thread T0 here:
    #0 0x76a4ea6c in calloc (/lib/libasan.so.8+0x8da6c)
    #1 0x925fc in connman_service_create (/usr/sbin/connmand+0x925fc)
    #2 0x92994  (/usr/sbin/connmand+0x92994)
    #3 0x9e88c  (/usr/sbin/connmand+0x9e88c)
    #4 0x7ddee  (/usr/sbin/connmand+0x7ddee)
    #5 0x7ea60 in connman_network_set_group (/usr/sbin/connmand+0x7ea60)
    #6 0x3da7e  (/usr/sbin/connmand+0x3da7e)
    #7 0x3db9e  (/usr/sbin/connmand+0x3db9e)
    #8 0xd05c4  (/usr/sbin/connmand+0xd05c4)
    #9 0xd08ca  (/usr/sbin/connmand+0xd08ca)
    #10 0xd2922  (/usr/sbin/connmand+0xd2922)
    #11 0xd2cec  (/usr/sbin/connmand+0xd2cec)

SUMMARY: AddressSanitizer: heap-use-after-free =
(/usr/sbin/connmand+0x9b496) in connman_service_get_nameservers
Shadow bytes around the buggy address:
  0x2e4e04c0: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
  0x2e4e04d0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x2e4e04e0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x2e4e04f0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x2e4e0500: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
=3D>0x2e4e0510: fd fd fd[fd]fd fd fd fd fd fd fd fd fd fd fd fd
  0x2e4e0520: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x2e4e0530: fd fd fd fd fd fd fd fd fd fd fd fa fa fa fa fa
  0x2e4e0540: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
  0x2e4e0550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x2e4e0560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
=3D=3D508=3D=3DABORTING
2023-10-31T18:06:31-0600 [19205453]#=20

The most reasonable change I can envision for this would be to qualify =
the call to __connman_timeserver_sync with the existing conditional if =
(!is_connected(old_state) && is_connected(new_state)) that occurs before =
it that checks for a new is_connected state:

diff --git a/src/service.c b/src/service.c
--- a/src/service.c
+++ b/src/service.c

@@ -6527,11 +6651,12 @@ int =
__connman_service_ipconfig_indicate_state(struct connman_service =
*service,
    else
        service->state_ipv6 =3D new_state;
=20
-   if (!is_connected(old_state) && is_connected(new_state))
+   if (!is_connected(old_state) && is_connected(new_state)) {
        nameserver_add_all(service, type);
=20
-   __connman_timeserver_sync(service,
-               CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE);
+        __connman_timeserver_sync(service,
+                   CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE);
+    }
=20
    return service_indicate_state(service);
 }

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

