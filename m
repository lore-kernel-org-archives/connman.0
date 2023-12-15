Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA58CA70
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id DB148730F9;
	Fri, 15 Dec 2023 01:12:27 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:b068:f747:ef15:95c3] (unknown [IPv6:2601:647:5a00:15c1:b068:f747:ef15:95c3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7418E7310E;
	Fri, 15 Dec 2023 01:12:27 -0500 (EST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: RFC: There Are No Routes for Non-default Services
From: Grant Erickson <gerickson@nuovations.com>
X-Priority: 1
In-Reply-To: <FAB1AC37-E077-4067-B245-5CE862CB22B7@gmail.com>
Date: Thu, 14 Dec 2023 22:12:26 -0800
Cc: connman@lists.linux.dev,
 =?utf-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7AA7A9C0-3788-472F-A095-CA72DA3BB408@nuovations.com>
References: <4C194197-1C1D-4FB4-A526-4284D6545A37@nuovations.com>
 <FAB1AC37-E077-4067-B245-5CE862CB22B7@gmail.com>
To: Christian Hewitt <christianshewitt@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

On Dec 14, 2023, at 8:51 PM, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
> I=E2=80=99m not on the mailing list and this ended up in Junk so I =
missed the opportunity to test/comment before the series was merged.

Given that, thank you for taking the time to reply and provide your =
experience and feedback!

> Using current connman HEAD support for WireGuard via connman-vpn is =
broken (cannot create a connection) and results in loss of internet =
connectivity on hosts where the vpn connection is configured (via =
scripts or a simple systemd service) to start automatically on boot.

If you have any setup or how-tos on your WireGuard configuration, =
that=E2=80=99d be helpful in orienting towards a setup that replicates =
your environment.

> If I start the host with no active VPN connection the ethernet service =
started and I have internet access. Once I initiate a VPN connection the =
journal shows:
>=20
> Dec 15 08:11:23 RPi5 systemd[1]: Starting connman.service...
> Dec 15 08:11:23 RPi5 connmand[1284]: Connection Manager version 1.42
> Dec 15 08:11:23 RPi5 systemd[1]: Started connman.service.
> Dec 15 08:11:23 RPi5 connmand[1284]: Checking loopback interface =
settings
> Dec 15 08:11:23 RPi5 connmand[1284]: System hostname is RPi5
> Dec 15 08:11:23 RPi5 connmand[1284]: lo {newlink} index 1 address =
00:00:00:00:00:00 mtu 65536
> Dec 15 08:11:23 RPi5 connmand[1284]: lo {newlink} index 1 operstate 0 =
<UNKNOWN>
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {create} index 2 type 1 =
<ETHER>
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {RX} 40998 packets 52398192 =
bytes
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {TX} 13806 packets 1176407 =
bytes
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {update} flags 102467 =
<UP,RUNNING,LOWER_UP>
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {newlink} index 2 address =
B8:27:EB:B5:D9:A2 mtu 1500
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {newlink} index 2 operstate =
6 <UP>
> Dec 15 08:11:23 RPi5 connmand[1284]: ipconfig state 3 ipconfig method =
1
> Dec 15 08:11:23 RPi5 connmand[1284]: Adding interface eth0 [ ethernet =
]
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} address =
172.16.40.25/24 label eth0 family 2
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 0.0.0.0/0 gw =
172.16.40.1 scope 0 <UNIVERSE> table 254 <main> metric 0
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 0.0.0.0/0 gw =
172.16.40.1 scope 0 <UNIVERSE> table 254 <main> metric 0
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 65.109.130.17/32 =
gw 172.16.40.1 scope 0 <UNIVERSE> table 254 <main> metric 0
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 82.165.8.211/32 =
gw 172.16.40.1 scope 0 <UNIVERSE> table 254 <main> metric 0
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route =
167.99.210.149/32 gw 172.16.40.1 scope 0 <UNIVERSE> table 254 <main> =
metric 0
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 172.16.40.0/24 =
gw 0.0.0.0 scope 253 <LINK> table 254 <main> metric 0
> Dec 15 08:11:23 RPi5 connmand[1284]: eth0 {add} route 172.16.40.1/32 =
gw 0.0.0.0 scope 253 <LINK> table 254 <main> metric 0
> Dec 15 08:11:23 RPi5 connmand[1284]: Aborting (signal 11) =
[/usr/sbin/connmand]
> Dec 15 08:11:23 RPi5 connmand[1284]: ++++++++ backtrace ++++++++
> Dec 15 08:11:23 RPi5 connmand[1284]: Error in backtrace format
> Dec 15 08:11:23 RPi5 connmand[1284]: +++++++++++++++++++++++++++
> Dec 15 08:11:23 RPi5 systemd[1]: connman.service: Main process exited, =
code=3Dexited, status=3D1/FAILURE
> Dec 15 08:11:23 RPi5 systemd[1]: connman.service: Failed with result =
'exit-code'.

A couple of suggestions here, if you=E2=80=99re able:

1. Are you able to build with =E2=80=94enable-debug or, failing that, =
with =E2=80=9C-Og -g3=E2=80=9D as the optimizer / CFLAGS?
2. Are you able to build with --enable-asan or, failing that, =
"-fsanitize=3Daddress -fno-omit-frame-pointer =
-fno-optimize-sibling-calls=E2=80=9D as the CFLAGS?
3. Are you able to run connmand with the =E2=80=9C-d=E2=80=9D option?

(1) and/or (2) may help provide a more exact backtrace. Failing that, =
(3) may put the failure in a smaller scope.

Have you tried to do a =E2=80=9Cgit bisect" to zero in on the most =
likely commit that is causing the regression?

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

