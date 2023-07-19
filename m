Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C817F6
	for <connman@lists.linux.dev>; Wed, 19 Jul 2023 16:57:17 +0000 (UTC)
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B9A0A7334D
	for <connman@lists.linux.dev>; Wed, 19 Jul 2023 12:57:16 -0400 (EDT)
Received: from [IPv6:2601:647:5a83:8c51:c1c9:4e94:766e:a5db] (unknown [IPv6:2601:647:5a83:8c51:c1c9:4e94:766e:a5db])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6FF8673343
	for <connman@lists.linux.dev>; Wed, 19 Jul 2023 12:57:16 -0400 (EDT)
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
Subject: A Few Minor Complications on connman + connman-vpn + wpa_supplicant +
 ofono Bringup
Message-Id: <E519DA16-D9AE-48C9-9731-6DB7A9B7ABE7@nuovations.com>
Date: Wed, 19 Jul 2023 09:57:15 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

It=E2=80=99s great to be re-engaged with the connman community after =
some time away, noting a community and mailing list migration in the =
intervening time.

I am currently working on modernizing an IP-based communications stack =
for a Digi i.MX6-based SBC with Ethernet, Wi-Fi, and Cellular (using a =
Quectel-based =E2=80=9CNimblelink=E2=80=9D) connectivity. The =
infrastructure has migrated from =
ifupdown/ifplugd/wpa_supplicant/ppp/chat to connmand (1.41) + =
connman-vpnd + ofono (2.1) + wpa_supplicant (2.10). All in all, standing =
up a prototype for this more modern stack was very straightforward and =
simple relative to when I first engaged on this front in late 2010. =
Ethernet + Wi-Fi + Cellular worked, mostly, straight away with =
little-to-no configuration and setup on my part. Congratulations to the =
community on all the progress in the intervening 13 years!

I=E2=80=99ve noted a handful hiccups which I=E2=80=99ll continue to =
debug and triage and will post updates as I find them. In the interim, =
if anyone else can confirm seeing the issues below or has suggestion on =
them, I would welcome the input as I begin to triage each:

1. When ofono indicates to connmand that the Cellular connection has =
gone down, connmand aborts with signal 11 (SIGABRT) 100% of the time. =
The logs preceding the abort are:

    Jul 16 08:25:27 19205453 daemon.info connman-vpnd[360]: wwan0 =
{update} flags 4240 <DOWN>
    Jul 16 08:25:27 19205453 daemon.info connman-vpnd[360]: wwan0 =
{newlink} index 8 operstate 2 <DOWN>
    Jul 16 08:25:27 19205453 daemon.info connmand[377]: wwan0 {RX} 0 =
packets 0 bytes
    Jul 16 08:25:27 19205453 daemon.info connmand[377]: wwan0 {TX} 1 =
packets 48 bytes
    Jul 16 08:25:27 19205453 daemon.info connmand[377]: wwan0 {update} =
flags 4240 <DOWN>
    Jul 16 08:25:27 19205453 daemon.info connmand[377]: wwan0 {newlink} =
index 8 address 00:00:00:00:00:00 mtu 1500
    Jul 16 08:25:27 19205453 daemon.info connmand[377]: wwan0 {newlink} =
index 8 operstate 2 <DOWN>
    Jul 16 08:25:27 19205453 daemon.info connmand[377]: wwan0 {del} =
address 100.102.174.234/30 label wwan0
    Jul 16 08:25:33 19205453 daemon.err connmand[377]: Aborting (signal =
11) [/usr/sbin/connmand]

Has anyone else observed this?

2. I am attempting to keep Ethernet + Wi-Fi + Cellular concurrent at all =
times, in that priority order. I expect, of course, that the most =
preferred and connected technology will keep the default route. However, =
I would expect that if I bind to an interface, I can still get Internet =
reachability with that interface. This works for Ethernet (expected, =
since it has the default route) and Cellular and Wi-Fi for IPv6. =
However, Wi-Fi over IPv4 can only reach its local subnet but not the =
Internet when it is not primary:

I suspect an issue with the routing setup:

	# ifconfig=20
	eth0      Link encap:Ethernet  HWaddr 00:04:F3:1A:5E:E0 =20
			  inet addr:192.168.2.69  Bcast:192.168.2.255  =
Mask:255.255.255.0
			  inet6 addr: =
2601:647:5a83:8c52:204:f3ff:fe1a:5ee0/64 Scope:Global
			  inet6 addr: fe80::204:f3ff:fe1a:5ee0/64 =
Scope:Link
			  UP BROADCAST RUNNING MULTICAST  MTU:1500  =
Metric:1
			  RX packets:53 errors:0 dropped:0 overruns:0 =
frame:0
			  TX packets:112 errors:0 dropped:0 overruns:0 =
carrier:0
			  collisions:0 txqueuelen:1000=20
			  RX bytes:8488 (8.2 KiB)  TX bytes:16201 (15.8 =
KiB)

	lo        Link encap:Local Loopback =20
			  inet addr:127.0.0.1  Mask:255.0.0.0
			  inet6 addr: ::1/128 Scope:Host
			  UP LOOPBACK RUNNING  MTU:65536  Metric:1
			  RX packets:254 errors:0 dropped:0 overruns:0 =
frame:0
			  TX packets:254 errors:0 dropped:0 overruns:0 =
carrier:0
			  collisions:0 txqueuelen:1=20
			  RX bytes:16495 (16.1 KiB)  TX bytes:16495 =
(16.1 KiB)

	wlan0     Link encap:Ethernet  HWaddr 00:04:F3:1A:5E:E1 =20
			  inet addr:192.168.2.46  Bcast:192.168.2.255  =
Mask:255.255.255.0
			  inet6 addr: =
2601:647:5a83:8c52:204:f3ff:fe1a:5ee1/64 Scope:Global
			  inet6 addr: fe80::204:f3ff:fe1a:5ee1/64 =
Scope:Link
			  UP BROADCAST RUNNING MULTICAST  MTU:1500  =
Metric:1
			  RX packets:41 errors:0 dropped:0 overruns:0 =
frame:0
			  TX packets:143 errors:0 dropped:0 overruns:0 =
carrier:0
			  collisions:0 txqueuelen:1000=20
			  RX bytes:7538 (7.3 KiB)  TX bytes:15891 (15.5 =
KiB)

	wwan0     Link encap:UNSPEC  HWaddr =
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00 =20
			  inet addr:100.87.218.182  P-t-P:100.87.218.182 =
 Mask:255.255.255.252
			  UP POINTOPOINT RUNNING NOARP MULTICAST  =
MTU:1500  Metric:1
			  RX packets:0 errors:0 dropped:0 overruns:0 =
frame:0
			  TX packets:1 errors:0 dropped:0 overruns:0 =
carrier:0
			  collisions:0 txqueuelen:1000=20
			  RX bytes:0 (0.0 B)  TX bytes:48 (48.0 B)

	# ping -c 4 -I eth0 dns.google.com=20
	PING dns.google.com (8.8.8.8): 56 data bytes
	64 bytes from 8.8.8.8: seq=3D0 ttl=3D116 time=3D8.249 ms
	64 bytes from 8.8.8.8: seq=3D1 ttl=3D116 time=3D9.280 ms
	64 bytes from 8.8.8.8: seq=3D2 ttl=3D116 time=3D8.085 ms
	64 bytes from 8.8.8.8: seq=3D3 ttl=3D116 time=3D8.804 ms

	--- dns.google.com ping statistics ---
	4 packets transmitted, 4 packets received, 0% packet loss
	round-trip min/avg/max =3D 8.085/8.604/9.280 ms

	# ping6 -c 4 -I eth0 dns.google.com=20
	PING dns.google.com (2001:4860:4860::8844): 56 data bytes
	64 bytes from 2001:4860:4860::8844: seq=3D0 ttl=3D57 time=3D9.434 =
ms
	64 bytes from 2001:4860:4860::8844: seq=3D1 ttl=3D57 time=3D9.235 =
ms
	64 bytes from 2001:4860:4860::8844: seq=3D2 ttl=3D57 time=3D9.297 =
ms
	64 bytes from 2001:4860:4860::8844: seq=3D3 ttl=3D57 time=3D9.166 =
ms

	--- dns.google.com ping statistics ---
	4 packets transmitted, 4 packets received, 0% packet loss
	round-trip min/avg/max =3D 9.166/9.283/9.434 ms

	# ping -c 4 -I wlan0 dns.google.com=20
	PING dns.google.com (8.8.8.8): 56 data bytes

	--- dns.google.com ping statistics ---
	4 packets transmitted, 0 packets received, 100% packet loss

	# ping6 -c 4 -I wlan0 dns.google.com=20
	PING dns.google.com (2001:4860:4860::8844): 56 data bytes
	64 bytes from 2001:4860:4860::8844: seq=3D0 ttl=3D57 =
time=3D100.924 ms
	64 bytes from 2001:4860:4860::8844: seq=3D1 ttl=3D57 =
time=3D124.037 ms
	64 bytes from 2001:4860:4860::8844: seq=3D2 ttl=3D57 time=3D45.249=
 ms
	64 bytes from 2001:4860:4860::8844: seq=3D3 ttl=3D57 time=3D69.188=
 ms

	--- dns.google.com ping statistics ---
	4 packets transmitted, 4 packets received, 0% packet loss
	round-trip min/avg/max =3D 45.249/84.849/124.037 ms

	# ping -c 4 -I wwan0 dns.google.com=20
	PING dns.google.com (8.8.8.8): 56 data bytes
	64 bytes from 8.8.8.8: seq=3D0 ttl=3D113 time=3D605.749 ms
	64 bytes from 8.8.8.8: seq=3D1 ttl=3D113 time=3D287.500 ms
	64 bytes from 8.8.8.8: seq=3D2 ttl=3D113 time=3D98.122 ms
	64 bytes from 8.8.8.8: seq=3D3 ttl=3D113 time=3D293.822 ms

	--- dns.google.com ping statistics ---
	4 packets transmitted, 4 packets received, 0% packet loss
	round-trip min/avg/max =3D 98.122/321.298/605.749 ms

	# ip -4 route show
	default via 192.168.2.1 dev eth0=20
	100.87.218.180/30 dev wwan0 proto kernel scope link src =
100.87.218.182=20
	100.87.218.181 dev wwan0 scope link=20
	192.168.2.0/24 dev wlan0 proto kernel scope link src =
192.168.2.46=20
	192.168.2.0/24 dev eth0 proto kernel scope link src 192.168.2.69=20=

	192.168.2.1 dev eth0 scope link=20
	192.168.2.1 dev wlan0 scope link=20
	198.224.173.135 via 100.87.218.181 dev wwan0=20
	198.224.174.135 via 100.87.218.181 dev wwan0=20

	# ip -6 route show
	2601:647:5a83:8c52::/64 dev wlan0 proto kernel metric 256 =
expires 2591856sec pref medium
	2601:647:5a83:8c52::/64 dev eth0 proto kernel metric 256 expires =
2591856sec pref medium
	fe80::/64 dev wlan0 proto kernel metric 256 pref medium
	fe80::/64 dev eth0 proto kernel metric 256 pref medium
	ff00::/8 dev wlan0 metric 256 pref medium
	ff00::/8 dev eth0 metric 256 pref medium
	default via fe80::f29f:c2ff:fe10:271e dev wlan0 proto ra metric =
1024 expires 1656sec hoplimit 64 pref medium
	default via fe80::f29f:c2ff:fe10:271e dev eth0 proto ra metric =
1024 expires 1656sec hoplimit 64 pref medium

Has anyone else observed this?

3. In the aforementioned configuration, connmanctl (or dbus-send) =
reports that `State =3D ready` nearly indefinitely without a transition =
to Online, despite the ipv4.connman.net and ipv6.connman.net URLs being =
readily reachable.

4. Connman complains about not being able to use the configured Google =
DNS fallback servers:

    FallbackNameservers=3D8.8.8.8,8.8.4.4

with:

    Jul 12 18:12:33 19205453 daemon.err connmand[360]: Failed to connect =
to server 8.8.8.8
    Jul 12 18:12:33 19205453 daemon.err connmand[360]: Failed to connect =
to server 8.8.4.4

5. Despite having set ResolvConf=3D/dev/null per the man page, connman =
seems to be unhappy with and not following the code path for =
ResolvConf=3D/dev/null:

    Jul 12 18:02:42 19205453 daemon.warn connmand[360]: Cannot create =
/var/run/connman/resolv.conf falling back to /etc/resolv.conf

While I realize this is a harmless warning, it seems at odds with the =
man page and the code path for =E2=80=98resolvfile_export'.

I=E2=80=99ve manually-created a static, read-only /etc/resolv.conf which =
need not be dynamically updated at runtime:

    nameserver 127.0.0.1
    nameserver ::1

6. The openvpn plugin seems to be unable to find the =E2=80=98=E2=80=99 =
symbol:

    Jul 12 18:02:42 19205453 daemon.err connmand[360]: Can't load =
/usr/lib/connman/plugins/openvpn.so: =
/usr/lib/connman/plugins/openvpn.so: undefined symbol: =
vpn_provider_set_nameservers

The contents of /etc/connman/main.conf:

    [General]
    AllowDomainnameUpdates=3Dfalse
    AllowHostnameUpdates=3Dfalse
    AlwaysConnectedTechnologies=3Dethernet,wifi,cellular
    BackgroundScanning=3Dtrue
    DefaultAutoConnectTechnologies=3Dethernet,wifi,cellular
    EnableOnlineCheck=3Dtrue
    EnableOnlineToReadyTransition=3Dtrue
    =
FallbackTimeservers=3D0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org,3.pool.=
ntp.org
    FallbackNameservers=3D8.8.8.8,8.8.4.4
    PreferredTechnologies=3Dethernet,wifi,cellular
    ResolvConf=3D/dev/null
    SingleConnectedTechnology=3Dfalse

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

