Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745825A63A
	for <connman@lists.linux.dev>; Mon, 27 Jan 2025 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973881; cv=none; b=a5TujiEHjiofsHP+r8jCPq174OdlJMuZHCdmd8K3W0c70J1ASGl3yCEHMicLQCAvxCeqYc68wu5h5ZYg9uZMOEou0avBdahGqTBZwVgAeK8r33/s4mG+3DJDuCURJ3jmhq2wT+NejtdM61a8oMqotBX/G8hE1ctXPV02tn+R8CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973881; c=relaxed/simple;
	bh=4VLh3/KFgSI32PUACj6rXo6ryeZg+JCKlLnSrUe5is8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SA7jREm/dK4zHkcAiNuueuFVvbbys21voFaoeed/ioB3WJsd5oMC5mvZUCoVURc5aGp+flgP06U/vNVHjQzt5r4Z2h9quxwna44ulzSJ5AEF18tUl0mJTCrtxNtp9UGGgyljzyLFs2UNqKJYDZ32KIAvF7yr6Mekf6afPK5dfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG73rXnR; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG73rXnR"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85b92397fe2so849124241.3
        for <connman@lists.linux.dev>; Mon, 27 Jan 2025 02:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737973878; x=1738578678; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD7EHw4AgMXNWzIxaYwEvGX1mURT24DRv+IXAiBT558=;
        b=hG73rXnRdCJZKXGc8CjDgIrEJHLIdUiK+jJA8r8dMO34okIdmATTXgk3xFT3jTfDS1
         DrobNSMdpSxr2opdSVyVr62DUtY2SIMfutoyam5NSJjVTp8X45UT3hxAVt+gSnMPbz/V
         jU+KXgSpRIoqLs59yEbxPVmsfn+uPCQYFt5MQKSGqv94A6UNxEdQaw/4hQxfDFEy8Emh
         m6OfUNzvJmPA+tqUkj0vdhvSbhtovyY7A2Iv8czYXr0Xkx88fYpN9SYvx9LmjpS7DFao
         hf5bSel3QBFwmWM9OmZeS0jo8Ur6dQubpKXCAPM9Rkjh+BmQ9bzA0yCKZw6Qw6EOkHc7
         1NHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737973878; x=1738578678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD7EHw4AgMXNWzIxaYwEvGX1mURT24DRv+IXAiBT558=;
        b=gCasnnWf3cJ5ub9DN0XuHWbYkGSTSo7MHZkzGtHHxQW+XSwgFwuIb5G0V2WAcRi+aP
         scJ3gP5Bj7wl/VP1M06UxY7LNwrC0pG6xZlrWH/PEJ3R41SxmRyH0j7TcK8wRNd40+1b
         v4Evsit5LG3WguWqmqXQal90DJTXV/e4S+byL5WqzabiG5ebQ3ZPDO7ih6/LxUQfkFB1
         E5IuB1HVgpekhu2u1JO/O1/xQtfnN7fsj66aQUbH1ZND8alDrpJJfYPUcLgE8t44WRg1
         H0SKYypUEHIAPdmMd2sMvnDYgaZMNTSGNxFfYYdj4e7EfMEyIsQ1D8XHbz4bKFxBkPd5
         j6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVd+GqnKp/pL3Nw7K60KJN2zF7aFDutWiuMlyPSyUj9ZKvPuScuwAX5RmZ66MzW/rFg8HsLNA7g@lists.linux.dev
X-Gm-Message-State: AOJu0YzCF1SmjVcwlvwjLZu9atMbaCsqIOjDc65JQfwLmNB1IDTQHLRE
	S55z/W3YzwzjZ5x+hbY6Zv8BQa3+x3qGn+q8ky0EiJ+gSyMkUS7+r4unx7XKYw2bAMioFKUt6il
	U4DgcVX6Pppfy52YLX45DtnyaGlw=
X-Gm-Gg: ASbGnctEiv2rvOiluyF7JR5uyat4G/bACQ/Smlb7ZUqW0+5kUwwgDfBIr5Da4Za9l8L
	Mzvpjmyez+Gm/Haw09gmG80uI4WlspmaSmSI/jrzB/eDO2nBJjzACEQTAKLrbCr/VEV2ThdEGWq
	xySr7vO7UjwWK1DkL3vXs=
X-Google-Smtp-Source: AGHT+IGx2qQGnKCRvWPw3BxXle7J75PPSuugD/O8CopWFOejjBNAKLEmjbaWLtzHYotiW2G9rooRHh8X7dgwGC2VK9Y=
X-Received: by 2002:a05:6102:3751:b0:4b2:9f20:51d3 with SMTP id
 ada2fe7eead31-4b69099f768mr31832825137.0.1737973877630; Mon, 27 Jan 2025
 02:31:17 -0800 (PST)
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
 <B003F09E-E90B-45BD-8E40-EF11D13789C2@gmail.com> <CA+iibzBoXcrruA8Axk7XZFpqdy0985wMX_658yJ6Lo_X-BkmKw@mail.gmail.com>
In-Reply-To: <CA+iibzBoXcrruA8Axk7XZFpqdy0985wMX_658yJ6Lo_X-BkmKw@mail.gmail.com>
From: daniel antoine <univac55@gmail.com>
Date: Mon, 27 Jan 2025 11:31:06 +0100
X-Gm-Features: AWEUYZkWgzc3md9wTv2IkkfMVxixuvPZzLaw-KvtLkYCa7TRtiUN0jBATRXy02E
Message-ID: <CA+iibzD-8N5uZumhYHfeVOzDVNgQrLi9O2e8BHpYveYc5L0M5w@mail.gmail.com>
Subject: Re: [PATCH] gateway: Fix typo when setting 'is_vpn6'
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Jussi Laakkonen <jussi.laakkonen@jolla.com>, Grant Erickson <gerickson@nuovations.com>, 
	"connman@lists.linux.dev" <connman@lists.linux.dev>, Gabriel Sanches <gabriel.sanches@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I have replaced the fqdn by the ipv4 address of the host that is
located on an OVH distributor. I can connect and ping the endpoint but
my wifi connection passed from offline to ready and the vpn connection
is considered as the default. I lose all access to internet discord
etc...

root@grat-os1:/var/lib/connman-vpn# systemctl status connman
=E2=97=8F connman.service - Connection service
     Loaded: loaded (/usr/lib/systemd/system/connman.service; enabled;
preset: enabled)
     Active: active (running) since Mon 2025-01-27 10:59:15 CET; 13min ago
 Invocation: 731fc39df2b9456f996e16e9e484036c
   Main PID: 573 (connmand)
      Tasks: 1 (limit: 4915)
     Memory: 3.3M (peak: 3.6M)
        CPU: 136ms
     CGroup: /system.slice/connman.service
             =E2=94=94=E2=94=80573 /usr/bin/connmand -n

janv. 27 11:12:45 grat-os1 connmand[573]: Interface (null) [ vpn ]
state is configuration
janv. 27 11:12:45 grat-os1 connmand[573]: wg0 {update} flags 98513
<UP,RUNNING,LOWER_UP>
janv. 27 11:12:45 grat-os1 connmand[573]: wg0 {newlink} index 7
address 00:00:00:00:00:00 mtu 1420
janv. 27 11:12:45 grat-os1 connmand[573]: wg0 {newlink} index 7
operstate 0 <UNKNOWN>
janv. 27 11:12:45 grat-os1 connmand[573]: wg0 {add} address
10.0.7.5/24 label wg0 family 2
janv. 27 11:12:45 grat-os1 connmand[573]: Interface wg0 [ vpn ] state is re=
ady
janv. 27 11:12:45 grat-os1 connmand[573]: Interface wlan0 [ wifi ]
state is ready
janv. 27 11:12:45 grat-os1 connmand[573]: Interface wg0 [ vpn ] is the defa=
ult
janv. 27 11:12:45 grat-os1 connmand[573]: Interface wg0 [ vpn ] is the defa=
ult
janv. 27 11:12:45 grat-os1 connmand[573]: ipconfig state 4 ipconfig method =
1

root@grat-os1:/var/lib/connman-vpn# systemctl status connman-vpn
=E2=97=8F connman-vpn.service - ConnMan VPN service
     Loaded: loaded (/usr/lib/systemd/system/connman-vpn.service;
enabled; preset: enabled)
     Active: active (running) since Mon 2025-01-27 11:12:14 CET; 2min 6s ag=
o
 Invocation: 28e320a0d50d4e09909da0af332be591
   Main PID: 1742 (connman-vpnd)
      Tasks: 1 (limit: 4915)
     Memory: 1M (peak: 1.5M)
        CPU: 22ms
     CGroup: /system.slice/connman-vpn.service
             =E2=94=94=E2=94=801742 /usr/bin/connman-vpnd -n

janv. 27 11:12:14 grat-os1 connman-vpnd[1742]: virbr0 {create} index 5
type 1 <ETHER>
janv. 27 11:12:14 grat-os1 connman-vpnd[1742]: virbr0 {update} flags 4099 <=
UP>
janv. 27 11:12:14 grat-os1 connman-vpnd[1742]: virbr0 {newlink} index
5 address xxxxxxxxxxxxxxxxx mtu 1500
janv. 27 11:12:14 grat-os1 connman-vpnd[1742]: virbr0 {newlink} index
5 operstate 2 <DOWN>
janv. 27 11:12:14 grat-os1 systemd[1]: Started ConnMan VPN service.
janv. 27 11:12:45 grat-os1 connman-vpnd[1742]: wg0 {create} index 7
type 65534 <NONE>
janv. 27 11:12:45 grat-os1 connman-vpnd[1742]: wg0 {update} flags 144 <DOWN=
>
janv. 27 11:12:45 grat-os1 connman-vpnd[1742]: wg0 {newlink} index 7
operstate 2 <DOWN>
janv. 27 11:12:45 grat-os1 connman-vpnd[1742]: wg0 {update} flags
98513 <UP,RUNNING,LOWER_UP>
janv. 27 11:12:45 grat-os1 connman-vpnd[1742]: wg0 {newlink} index 7
operstate 0 <UNKNOWN>

After a certain time the vpn connection stopped and the wifi returns to nor=
mal

root@grat-os1:/var/lib/connman-vpn# systemctl status connman-vpn
=E2=97=8F connman-vpn.service - ConnMan VPN service
     Loaded: loaded (/usr/lib/systemd/system/connman-vpn.service;
enabled; preset: enabled)
     Active: active (running) since Mon 2025-01-27 11:12:14 CET; 2min 47s a=
go
 Invocation: 28e320a0d50d4e09909da0af332be591
   Main PID: 1742 (connman-vpnd)
      Tasks: 1 (limit: 4915)
     Memory: 1M (peak: 1.5M)
        CPU: 27ms
     CGroup: /system.slice/connman-vpn.service
             =E2=94=94=E2=94=801742 /usr/bin/connman-vpnd -n

janv. 27 11:12:45 grat-os1 connman-vpnd[1742]: wg0 {create} index 7
type 65534 <NONE>
janv. 27 11:12:45 grat-os1 connman-vpnd[1742]: wg0 {update} flags 144 <DOWN=
>
janv. 27 11:12:45 grat-os1 connman-vpnd[1742]: wg0 {newlink} index 7
operstate 2 <DOWN>
janv. 27 11:12:45 grat-os1 connman-vpnd[1742]: wg0 {update} flags
98513 <UP,RUNNING,LOWER_UP>
janv. 27 11:12:45 grat-os1 connman-vpnd[1742]: wg0 {newlink} index 7
operstate 0 <UNKNOWN>
janv. 27 11:14:50 grat-os1 connman-vpnd[1742]: reresolve error limit reache=
d
janv. 27 11:14:50 grat-os1 connman-vpnd[1742]: wg0 {update} flags 32912 <DO=
WN>
janv. 27 11:14:50 grat-os1 connman-vpnd[1742]: wg0 {newlink} index 7
operstate 2 <DOWN>
janv. 27 11:14:50 grat-os1 connman-vpnd[1742]: wg0 {dellink} index 7
operstate 2 <DOWN>
janv. 27 11:14:50 grat-os1 connman-vpnd[1742]: wg0 {remove} index 7

The reresolve error refers to theses commits
AgeCommit message (Expand)AuthorFilesLines
2020-10-12wireguard: Fix struct sockaddr usage
2020-07-31wireguard: Regular reresolve endpoint address

There is no wireguard DNS if I add one with WireGuard.DNS =3D 1.1.1.1 in
the config file the VPN connection is longer but failed with a default
route error

Best regards

Daniel

Le sam. 25 janv. 2025 =C3=A0 16:44, daniel antoine <univac55@gmail.com> a =
=C3=A9crit :
>
> Hi
> Thanks a lot
> Best regards
> Daniel
>
> Le sam. 25 janv. 2025 =C3=A0 16:22, Christian Hewitt
> <christianshewitt@gmail.com> a =C3=A9crit :
> >
> > In the connman config "Host=E2=80=9D must be an IP address not an FQDN.
> >
> > Christian
> >
> > > On 25 Jan 2025, at 7:12=E2=80=AFpm, daniel antoine <univac55@gmail.co=
m> wrote:
> > >
> > > Hi
> > > with wg-quik I can connect the vpn and ping the endpoint 10.0.7.2
> > > the config file in /etc/wireguard (I have modify it for the e-mail) i=
s
> > >
> > > [Interface]
> > > Address =3D 10.0.7.5/24
> > > PrivateKey =3D yyyyy
> > >
> > > [Peer]
> > > Endpoint =3D monsite.fr:51820
> > > PublicKey =3D xxxxx
> > > AllowedIPs =3D 10.0.7.0/24
> > > PersistentKeepalive =3D 25
> > >
> > > The config file for connman-vpn in /var/lib/connman-vpn
> > >
> > > [provider_wireguard]
> > > Type =3D WireGuard
> > > Name =3D chezlui
> > > Host =3D monsite.fr
> > > WireGuard.Address =3D 10.0.7.5/24
> > > WireGuard.PrivateKey =3D yyyyyy
> > > WireGuard.PublicKey =3D xxxxx
> > > WireGuard.AllowedIPs =3D 10.0.7.0/24
> > > WireGuard.EndpointPort =3D 51820
> > > WireGuard.PersistentKeepalive =3D 25
> > >
> > > Is there something wrong with it? It cause the wifi connexion to drop
> > > when I connect the vpn
> > >
> > > Best regards
> > >
> > > Daniel
> > >
> > > Le sam. 25 janv. 2025 =C3=A0 14:12, Christian Hewitt
> > > <christianshewitt@gmail.com> a =C3=A9crit :
> > >>
> > >> I=E2=80=99ve picked patches into https://github.com/chewitt/connman/=
commits/wireguard
> > >>
> > >> This is connman HEAD + Gabriel's is_vpn6 patch + my revert patch (to=
 fix routing)
> > >> + the two series that Jussi posted to the list yesterday.
> > >>
> > >> For me this is working fine with no wireguard issues observed since =
this morning
> > >> when I=E2=80=99ve rebuilt a LibreELEC image using that branch. I pla=
n to use it myself
> > >> for a couple of days, then if all good I=E2=80=99ll push changes int=
o LibreELEC nightly
> > >> images for a while to get some wider testing done.
> > >>
> > >> Christian
> > >>
> > >>
> > >>> On 25 Jan 2025, at 3:23=E2=80=AFpm, daniel antoine <univac55@gmail.=
com> wrote:
> > >>>
> > >>> I have copy the patches from the dev list and they have all passed =
;
> > >>> The vpn connection continue to drop with in the journalctl
> > >>>
> > >>> janv. 25 12:12:01 grat-os1 connman-vpnd[1176]: wlan0 {newlink} inde=
x
> > >>> 5 operstate 6 <UP>
> > >>> janv. 25 12:13:03 grat-os1 connman-vpnd[1176]: Adding configuration=
 vpndania
> > >>> janv. 25 12:13:03 grat-os1 connman-vpnd[1176]: Added provider
> > >>> configuration wireguard
> > >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {create} index 6
> > >>> type 65534 <NONE>
> > >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags 1=
44 <DOWN>
> > >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index =
6
> > >>> operstate 2 <DOWN>
> > >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags
> > >>> 98513 <UP,RUNNING,LOWER_UP>
> > >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index =
6
> > >>> operstate 0 <UNKNOWN>
> > >>> janv. 25 12:15:46 grat-os1 connman-vpnd[1176]: reresolve error limi=
t reached
> > >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {update} flags 3=
2912 <DOWN>
> > >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {newlink} index =
6
> > >>> operstate 2 <DOWN>
> > >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {dellink} index =
6
> > >>> operstate 2 <DOWN>
> > >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {remove} index 6
> > >>>
> > >>> and
> > >>>
> > >>> =E2=97=8F connman-vpn.service - ConnMan VPN service
> > >>>    Loaded: loaded (/usr/lib/systemd/system/connman-vpn.service;
> > >>> enabled; preset: enabled)
> > >>>    Active: active (running) since Sat 2025-01-25 12:12:02 CET; 6min=
 ago
> > >>> Invocation: c3584a6570fc48deb60efbb589e55903
> > >>>  Main PID: 1176 (connman-vpnd)
> > >>>     Tasks: 1 (limit: 4915)
> > >>>    Memory: 1.1M (peak: 1.7M)
> > >>>       CPU: 24ms
> > >>>    CGroup: /system.slice/connman-vpn.service
> > >>>            =E2=94=94=E2=94=801176 /usr/bin/connman-vpnd -n
> > >>>
> > >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {create} index 6
> > >>> type 65534 <NONE>
> > >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags 1=
44 <DOWN>
> > >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index =
6
> > >>> operstate 2 <DOWN>
> > >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {update} flags
> > >>> 98513 <UP,RUNNING,LOWER_UP>
> > >>> janv. 25 12:13:41 grat-os1 connman-vpnd[1176]: wg0 {newlink} index =
6
> > >>> operstate 0 <UNKNOWN>
> > >>> janv. 25 12:15:46 grat-os1 connman-vpnd[1176]: reresolve error limi=
t reached
> > >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {update} flags 3=
2912 <DOWN>
> > >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {newlink} index =
6
> > >>> operstate 2 <DOWN>
> > >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {dellink} index =
6
> > >>> operstate 2 <DOWN>
> > >>> janv. 25 12:15:47 grat-os1 connman-vpnd[1176]: wg0 {remove} index 6
> > >>>
> > >>> There was a question about a reverse patch for the iptable. Does I
> > >>> have missed it
> > >>>
> > >>> Best regards
> > >>>
> > >>> Daniel
> > >>>
> > >>>
> > >>> Le sam. 25 janv. 2025 =C3=A0 11:46, daniel antoine <univac55@gmail.=
com> a =C3=A9crit :
> > >>>>
> > >>>> Hi Jussi  Grant Christian and Gabiel
> > >>>>
> > >>>> I have installed first the Gabriel patch and tested but my vpn
> > >>>> connexion drops after 5 seconds and finally hangs the wifi connexi=
on
> > >>>>
> > >>>> I have continued by installing the eleven and twelves jussi patche=
s
> > >>>> but my compilation failed with the first patch 11-1
> > >>>>
> > >>>> =3D=3D=3D=3D=3D=3D=3D> name: connman
> > >>>> =3D=3D=3D=3D=3D=3D=3D> version: 1.43
> > >>>> =3D=3D=3D=3D=3D=3D=3D> release: 9
> > >>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman1737741659x86_64.cards.tar.=
xz already exist
> > >>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman.man1737741659any.cards.tar=
.xz already exist
> > >>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman.devel1737741659any.cards.t=
ar.xz already exist
> > >>>> =3D=3D=3D=3D=3D=3D=3D> WARNING: connman.sources1737741659any.cards=
.tar.xz already exist
> > >>>> =3D=3D=3D=3D=3D=3D=3D> Building starting...
> > >>>> cp allow_group_network.diff /tmp/work/src
> > >>>> cp vpn6.patch /tmp/work/src
> > >>>> cp vpn-11-1.patch /tmp/work/src
> > >>>> cp vpn-11-2.patch /tmp/work/src
> > >>>> cp vpn-11-3.patch /tmp/work/src
> > >>>> cp vpn-11-4.patch /tmp/work/src
> > >>>> cp vpn-11-5.patch /tmp/work/src
> > >>>> cp vpn-11-6.patch /tmp/work/src
> > >>>> cp vpn-11-7.patch /tmp/work/src
> > >>>> cp vpn-11-8.patch /tmp/work/src
> > >>>> cp vpn-11-9.patch /tmp/work/src
> > >>>> cp vpn-11-10.patch /tmp/work/src
> > >>>> cp vpn-11-11.patch /tmp/work/src
> > >>>> cp vpn-12-1.patch /tmp/work/src
> > >>>> cp vpn-12-2.patch /tmp/work/src
> > >>>> cp vpn-12-3.patch /tmp/work/src
> > >>>> cp vpn-12-4.patch /tmp/work/src
> > >>>> cp vpn-12-5.patch /tmp/work/src
> > >>>> cp vpn-12-6.patch /tmp/work/src
> > >>>> cp vpn-12-7.patch /tmp/work/src
> > >>>> cp vpn-12-8.patch /tmp/work/src
> > >>>> cp vpn-12-9.patch /tmp/work/src
> > >>>> cp vpn-12-10.patch /tmp/work/src
> > >>>> cp vpn-12-11.patch /tmp/work/src
> > >>>> cp vpn-12-12.patch /tmp/work/src
> > >>>> + prepare
> > >>>> + git clone https://git.kernel.org/pub/scm/network/connman/connman=
.git
> > >>>> connman-1.43
> > >>>> Cloning into 'connman-1.43'...
> > >>>> remote: Enumerating objects: 41151, done.
> > >>>> remote: Total 41151 (delta 0), reused 0 (delta 0), pack-reused 411=
51
> > >>>> Receiving objects: 100% (41151/41151), 6.41 MiB | 1.64 MiB/s, done=
.
> > >>>> Resolving deltas: 100% (31525/31525), done.
> > >>>> + cd connman-1.43
> > >>>> + git checkout 263e151fcfb09134dcf17a4147355b0ee9a5eb66
> > >>>> Note: switching to '263e151fcfb09134dcf17a4147355b0ee9a5eb66'.
> > >>>>
> > >>>> You are in 'detached HEAD' state. You can look around, make experi=
mental
> > >>>> changes and commit them, and you can discard any commits you make =
in this
> > >>>> state without impacting any branches by switching back to a branch=
.
> > >>>>
> > >>>> If you want to create a new branch to retain commits you create, y=
ou may
> > >>>> do so (now or later) by using -c with the switch command. Example:
> > >>>>
> > >>>> git switch -c <new-branch-name>
> > >>>>
> > >>>> Or undo this operation with:
> > >>>>
> > >>>> git switch -
> > >>>>
> > >>>> Turn off this advice by setting config variable advice.detachedHea=
d to false
> > >>>>
> > >>>> HEAD is now at 263e151f treewide: Fix typo in ARPHRD_PHONET_PIPE
> > >>>> + patch -Np1 -i /tmp/work/src/allow_group_network.diff
> > >>>> patching file src/connman-polkit.conf
> > >>>> Hunk #1 succeeded at 7 with fuzz 2 (offset 2 lines).
> > >>>> + patch -Np1 -i /tmp/work/src/vpn6.patch
> > >>>> patching file src/gateway.c
> > >>>> + patch -Np1 -i /tmp/work/src/vpn-11-1.patch
> > >>>> patching file src/agent.c
> > >>>> Hunk #1 FAILED at 201.
> > >>>> 1 out of 1 hunk FAILED -- saving rejects to file src/agent.c.rej
> > >>>> =3D=3D=3D=3D=3D=3D=3D> ERROR: Building 'connman.sources1737741659a=
ny.cards.tar.xz' failed.
> > >>>>
> > >>>> I have copy the patches from the e-mail , may be it introduce fals=
e
> > >>>> characters  or must i copy them from the dev list
> > >>>>
> > >>>> Best regards
> > >>>>
> > >>>> Daniel
> > >>>>
> > >>>>
> > >>>> Le ven. 24 janv. 2025 =C3=A0 20:03, Jussi Laakkonen
> > >>>> <jussi.laakkonen@jolla.com> a =C3=A9crit :
> > >>>>>
> > >>>>> Hi Christian,
> > >>>>>
> > >>>>> Actually, that commit is in upstream.
> > >>>>> https://git.kernel.org/pub/scm/network/connman/connman.git/log/vp=
n/plugins/wireguard.c
> > >>>>> - the date on the cherry-picked commits is the date of cherry pic=
king (I
> > >>>>> guess I missed some option while doing this..) but the original c=
ommit
> > >>>>> is there submitted on 2020-07-31.
> > >>>>>
> > >>>>> I also pushed the association state and most of the wireguard fix=
es I've
> > >>>>> done to the mailing list. Have fun testing and tell me if it work=
s
> > >>>>> better, we can always improve it if something is still missing. T=
here
> > >>>>> are few commits I held back as they could be the next patch set, =
because
> > >>>>> support for IPv4 and IPv6 addresses, and the route adding fixes a=
re also
> > >>>>> quite large changes.
> > >>>>>
> > >>>>> BR,
> > >>>>> - Jussi
> > >>>>>
> > >>>>>
> > >>>>>
> > >>>>> On 1/23/25 13:35, Christian Hewitt wrote:
> > >>>>>> Looking here: https://git.kernel.org/pub/scm/network/connman/con=
nman.git/log/ I=E2=80=99m not finding "wireguard: Regular reresolve endpoin=
t address=E2=80=9D and the first page of log goes back to December =E2=80=
=9923. Are we using the wrong upstream?
> > >>>>>>
> > >>>>>> Christian
> > >>>>>>
> > >>>>>>> On 23 Jan 2025, at 3:22=E2=80=AFpm, Jussi Laakkonen <jussi.laak=
konen@jolla.com> wrote:
> > >>>>>>>
> > >>>>>>> Hi Christian,
> > >>>>>>>
> > >>>>>>> That is actually in upstream, all the commits regarding WireGua=
rd before July 10, 2024 are taken from the latest upstream and the changes =
after that are new features.
> > >>>>>>>
> > >>>>>>> Well, the vpn.c changes do depend on having the ASSOCIATION sta=
te also for VPNs to be implemented, that was proposed in the RFC https://lo=
re.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#=
mbced39d72dd424884fe105a66fea02a83c708f97 as the state transitions depend o=
n that bit. But it does not seem to be depending on the gateway.c/connectio=
n.c. Well, I can try to squeeze time to address the issues Daniel earlier r=
aised on that RFC and push them to upstream, then make a big change on the =
vpn.c and wireguard.c.
> > >>>>>>>
> > >>>>>>> Br,
> > >>>>>>> Jussi
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> On 1/23/25 13:12, Christian Hewitt wrote:
> > >>>>>>>> You don't often get email from christianshewitt@gmail.com. Lea=
rn why this is important<https://aka.ms/LearnAboutSenderIdentification>
> > >>>>>>>> Ohh.. I would be VERY keen to see support for FQDN=E2=80=99s r=
esolving to dynamic IP=E2=80=99s upstreamed so this looks interesting:
> > >>>>>>>> https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e=
6517d703f972b866fdbd8bd
> > >>>>>>>> Is that feature dependent on any other changes? (being lazy.. =
I didn=E2=80=99t read all the commits in that branch yet!).
> > >>>>>>>> Christian
> > >>>>>>>> On 23 Jan 2025, at 3:06=E2=80=AFpm, Jussi Laakkonen <jussi.laa=
kkonen@jolla.com> wrote:
> > >>>>>>>> Hello,
> > >>>>>>>> Regarding WireGuard, I had to make a bunch of changes to the l=
atest version of it to get it running properly on our fork (yes, we upgrade=
 it slowly, now 1.38): https://github.com/sailfishos/connman/commits/master=
/connman/vpn
> > >>>>>>>> But I haven't had time to figure out all that is needed for up=
stream to be sent first, like this RFC edit that was forgotten because of..=
. "eastern winds blowing into our direction": https://lore.kernel.org/connm=
an/20221213140707.278313-5-jussi.laakkonen@jolla.com/T/#mbced39d72dd424884f=
e105a66fea02a83c708f97
> > >>>>>>>> And then the connection.c was modified a lot (and renamed) and=
 I'm not sure if these will work on top of that anymore. Mostly because we =
have features that may not have been compatible with latest upstream, like =
adding a support  for two different devices to be belonging into one servic=
e to facilitate CLAT support https://github.com/sailfishos/connman/commits/=
master/connman/src/connection.c etc. etc. etc.
> > >>>>>>>> At some point I'll start pushing changes but not sure when I h=
ave time. Mostly they could be RFCs as the changes are big.
> > >>>>>>>> BR,
> > >>>>>>>> Jussi
> > >>>>>>>> On 1/23/25 12:45, daniel antoine wrote:
> > >>>>>>>> Hi
> > >>>>>>>> I have opened a ticket for connman-vpn not working with wiregu=
ard  in
> > >>>>>>>> April 2024. If you give me the patches I can test them
> > >>>>>>>> Best regards
> > >>>>>>>> Daniel
> > >>>>>>>> Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
> > >>>>>>>> <gerickson@nuovations.com> a =C3=A9crit :
> > >>>>>>>> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches <gabriel.=
sanches@prevas.dk> wrote:
> > >>>>>>>> I was testing connman's wireguard plugin and got a segmentatio=
n fault.
> > >>>>>>>> Looking at the backtrace revealed that there are some typos in=
 the `src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 va=
riables instead of ipv6 regarding vpn.
> > >>>>>>>> I simply changed them to ipv6 and got it working.
> > >>>>>>>> not related to the patch:
> > >>>>>>>> I had to manually add ip route so the other devices could be p=
inged
> > >>>>>>>> The plugin adds routes for the WireGuard.DNS configuration set=
ting
> > >>>>>>>> # ip route
> > >>>>>>>> 1.1.1.1 dev wg0 scope link
> > >>>>>>>> 8.8.8.8 dev wg0 scope link
> > >>>>>>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
> > >>>>>>>> 10.42.0.1 dev end1 scope link
> > >>>>>>>> <vpn host ip> via 10.42.0.1 dev end1
> > >>>>>>>> the missing route added manually:
> > >>>>>>>> ip route add 10.33.0.0/16 dev wg0 scope link
> > >>>>>>>> an equivalent wireguard file adds it properly (using wg-quick)
> > >>>>>>>> Is the plugin lacking some implementation?
> > >>>>>>>> ---
> > >>>>>>>> src/gateway.c | 6 +++---
> > >>>>>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
> > >>>>>>>> diff --git a/src/gateway.c b/src/gateway.c
> > >>>>>>>> index 16c87f83..b2c211e2 100644
> > >>>>>>>> --- a/src/gateway.c
> > >>>>>>>> +++ b/src/gateway.c
> > >>>>>>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connm=
an_service *service,
> > >>>>>>>>                                      is_gateway_config_vpn(
> > >>>>>>>>                                              new_gateway->ipv4=
_config);
> > >>>>>>>> -             is_vpn6 =3D do_ipv4 &&
> > >>>>>>>> -                                     new_gateway->ipv4_config=
 &&
> > >>>>>>>> +             is_vpn6 =3D do_ipv6 &&
> > >>>>>>>> +                                     new_gateway->ipv6_config=
 &&
> > >>>>>>>>                                      is_gateway_config_vpn(
> > >>>>>>>> -                                             new_gateway->ipv=
4_config);
> > >>>>>>>> +                                             new_gateway->ipv=
6_config);
> > >>>>>>>>      } else {
> > >>>>>>>>              if (do_ipv4 && new_gateway->ipv4_config)
> > >>>>>>>> --
> > >>>>>>>> 2.43.0
> > >>>>>>>> Gabriel,
> > >>>>>>>> Great catch on this copy-and-paste typo; thank you!
> > >>>>>>>> Best,
> > >>>>>>>> Grant
> > >>>>>>>
> > >>>>>>
> > >>>>>
> > >>>>>
> > >>
> >
