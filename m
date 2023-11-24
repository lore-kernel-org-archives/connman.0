Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B62511F
	for <connman@lists.linux.dev>; Fri, 24 Nov 2023 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 71E3173133;
	Fri, 24 Nov 2023 14:47:36 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:e9e3:725c:3cdc:7b3c] (unknown [IPv6:2601:647:5a00:15c1:e9e3:725c:3cdc:7b3c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2647E73142;
	Fri, 24 Nov 2023 14:47:36 -0500 (EST)
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
In-Reply-To: <9D699F16-5833-40D2-97C4-C3B2D545BA0F@nuovations.com>
Date: Fri, 24 Nov 2023 11:47:35 -0800
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BE7A0AB-C2A6-41DD-A68A-7BCC302FD8EA@nuovations.com>
References: <E519DA16-D9AE-48C9-9731-6DB7A9B7ABE7@nuovations.com>
 <41f83fcb-8ced-75f8-4d42-64c67a886eb3@gmail.com>
 <9D699F16-5833-40D2-97C4-C3B2D545BA0F@nuovations.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Jul 19, 2023, at 4:29 PM, Grant Erickson <gerickson@nuovations.com> =
wrote:
> On Jul 19, 2023, at 3:58 PM, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 7/19/23 11:57, Grant Erickson wrote:
>>> I suspect an issue with the routing setup:
>>=20
>> <snip>
>>=20
>>> 	# ip -4 route show
>>> 	default via 192.168.2.1 dev eth0
>>> 	100.87.218.180/30 dev wwan0 proto kernel scope link src =
100.87.218.182
>>> 	100.87.218.181 dev wwan0 scope link
>>> 	192.168.2.0/24 dev wlan0 proto kernel scope link src =
192.168.2.46
>>> 	192.168.2.0/24 dev eth0 proto kernel scope link src 192.168.2.69
>>> 	192.168.2.1 dev eth0 scope link
>>> 	192.168.2.1 dev wlan0 scope link
>>> 	198.224.173.135 via 100.87.218.181 dev wwan0
>>> 	198.224.174.135 via 100.87.218.181 dev wwan0
>>>=20
>>=20
>> Correct.  IPv4 routing is missing any gateway information for wlan =
and wwan links.  Hence the packets cannot be routed.  iwd uses a default =
route with a metric set with the assumption that the metric for ethernet =
devices would be higher priority.
>=20
> Absent iwd doing this, shouldn=E2=80=99t connman be adding such a =
route for wlan0 as it did / seems to have for eth0 IPv4/IPv6 and wwan0 =
IPv4? My understand is connman is the maintainer of routing from a link =
redundancy perspective. Is that not accurate?
>=20
>> You can also try doing something like:
>>=20
>> ip route add default dev wlan0 table 1234
>=20
> That didn=E2=80=99t quite work; however, this did:
>=20
> ip route add default dev wlan0 via 192.168.2.1 metric 1024
>=20
> where 192.168.2.1 is the next hop gateway.

It also turns out that the 'redirect-gateway' =E2=80=9Cdef1" trick =
employed by OpenVPN also works, albeit it requires two routing table =
entries to the RTA_PRIORITY / metric approach's one entry:

    ip route add 0.0.0.0/1 dev wlan0 via <gateway>
    ip route add 128.0.0.0/1 dev wlan0 via <gateway>

both routes are more specific than:

    ip route add default dev eth0 via <gateway>

and are thus chosen when doing:

    ping -c4 -Iwlan0 dns.google.com

However, since this requires two entries and may create conflicts with =
VPNs, I am inclined to stick with the:

    ip route add default dev wlan0 via 192.168.2.1 metric UINT32_MAX

approach and will have patches towards that end shortly.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

