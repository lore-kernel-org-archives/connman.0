Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2362C859
	for <connman@lists.linux.dev>; Sat, 25 Jan 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737818539; cv=none; b=NHsT8AD5h0sztwI9Lbkg+Ss47oeHX5vemkVHRElfPNFcFlWHZ3EhJ7gfYH5HilY3KhXKsBNux3AuOIOObnKDa/8T/37lplxjB5LF1GSuLRboq7wKh+Pxi3F6TRqdLL+2HukWPpS+iSwe8926PH/v/VPtCdwJ9UzxDjMRqMlCtnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737818539; c=relaxed/simple;
	bh=aS4fgjFYMv+/Ja3Dw95E4nhFOuuYKrPkIrmbCTdHe9g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BFhpci2zFOQIbg94F7mWXIt8eMTHgrZgyGg2jCit2ABjjHqJQEu1jdtqGRwKNGmQXuaooBcpbWdVt6AlH8GfARG5jH3BO5dvmqLeReT/nNmS6OQsbV00XsAn8RgrKn8Vl6a+Jp5X0qXDRH7OAQKW3+R/pcm/kvbv0Mnx2i3DV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm8aTwze; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm8aTwze"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4368a293339so34285375e9.3
        for <connman@lists.linux.dev>; Sat, 25 Jan 2025 07:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737818536; x=1738423336; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbhLU1Y8nVkoGv36/c7spirhYtXETdqybJJw4SZq+rU=;
        b=mm8aTwzePlhTM6osgZAdSJYC3zwhADjvZKHL0wfQsSSvzjXpJj/Vj4uXbRQ/nSIoVG
         hrYBzTyw3rExmpIjbev+g/CtyDJDdnk79DQaPs+C9MQu02HQ3C7xeg3NSU9cyvW3enIo
         lIUCK8ilv/8FUdTEKNY+Ho291dIVqKf5Pzfhj9xNBkJ90lMcCdR8EO8JkWQQiIxf8IU5
         4owACrAZmxx4KsgEGQgiw0wRFsaX4HecFKM2W5DMAs93ay+nO0kpTqEF6c9i5Dj/jhVQ
         gW3wRvi2aIhE8oXSmutaKdVvkB+K4G9wjxvJNCZtgV1psiil13OGazLivao2ta2IVrlj
         by0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737818536; x=1738423336;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbhLU1Y8nVkoGv36/c7spirhYtXETdqybJJw4SZq+rU=;
        b=GVwBYIvBpuNKk9q8p/Pjrs2h0YtcOLYyCfuxsRKZMT9Wk4boU0WKTBVmCMzNJYn0ru
         P9CJ/GMpK35oGyKTMdeKswEPgwNb2n8EJLFyv1LZ+r7pfZZRm4v1d+h0Cu2hLDQyZ/ug
         ol/AyONCPJ4SSThRvDmgf+JIt3Hek5Q1ffGPa1S2VJHoiFSsOF8aTAd3pM5Y7kXteke4
         U10RPGwcsUAPIwGGei3WcUdKens2wdu/xrMKCF3hll3QQqxVQY00hqwVJrAI92s9a6UO
         nmexwsruAmcH728LzL1YK02yfHgrCKbH3GBzLs+3jb04S3m1H8aVRZflaK9PTsZhah2O
         725w==
X-Forwarded-Encrypted: i=1; AJvYcCXQnAnKYf0ahKgYd0l9GpbdEg7vQ8ORMPwfYswgtIodxoB9oFZme61Pyt+nfc5T3+nNCDXhzV4g@lists.linux.dev
X-Gm-Message-State: AOJu0YxSUu2NnH6AkhzdAT6Hh78qSGHaL8GKwnrKWgw+Igii/Bm2Bdss
	ldjUIGtYYd61MNiXliYiSrBBv4wcgb2IwLIb7QrSIPxuSi/o91ZN4IHA2A==
X-Gm-Gg: ASbGncttqLn4+xv8V7uyHpzpyRCJyjORtXAGJ9D30wDS0posdgcq0bY+UEoOqES2MBD
	DoNzVEq0DwOqGX8JZLrg+HsrdsHNGIGRxVGpSxi/NsozJq/cJ9/jFy0SUgSo9rJTy8SZfcQgZym
	dxN+LiWwrf5JVKwHoAf8JOlXy0xUiheK926c31yQ45yhzi2FPhxfJLbfAz25lau2rbZnjKkVaU5
	JdcYLNkBVahxpZ+LROFAkh5ie91GyY5fngOfB4dzNdNnHmOPkqoMk3Zz2cjd2kss2QtHtrQi6KF
	IuX3avbEeELezgGxUIbW5G1E92M=
X-Google-Smtp-Source: AGHT+IG3ktyuLt0OchOmNRrjdHLVTGs17tl26ohXTFH+Fjf1FacUqab5c+l0BlJQuu8+y7Kuaha++A==
X-Received: by 2002:a05:600c:4f48:b0:434:fd15:3adc with SMTP id 5b1f17b1804b1-43891431319mr255296635e9.25.1737818535403;
        Sat, 25 Jan 2025 07:22:15 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4fa599sm66977185e9.7.2025.01.25.07.22.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2025 07:22:14 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] gateway: Fix typo when setting 'is_vpn6'
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CA+iibzD3ctMW7chEiPfis9JKuTJqQxOb2uaC48BM3TRZkm1MqA@mail.gmail.com>
Date: Sat, 25 Jan 2025 19:22:01 +0400
Cc: Jussi Laakkonen <jussi.laakkonen@jolla.com>,
 Grant Erickson <gerickson@nuovations.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>,
 Gabriel Sanches <gabriel.sanches@prevas.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B003F09E-E90B-45BD-8E40-EF11D13789C2@gmail.com>
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
 <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
 <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com>
 <DA3FEE9B-62E5-4A2E-920F-ADFAE67CDB9A@gmail.com>
 <151b7546-a12c-4383-96e7-a6099a7a298f@jolla.com>
 <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
 <bb952186-9493-4efc-8256-deaa63c7385f@jolla.com>
 <CA+iibzBrT7mcgK8ZnsxdYuMqF5E+57z-kCZ-G0PLsWaezkdT4Q@mail.gmail.com>
 <CA+iibzC3xjeN2=SyLU3yhhOEKvPysSbr+obGKKo8G8noCRSOKQ@mail.gmail.com>
 <EFEF67A5-8CCE-457B-A5F1-AEF6552F712F@gmail.com>
 <CA+iibzD3ctMW7chEiPfis9JKuTJqQxOb2uaC48BM3TRZkm1MqA@mail.gmail.com>
To: daniel antoine <univac55@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)

In the connman config "Host=E2=80=9D must be an IP address not an FQDN.

Christian

> On 25 Jan 2025, at 7:12=E2=80=AFpm, daniel antoine =
<univac55@gmail.com> wrote:
>=20
> Hi
> with wg-quik I can connect the vpn and ping the endpoint 10.0.7.2
> the config file in /etc/wireguard (I have modify it for the e-mail) is
>=20
> [Interface]
> Address =3D 10.0.7.5/24
> PrivateKey =3D yyyyy
>=20
> [Peer]
> Endpoint =3D monsite.fr:51820
> PublicKey =3D xxxxx
> AllowedIPs =3D 10.0.7.0/24
> PersistentKeepalive =3D 25
>=20
> The config file for connman-vpn in /var/lib/connman-vpn
>=20
> [provider_wireguard]
> Type =3D WireGuard
> Name =3D chezlui
> Host =3D monsite.fr
> WireGuard.Address =3D 10.0.7.5/24
> WireGuard.PrivateKey =3D yyyyyy
> WireGuard.PublicKey =3D xxxxx
> WireGuard.AllowedIPs =3D 10.0.7.0/24
> WireGuard.EndpointPort =3D 51820
> WireGuard.PersistentKeepalive =3D 25
>=20
> Is there something wrong with it? It cause the wifi connexion to drop
> when I connect the vpn
>=20
> Best regards
>=20
> Daniel
>=20
> Le sam. 25 janv. 2025 =C3=A0 14:12, Christian Hewitt
> <christianshewitt@gmail.com> a =C3=A9crit :
>>=20
>> I=E2=80=99ve picked patches into =
https://github.com/chewitt/connman/commits/wireguard
>>=20
>> This is connman HEAD + Gabriel's is_vpn6 patch + my revert patch (to =
fix routing)
>> + the two series that Jussi posted to the list yesterday.
>>=20
>> For me this is working fine with no wireguard issues observed since =
this morning
>> when I=E2=80=99ve rebuilt a LibreELEC image using that branch. I plan =
to use it myself
>> for a couple of days, then if all good I=E2=80=99ll push changes into =
LibreELEC nightly
>> images for a while to get some wider testing done.
>>=20
>> Christian
>>=20
>>=20
>>> On 25 Jan 2025, at 3:23=E2=80=AFpm, daniel antoine =
<univac55@gmail.com> wrote:
>>>=20
>>> I have copy the patches from the dev list and they have all passed ;
>>> The vpn connection continue to drop with in the journalctl
>>>=20
>>> janv. 25 12:12:01 grat-os1 connman-vpnd[1176]: wlan0 {newlink} index
>>> 5 operstate 6 <UP>
>>> janv. 25 12:13:03 grat-os1 connman-vpnd[1176]: Adding configuration =
vpndania
>>> janv. 25 12:13:03 grat-os1 connman-vpnd[1176]: Added provider
>>> configuration wireguard
>>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {create} index 6
>>> type 65534 <NONE>
>>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags =
144 <DOWN>
>>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
>>> operstate 2 <DOWN>
>>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags
>>> 98513 <UP,RUNNING,LOWER_UP>
>>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
>>> operstate 0 <UNKNOWN>
>>> janv. 25 12:15:46 grat-os1 connman-vpnd[1176]: reresolve error limit =
reached
>>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {update} flags =
32912 <DOWN>
>>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
>>> operstate 2 <DOWN>
>>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {dellink} index 6
>>> operstate 2 <DOWN>
>>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {remove} index 6
>>>=20
>>> and
>>>=20
>>> =E2=97=8F connman-vpn.service - ConnMan VPN service
>>>    Loaded: loaded (/usr/lib/systemd/system/connman-vpn.service;
>>> enabled; preset: enabled)
>>>    Active: active (running) since Sat 2025-01-25 12:12:02 CET; 6min =
ago
>>> Invocation: c3584a6570fc48deb60efbb589e55903
>>>  Main PID: 1176 (connman-vpnd)
>>>     Tasks: 1 (limit: 4915)
>>>    Memory: 1.1M (peak: 1.7M)
>>>       CPU: 24ms
>>>    CGroup: /system.slice/connman-vpn.service
>>>            =E2=94=94=E2=94=801176 /usr/bin/connman-vpnd -n
>>>=20
>>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {create} index 6
>>> type 65534 <NONE>
>>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags =
144 <DOWN>
>>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
>>> operstate 2 <DOWN>
>>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags
>>> 98513 <UP,RUNNING,LOWER_UP>
>>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
>>> operstate 0 <UNKNOWN>
>>> janv. 25 12:15:46 grat-os1 connman-vpnd[1176]: reresolve error limit =
reached
>>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {update} flags =
32912 <DOWN>
>>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
>>> operstate 2 <DOWN>
>>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {dellink} index 6
>>> operstate 2 <DOWN>
>>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {remove} index 6
>>>=20
>>> There was a question about a reverse patch for the iptable. Does I
>>> have missed it
>>>=20
>>> Best regards
>>>=20
>>> Daniel
>>>=20
>>>=20
>>> Le sam. 25 janv. 2025 =C3=A0 11:46, daniel antoine =
<univac55@gmail.com> a =C3=A9crit :
>>>>=20
>>>> Hi Jussi  Grant Christian and Gabiel
>>>>=20
>>>> I have installed first the Gabriel patch and tested but my vpn
>>>> connexion drops after 5 seconds and finally hangs the wifi =
connexion
>>>>=20
>>>> I have continued by installing the eleven and twelves jussi patches
>>>> but my compilation failed with the first patch 11-1
>>>>=20
>>>> =3D=3D=3D=3D=3D=3D=3D> name: connman
>>>> =3D=3D=3D=3D=3D=3D=3D> version: 1.43
>>>> =3D=3D=3D=3D=3D=3D=3D> release: 9
>>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: =
connman1737741659x86_64.cards.tar.xz already exist
>>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: =
connman.man1737741659any.cards.tar.xz already exist
>>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: =
connman.devel1737741659any.cards.tar.xz already exist
>>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: =
connman.sources1737741659any.cards.tar.xz already exist
>>>> =3D=3D=3D=3D=3D=3D=3D> Building starting...
>>>> cp allow_group_network.diff /tmp/work/src
>>>> cp vpn6.patch /tmp/work/src
>>>> cp vpn-11-1.patch /tmp/work/src
>>>> cp vpn-11-2.patch /tmp/work/src
>>>> cp vpn-11-3.patch /tmp/work/src
>>>> cp vpn-11-4.patch /tmp/work/src
>>>> cp vpn-11-5.patch /tmp/work/src
>>>> cp vpn-11-6.patch /tmp/work/src
>>>> cp vpn-11-7.patch /tmp/work/src
>>>> cp vpn-11-8.patch /tmp/work/src
>>>> cp vpn-11-9.patch /tmp/work/src
>>>> cp vpn-11-10.patch /tmp/work/src
>>>> cp vpn-11-11.patch /tmp/work/src
>>>> cp vpn-12-1.patch /tmp/work/src
>>>> cp vpn-12-2.patch /tmp/work/src
>>>> cp vpn-12-3.patch /tmp/work/src
>>>> cp vpn-12-4.patch /tmp/work/src
>>>> cp vpn-12-5.patch /tmp/work/src
>>>> cp vpn-12-6.patch /tmp/work/src
>>>> cp vpn-12-7.patch /tmp/work/src
>>>> cp vpn-12-8.patch /tmp/work/src
>>>> cp vpn-12-9.patch /tmp/work/src
>>>> cp vpn-12-10.patch /tmp/work/src
>>>> cp vpn-12-11.patch /tmp/work/src
>>>> cp vpn-12-12.patch /tmp/work/src
>>>> + prepare
>>>> + git clone =
https://git.kernel.org/pub/scm/network/connman/connman.git
>>>> connman-1.43
>>>> Cloning into 'connman-1.43'...
>>>> remote: Enumerating objects: 41151, done.
>>>> remote: Total 41151 (delta 0), reused 0 (delta 0), pack-reused =
41151
>>>> Receiving objects: 100% (41151/41151), 6.41 MiB | 1.64 MiB/s, done.
>>>> Resolving deltas: 100% (31525/31525), done.
>>>> + cd connman-1.43
>>>> + git checkout 263e151fcfb09134dcf17a4147355b0ee9a5eb66
>>>> Note: switching to '263e151fcfb09134dcf17a4147355b0ee9a5eb66'.
>>>>=20
>>>> You are in 'detached HEAD' state. You can look around, make =
experimental
>>>> changes and commit them, and you can discard any commits you make =
in this
>>>> state without impacting any branches by switching back to a branch.
>>>>=20
>>>> If you want to create a new branch to retain commits you create, =
you may
>>>> do so (now or later) by using -c with the switch command. Example:
>>>>=20
>>>> git switch -c <new-branch-name>
>>>>=20
>>>> Or undo this operation with:
>>>>=20
>>>> git switch -
>>>>=20
>>>> Turn off this advice by setting config variable advice.detachedHead =
to false
>>>>=20
>>>> HEAD is now at 263e151f treewide: Fix typo in ARPHRD_PHONET_PIPE
>>>> + patch -Np1 -i /tmp/work/src/allow_group_network.diff
>>>> patching file src/connman-polkit.conf
>>>> Hunk #1 succeeded at 7 with fuzz 2 (offset 2 lines).
>>>> + patch -Np1 -i /tmp/work/src/vpn6.patch
>>>> patching file src/gateway.c
>>>> + patch -Np1 -i /tmp/work/src/vpn-11-1.patch
>>>> patching file src/agent.c
>>>> Hunk #1 FAILED at 201.
>>>> 1 out of 1 hunk FAILED -- saving rejects to file src/agent.c.rej
>>>> =3D=3D=3D=3D=3D=3D=3D> ERROR: Building =
'connman.sources1737741659any.cards.tar.xz' failed.
>>>>=20
>>>> I have copy the patches from the e-mail , may be it introduce false
>>>> characters  or must i copy them from the dev list
>>>>=20
>>>> Best regards
>>>>=20
>>>> Daniel
>>>>=20
>>>>=20
>>>> Le ven. 24 janv. 2025 =C3=A0 20:03, Jussi Laakkonen
>>>> <jussi.laakkonen@jolla.com> a =C3=A9crit :
>>>>>=20
>>>>> Hi Christian,
>>>>>=20
>>>>> Actually, that commit is in upstream.
>>>>> =
https://git.kernel.org/pub/scm/network/connman/connman.git/log/vpn/plugins=
/wireguard.c
>>>>> - the date on the cherry-picked commits is the date of cherry =
picking (I
>>>>> guess I missed some option while doing this..) but the original =
commit
>>>>> is there submitted on 2020-07-31.
>>>>>=20
>>>>> I also pushed the association state and most of the wireguard =
fixes I've
>>>>> done to the mailing list. Have fun testing and tell me if it works
>>>>> better, we can always improve it if something is still missing. =
There
>>>>> are few commits I held back as they could be the next patch set, =
because
>>>>> support for IPv4 and IPv6 addresses, and the route adding fixes =
are also
>>>>> quite large changes.
>>>>>=20
>>>>> BR,
>>>>> - Jussi
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> On 1/23/25 13:35, Christian Hewitt wrote:
>>>>>> Looking here: =
https://git.kernel.org/pub/scm/network/connman/connman.git/log/ I=E2=80=99=
m not finding "wireguard: Regular reresolve endpoint address=E2=80=9D =
and the first page of log goes back to December =E2=80=9923. Are we =
using the wrong upstream?
>>>>>>=20
>>>>>> Christian
>>>>>>=20
>>>>>>> On 23 Jan 2025, at 3:22=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>>>>>>=20
>>>>>>> Hi Christian,
>>>>>>>=20
>>>>>>> That is actually in upstream, all the commits regarding =
WireGuard before July 10, 2024 are taken from the latest upstream and =
the changes after that are new features.
>>>>>>>=20
>>>>>>> Well, the vpn.c changes do depend on having the ASSOCIATION =
state also for VPNs to be implemented, that was proposed in the RFC =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97 as the state =
transitions depend on that bit. But it does not seem to be depending on =
the gateway.c/connection.c. Well, I can try to squeeze time to address =
the issues Daniel earlier raised on that RFC and push them to upstream, =
then make a big change on the vpn.c and wireguard.c.
>>>>>>>=20
>>>>>>> Br,
>>>>>>> Jussi
>>>>>>>=20
>>>>>>>=20
>>>>>>> On 1/23/25 13:12, Christian Hewitt wrote:
>>>>>>>> You don't often get email from christianshewitt@gmail.com. =
Learn why this is =
important<https://aka.ms/LearnAboutSenderIdentification>
>>>>>>>> Ohh.. I would be VERY keen to see support for FQDN=E2=80=99s =
resolving to dynamic IP=E2=80=99s upstreamed so this looks interesting:
>>>>>>>> =
https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d703f972=
b866fdbd8bd
>>>>>>>> Is that feature dependent on any other changes? (being lazy.. I =
didn=E2=80=99t read all the commits in that branch yet!).
>>>>>>>> Christian
>>>>>>>> On 23 Jan 2025, at 3:06=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>>>>>>> Hello,
>>>>>>>> Regarding WireGuard, I had to make a bunch of changes to the =
latest version of it to get it running properly on our fork (yes, we =
upgrade it slowly, now 1.38): =
https://github.com/sailfishos/connman/commits/master/connman/vpn
>>>>>>>> But I haven't had time to figure out all that is needed for =
upstream to be sent first, like this RFC edit that was forgotten because =
of... "eastern winds blowing into our direction": =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97
>>>>>>>> And then the connection.c was modified a lot (and renamed) and =
I'm not sure if these will work on top of that anymore. Mostly because =
we have features that may not have been compatible with latest upstream, =
like adding a support  for two different devices to be belonging into =
one service to facilitate CLAT support =
https://github.com/sailfishos/connman/commits/master/connman/src/connectio=
n.c etc. etc. etc.
>>>>>>>> At some point I'll start pushing changes but not sure when I =
have time. Mostly they could be RFCs as the changes are big.
>>>>>>>> BR,
>>>>>>>> Jussi
>>>>>>>> On 1/23/25 12:45, daniel antoine wrote:
>>>>>>>> Hi
>>>>>>>> I have opened a ticket for connman-vpn not working with =
wireguard  in
>>>>>>>> April 2024. If you give me the patches I can test them
>>>>>>>> Best regards
>>>>>>>> Daniel
>>>>>>>> Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
>>>>>>>> <gerickson@nuovations.com> a =C3=A9crit :
>>>>>>>> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches =
<gabriel.sanches@prevas.dk> wrote:
>>>>>>>> I was testing connman's wireguard plugin and got a segmentation =
fault.
>>>>>>>> Looking at the backtrace revealed that there are some typos in =
the `src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 =
variables instead of ipv6 regarding vpn.
>>>>>>>> I simply changed them to ipv6 and got it working.
>>>>>>>> not related to the patch:
>>>>>>>> I had to manually add ip route so the other devices could be =
pinged
>>>>>>>> The plugin adds routes for the WireGuard.DNS configuration =
setting
>>>>>>>> # ip route
>>>>>>>> 1.1.1.1 dev wg0 scope link
>>>>>>>> 8.8.8.8 dev wg0 scope link
>>>>>>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
>>>>>>>> 10.42.0.1 dev end1 scope link
>>>>>>>> <vpn host ip> via 10.42.0.1 dev end1
>>>>>>>> the missing route added manually:
>>>>>>>> ip route add 10.33.0.0/16 dev wg0 scope link
>>>>>>>> an equivalent wireguard file adds it properly (using wg-quick)
>>>>>>>> Is the plugin lacking some implementation?
>>>>>>>> ---
>>>>>>>> src/gateway.c | 6 +++---
>>>>>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>>> diff --git a/src/gateway.c b/src/gateway.c
>>>>>>>> index 16c87f83..b2c211e2 100644
>>>>>>>> --- a/src/gateway.c
>>>>>>>> +++ b/src/gateway.c
>>>>>>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct =
connman_service *service,
>>>>>>>>                                      is_gateway_config_vpn(
>>>>>>>>                                              =
new_gateway->ipv4_config);
>>>>>>>> -             is_vpn6 =3D do_ipv4 &&
>>>>>>>> -                                     new_gateway->ipv4_config =
&&
>>>>>>>> +             is_vpn6 =3D do_ipv6 &&
>>>>>>>> +                                     new_gateway->ipv6_config =
&&
>>>>>>>>                                      is_gateway_config_vpn(
>>>>>>>> -                                             =
new_gateway->ipv4_config);
>>>>>>>> +                                             =
new_gateway->ipv6_config);
>>>>>>>>      } else {
>>>>>>>>              if (do_ipv4 && new_gateway->ipv4_config)
>>>>>>>> --
>>>>>>>> 2.43.0
>>>>>>>> Gabriel,
>>>>>>>> Great catch on this copy-and-paste typo; thank you!
>>>>>>>> Best,
>>>>>>>> Grant
>>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>>=20
>>=20

