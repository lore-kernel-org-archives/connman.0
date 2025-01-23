Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4820F072
	for <connman@lists.linux.dev>; Thu, 23 Jan 2025 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632986; cv=none; b=OSZB9ss6l/NRO9n7MQkMvptArd6C2oVWs+ylJDLyA545Jm7soBmEgGTNe9/nTt32r//fSAhzXNNKJRfQFbLs94XxE/HyiTY92baTj7qBu1iBiNk5J4QOAo7AvNZuz/MdF8r3Ig7g3xQ9bKoHemGQWumKQr/3OnhXY2jZEaMt3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632986; c=relaxed/simple;
	bh=VW6YhZRpJv71HNizkSq8127vS71E/rckcG6Zet6OUtA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dVSRIn5hdYlBKbdeDYEcMJ9q1x2D0hQYNZctf/ygVst0HSJef8J0qnmUSAWtsOQxxl+m+LdOsVfhMINgUPOdFu2XHAHgdUE7yGTPH/ZlJDTBX7bZbJ6jrcdhU1yUdNQTlSavnOauUNDt6YlHMgUqc0vxN/Sak0ZDY48owe1C030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NORgiI29; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NORgiI29"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so9362035e9.0
        for <connman@lists.linux.dev>; Thu, 23 Jan 2025 03:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737632982; x=1738237782; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9547NQ16hjDHM+695ZKEmhcWxo6gZbWfQDkc4UyaaY=;
        b=NORgiI29bwJLJxHw/xoW3Q8ozOzYK56GMrk9rNsdQ9hg6+v5Dw98C/5lNdj+QtDhNe
         0IiX56CWwQKE+gVUhuvQRxu0HmE4qvU6K02eX9e424xp+GihUcdfuH51dN57LI/5b1w/
         xR6kbJeXxY2RQHAn57fFe1l32Du1ZSKvqa58/sKKG/REtPOfFqpYLKJomUNjbrGJQEUI
         ON9/oE9b03CogQX3x/5P9Z9bvSBHREOudqjSTQStbT7wmAXUIGGDQaCumIaKdJo4dpvQ
         kjlYN0tuBf6ycHRYvvpcufp8E6oFV4W7DIqjAmPQjAH2DF1eHzKaagHwsIwf/QBiZCQW
         AmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632982; x=1738237782;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9547NQ16hjDHM+695ZKEmhcWxo6gZbWfQDkc4UyaaY=;
        b=VMcAsiJHqGyUHQkoMofoHQhv+y5B/u0DvdvH7+KU08eyyub1aDuu+KCnyfMoosSbso
         vTAfMMGKsXNchhz7/2DiWhQwtnKFx4/giB0ARiKja1QcMeBWaGqoZzwGIq8bKMqJ7k+C
         6B0uhxn4L+d5oEPiskaoYThO83//JCYRIowaqYiEv8FhVyO7Ev+DLh00WNXjYKjzGfaK
         XB39VIXKN47Pwi0q+Wnp3HQO9dvx4LKOpIUbEYG9aQqwIYR5PLlqVeWcgIx8zPKghSbm
         7CbXiNhbHhwvfe5R4WnJ+mZHjWGYMMUInohVqTrBqikiwR0VtxgsVjri52iOeCRmV1vZ
         TcNw==
X-Forwarded-Encrypted: i=1; AJvYcCX21/mqL7OvXnSDAoZ/9hpjgsEOoZkzPxGG4JSaNZU3Gqe94jD2ZsmTmEZdqhoJdkLz5+r9Tshl@lists.linux.dev
X-Gm-Message-State: AOJu0YykIcUxpE6SkRUI+jW5Dopr+pDMSu9Oxx+G6izXspayznRbLU72
	w8ulh+dUENg2BgUy3lZyR/RmEhlJkjI637atvWDVcCPPYlGE/F0/
X-Gm-Gg: ASbGncv4ISw0TXcR+DlTMp7iPR/DKQqPPX7DdZrkZsU3qitEUpLDcnEBxtcT2eoiWVm
	h8anl+2yt0lO8oKxnirHMh/G1Sv9D75EX0AClsePVVunFX6Uod2V3K2yLiJKw4OdzyQ2A3PssBn
	OmuDkISARoHEIxDBCdV2xZoKG0NKh4n5jdZ/EGQ4ySdbSF4+W+XwqtuKvIZmcfr+HsG7ePPhueb
	PlgUoaog42jzitbR71kib1dJkcbxkkcPTFlwmnYYgM6kSU/pkDRMZ8WfdFXBNwWv6qTlq+MXf5k
	kceeXZ7uxQp+1dL/HeERs8wwYQo=
X-Google-Smtp-Source: AGHT+IG+gVNkl4eJjjvJEHoGLlHU8pqM+3ZTWh0IPCpF52SqBymoPAoUaO9boucyjivhaMb3DrXb4A==
X-Received: by 2002:a05:600c:1988:b0:434:fddf:5bfa with SMTP id 5b1f17b1804b1-438913bf072mr225913675e9.2.1737632981986;
        Thu, 23 Jan 2025 03:49:41 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31a324asm58870285e9.14.2025.01.23.03.49.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2025 03:49:41 -0800 (PST)
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
In-Reply-To: <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
Date: Thu, 23 Jan 2025 15:49:28 +0400
Cc: daniel antoine <univac55@gmail.com>,
 Grant Erickson <gerickson@nuovations.com>,
 Gabriel Sanches <gabriel.sanches@prevas.dk>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <418557AF-4801-44C8-9099-096A0BAD8110@gmail.com>
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
 <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
 <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com>
 <DA3FEE9B-62E5-4A2E-920F-ADFAE67CDB9A@gmail.com>
 <151b7546-a12c-4383-96e7-a6099a7a298f@jolla.com>
 <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3826.200.121)

Ignore: =
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=3D90=
592f7a58358a98bde5df6928e2b871041c12bc

So I think this is not the feature I=E2=80=99m thinking of, as it =
discusses Endpoint re-resolving.

The challenge our users have is =E2=80=98Host=E2=80=99 which currently =
must be an IP address. Upstream WireGuard with wg-quick etc. allows an =
FQDN. I see users that need to connect to home locations on dynamic IPs =
where Host will periodically change. I also see users with commercial =
VPN services which use an FQDN in the (upstream) wireguard configuration =
format and this resolves to multiple A records (round-robin balancing) =
and the =E2=80=98static=E2=80=99 IPs move around in their ASN range over =
time in an an attempt to mitigate (poor) IP reputation issues.

Christian


> On 23 Jan 2025, at 3:35=E2=80=AFpm, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>=20
> Looking here: =
https://git.kernel.org/pub/scm/network/connman/connman.git/log/ I=E2=80=99=
m not finding "wireguard: Regular reresolve endpoint address=E2=80=9D =
and the first page of log goes back to December =E2=80=9923. Are we =
using the wrong upstream?
>=20
> Christian
>=20
>> On 23 Jan 2025, at 3:22=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>=20
>> Hi Christian,
>>=20
>> That is actually in upstream, all the commits regarding WireGuard =
before July 10, 2024 are taken from the latest upstream and the changes =
after that are new features.
>>=20
>> Well, the vpn.c changes do depend on having the ASSOCIATION state =
also for VPNs to be implemented, that was proposed in the RFC =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97 as the state =
transitions depend on that bit. But it does not seem to be depending on =
the gateway.c/connection.c. Well, I can try to squeeze time to address =
the issues Daniel earlier raised on that RFC and push them to upstream, =
then make a big change on the vpn.c and wireguard.c.
>>=20
>> Br,
>> Jussi
>>=20
>>=20
>> On 1/23/25 13:12, Christian Hewitt wrote:
>>> You don't often get email from christianshewitt@gmail.com. Learn why =
this is important<https://aka.ms/LearnAboutSenderIdentification>
>>> Ohh.. I would be VERY keen to see support for FQDN=E2=80=99s =
resolving to dynamic IP=E2=80=99s upstreamed so this looks interesting:
>>> =
https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d703f972=
b866fdbd8bd
>>> Is that feature dependent on any other changes? (being lazy.. I =
didn=E2=80=99t read all the commits in that branch yet!).
>>> Christian
>>> On 23 Jan 2025, at 3:06=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>> Hello,
>>> Regarding WireGuard, I had to make a bunch of changes to the latest =
version of it to get it running properly on our fork (yes, we upgrade it =
slowly, now 1.38): =
https://github.com/sailfishos/connman/commits/master/connman/vpn
>>> But I haven't had time to figure out all that is needed for upstream =
to be sent first, like this RFC edit that was forgotten because of... =
"eastern winds blowing into our direction": =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97
>>> And then the connection.c was modified a lot (and renamed) and I'm =
not sure if these will work on top of that anymore. Mostly because we =
have features that may not have been compatible with latest upstream, =
like adding a support  for two different devices to be belonging into =
one service to facilitate CLAT support =
https://github.com/sailfishos/connman/commits/master/connman/src/connectio=
n.c etc. etc. etc.
>>> At some point I'll start pushing changes but not sure when I have =
time. Mostly they could be RFCs as the changes are big.
>>> BR,
>>> Jussi
>>> On 1/23/25 12:45, daniel antoine wrote:
>>> Hi
>>> I have opened a ticket for connman-vpn not working with wireguard  =
in
>>> April 2024. If you give me the patches I can test them
>>> Best regards
>>> Daniel
>>> Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
>>> <gerickson@nuovations.com> a =C3=A9crit :
>>> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches =
<gabriel.sanches@prevas.dk> wrote:
>>> I was testing connman's wireguard plugin and got a segmentation =
fault.
>>> Looking at the backtrace revealed that there are some typos in the =
`src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 =
variables instead of ipv6 regarding vpn.
>>> I simply changed them to ipv6 and got it working.
>>> not related to the patch:
>>> I had to manually add ip route so the other devices could be pinged
>>> The plugin adds routes for the WireGuard.DNS configuration setting
>>> # ip route
>>> 1.1.1.1 dev wg0 scope link
>>> 8.8.8.8 dev wg0 scope link
>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
>>> 10.42.0.1 dev end1 scope link
>>> <vpn host ip> via 10.42.0.1 dev end1
>>> the missing route added manually:
>>> ip route add 10.33.0.0/16 dev wg0 scope link
>>> an equivalent wireguard file adds it properly (using wg-quick)
>>> Is the plugin lacking some implementation?
>>> ---
>>> src/gateway.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>> diff --git a/src/gateway.c b/src/gateway.c
>>> index 16c87f83..b2c211e2 100644
>>> --- a/src/gateway.c
>>> +++ b/src/gateway.c
>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct =
connman_service *service,
>>>                                      is_gateway_config_vpn(
>>>                                              =
new_gateway->ipv4_config);
>>> -             is_vpn6 =3D do_ipv4 &&
>>> -                                     new_gateway->ipv4_config &&
>>> +             is_vpn6 =3D do_ipv6 &&
>>> +                                     new_gateway->ipv6_config &&
>>>                                      is_gateway_config_vpn(
>>> -                                             =
new_gateway->ipv4_config);
>>> +                                             =
new_gateway->ipv6_config);
>>>      } else {
>>>              if (do_ipv4 && new_gateway->ipv4_config)
>>> --
>>> 2.43.0
>>> Gabriel,
>>> Great catch on this copy-and-paste typo; thank you!
>>> Best,
>>> Grant
>>=20
>=20

