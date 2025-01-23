Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB63F38F83
	for <connman@lists.linux.dev>; Thu, 23 Jan 2025 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638180; cv=none; b=LqZpsqjJ8gPl4aRWg0eBGqJFo9yDSp2oPf9P/NKClwYQPAAFIiaazWPjf+GPOZgnnaQUKOvZQIZ4RGqEK6Aadc5pTmPVAj09muwWTc9Qzg74lInvfKs7uOjDn5Iu+PTzPOMiZuvoUrsKkV9ENTWD1uIOsEa0Qf+/PgFh/ygSvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638180; c=relaxed/simple;
	bh=35xTSrMhHkLLFt1CTG7Hdf3mcAZdfDnX4aH+iglICTk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ky2S04yrC3L9zfLHcknC+snJyLdnm0oT6rB4Wtv2uXq0/KUBBIuUfcKeLvgqD2p2Qd+74bA+PtmOlP6GdOg457mkJAA6ehxHD2hWsA+nG7c5rb3PMUuMBpkhQRkmdi5Lm3feyKbSZqSQB6L7D79RvCCdYF1YD2kwlM2/qiQ1i+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPo/qGo3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPo/qGo3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso6061715e9.3
        for <connman@lists.linux.dev>; Thu, 23 Jan 2025 05:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737638177; x=1738242977; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oT9tdqHykaWw8X5XdgPf6O1PqF7pqoR8nLHtmA7aoYE=;
        b=DPo/qGo3pB96HpCA1KsfUumd6t3WwJ5yp2qDjAUS7fWB9UpX+YAs8qF3G4dmnJGCCn
         vn93ZzVY0L2OuTqqDMjBbZZuLTgX0CDQsGH8VIW1uJHJAzihrM50Mp9VLWnB9mYWYFer
         KgpTCWOSoN+mnJyJji8KJKwBB8GKC7n64pwcbrbPMDRS9FcWqbxPBbzReDn98u8YONUz
         T/arsMw5+FUxMAZoiaKSu50Xk/GobyO5lkUhNO54UF+TyyfzxsJJ0A/q68HJ4DXetijK
         aVx3S6wYTcH5ItImXbCO0m+a3F1CHR9J2YUmfRS84McA6b7fPxvE5aKv5uUFnondiJWT
         ia2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638177; x=1738242977;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oT9tdqHykaWw8X5XdgPf6O1PqF7pqoR8nLHtmA7aoYE=;
        b=RUW9JNLHT/zg0Y8XDwOXfUs38MM+ansFg2/G2Z7IvHJBMnQvU5/SuzFjpjkkOMGnic
         nFUeRf54UVcHcXjdnMCaYyYqYvZ/2T5+kMoSL+awNVngAA21SBhGyOKTHY/b85mUeyZx
         wQ4c3bpjYQzl3TupS+0FmqL9keHXJjf05XZCPk3Kdm5W9AEZiqURM8QCEIe3IRdhzrTh
         hSiQ3GN05n2AU03v4BaC3jEJQMATklhSUGdi5XFt1r2lFBwIPT0gpdftC3c5rOTBIEfb
         8/17EOSToL/eN2bKZB2JFiaBHz6rxWTLp8j7hW1g7R/wXNiWlb1bU5z8G8TXYBP/51WE
         7wJw==
X-Forwarded-Encrypted: i=1; AJvYcCWtubzbUFcjpukc1Si076s20qEuBAEEJnsgva7rGjRmfN4dxd8Ckjtf6AJIf7JPzZ4qxsX0x/6G@lists.linux.dev
X-Gm-Message-State: AOJu0Yxv26MHgi98PahE0J3bLyth7V2/hZWFmtXuGw2z+2IWYz6GpTo8
	G6MLoLRUGYzMf1SLvHmF3bvuhGAqV5WzIHznSl7ulYnTmxCrFi82MX2Ks3mD
X-Gm-Gg: ASbGncsctpnvWcW5pl998mvbk79Z9iG+HZY3ooVniXVAnFt0RYa4kgf0bgRDTj6wSBX
	t2X8mLrVTZKfqE7V23CRpJrdwqyIERA9LNlOmFJBaBHVPoiTMGgVWq45Mdc9mBxTza8ApIWBpLZ
	u5GOdDeFOcAxD9W0UQcmKbpUnD7qy2x9wFtj/5UtoWDxzACw5BMR2+QQpfyFkvwIy6ZEzgQFLn+
	W//h3IFZMkiXMFljpDjM3FT+8Z7CfsrqrMgjzc7/9l1iQzl4XIJ36Es9jpxbEm3ybx255GsuEeR
	jGNeKtmsGaAPb7C2unJ8Wkc8FTe6QCk=
X-Google-Smtp-Source: AGHT+IEQWxHt6mnMgBDrIkgiOZP7CUjpckewp5HkzZjF/lVh2rZ9WOMDk/XpeS56EaOlsW1/MnKgOw==
X-Received: by 2002:a5d:6c6f:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-38bf566e691mr24115379f8f.3.1737638176827;
        Thu, 23 Jan 2025 05:16:16 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32222d1sm19323994f8f.38.2025.01.23.05.16.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2025 05:16:16 -0800 (PST)
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
In-Reply-To: <d10885e3-539e-4be1-8c33-c6028d55c7ef@jolla.com>
Date: Thu, 23 Jan 2025 17:16:03 +0400
Cc: daniel antoine <univac55@gmail.com>,
 Grant Erickson <gerickson@nuovations.com>,
 Gabriel Sanches <gabriel.sanches@prevas.dk>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5116CCA9-DA26-4D73-BBA6-C89D58F0B4AC@gmail.com>
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
 <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
 <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com>
 <DA3FEE9B-62E5-4A2E-920F-ADFAE67CDB9A@gmail.com>
 <151b7546-a12c-4383-96e7-a6099a7a298f@jolla.com>
 <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
 <418557AF-4801-44C8-9099-096A0BAD8110@gmail.com>
 <d10885e3-539e-4be1-8c33-c6028d55c7ef@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3826.200.121)

It=E2=80=99s not impossible, but definitely less convenient. There are =
some messy script workarounds in our forum and a regular drip-feed of =
people reporting WireGuard connects but doesn=E2=80=99t work; because =
they configured Host with an FQDN.

I=E2=80=99m going to have a play with your fork to see if that meets our =
needs. If yes, I won=E2=80=99t be switching LibreELEC as we love =
upstream sources not forks, but I=E2=80=99ll be enquiring how we can =
bribe you into upstreaming the required changes :)

Christian

> On 23 Jan 2025, at 4:08=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>=20
> Ok, right. I get your point, if that feature is missing it will be =
quite impossible to use WG.
>=20
> Our version with the changes does handle that, and also requires CIDR =
format for IP address, well, check is a bit rudimentary:
> =
https://github.com/sailfishos/connman/blob/master/connman/vpn/plugins/wire=
guard.c#L201 but since all goes through getaddrinfo() checks it should =
work if DNS is working on the transport medium.
>=20
> - Jussi
>=20
>=20
>=20
> On 1/23/25 13:49, Christian Hewitt wrote:
>> Ignore: =
https://git.kernel.org/pub/scm/network/connman/connman.git/commit/?id=3D90=
592f7a58358a98bde5df6928e2b871041c12bc
>> So I think this is not the feature I=E2=80=99m thinking of, as it =
discusses Endpoint re-resolving.
>> The challenge our users have is =E2=80=98Host=E2=80=99 which =
currently must be an IP address. Upstream WireGuard with wg-quick etc. =
allows an FQDN. I see users that need to connect to home locations on =
dynamic IPs where Host will periodically change. I also see users with =
commercial VPN services which use an FQDN in the (upstream) wireguard =
configuration format and this resolves to multiple A records =
(round-robin balancing) and the =E2=80=98static=E2=80=99 IPs move around =
in their ASN range over time in an an attempt to mitigate (poor) IP =
reputation issues.
>> Christian
>>> On 23 Jan 2025, at 3:35=E2=80=AFpm, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>>>=20
>>> Looking here: =
https://git.kernel.org/pub/scm/network/connman/connman.git/log/ I=E2=80=99=
m not finding "wireguard: Regular reresolve endpoint address=E2=80=9D =
and the first page of log goes back to December =E2=80=9923. Are we =
using the wrong upstream?
>>>=20
>>> Christian
>>>=20
>>>> On 23 Jan 2025, at 3:22=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>>>=20
>>>> Hi Christian,
>>>>=20
>>>> That is actually in upstream, all the commits regarding WireGuard =
before July 10, 2024 are taken from the latest upstream and the changes =
after that are new features.
>>>>=20
>>>> Well, the vpn.c changes do depend on having the ASSOCIATION state =
also for VPNs to be implemented, that was proposed in the RFC =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97 as the state =
transitions depend on that bit. But it does not seem to be depending on =
the gateway.c/connection.c. Well, I can try to squeeze time to address =
the issues Daniel earlier raised on that RFC and push them to upstream, =
then make a big change on the vpn.c and wireguard.c.
>>>>=20
>>>> Br,
>>>> Jussi
>>>>=20
>>>>=20
>>>> On 1/23/25 13:12, Christian Hewitt wrote:
>>>>> You don't often get email from christianshewitt@gmail.com. Learn =
why this is important<https://aka.ms/LearnAboutSenderIdentification>
>>>>> Ohh.. I would be VERY keen to see support for FQDN=E2=80=99s =
resolving to dynamic IP=E2=80=99s upstreamed so this looks interesting:
>>>>> =
https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d703f972=
b866fdbd8bd
>>>>> Is that feature dependent on any other changes? (being lazy.. I =
didn=E2=80=99t read all the commits in that branch yet!).
>>>>> Christian
>>>>> On 23 Jan 2025, at 3:06=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>>>>> Hello,
>>>>> Regarding WireGuard, I had to make a bunch of changes to the =
latest version of it to get it running properly on our fork (yes, we =
upgrade it slowly, now 1.38): =
https://github.com/sailfishos/connman/commits/master/connman/vpn
>>>>> But I haven't had time to figure out all that is needed for =
upstream to be sent first, like this RFC edit that was forgotten because =
of... "eastern winds blowing into our direction": =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97
>>>>> And then the connection.c was modified a lot (and renamed) and I'm =
not sure if these will work on top of that anymore. Mostly because we =
have features that may not have been compatible with latest upstream, =
like adding a support  for two different devices to be belonging into =
one service to facilitate CLAT support =
https://github.com/sailfishos/connman/commits/master/connman/src/connectio=
n.c etc. etc. etc.
>>>>> At some point I'll start pushing changes but not sure when I have =
time. Mostly they could be RFCs as the changes are big.
>>>>> BR,
>>>>> Jussi
>>>>> On 1/23/25 12:45, daniel antoine wrote:
>>>>> Hi
>>>>> I have opened a ticket for connman-vpn not working with wireguard  =
in
>>>>> April 2024. If you give me the patches I can test them
>>>>> Best regards
>>>>> Daniel
>>>>> Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
>>>>> <gerickson@nuovations.com> a =C3=A9crit :
>>>>> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches =
<gabriel.sanches@prevas.dk> wrote:
>>>>> I was testing connman's wireguard plugin and got a segmentation =
fault.
>>>>> Looking at the backtrace revealed that there are some typos in the =
`src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 =
variables instead of ipv6 regarding vpn.
>>>>> I simply changed them to ipv6 and got it working.
>>>>> not related to the patch:
>>>>> I had to manually add ip route so the other devices could be =
pinged
>>>>> The plugin adds routes for the WireGuard.DNS configuration setting
>>>>> # ip route
>>>>> 1.1.1.1 dev wg0 scope link
>>>>> 8.8.8.8 dev wg0 scope link
>>>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
>>>>> 10.42.0.1 dev end1 scope link
>>>>> <vpn host ip> via 10.42.0.1 dev end1
>>>>> the missing route added manually:
>>>>> ip route add 10.33.0.0/16 dev wg0 scope link
>>>>> an equivalent wireguard file adds it properly (using wg-quick)
>>>>> Is the plugin lacking some implementation?
>>>>> ---
>>>>> src/gateway.c | 6 +++---
>>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>>> diff --git a/src/gateway.c b/src/gateway.c
>>>>> index 16c87f83..b2c211e2 100644
>>>>> --- a/src/gateway.c
>>>>> +++ b/src/gateway.c
>>>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct =
connman_service *service,
>>>>>                                      is_gateway_config_vpn(
>>>>>                                              =
new_gateway->ipv4_config);
>>>>> -             is_vpn6 =3D do_ipv4 &&
>>>>> -                                     new_gateway->ipv4_config &&
>>>>> +             is_vpn6 =3D do_ipv6 &&
>>>>> +                                     new_gateway->ipv6_config &&
>>>>>                                      is_gateway_config_vpn(
>>>>> -                                             =
new_gateway->ipv4_config);
>>>>> +                                             =
new_gateway->ipv6_config);
>>>>>      } else {
>>>>>              if (do_ipv4 && new_gateway->ipv4_config)
>>>>> --
>>>>> 2.43.0
>>>>> Gabriel,
>>>>> Great catch on this copy-and-paste typo; thank you!
>>>>> Best,
>>>>> Grant
>>>>=20
>>>=20
>=20

