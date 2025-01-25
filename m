Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F001D9A54
	for <connman@lists.linux.dev>; Sat, 25 Jan 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737810756; cv=none; b=sm6Zt2CDk7NVqNO0f79ZcR9Il6vQBVOcg5iAYt98OvvzGQpZ6zdDZUS8aJN1M3XcFhCXfY4MwlHHsmhnEmQJaYZMwRwjwPVMc6LVCySOjHje7pn033vOgcUT2FpAvWUe2LUfnZuWpE1i8vVAfcva6mEG+B8Qc1+k7+1ymSnft4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737810756; c=relaxed/simple;
	bh=SN0WY2WiaC4+RMkY81yaXBSGMsokMdEyGkDfA7Ja5Cs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uurK33V+W7L4Kjv0co6wV5FUyFRkp3GDxcze62VFpNgYPYhoTeYDs1OQSeZUU7h8akjtFy/5p9Ld57YkaU885+wIC6EkZkBLLieWDpbyfriFtbLbSEICA8NnCVgs2zFa/27WK9z7m3NKB4o5dzeYejDH2NOLE8tThXRUja6pu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X25DCCMk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X25DCCMk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436341f575fso32083125e9.1
        for <connman@lists.linux.dev>; Sat, 25 Jan 2025 05:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737810752; x=1738415552; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFBvtv7ttcb9ijxq4i6d9rsFqLPFLcnRMezoeXCESzc=;
        b=X25DCCMkTwOSTftrnRRNOEZfjxC2XCNgYZsTybGv84ocexV+g4Q1mAi3JYpDRdBkHo
         2eQpGaC+9+uCfmHkb8kp6A1IPv1brUAeIft8irmnQPZHtB1WKqXTZ2nfIx0fMUX25QLg
         XxlsyWCBOBdpjUVIk2hhkFUkQ/XpvXLIF6zlBv+a7+N110KFMvDhmtR3CEZ9TZgs/6bH
         jLwL3l85aWEig8yojiXsNheCX8sLC8WkoX+8e8ml2TEltJmJKQvxzf6seg0rRziLJIkC
         149vxB0w+la0pyrhh11cPlC7H5VO5MDQefSrOhT+Io0TlL9vbcKoTh3Z3OUrKjk5YXOb
         z4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737810752; x=1738415552;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFBvtv7ttcb9ijxq4i6d9rsFqLPFLcnRMezoeXCESzc=;
        b=W848W62CjHAtSQzoo0C9jPtw+Qgc97QRTH3HdyeC2kB6qgyOSukGgY+VAN4FnIObco
         BAZ7KWoXIiWtPCBi4pgI/b6uWdO2n0TF42LwkIK5ZTWsxEUtkvlc+jMNZ7F5sfVPaESA
         v4TMVa/yiu+OXteoV5XBEbTHP5tET991eO1NBbVOt7cDnqN+GqkTk6625tB11FIoZnMR
         rCi3OEin+xjpLNZQFtkuQlUMUCoqAdA4V+pg8ig8/PG98xnYeEoZwUK2h3mQ8M/9IlvB
         etbWW4WMOduDEk4dWuyHwt9J3mHIQeXDNE/idFX/zcV4ZNz8b36juhsckVnb53SUV4G7
         MImQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlqbQSF+X5EXPkWLGgzGT/224CvQyEc30FW6IVNbrTYM+upg3eu6rKpBkFPpmZnt8Xx37f8f90@lists.linux.dev
X-Gm-Message-State: AOJu0YxAxyNrEFNhEsrJtALGcANSipFCPNs7rAVEh1bFgTb8EHX8cSA5
	nijmy5vqzmLoW5HXZRciWMp57ZL9KUp1OZ174+Sz+EelIybuvtHd
X-Gm-Gg: ASbGncuN5pW5+t8+2BeANfv7RQ02C9y+xjhPIjA/vxuXhcD3TdVGgQdZdzWmTdNB1xj
	CH9+c1+n5Ztefl6//L4yiCJMh3Ozx3qf82mURbymLyzQ1TSnTi/2Lcu6idengjV8pQLfh3E8wjL
	+r+HQ85BpkDlkCCnQWWbbxuQ8z4h+Je0eeNecpTf6hOMoEJU7idh8LW7HJrID6O+PInzP1Ps2jj
	S+f2AV9Nx4LArt77tbQdRqJqdmkaNqr1KqqHLPuBKyVW4EncGmOgIQyMQwZWoQIVLerlAw43eOl
	yv0Fj5tGWWYvmu0sajyOIuFEVg0=
X-Google-Smtp-Source: AGHT+IF3WMrP5pdXR+Y3COLJ30EsyCWxeWj0ZVORLdDyJnuDHJfnJZET4oPUHKbPeZTzjlonVhLrVA==
X-Received: by 2002:a05:600c:4ed4:b0:434:f586:7520 with SMTP id 5b1f17b1804b1-438913c5d53mr316594155e9.6.1737810751751;
        Sat, 25 Jan 2025 05:12:31 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd48a906sm62172675e9.18.2025.01.25.05.12.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2025 05:12:31 -0800 (PST)
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
In-Reply-To: <CA+iibzC3xjeN2=SyLU3yhhOEKvPysSbr+obGKKo8G8noCRSOKQ@mail.gmail.com>
Date: Sat, 25 Jan 2025 17:12:17 +0400
Cc: Jussi Laakkonen <jussi.laakkonen@jolla.com>,
 Grant Erickson <gerickson@nuovations.com>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>,
 Gabriel Sanches <gabriel.sanches@prevas.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFEF67A5-8CCE-457B-A5F1-AEF6552F712F@gmail.com>
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
To: daniel antoine <univac55@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)

I=E2=80=99ve picked patches into =
https://github.com/chewitt/connman/commits/wireguard

This is connman HEAD + Gabriel's is_vpn6 patch + my revert patch (to fix =
routing)
+ the two series that Jussi posted to the list yesterday.

For me this is working fine with no wireguard issues observed since this =
morning
when I=E2=80=99ve rebuilt a LibreELEC image using that branch. I plan to =
use it myself
for a couple of days, then if all good I=E2=80=99ll push changes into =
LibreELEC nightly
images for a while to get some wider testing done.

Christian


> On 25 Jan 2025, at 3:23=E2=80=AFpm, daniel antoine =
<univac55@gmail.com> wrote:
>=20
> I have copy the patches from the dev list and they have all passed ;
> The vpn connection continue to drop with in the journalctl
>=20
> janv. 25 12:12:01 grat-os1 connman-vpnd[1176]: wlan0 {newlink} index
> 5 operstate 6 <UP>
> janv. 25 12:13:03 grat-os1 connman-vpnd[1176]: Adding configuration =
vpndania
> janv. 25 12:13:03 grat-os1 connman-vpnd[1176]: Added provider
> configuration wireguard
> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {create} index 6
> type 65534 <NONE>
> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags 144 =
<DOWN>
> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> operstate 2 <DOWN>
> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags
> 98513 <UP,RUNNING,LOWER_UP>
> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> operstate 0 <UNKNOWN>
> janv. 25 12:15:46 grat-os1 connman-vpnd[1176]: reresolve error limit =
reached
> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {update} flags =
32912 <DOWN>
> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> operstate 2 <DOWN>
> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {dellink} index 6
> operstate 2 <DOWN>
> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {remove} index 6
>=20
> and
>=20
> =E2=97=8F connman-vpn.service - ConnMan VPN service
>     Loaded: loaded (/usr/lib/systemd/system/connman-vpn.service;
> enabled; preset: enabled)
>     Active: active (running) since Sat 2025-01-25 12:12:02 CET; 6min =
ago
> Invocation: c3584a6570fc48deb60efbb589e55903
>   Main PID: 1176 (connman-vpnd)
>      Tasks: 1 (limit: 4915)
>     Memory: 1.1M (peak: 1.7M)
>        CPU: 24ms
>     CGroup: /system.slice/connman-vpn.service
>             =E2=94=94=E2=94=801176 /usr/bin/connman-vpnd -n
>=20
> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {create} index 6
> type 65534 <NONE>
> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags 144 =
<DOWN>
> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> operstate 2 <DOWN>
> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags
> 98513 <UP,RUNNING,LOWER_UP>
> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> operstate 0 <UNKNOWN>
> janv. 25 12:15:46 grat-os1 connman-vpnd[1176]: reresolve error limit =
reached
> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {update} flags =
32912 <DOWN>
> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> operstate 2 <DOWN>
> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {dellink} index 6
> operstate 2 <DOWN>
> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {remove} index 6
>=20
> There was a question about a reverse patch for the iptable. Does I
> have missed it
>=20
> Best regards
>=20
> Daniel
>=20
>=20
> Le sam. 25 janv. 2025 =C3=A0 11:46, daniel antoine =
<univac55@gmail.com> a =C3=A9crit :
>>=20
>> Hi Jussi  Grant Christian and Gabiel
>>=20
>> I have installed first the Gabriel patch and tested but my vpn
>> connexion drops after 5 seconds and finally hangs the wifi connexion
>>=20
>> I have continued by installing the eleven and twelves jussi patches
>> but my compilation failed with the first patch 11-1
>>=20
>> =3D=3D=3D=3D=3D=3D=3D> name: connman
>> =3D=3D=3D=3D=3D=3D=3D> version: 1.43
>> =3D=3D=3D=3D=3D=3D=3D> release: 9
>> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman1737741659x86_64.cards.tar.xz =
already exist
>> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman.man1737741659any.cards.tar.xz =
already exist
>> =3D=3D=3D=3D=3D=3D=3D> WARNING: =
connman.devel1737741659any.cards.tar.xz already exist
>> =3D=3D=3D=3D=3D=3D=3D> WARNING: =
connman.sources1737741659any.cards.tar.xz already exist
>> =3D=3D=3D=3D=3D=3D=3D> Building starting...
>> cp allow_group_network.diff /tmp/work/src
>> cp vpn6.patch /tmp/work/src
>> cp vpn-11-1.patch /tmp/work/src
>> cp vpn-11-2.patch /tmp/work/src
>> cp vpn-11-3.patch /tmp/work/src
>> cp vpn-11-4.patch /tmp/work/src
>> cp vpn-11-5.patch /tmp/work/src
>> cp vpn-11-6.patch /tmp/work/src
>> cp vpn-11-7.patch /tmp/work/src
>> cp vpn-11-8.patch /tmp/work/src
>> cp vpn-11-9.patch /tmp/work/src
>> cp vpn-11-10.patch /tmp/work/src
>> cp vpn-11-11.patch /tmp/work/src
>> cp vpn-12-1.patch /tmp/work/src
>> cp vpn-12-2.patch /tmp/work/src
>> cp vpn-12-3.patch /tmp/work/src
>> cp vpn-12-4.patch /tmp/work/src
>> cp vpn-12-5.patch /tmp/work/src
>> cp vpn-12-6.patch /tmp/work/src
>> cp vpn-12-7.patch /tmp/work/src
>> cp vpn-12-8.patch /tmp/work/src
>> cp vpn-12-9.patch /tmp/work/src
>> cp vpn-12-10.patch /tmp/work/src
>> cp vpn-12-11.patch /tmp/work/src
>> cp vpn-12-12.patch /tmp/work/src
>> + prepare
>> + git clone =
https://git.kernel.org/pub/scm/network/connman/connman.git
>> connman-1.43
>> Cloning into 'connman-1.43'...
>> remote: Enumerating objects: 41151, done.
>> remote: Total 41151 (delta 0), reused 0 (delta 0), pack-reused 41151
>> Receiving objects: 100% (41151/41151), 6.41 MiB | 1.64 MiB/s, done.
>> Resolving deltas: 100% (31525/31525), done.
>> + cd connman-1.43
>> + git checkout 263e151fcfb09134dcf17a4147355b0ee9a5eb66
>> Note: switching to '263e151fcfb09134dcf17a4147355b0ee9a5eb66'.
>>=20
>> You are in 'detached HEAD' state. You can look around, make =
experimental
>> changes and commit them, and you can discard any commits you make in =
this
>> state without impacting any branches by switching back to a branch.
>>=20
>> If you want to create a new branch to retain commits you create, you =
may
>> do so (now or later) by using -c with the switch command. Example:
>>=20
>>  git switch -c <new-branch-name>
>>=20
>> Or undo this operation with:
>>=20
>>  git switch -
>>=20
>> Turn off this advice by setting config variable advice.detachedHead =
to false
>>=20
>> HEAD is now at 263e151f treewide: Fix typo in ARPHRD_PHONET_PIPE
>> + patch -Np1 -i /tmp/work/src/allow_group_network.diff
>> patching file src/connman-polkit.conf
>> Hunk #1 succeeded at 7 with fuzz 2 (offset 2 lines).
>> + patch -Np1 -i /tmp/work/src/vpn6.patch
>> patching file src/gateway.c
>> + patch -Np1 -i /tmp/work/src/vpn-11-1.patch
>> patching file src/agent.c
>> Hunk #1 FAILED at 201.
>> 1 out of 1 hunk FAILED -- saving rejects to file src/agent.c.rej
>> =3D=3D=3D=3D=3D=3D=3D> ERROR: Building =
'connman.sources1737741659any.cards.tar.xz' failed.
>>=20
>> I have copy the patches from the e-mail , may be it introduce false
>> characters  or must i copy them from the dev list
>>=20
>> Best regards
>>=20
>> Daniel
>>=20
>>=20
>> Le ven. 24 janv. 2025 =C3=A0 20:03, Jussi Laakkonen
>> <jussi.laakkonen@jolla.com> a =C3=A9crit :
>>>=20
>>> Hi Christian,
>>>=20
>>> Actually, that commit is in upstream.
>>> =
https://git.kernel.org/pub/scm/network/connman/connman.git/log/vpn/plugins=
/wireguard.c
>>> - the date on the cherry-picked commits is the date of cherry =
picking (I
>>> guess I missed some option while doing this..) but the original =
commit
>>> is there submitted on 2020-07-31.
>>>=20
>>> I also pushed the association state and most of the wireguard fixes =
I've
>>> done to the mailing list. Have fun testing and tell me if it works
>>> better, we can always improve it if something is still missing. =
There
>>> are few commits I held back as they could be the next patch set, =
because
>>> support for IPv4 and IPv6 addresses, and the route adding fixes are =
also
>>> quite large changes.
>>>=20
>>> BR,
>>>  - Jussi
>>>=20
>>>=20
>>>=20
>>> On 1/23/25 13:35, Christian Hewitt wrote:
>>>> Looking here: =
https://git.kernel.org/pub/scm/network/connman/connman.git/log/ I=E2=80=99=
m not finding "wireguard: Regular reresolve endpoint address=E2=80=9D =
and the first page of log goes back to December =E2=80=9923. Are we =
using the wrong upstream?
>>>>=20
>>>> Christian
>>>>=20
>>>>> On 23 Jan 2025, at 3:22=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>>>>=20
>>>>> Hi Christian,
>>>>>=20
>>>>> That is actually in upstream, all the commits regarding WireGuard =
before July 10, 2024 are taken from the latest upstream and the changes =
after that are new features.
>>>>>=20
>>>>> Well, the vpn.c changes do depend on having the ASSOCIATION state =
also for VPNs to be implemented, that was proposed in the RFC =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97 as the state =
transitions depend on that bit. But it does not seem to be depending on =
the gateway.c/connection.c. Well, I can try to squeeze time to address =
the issues Daniel earlier raised on that RFC and push them to upstream, =
then make a big change on the vpn.c and wireguard.c.
>>>>>=20
>>>>> Br,
>>>>> Jussi
>>>>>=20
>>>>>=20
>>>>> On 1/23/25 13:12, Christian Hewitt wrote:
>>>>>> You don't often get email from christianshewitt@gmail.com. Learn =
why this is important<https://aka.ms/LearnAboutSenderIdentification>
>>>>>> Ohh.. I would be VERY keen to see support for FQDN=E2=80=99s =
resolving to dynamic IP=E2=80=99s upstreamed so this looks interesting:
>>>>>> =
https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d703f972=
b866fdbd8bd
>>>>>> Is that feature dependent on any other changes? (being lazy.. I =
didn=E2=80=99t read all the commits in that branch yet!).
>>>>>> Christian
>>>>>> On 23 Jan 2025, at 3:06=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>>>>> Hello,
>>>>>> Regarding WireGuard, I had to make a bunch of changes to the =
latest version of it to get it running properly on our fork (yes, we =
upgrade it slowly, now 1.38): =
https://github.com/sailfishos/connman/commits/master/connman/vpn
>>>>>> But I haven't had time to figure out all that is needed for =
upstream to be sent first, like this RFC edit that was forgotten because =
of... "eastern winds blowing into our direction": =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97
>>>>>> And then the connection.c was modified a lot (and renamed) and =
I'm not sure if these will work on top of that anymore. Mostly because =
we have features that may not have been compatible with latest upstream, =
like adding a support  for two different devices to be belonging into =
one service to facilitate CLAT support =
https://github.com/sailfishos/connman/commits/master/connman/src/connectio=
n.c etc. etc. etc.
>>>>>> At some point I'll start pushing changes but not sure when I have =
time. Mostly they could be RFCs as the changes are big.
>>>>>> BR,
>>>>>> Jussi
>>>>>> On 1/23/25 12:45, daniel antoine wrote:
>>>>>> Hi
>>>>>> I have opened a ticket for connman-vpn not working with wireguard =
 in
>>>>>> April 2024. If you give me the patches I can test them
>>>>>> Best regards
>>>>>> Daniel
>>>>>> Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
>>>>>> <gerickson@nuovations.com> a =C3=A9crit :
>>>>>> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches =
<gabriel.sanches@prevas.dk> wrote:
>>>>>> I was testing connman's wireguard plugin and got a segmentation =
fault.
>>>>>> Looking at the backtrace revealed that there are some typos in =
the `src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 =
variables instead of ipv6 regarding vpn.
>>>>>> I simply changed them to ipv6 and got it working.
>>>>>> not related to the patch:
>>>>>> I had to manually add ip route so the other devices could be =
pinged
>>>>>> The plugin adds routes for the WireGuard.DNS configuration =
setting
>>>>>> # ip route
>>>>>> 1.1.1.1 dev wg0 scope link
>>>>>> 8.8.8.8 dev wg0 scope link
>>>>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
>>>>>> 10.42.0.1 dev end1 scope link
>>>>>> <vpn host ip> via 10.42.0.1 dev end1
>>>>>> the missing route added manually:
>>>>>> ip route add 10.33.0.0/16 dev wg0 scope link
>>>>>> an equivalent wireguard file adds it properly (using wg-quick)
>>>>>> Is the plugin lacking some implementation?
>>>>>> ---
>>>>>> src/gateway.c | 6 +++---
>>>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>> diff --git a/src/gateway.c b/src/gateway.c
>>>>>> index 16c87f83..b2c211e2 100644
>>>>>> --- a/src/gateway.c
>>>>>> +++ b/src/gateway.c
>>>>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct =
connman_service *service,
>>>>>>                                       is_gateway_config_vpn(
>>>>>>                                               =
new_gateway->ipv4_config);
>>>>>> -             is_vpn6 =3D do_ipv4 &&
>>>>>> -                                     new_gateway->ipv4_config &&
>>>>>> +             is_vpn6 =3D do_ipv6 &&
>>>>>> +                                     new_gateway->ipv6_config &&
>>>>>>                                       is_gateway_config_vpn(
>>>>>> -                                             =
new_gateway->ipv4_config);
>>>>>> +                                             =
new_gateway->ipv6_config);
>>>>>>       } else {
>>>>>>               if (do_ipv4 && new_gateway->ipv4_config)
>>>>>> --
>>>>>> 2.43.0
>>>>>> Gabriel,
>>>>>> Great catch on this copy-and-paste typo; thank you!
>>>>>> Best,
>>>>>> Grant
>>>>>=20
>>>>=20
>>>=20
>>>=20

