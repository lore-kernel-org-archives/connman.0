Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A963511
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9E9E673147;
	Thu, 21 Dec 2023 13:55:15 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:9c05:27c:79d0:aa4c] (unknown [IPv6:2601:647:5a00:15c1:9c05:27c:79d0:aa4c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3B88473156;
	Thu, 21 Dec 2023 13:55:15 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: A Few Minor Complications on connman + connman-vpn +
 wpa_supplicant + ofono Bringup
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <8BE7A0AB-C2A6-41DD-A68A-7BCC302FD8EA@nuovations.com>
Date: Thu, 21 Dec 2023 10:55:14 -0800
Cc: Denis Kenzior <denkenz@gmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C73067D-8D16-4971-88DE-6D2C9A5C013B@nuovations.com>
References: <E519DA16-D9AE-48C9-9731-6DB7A9B7ABE7@nuovations.com>
 <41f83fcb-8ced-75f8-4d42-64c67a886eb3@gmail.com>
 <9D699F16-5833-40D2-97C4-C3B2D545BA0F@nuovations.com>
 <8BE7A0AB-C2A6-41DD-A68A-7BCC302FD8EA@nuovations.com>
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Nov 24, 2023, at 11:47 AM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> On Jul 19, 2023, at 4:29 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
>> On Jul 19, 2023, at 3:58 PM, Denis Kenzior <denkenz@gmail.com> wrote:
>>> On 7/19/23 11:57, Grant Erickson wrote:
>>>> I suspect an issue with the routing setup:
>>>=20
>>> <snip>
>>>=20
>>>> <snip>
>>>=20
>>> Correct.  IPv4 routing is missing any gateway information for wlan =
and wwan links.  Hence the packets cannot be routed.  iwd uses a default =
route with a metric set with the assumption that the metric for ethernet =
devices would be higher priority.
>>=20
>> Absent iwd doing this, shouldn=E2=80=99t connman be adding such a =
route for wlan0 as it did / seems to have for eth0 IPv4/IPv6 and wwan0 =
IPv4? My understand is connman is the maintainer of routing from a link =
redundancy perspective. Is that not accurate?
>>=20
>>> You can also try doing something like:
>>>=20
>>> ip route add default dev wlan0 table 1234
>>=20
>> That didn=E2=80=99t quite work; however, this did:
>>=20
>> ip route add default dev wlan0 via 192.168.2.1 metric 1024
>>=20
>> where 192.168.2.1 is the next hop gateway.

ConnMan Community:

After the substantial number of patches submitted between 2023-11-07 and =
2023-12-20, I am pleased to convey that not only does the above use case =
(successfully binding to and using a non-default service network =
interface) work:

# ifconfig=20
eth0      Link encap:Ethernet  HWaddr 00:04:F3:1A:5E:E0 =20
          inet addr:192.168.2.69  Bcast:192.168.2.255  =
Mask:255.255.255.0
          inet6 addr: 2601:647:5a00:15c2:204:f3ff:fe1a:5ee0/64 =
Scope:Global
          inet6 addr: fe80::204:f3ff:fe1a:5ee0/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:54310 errors:0 dropped:0 overruns:0 frame:0
          TX packets:37996 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:8580232 (8.1 MiB)  TX bytes:3603832 (3.4 MiB)

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:34349 errors:0 dropped:0 overruns:0 frame:0
          TX packets:34349 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1=20
          RX bytes:1871507 (1.7 MiB)  TX bytes:1871507 (1.7 MiB)

wlan0     Link encap:Ethernet  HWaddr 00:04:F3:1A:5E:E1 =20
          inet addr:192.168.2.46  Bcast:192.168.2.255  =
Mask:255.255.255.0
          inet6 addr: fe80::204:f3ff:fe1a:5ee1/64 Scope:Link
          inet6 addr: 2601:647:5a00:15c2:204:f3ff:fe1a:5ee1/64 =
Scope:Global
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:20500 errors:0 dropped:0 overruns:0 frame:0
          TX packets:450 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:4118209 (3.9 MiB)  TX bytes:52914 (51.6 KiB)

wwan0     Link encap:UNSPEC  HWaddr =
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00 =20
          inet addr:100.69.213.13  P-t-P:100.69.213.13  =
Mask:255.255.255.252
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 B)  TX bytes:48 (48.0 B)

# ip -4 route show
default via 192.168.2.1 dev eth0=20
default via 100.69.213.14 dev wwan0 metric 4294959103=20
default via 192.168.2.1 dev wlan0 metric 4294960127=20
100.69.213.12/30 dev wwan0 proto kernel scope link src 100.69.213.13=20
100.69.213.14 dev wwan0 scope link=20
192.168.2.0/24 dev wlan0 proto kernel scope link src 192.168.2.46=20
192.168.2.0/24 dev eth0 proto kernel scope link src 192.168.2.69=20
192.168.2.1 dev eth0 scope link=20
192.168.2.1 dev wlan0 scope link=20
198.224.173.135 via 100.69.213.14 dev wwan0=20
198.224.174.135 via 100.69.213.14 dev wwan0=20

# ping -c4 -Iwlan0 dns.google.com
PING dns.google.com (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=3D0 ttl=3D116 time=3D12.208 ms
64 bytes from 8.8.8.8: seq=3D1 ttl=3D116 time=3D40.421 ms
64 bytes from 8.8.8.8: seq=3D2 ttl=3D116 time=3D64.158 ms
64 bytes from 8.8.8.8: seq=3D3 ttl=3D116 time=3D87.914 ms

--- dns.google.com ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max =3D 12.208/51.175/87.914 ms

# ping -c4 -Ieth0 dns.google.com
PING dns.google.com (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=3D0 ttl=3D116 time=3D8.409 ms
64 bytes from 8.8.8.8: seq=3D1 ttl=3D116 time=3D9.209 ms
64 bytes from 8.8.8.8: seq=3D2 ttl=3D116 time=3D8.847 ms
64 bytes from 8.8.8.8: seq=3D3 ttl=3D116 time=3D8.414 ms

--- dns.google.com ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max =3D 8.409/8.719/9.209 ms

# ping -c4 -Iwwan0 dns.google.com
PING dns.google.com (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=3D0 ttl=3D114 time=3D665.069 ms
64 bytes from 8.8.8.8: seq=3D1 ttl=3D114 time=3D42.188 ms
64 bytes from 8.8.8.8: seq=3D2 ttl=3D114 time=3D82.943 ms
64 bytes from 8.8.8.8: seq=3D3 ttl=3D114 time=3D121.834 ms

--- dns.google.com ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max =3D 42.188/228.008/665.069 ms

as desired, but so does the =E2=80=98OnlineCheckMode=3D=E2=80=9Ccontinuous=
=E2=80=9D=E2=80=99 (formerly EnableOnlineCheck=3Dtrue, =
EnableOnlineToReadyTransition=3Dtrue) use case in which end-to-end =
reachability failures that are not next-hop link related are recognized =
and cause failover to the next =E2=80=9Conline=E2=80=9D service with =
end-to-end reachability.

Next, onto investigating VPN failures with the most recent patches for =
Christian Hewitt and looking into why cellular fails after some period =
of time with oFono 2.1 and 2.2.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

