Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6E625777
	for <connman@lists.linux.dev>; Sat, 25 Jan 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737819878; cv=none; b=EHi2HD4eksGzOanIoYCqNeSJJ4rmuKlU3+bNi+ySteSJGOwvWBA0Y0+BLv9rq9UW4l8r83LkqMdmzKOMl/Ikp7u7thAo89yqCMKOU5kpuO0QM++WEv3+ewYtLefQtoXxM/W60s6sRFGQU3Cd6W/fQkzxRNE+J3SpDyk9j34cSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737819878; c=relaxed/simple;
	bh=qCmXzu8Ba9TcUux4EkWoFSZmH5bqKFcXFatr3ZsVBCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7hZNLmbFLTwTkW/AAmq9z0+g/7ZyS9iKTmsyZE0BJm/gxFjaUDgWRhS/Gbwq3MHuF8n0NHA7Kv4OHGgifXXORVRGMnFeBz9q49OwQxxWrxT+8DAJTQgeI0NZrkkzCpNVG1pzKYrr5aOUVJHRxZaFMfVjzkAo4KSUwycZ4p4EXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTuFie1h; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTuFie1h"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51c8460328dso855570e0c.3
        for <connman@lists.linux.dev>; Sat, 25 Jan 2025 07:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737819874; x=1738424674; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=094NDDYW7s079MiETnGRhl1M5e6h5OZJK7VkABv0xwI=;
        b=JTuFie1hWlOB2k7q3aUau4vhSJyN4fwnxSTJHhou3jyvqc3cwMLin3kFDqmEkRic6J
         aOqAeyTNl20xLcraW4v5bYghZ13EEOU9l/AX2nMvS9cqYSUqZGxS3BmkVfmb847/gwEw
         trhvwRV5ODcX6ItaRQuFG4nMzifpNqwjQVpZlWJTi9q9/Iiu1PduqvkezCgBEtZFuiS4
         tGzOBshIipdLozhDQpZPfma3XsCM/ekYL+hCjTRnVz/Xdrzj3+QWJzFalyOBI7Vtagir
         jQnbaOJN4SwQVojxiwMQMZvYY0Fh70leIEuBnlsS1lGTFCFHmlT58KpljbkQGEI2KNfP
         569g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737819874; x=1738424674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=094NDDYW7s079MiETnGRhl1M5e6h5OZJK7VkABv0xwI=;
        b=kPttE3CGibbDNx3XWy2eu701r5fUQrvojkbtJxlaNeCnmZ3xW/Kkmg8LmN6Xpy/TOO
         KZGiMrhhRxwgyhREUAd5spkZ7wN8nmdeCtt4mluaZrqekb+9PRrfh4h6zaFeFrbt7oVc
         HN+UBRScyHPhAYD0E6RHl0d2amx5/ZOUfUQtRKcojoUr0IcXfo013vGjyUkIt5ybeVt5
         4RYwdkgtFdQYtuQq9PPwVrrevhNSjhiuwNbfsp9jg73E8vgUD99meZ0KuV3lLVV+lcWN
         0FlI0G0ENIbD56dHljlFXtvvaTZVmmVDtZqWHGN0Aeov7VmZEjlGbsiwZo8Ok6lgJlxL
         70tw==
X-Forwarded-Encrypted: i=1; AJvYcCX30lWVs82B6wbs9I+NCXKG41j9P0JqjjtJ7vEhXe28yhaFRo9CDJXNh8otHf0qUJMQ6nRNlgXj@lists.linux.dev
X-Gm-Message-State: AOJu0YxrWfYMycFbf2L+to7MrN45sTHWezQcBNQQVVccgc1asxshaPKJ
	wiRPlRpWNVIh+IRp3RQrn1mKWduqBYxGgg027lAPgDb3QeoD5pbzLJepqIAToqjFG3zVvQK/X+9
	9aZZMJji7i6ejn49CPhSiS6KuQoo=
X-Gm-Gg: ASbGncvqxcZ274d31ScOFz5moDHXxUlcTV/6t5ZS5jS6Bd79SOatZHeXJiEAulXAZ3y
	otXaii3EytgNmYLLAkiHDtL6UNrrAj1xFMOnUiy1cR6kUnsyYzLiCGA8zKd5duUWHbgWJUIpmDq
	9hduCmVq8t26RaCOc6wY4=
X-Google-Smtp-Source: AGHT+IEUj3BcWiB7dWN93WEvczNqERN2XqT98r0qDlULfTEPrSvMcqJ+E0O1d3PwdS2V0RCfvyEh22tMceJxOBnfFcM=
X-Received: by 2002:a05:6122:8286:b0:518:778b:70a1 with SMTP id
 71dfb90a1353d-51d5b2f094dmr29650780e0c.7.1737819873543; Sat, 25 Jan 2025
 07:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com> <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
 <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com> <DA3FEE9B-62E5-4A2E-920F-ADFAE67CDB9A@gmail.com>
 <151b7546-a12c-4383-96e7-a6099a7a298f@jolla.com> <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
 <bb952186-9493-4efc-8256-deaa63c7385f@jolla.com> <CA+iibzBrT7mcgK8ZnsxdYuMqF5E+57z-kCZ-G0PLsWaezkdT4Q@mail.gmail.com>
 <CA+iibzC3xjeN2=SyLU3yhhOEKvPysSbr+obGKKo8G8noCRSOKQ@mail.gmail.com>
 <EFEF67A5-8CCE-457B-A5F1-AEF6552F712F@gmail.com> <CA+iibzD3ctMW7chEiPfis9JKuTJqQxOb2uaC48BM3TRZkm1MqA@mail.gmail.com>
 <B003F09E-E90B-45BD-8E40-EF11D13789C2@gmail.com>
In-Reply-To: <B003F09E-E90B-45BD-8E40-EF11D13789C2@gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Sat, 25 Jan 2025 16:44:22 +0100
X-Gm-Features: AWEUYZnkBRHTgh8G-hFjcy-YHZp0RcDPBc7sk51oE4RnxptNgC4rHqpRkfAgARc
Message-ID: <CA+iibzBoXcrruA8Axk7XZFpqdy0985wMX_658yJ6Lo_X-BkmKw@mail.gmail.com>
Subject: Re: [PATCH] gateway: Fix typo when setting 'is_vpn6'
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Jussi Laakkonen <jussi.laakkonen@jolla.com>, Grant Erickson <gerickson@nuovations.com>, 
	"connman@lists.linux.dev" <connman@lists.linux.dev>, Gabriel Sanches <gabriel.sanches@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi
Thanks a lot
Best regards
Daniel

Le sam. 25 janv. 2025 =C3=A0 16:22, Christian Hewitt
<christianshewitt@gmail.com> a =C3=A9crit :
>
> In the connman config "Host=E2=80=9D must be an IP address not an FQDN.
>
> Christian
>
> > On 25 Jan 2025, at 7:12=E2=80=AFpm, daniel antoine <univac55@gmail.com>=
 wrote:
> >
> > Hi
> > with wg-quik I can connect the vpn and ping the endpoint 10.0.7.2
> > the config file in /etc/wireguard (I have modify it for the e-mail) is
> >
> > [Interface]
> > Address =3D 10.0.7.5/24
> > PrivateKey =3D yyyyy
> >
> > [Peer]
> > Endpoint =3D monsite.fr:51820
> > PublicKey =3D xxxxx
> > AllowedIPs =3D 10.0.7.0/24
> > PersistentKeepalive =3D 25
> >
> > The config file for connman-vpn in /var/lib/connman-vpn
> >
> > [provider_wireguard]
> > Type =3D WireGuard
> > Name =3D chezlui
> > Host =3D monsite.fr
> > WireGuard.Address =3D 10.0.7.5/24
> > WireGuard.PrivateKey =3D yyyyyy
> > WireGuard.PublicKey =3D xxxxx
> > WireGuard.AllowedIPs =3D 10.0.7.0/24
> > WireGuard.EndpointPort =3D 51820
> > WireGuard.PersistentKeepalive =3D 25
> >
> > Is there something wrong with it? It cause the wifi connexion to drop
> > when I connect the vpn
> >
> > Best regards
> >
> > Daniel
> >
> > Le sam. 25 janv. 2025 =C3=A0 14:12, Christian Hewitt
> > <christianshewitt@gmail.com> a =C3=A9crit :
> >>
> >> I=E2=80=99ve picked patches into https://github.com/chewitt/connman/co=
mmits/wireguard
> >>
> >> This is connman HEAD + Gabriel's is_vpn6 patch + my revert patch (to f=
ix routing)
> >> + the two series that Jussi posted to the list yesterday.
> >>
> >> For me this is working fine with no wireguard issues observed since th=
is morning
> >> when I=E2=80=99ve rebuilt a LibreELEC image using that branch. I plan =
to use it myself
> >> for a couple of days, then if all good I=E2=80=99ll push changes into =
LibreELEC nightly
> >> images for a while to get some wider testing done.
> >>
> >> Christian
> >>
> >>
> >>> On 25 Jan 2025, at 3:23=E2=80=AFpm, daniel antoine <univac55@gmail.co=
m> wrote:
> >>>
> >>> I have copy the patches from the dev list and they have all passed ;
> >>> The vpn connection continue to drop with in the journalctl
> >>>
> >>> janv. 25 12:12:01 grat-os1 connman-vpnd[1176]: wlan0 {newlink} index
> >>> 5 operstate 6 <UP>
> >>> janv. 25 12:13:03 grat-os1 connman-vpnd[1176]: Adding configuration v=
pndania
> >>> janv. 25 12:13:03 grat-os1 connman-vpnd[1176]: Added provider
> >>> configuration wireguard
> >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {create} index 6
> >>> type 65534 <NONE>
> >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags 144=
 <DOWN>
> >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> >>> operstate 2 <DOWN>
> >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags
> >>> 98513 <UP,RUNNING,LOWER_UP>
> >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> >>> operstate 0 <UNKNOWN>
> >>> janv. 25 12:15:46 grat-os1 connman-vpnd[1176]: reresolve error limit =
reached
> >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {update} flags 329=
12 <DOWN>
> >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> >>> operstate 2 <DOWN>
> >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {dellink} index 6
> >>> operstate 2 <DOWN>
> >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {remove} index 6
> >>>
> >>> and
> >>>
> >>> =E2=97=8F connman-vpn.service - ConnMan VPN service
> >>>    Loaded: loaded (/usr/lib/systemd/system/connman-vpn.service;
> >>> enabled; preset: enabled)
> >>>    Active: active (running) since Sat 2025-01-25 12:12:02 CET; 6min a=
go
> >>> Invocation: c3584a6570fc48deb60efbb589e55903
> >>>  Main PID: 1176 (connman-vpnd)
> >>>     Tasks: 1 (limit: 4915)
> >>>    Memory: 1.1M (peak: 1.7M)
> >>>       CPU: 24ms
> >>>    CGroup: /system.slice/connman-vpn.service
> >>>            =E2=94=94=E2=94=801176 /usr/bin/connman-vpnd -n
> >>>
> >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {create} index 6
> >>> type 65534 <NONE>
> >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags 144=
 <DOWN>
> >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> >>> operstate 2 <DOWN>
> >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags
> >>> 98513 <UP,RUNNING,LOWER_UP>
> >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> >>> operstate 0 <UNKNOWN>
> >>> janv. 25 12:15:46 grat-os1 connman-vpnd[1176]: reresolve error limit =
reached
> >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {update} flags 329=
12 <DOWN>
> >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {newlink} index 6
> >>> operstate 2 <DOWN>
> >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {dellink} index 6
> >>> operstate 2 <DOWN>
> >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {remove} index 6
> >>>
> >>> There was a question about a reverse patch for the iptable. Does I
> >>> have missed it
> >>>
> >>> Best regards
> >>>
> >>> Daniel
> >>>
> >>>
> >>> Le sam. 25 janv. 2025 =C3=A0 11:46, daniel antoine <univac55@gmail.co=
m> a =C3=A9crit :
> >>>>
> >>>> Hi Jussi  Grant Christian and Gabiel
> >>>>
> >>>> I have installed first the Gabriel patch and tested but my vpn
> >>>> connexion drops after 5 seconds and finally hangs the wifi connexion
> >>>>
> >>>> I have continued by installing the eleven and twelves jussi patches
> >>>> but my compilation failed with the first patch 11-1
> >>>>
> >>>> =3D=3D=3D=3D=3D=3D=3D> name: connman
> >>>> =3D=3D=3D=3D=3D=3D=3D> version: 1.43
> >>>> =3D=3D=3D=3D=3D=3D=3D> release: 9
> >>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman1737741659x86_64.cards.tar.xz=
 already exist
> >>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman.man1737741659any.cards.tar.x=
z already exist
> >>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman.devel1737741659any.cards.tar=
.xz already exist
> >>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman.sources1737741659any.cards.t=
ar.xz already exist
> >>>> =3D=3D=3D=3D=3D=3D=3D> Building starting...
> >>>> cp allow_group_network.diff /tmp/work/src
> >>>> cp vpn6.patch /tmp/work/src
> >>>> cp vpn-11-1.patch /tmp/work/src
> >>>> cp vpn-11-2.patch /tmp/work/src
> >>>> cp vpn-11-3.patch /tmp/work/src
> >>>> cp vpn-11-4.patch /tmp/work/src
> >>>> cp vpn-11-5.patch /tmp/work/src
> >>>> cp vpn-11-6.patch /tmp/work/src
> >>>> cp vpn-11-7.patch /tmp/work/src
> >>>> cp vpn-11-8.patch /tmp/work/src
> >>>> cp vpn-11-9.patch /tmp/work/src
> >>>> cp vpn-11-10.patch /tmp/work/src
> >>>> cp vpn-11-11.patch /tmp/work/src
> >>>> cp vpn-12-1.patch /tmp/work/src
> >>>> cp vpn-12-2.patch /tmp/work/src
> >>>> cp vpn-12-3.patch /tmp/work/src
> >>>> cp vpn-12-4.patch /tmp/work/src
> >>>> cp vpn-12-5.patch /tmp/work/src
> >>>> cp vpn-12-6.patch /tmp/work/src
> >>>> cp vpn-12-7.patch /tmp/work/src
> >>>> cp vpn-12-8.patch /tmp/work/src
> >>>> cp vpn-12-9.patch /tmp/work/src
> >>>> cp vpn-12-10.patch /tmp/work/src
> >>>> cp vpn-12-11.patch /tmp/work/src
> >>>> cp vpn-12-12.patch /tmp/work/src
> >>>> + prepare
> >>>> + git clone https://git.kernel.org/pub/scm/network/connman/connman.g=
it
> >>>> connman-1.43
> >>>> Cloning into 'connman-1.43'...
> >>>> remote: Enumerating objects: 41151, done.
> >>>> remote: Total 41151 (delta 0), reused 0 (delta 0), pack-reused 41151
> >>>> Receiving objects: 100% (41151/41151), 6.41 MiB | 1.64 MiB/s, done.
> >>>> Resolving deltas: 100% (31525/31525), done.
> >>>> + cd connman-1.43
> >>>> + git checkout 263e151fcfb09134dcf17a4147355b0ee9a5eb66
> >>>> Note: switching to '263e151fcfb09134dcf17a4147355b0ee9a5eb66'.
> >>>>
> >>>> You are in 'detached HEAD' state. You can look around, make experime=
ntal
> >>>> changes and commit them, and you can discard any commits you make in=
 this
> >>>> state without impacting any branches by switching back to a branch.
> >>>>
> >>>> If you want to create a new branch to retain commits you create, you=
 may
> >>>> do so (now or later) by using -c with the switch command. Example:
> >>>>
> >>>> git switch -c <new-branch-name>
> >>>>
> >>>> Or undo this operation with:
> >>>>
> >>>> git switch -
> >>>>
> >>>> Turn off this advice by setting config variable advice.detachedHead =
to false
> >>>>
> >>>> HEAD is now at 263e151f treewide: Fix typo in ARPHRD_PHONET_PIPE
> >>>> + patch -Np1 -i /tmp/work/src/allow_group_network.diff
> >>>> patching file src/connman-polkit.conf
> >>>> Hunk #1 succeeded at 7 with fuzz 2 (offset 2 lines).
> >>>> + patch -Np1 -i /tmp/work/src/vpn6.patch
> >>>> patching file src/gateway.c
> >>>> + patch -Np1 -i /tmp/work/src/vpn-11-1.patch
> >>>> patching file src/agent.c
> >>>> Hunk #1 FAILED at 201.
> >>>> 1 out of 1 hunk FAILED -- saving rejects to file src/agent.c.rej
> >>>> =3D=3D=3D=3D=3D=3D=3D> ERROR: Building 'connman.sources1737741659any=
.cards.tar.xz' failed.
> >>>>
> >>>> I have copy the patches from the e-mail , may be it introduce false
> >>>> characters  or must i copy them from the dev list
> >>>>
> >>>> Best regards
> >>>>
> >>>> Daniel
> >>>>
> >>>>
> >>>> Le ven. 24 janv. 2025 =C3=A0 20:03, Jussi Laakkonen
> >>>> <jussi.laakkonen@jolla.com> a =C3=A9crit :
> >>>>>
> >>>>> Hi Christian,
> >>>>>
> >>>>> Actually, that commit is in upstream.
> >>>>> https://git.kernel.org/pub/scm/network/connman/connman.git/log/vpn/=
plugins/wireguard.c
> >>>>> - the date on the cherry-picked commits is the date of cherry picki=
ng (I
> >>>>> guess I missed some option while doing this..) but the original com=
mit
> >>>>> is there submitted on 2020-07-31.
> >>>>>
> >>>>> I also pushed the association state and most of the wireguard fixes=
 I've
> >>>>> done to the mailing list. Have fun testing and tell me if it works
> >>>>> better, we can always improve it if something is still missing. The=
re
> >>>>> are few commits I held back as they could be the next patch set, be=
cause
> >>>>> support for IPv4 and IPv6 addresses, and the route adding fixes are=
 also
> >>>>> quite large changes.
> >>>>>
> >>>>> BR,
> >>>>> - Jussi
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 1/23/25 13:35, Christian Hewitt wrote:
> >>>>>> Looking here: https://git.kernel.org/pub/scm/network/connman/connm=
an.git/log/ I=E2=80=99m not finding "wireguard: Regular reresolve endpoint =
address=E2=80=9D and the first page of log goes back to December =E2=80=992=
3. Are we using the wrong upstream?
> >>>>>>
> >>>>>> Christian
> >>>>>>
> >>>>>>> On 23 Jan 2025, at 3:22=E2=80=AFpm, Jussi Laakkonen <jussi.laakko=
nen@jolla.com> wrote:
> >>>>>>>
> >>>>>>> Hi Christian,
> >>>>>>>
> >>>>>>> That is actually in upstream, all the commits regarding WireGuard=
 before July 10, 2024 are taken from the latest upstream and the changes af=
ter that are new features.
> >>>>>>>
> >>>>>>> Well, the vpn.c changes do depend on having the ASSOCIATION state=
 also for VPNs to be implemented, that was proposed in the RFC https://lore=
.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mb=
ced39d72dd424884fe105a66fea02a83c708f97 as the state transitions depend on =
that bit. But it does not seem to be depending on the gateway.c/connection.=
c. Well, I can try to squeeze time to address the issues Daniel earlier rai=
sed on that RFC and push them to upstream, then make a big change on the vp=
n.c and wireguard.c.
> >>>>>>>
> >>>>>>> Br,
> >>>>>>> Jussi
> >>>>>>>
> >>>>>>>
> >>>>>>> On 1/23/25 13:12, Christian Hewitt wrote:
> >>>>>>>> You don't often get email from christianshewitt@gmail.com. Learn=
 why this is important<https://aka.ms/LearnAboutSenderIdentification>
> >>>>>>>> Ohh.. I would be VERY keen to see support for FQDN=E2=80=99s res=
olving to dynamic IP=E2=80=99s upstreamed so this looks interesting:
> >>>>>>>> https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e65=
17d703f972b866fdbd8bd
> >>>>>>>> Is that feature dependent on any other changes? (being lazy.. I =
didn=E2=80=99t read all the commits in that branch yet!).
> >>>>>>>> Christian
> >>>>>>>> On 23 Jan 2025, at 3:06=E2=80=AFpm, Jussi Laakkonen <jussi.laakk=
onen@jolla.com> wrote:
> >>>>>>>> Hello,
> >>>>>>>> Regarding WireGuard, I had to make a bunch of changes to the lat=
est version of it to get it running properly on our fork (yes, we upgrade i=
t slowly, now 1.38): https://github.com/sailfishos/connman/commits/master/c=
onnman/vpn
> >>>>>>>> But I haven't had time to figure out all that is needed for upst=
ream to be sent first, like this RFC edit that was forgotten because of... =
"eastern winds blowing into our direction": https://lore.kernel.org/connman=
/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884fe1=
05a66fea02a83c708f97
> >>>>>>>> And then the connection.c was modified a lot (and renamed) and I=
'm not sure if these will work on top of that anymore. Mostly because we ha=
ve features that may not have been compatible with latest upstream, like ad=
ding a support  for two different devices to be belonging into one service =
to facilitate CLAT support https://github.com/sailfishos/connman/commits/ma=
ster/connman/src/connection.c etc. etc. etc.
> >>>>>>>> At some point I'll start pushing changes but not sure when I hav=
e time. Mostly they could be RFCs as the changes are big.
> >>>>>>>> BR,
> >>>>>>>> Jussi
> >>>>>>>> On 1/23/25 12:45, daniel antoine wrote:
> >>>>>>>> Hi
> >>>>>>>> I have opened a ticket for connman-vpn not working with wireguar=
d  in
> >>>>>>>> April 2024. If you give me the patches I can test them
> >>>>>>>> Best regards
> >>>>>>>> Daniel
> >>>>>>>> Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
> >>>>>>>> <gerickson@nuovations.com> a =C3=A9crit :
> >>>>>>>> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches <gabriel.sa=
nches@prevas.dk> wrote:
> >>>>>>>> I was testing connman's wireguard plugin and got a segmentation =
fault.
> >>>>>>>> Looking at the backtrace revealed that there are some typos in t=
he `src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 vari=
ables instead of ipv6 regarding vpn.
> >>>>>>>> I simply changed them to ipv6 and got it working.
> >>>>>>>> not related to the patch:
> >>>>>>>> I had to manually add ip route so the other devices could be pin=
ged
> >>>>>>>> The plugin adds routes for the WireGuard.DNS configuration setti=
ng
> >>>>>>>> # ip route
> >>>>>>>> 1.1.1.1 dev wg0 scope link
> >>>>>>>> 8.8.8.8 dev wg0 scope link
> >>>>>>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
> >>>>>>>> 10.42.0.1 dev end1 scope link
> >>>>>>>> <vpn host ip> via 10.42.0.1 dev end1
> >>>>>>>> the missing route added manually:
> >>>>>>>> ip route add 10.33.0.0/16 dev wg0 scope link
> >>>>>>>> an equivalent wireguard file adds it properly (using wg-quick)
> >>>>>>>> Is the plugin lacking some implementation?
> >>>>>>>> ---
> >>>>>>>> src/gateway.c | 6 +++---
> >>>>>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>>>>> diff --git a/src/gateway.c b/src/gateway.c
> >>>>>>>> index 16c87f83..b2c211e2 100644
> >>>>>>>> --- a/src/gateway.c
> >>>>>>>> +++ b/src/gateway.c
> >>>>>>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman=
_service *service,
> >>>>>>>>                                      is_gateway_config_vpn(
> >>>>>>>>                                              new_gateway->ipv4_c=
onfig);
> >>>>>>>> -             is_vpn6 =3D do_ipv4 &&
> >>>>>>>> -                                     new_gateway->ipv4_config &=
&
> >>>>>>>> +             is_vpn6 =3D do_ipv6 &&
> >>>>>>>> +                                     new_gateway->ipv6_config &=
&
> >>>>>>>>                                      is_gateway_config_vpn(
> >>>>>>>> -                                             new_gateway->ipv4_=
config);
> >>>>>>>> +                                             new_gateway->ipv6_=
config);
> >>>>>>>>      } else {
> >>>>>>>>              if (do_ipv4 && new_gateway->ipv4_config)
> >>>>>>>> --
> >>>>>>>> 2.43.0
> >>>>>>>> Gabriel,
> >>>>>>>> Great catch on this copy-and-paste typo; thank you!
> >>>>>>>> Best,
> >>>>>>>> Grant
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>>
> >>
>
