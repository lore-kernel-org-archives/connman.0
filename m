Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC669288
	for <connman@lists.linux.dev>; Tue,  5 Dec 2023 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CB43373100;
	Tue,  5 Dec 2023 12:09:05 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:5908:434f:401b:daca] (unknown [IPv6:2601:647:5a00:15c1:5908:434f:401b:daca])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 79ED07310E;
	Tue,  5 Dec 2023 12:09:05 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: There Are No Routes for Non-default Ethernet / Wi-Fi Services (was
 Re: A Few Minor Complications on connman + connman-vpn + wpa_supplicant +
 ofono Bringup)
From: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <8BE7A0AB-C2A6-41DD-A68A-7BCC302FD8EA@nuovations.com>
Date: Tue, 5 Dec 2023 09:09:04 -0800
Cc: Denis Kenzior <denkenz@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00108C3F-D96B-4C90-A95D-FB5D8D1A26D4@nuovations.com>
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
>>>> [=E2=80=A6]
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
>=20
> It also turns out that the 'redirect-gateway' =E2=80=9Cdef1" trick =
employed by OpenVPN also works, albeit it requires two routing table =
entries to the RTA_PRIORITY / metric approach's one entry:
>=20
>    ip route add 0.0.0.0/1 dev wlan0 via <gateway>
>    ip route add 128.0.0.0/1 dev wlan0 via <gateway>
>=20
> both routes are more specific than:
>=20
>    ip route add default dev eth0 via <gateway>
>=20
> and are thus chosen when doing:
>=20
>    ping -c4 -Iwlan0 dns.google.com
>=20
> However, since this requires two entries and may create conflicts with =
VPNs, I am inclined to stick with the:
>=20
>    ip route add default dev wlan0 via 192.168.2.1 metric UINT32_MAX
>=20
> approach and will have patches towards that end shortly.

ConnMan Community:

At this point, I have low-priority default routes working and mostly =
production-ready, at least for Ethernet and Wi-Fi. I need to bring =
Cellular into the mix today for testing to ensure that follows the =
algorithm (which, aside from VPN as before, is service-neutral).

Hopefully, someone from the list can assist with VPN testing. I=E2=80=99ll=
 post an evaluation GitHub branch along with RFC patches for those =
interested / capable.

I=E2=80=99ve made every effort to not break VPN support intentionally; =
however, there was some overloading of the =E2=80=9Cactive=E2=80=9D =
(which I=E2=80=99ve now formalized as one of four states in a gateway =
lifetime finite state machine) gateway flag and I=E2=80=99ve =
=E2=80=9Cun-overloaded=E2=80=9D it such that the =E2=80=9Cactive=E2=80=9D =
state behaves as it seems it was originally designed to, without the =
overloading. The overloading was such that a gateway configuration would =
be promoted to =E2=80=9Cactive=E2=80=9D and demoted out of it in the =
{unset, set}_default_gateway for non-default cases such that the =
connection_newgateway/connection_delgateway RTNL notification round-trip =
was short-circuited. There will now be a =E2=80=9Cflags=E2=80=9D member =
that will include a VPN flag (formerly a Boolean) to which additional =
flags can be added for this =E2=80=9Coverloading=E2=80=9D if so =
warranted / necessary.

The other use case, beyond VPN, I am unsure about and do not have the =
test DUT for is multiple Ethernet or Wi-Fi interfaces. I suspect my =
approach of one metric 0 =E2=80=9Chigh-priority=E2=80=9D gateway / =
default route and one metric UINT32_MAX =E2=80=9Clow-priorty=E2=80=9D =
gateway / default route will fall apart there. A partitioning of the 1 - =
UINT32_MAX space may need to be partitioned up by =E2=80=9Cservice =
order=E2=80=9D for non-default services for that case. Again, if you =
have a use and test case for that, testing and feedback would be =
appreciated. There may also need to be some per-technology plugin =
introspection interaction, per Denis=E2=80=99 comments above, that say =
=E2=80=9CDon=E2=80=99t set a low-priority default route; we=E2=80=99ve =
got that on our end=E2=80=9D.

My test case thus far has been:

    1. Start with Ethernet and Wi-Fi connected.
	a. Verify "connmanctl services; ifconfig; ip -4 route show; ping =
-c4 -Iwlan0 dns.google.com; ping6 -c4 -Iwlan0 dns.google.com" against =
the Ethernet IP address via ssh.
    2. Unplug Ethernet at the DUT.
        b. Verify "connmanctl services; ifconfig; ip -4 route show; ping =
-c4 -Iwlan0 dns.google.com; ping6 -c4 -Iwlan0 dns.google.com" against =
the Wi-Fi IP address via ssh.
    3. Replug Ethernet at the DUT.
	c. Verify (1a) above again.

Prior to my pending patches, (1a) and (1c) failed every time for the =
"ping -c4 -Iwlan0 dns.google.com=E2=80=9D case.

In the (1) and (3) cases, the IPv4 routing table ends up looking like:

    default via 192.168.2.1 dev eth0=20
    default via 192.168.2.1 dev wlan0 metric 4294967295=20
    192.168.2.0/24 dev wlan0 proto kernel scope link src 192.168.2.46=20
    192.168.2.0/24 dev eth0 proto kernel scope link src 192.168.2.69=20
    192.168.2.1 dev eth0 scope link=20
    192.168.2.1 dev wlan0 scope link=20

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

