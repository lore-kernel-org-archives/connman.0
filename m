Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CD1BB27
	for <connman@lists.linux.dev>; Wed, 19 Jul 2023 23:40:17 +0000 (UTC)
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2D5D27336C;
	Wed, 19 Jul 2023 19:40:17 -0400 (EDT)
Received: from [IPv6:2601:647:5a83:8c51:6890:2a40:c15c:d720] (unknown [IPv6:2601:647:5a83:8c51:6890:2a40:c15c:d720])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E2E9F73383;
	Wed, 19 Jul 2023 19:40:16 -0400 (EDT)
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
In-Reply-To: <41f83fcb-8ced-75f8-4d42-64c67a886eb3@gmail.com>
Date: Wed, 19 Jul 2023 16:40:16 -0700
Cc: connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD3159CB-7D79-4188-B56A-7EB65C6581DB@nuovations.com>
References: <E519DA16-D9AE-48C9-9731-6DB7A9B7ABE7@nuovations.com>
 <41f83fcb-8ced-75f8-4d42-64c67a886eb3@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Thanks for the quick and detailed reply! Please see more inline below.

On Jul 19, 2023, at 3:58 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> On 7/19/23 11:57, Grant Erickson wrote:
>> It=E2=80=99s great to be re-engaged with the connman community after =
some time away, noting a community and mailing list migration in the =
intervening time.
>> I am currently working on modernizing an IP-based communications =
stack for a Digi i.MX6-based SBC with Ethernet, Wi-Fi, and Cellular =
(using a Quectel-based =E2=80=9CNimblelink=E2=80=9D) connectivity. The =
infrastructure has migrated from =
ifupdown/ifplugd/wpa_supplicant/ppp/chat to connmand (1.41) + =
connman-vpnd + ofono (2.1) + wpa_supplicant (2.10). All in all, standing =
up a prototype for this more modern stack was very straightforward and =
simple relative to when I first engaged on this front in late 2010. =
Ethernet + Wi-Fi + Cellular worked, mostly, straight away with =
little-to-no configuration and setup on my part. Congratulations to the =
community on all the progress in the intervening 13 years!
>=20
> You should check out iwd ;)

Definitely on my to-do list as I=E2=80=99ve heard other sources of =
advocacy for iwd as well. However, for the initial bring-up and =
prototyping phase of this modernized stack, I wanted to hold a few =
things constant, wpa_supplicant among them.

>> I suspect an issue with the routing setup:
>=20
> <snip>
>=20
>> 	# ip -4 route show
>> 	default via 192.168.2.1 dev eth0
>> 	100.87.218.180/30 dev wwan0 proto kernel scope link src =
100.87.218.182
>> 	100.87.218.181 dev wwan0 scope link
>> 	192.168.2.0/24 dev wlan0 proto kernel scope link src =
192.168.2.46
>> 	192.168.2.0/24 dev eth0 proto kernel scope link src 192.168.2.69
>> 	192.168.2.1 dev eth0 scope link
>> 	192.168.2.1 dev wlan0 scope link
>> 	198.224.173.135 via 100.87.218.181 dev wwan0
>> 	198.224.174.135 via 100.87.218.181 dev wwan0
>>=20
>=20
> Correct.  IPv4 routing is missing any gateway information for wlan and =
wwan links.  Hence the packets cannot be routed.  iwd uses a default =
route with a metric set with the assumption that the metric for ethernet =
devices would be higher priority.

Absent iwd doing this, shouldn=E2=80=99t connman be adding such a route =
for wlan0 as it did / seems to have for eth0 IPv4/IPv6 and wwan0 IPv4? =
My understand is connman is the maintainer of routing from a link =
redundancy perspective. Is that not accurate?

> You can also try doing something like:
>=20
> ip route add default dev wlan0 table 1234

That didn=E2=80=99t quite work; however, this did:

ip route add default dev wlan0 via 192.168.2.1 metric 1024

where 192.168.2.1 is the next hop gateway.

> ConnMan (or is ConnMan using the kernel to setup IPv6 routes? I don't =
remember) is setting up default routes for eth0 and wlan0, so things =
work in this case.

Precisely, it seems like the IPv4 route for wlan0 is a =E2=80=9Chole=E2=80=
=9D in routing coverage where it did set IPv{4,6} routes for eth0, an =
IPv4 route for wwan0 (no IPv6 on that interface), and an IPv6 route for =
wlan0 but missed the IPv4 route.

My gut says this is a =E2=80=9Cbug=E2=80=9D rather than =
=E2=80=9Cas-designed=E2=80=9D. Thoughts?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

