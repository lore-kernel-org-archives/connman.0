Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD216EBFF
	for <connman@lists.linux.dev>; Wed, 24 Apr 2024 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982951; cv=none; b=QW1JbVp+2M4q2rW0ts3TjGsWkq26it71PP5zp8SVWhLD00TYu5FVt9QOWgniQ91RaHUwNbBZ388zH0eRLIribSyQyA3N+OyOQNwuXmp4FJ9yl7/DtbXX/zPoKlviEPEmayjhMQwjZurjj6yBqj3XQG62a2HCRAYeOp9ZaMG5WQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982951; c=relaxed/simple;
	bh=zFjSGTaDytnW/fKXvCh4vSfIP5B1DyBfvDk2074ffyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F/O7f4WkLaXyeojZHflqVz8LzOxeyaFp0IMFI20/r9WneASLu9Red5pB+W2pi5sC+nwbblg3n9xEw5oJo6Ff/FJ9HcsE3+hin6ikC4wwvhkORA1/ZGWlnEU8rZ5jHzJ5E7mpCFH2RfNw4ctMKXzGYAKHhcHwIw9+itvtYeE0Uj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ64IAx+; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ64IAx+"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7eb7f34f36dso48554241.1
        for <connman@lists.linux.dev>; Wed, 24 Apr 2024 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713982949; x=1714587749; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVDYE0qkqgq9Z2iR5JjnbPSIrMSxoj6Ue8vJZHjnHdM=;
        b=YZ64IAx+kCG/drYKOfDOrpjhmFg+S54+LZs/vAWiwqut2axTsnl38lhIUu3gxs2I1x
         9hGKXDyUFPnX2pCywVVFTPdOAKJTcJMwtM367mmebbJvqPJAD+vohjORh+X52T6gbokg
         9hDrylYJgrA28zb/zzWh7Atk9THBLLjtFlwxO3SDFQcCsj8brAbjyWzKATTYPE3t2bVO
         RDZc1XtDC7JiMuJFmVLw9rP0PQuaHSq9WrF3wc/rsufUCtLtYBzjHx1TO/RTOFSvuKqO
         JtqAY2R05Vw0viR5snCh737tJjBH7LszD4Rti7H5L4dGn6lqy2dyH2/1z9xlHRjeAEyX
         4O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713982949; x=1714587749;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVDYE0qkqgq9Z2iR5JjnbPSIrMSxoj6Ue8vJZHjnHdM=;
        b=fqCqOyVtpFdPuBs8zHI0tcltk/nTyo9hwDrvO4K/H1Xn57TX4ONA/DUCfDIQ3SdsQo
         CPesdaqdkAnr8rnkz1pZBEK/AutkSs8+lrZeUp37Km1iejWMCZDBFu4oPYqMHHZTmQWa
         Z/xbLGlAAdLQ4Qrrw05z2qhFRP4Xh/fktYzFTQIoqig/PdePGgmqQGhNf+1uSZ7xBFjY
         fZ4cTdURMDCuWGl+Uyxlztj+UXmKhzdzIuDTT4OpzZgWOJ51VHU1nnmW1tTfkPXUPabA
         iPTwrAmT1LVcle6KuX8aqoXQ/QHCJVxdiikqy7up3qLOnvv3LO7WHY4Ikhytsns/AxDp
         EX+w==
X-Forwarded-Encrypted: i=1; AJvYcCVPcocpWv9mm5O1zQeXtZQNRebNSmndSOHJXcriDN8B+/qR/UXiId5Gc13gHyqsBtbdg7DolDZr0LBIf8dVMs9DqCZd1TDrYg==
X-Gm-Message-State: AOJu0YygBhea/ZvheK3jorAgIpP1BerUmoFcei5HdxE2yW/o2m2dxYYh
	1KJxxnp4fh8Rv/KLbjorPRGtU5gvVAqwK6hpxt/VxUnd3SgaujAo4vBsblorUGA72Hs7dOeCZuc
	ji929hb2XS2fqrNGvuuFOR36mPkk/Wd7s
X-Google-Smtp-Source: AGHT+IEKt9m8MxXVuZ0rAwrmqWdgPpr91XChuTDLVsPx8QeR6JY8XvzFpcxocebSgwxzwaGLHLMLrAVq3of3oXBeBgk=
X-Received: by 2002:a05:6122:4686:b0:4c8:e834:6cf2 with SMTP id
 di6-20020a056122468600b004c8e8346cf2mr3816218vkb.3.1713982947330; Wed, 24 Apr
 2024 11:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+iibzA2M1fDosrij=nUWCAuL4mS+FsO-jt1xxH_qsadBe7ZTA@mail.gmail.com>
 <A3823C56-1321-4B82-B839-9D4A288AA87E@nuovations.com> <5D35F841-0063-422D-B6E6-F2FFBAFFF332@gmail.com>
 <9E0CE3E4-BE47-4C6E-B102-570F8DB593E2@nuovations.com>
In-Reply-To: <9E0CE3E4-BE47-4C6E-B102-570F8DB593E2@nuovations.com>
From: daniel antoine <univac55@gmail.com>
Date: Wed, 24 Apr 2024 20:22:16 +0200
Message-ID: <CA+iibzBFvwPKe_rsvxFntGLFF1zvqt8NVBRf9HN-F_1CObr3xA@mail.gmail.com>
Subject: Re: connman-vpn does'nt work with wireguard
To: Grant Erickson <gerickson@nuovations.com>, 
	"christianshewitt@gmail.com" <christianshewitt@gmail.com>, zboszor@gmail.com, connman@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

some records on journalctl when the vpn connect and cause a restart of conn=
man

avril 24 20:12:21 grat-os1 connmand[554]: Interface wlan0 [ wifi ]
IPv4 online check to http://ipv4.connman.net/online/status.html
succeeded
avril 24 20:13:11 grat-os1 connmand[554]: Interface (null) [ vpn ]
state is association
avril 24 20:13:11 grat-os1 connmand[554]: ipconfig state 2 ipconfig method =
1
avril 24 20:13:11 grat-os1 connmand[554]: wg0 {create} index 6 type 65534 <=
NONE>
avril 24 20:13:11 grat-os1 connmand[554]: wg0 {update} flags 144 <DOWN>
avril 24 20:13:11 grat-os1 connmand[554]: wg0 {newlink} index 6
address 00:00:00:00:00:00 mtu 1420
avril 24 20:13:11 grat-os1 connmand[554]: wg0 {newlink} index 6
operstate 2 <DOWN>
avril 24 20:13:11 grat-os1 connman-vpnd[626]: wg0 {create} index 6
type 65534 <NONE>
avril 24 20:13:11 grat-os1 connman-vpnd[626]: wg0 {update} flags 144 <DOWN>
avril 24 20:13:11 grat-os1 connman-vpnd[626]: wg0 {newlink} index 6
operstate 2 <DOWN>
avril 24 20:13:11 grat-os1 connmand[554]: ipconfig state 2 ipconfig method =
1
avril 24 20:13:11 grat-os1 connmand[554]: wg0 {update} flags 98513
<UP,RUNNING,LOWER_UP>
avril 24 20:13:11 grat-os1 connmand[554]: wg0 {newlink} index 6
address 00:00:00:00:00:00 mtu 1420
avril 24 20:13:11 grat-os1 connmand[554]: wg0 {newlink} index 6
operstate 0 <UNKNOWN>
avril 24 20:13:11 grat-os1 connman-vpnd[626]: wg0 {update} flags 98513
<UP,RUNNING,LOWER_UP>
avril 24 20:13:11 grat-os1 connman-vpnd[626]: wg0 {newlink} index 6
operstate 0 <UNKNOWN>
avril 24 20:13:11 grat-os1 connmand[554]: wg0 {add} address
10.0.3.5/24 label wg0 family 2
avril 24 20:13:31 grat-os1 connmand[554]: Aborting (signal 11)
[/usr/bin/connmand]
avril 24 20:13:31 grat-os1 connmand[554]: ++++++++ backtrace ++++++++
avril 24 20:13:31 grat-os1 connmand[554]: #0  0x7f3a7d2592a0 in
/usr/lib/libc.so.6
avril 24 20:13:31 grat-os1 connmand[554]: #1  0x55bb53185ed7 in
/usr/bin/connmand
avril 24 20:13:31 grat-os1 connmand[554]: #2  0x55bb531a1d6a in
/usr/bin/connmand
avril 24 20:13:31 grat-os1 connmand[554]: #3  0x55bb5319db6c in
/usr/bin/connmand
avril 24 20:13:31 grat-os1 connmand[554]: #4  0x55bb5317704a in
/usr/bin/connmand
avril 24 20:13:31 grat-os1 connmand[554]: #5  0x55bb53177695 in
/usr/bin/connmand
avril 24 20:13:31 grat-os1 connmand[554]: #6  0x55bb531db674 in
/usr/bin/connmand
avril 24 20:13:31 grat-os1 connmand[554]: #7  0x55bb531db873 in
/usr/bin/connmand
avril 24 20:13:31 grat-os1 connmand[554]: #8  0x7f3a7d6c7711 in
/usr/lib/libdbus-1.so.3
avril 24 20:13:31 grat-os1 connmand[554]: #9  0x55bb531da9f0 in
/usr/bin/connmand
avril 24 20:13:31 grat-os1 connmand[554]: #10 0x7f3a7d7609e9 in
/usr/lib/libglib-2.0.so.0
avril 24 20:13:31 grat-os1 connmand[554]: #11 0x7f3a7d763b87 in
/usr/lib/libglib-2.0.so.0
avril 24 20:13:31 grat-os1 connmand[554]: #12 0x7f3a7d76443f in
/usr/lib/libglib-2.0.so.0
avril 24 20:13:31 grat-os1 connmand[554]: #13 0x55bb531462f9 in
/usr/bin/connmand
avril 24 20:13:31 grat-os1 connmand[554]: #14 0x7f3a7d243c4a in
/usr/lib/libc.so.6
avril 24 20:13:31 grat-os1 connmand[554]: #15 0x7f3a7d243d05 in
/usr/lib/libc.so.6
avril 24 20:13:31 grat-os1 connmand[554]: +++++++++++++++++++++++++++
avril 24 20:13:31 grat-os1 systemd[1]: connman.service: Main process
exited, code=3Dexited, status=3D1/FAILURE
avril 24 20:13:31 grat-os1 systemd[1]: connman.service: Failed with
result 'exit-code'.
avril 24 20:13:32 grat-os1 systemd[1]: connman.service: Scheduled
restart job, restart counter is at 1.
avril 24 20:13:32 grat-os1 systemd[1]: Starting connman.service...
avril 24 20:13:32 grat-os1 connmand[1091]: Connection Manager version 1.42

Best regards

Daniel

Le mer. 24 avr. 2024 =C3=A0 18:14, Grant Erickson
<gerickson@nuovations.com> a =C3=A9crit :
>
> +Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi
>
> On Apr 24, 2024, at 7:50=E2=80=AFAM, Christian Hewitt <christianshewitt@g=
mail.com> wrote:
> >> On 24 Apr 2024, at 6:06=E2=80=AFPM, Grant Erickson <gerickson@nuovatio=
ns.com> wrote:
> >> On Apr 23, 2024, at 11:05=E2=80=AFPM, daniel antoine <univac55@gmail.c=
om> wrote:
> >>> I have installed wireguards-tools on my system and I am able to
> >>> connect to a VPN server friend with the command wg-quick up 'name of
> >>> the interface' . The configuration file in /etc/wiregard has a host
> >>> with a FQDN as blabla.com  . It also works if I replace the host by a=
n
> >>> IP address (IPv4 or IPv6).
> >>>
> >>> I have adapted the configuration file in /var/lib/connman-plugin like=
 vpn.config
> >>>
> >>> [provider_wireguard]
> >>> Type =3D WireGuard
> >>> Name =3D vpn
> >>> Host =3D balabla.com
> >>> WireGuard.Address =3D 10.0.6.5 /24
> >>> WireGuard.PrivateKey =3D xxxx
> >>> WireGuard.PublicKey =3D zzzz
> >>> WireGuard.AllowedIPs =3D 10.0.6.0/24
> >>> WireGuard.EndpointPort =3D 51822
> >>> WireGuard.PersistentKeepalive =3D 25
> >>>
> >>> My display environment is enlightenment. I see the connection "vpn" i=
n
> >>> the connection window. When I click on it , wg show vpn displays the
> >>> connection to the server, a ip a command shows an interface wg0  but
> >>> it drops after some seconds. I can ping the server 10.0.6.1 until it
> >>> drops.
> >>>
> >>> If I replace the FQDN by an IP address in this file , for an IPv4
> >>> address it makes the wifi connection shutdown and returns. My laptop
> >>> is connected by wifi to my livebox. If I put an IPv6 address it does
> >>> nothing, no interface wg0 is created.
> >>>
> >>> connmanctl shows the vpn service with the command services and the vp=
n
> >>> connection is present in vpnconnection
> >>>
> >>> My first question is why connman does not accept an IP address IPv4 o=
r
> >>> IPv6 . I have compiled wiregard-tools with WITH_BASHCOMPLETION=3Dyes
> >>> and WITH_WGQUICK=3Dyes
> >>>
> >>> After why the connection drops
> >>
> >> Daniel:
> >>
> >> I wonder if you are running into the same issue as Christian Hewitt <c=
hristianshewitt@gmail.com> in the thread "RFC: There Are No Routes for Non-=
default Services
> >> =E2=80=9C: https://lore.kernel.org/connman/FAB1AC37-E077-4067-B245-5CE=
862CB22B7@gmail.com/
> >
> > The distro I work on (LibreELEC) is bundling this patch to revert the c=
hange:
> >
> > https://github.com/LibreELEC/LibreELEC.tv/commit/998f2bcfd5849e3eecda6f=
753ff5bab68a847aea
> >
> > This unfortunately means we=E2=80=99re unable to bump ConnMan until thi=
ngs are resolved/adapted upstream.
>
> Adding Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi <zboszor@gmail.com>, the or=
iginal patch submitter of 9eb1772d31b6 for visibility.
>
> Best,
>
> Grant
