Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BCD381AF
	for <connman@lists.linux.dev>; Thu, 23 Jan 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632175; cv=none; b=NK0n5vXuiC/PwWOMym4e53B3NSPiIsdes9RNOgbAArW4I9zKjcKi5M6pYSdvWMDFKkn1MR/bHTXBYJrfBcPs+lIbJCr/1VMa9LSw6w40+7yute1vqbixzuGsonuqAVcrFcHlh0lV3eNdOK5fJJGnsnev7Uyh0b0GNHR96gd8wpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632175; c=relaxed/simple;
	bh=bawGTjT/wVe7/f88jZWw2QtkaeiAFI2UwZFAsRoJB20=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jDWzwUjBbCYVR6wBmVflgHQqQ7WbBNZ+deAbdzKPI90XuBsL/MxdBujrW1oj2oxgDMxFQtrTI0S4UpL89dZd85YrBVauJFbomJ3/6jreTcIV6nKTf/6UlsU2XnpJVoGOEmAhGy/WDjaXXEC+5uRjVBo97aary3OIbSn7IOnw6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEf975KS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEf975KS"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38a34e8410bso413365f8f.2
        for <connman@lists.linux.dev>; Thu, 23 Jan 2025 03:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737632171; x=1738236971; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etF6uGbGXxEKWiXwAqNZMkyOudMG8ipSIfSMSOiAz1U=;
        b=EEf975KSBTsHNcVb0youhnw89i6lCYD+a9UdH+Yrouv/IfC3HHGxVaGMxMMKB5zAGW
         k89ecEWPKZJDzg9NCiyoEWLRde75c74r1KMYnLk5RZS4GBwvztBc6xJUiCuTvWP1z4Q+
         PfnWvcKkviDLclqdA4QHvJa15Fv09gZQY5MaM1ohSYeI1tgHxsTuXEA6CmHbF+6zzzXc
         vG0M6K7lcuAEBFRxQ15rExbpRyIDxWsfxtAo1wxwMay4n9yaOr4WlNdwH0MICX/gCFit
         Syh+migRGL7JB5+HSyz4PbzKwcPcelawnYtVJzYgYCgemYtBmd4t7KBxBrHoijw5vbJa
         zDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632171; x=1738236971;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etF6uGbGXxEKWiXwAqNZMkyOudMG8ipSIfSMSOiAz1U=;
        b=JN70JIqAZwWmHmtH+2kIm2Spa7cCr5FHuYGJLSsXyQZnh8ok+Pq2J6ga1g4Zfvanwx
         CEtmyxoN0PSPryXZoZMUe/qlHhMFh/dY3kVjeWucIY/FO3lZMxGQKy5siOOSSDha5nrw
         IFFOWeN4/rHhzW5TRRcJmixRJtUlsz5TmHkhJrKuI8JXhTtQvyWZ4oNEvpVMgz+eHmka
         1+RBI9+4awhJI3baS5AP33UDzSMc1VyuaNW9x9pTvNdfCdF3cyX8O+m8O4U/owiY6b3S
         x3hFVhjWwBQfqjbh3CW8s3ZPiK2pVQLrekQ0Q0kzKOeY6lI5S9xe0vGiHNE2uvyy4SGQ
         bWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMmdyR1UZdkyGlZLzl1isPAvble6UnjZ8ic5UNKu70xzfrMfZgZF4/BRX/0x9EtlhuSdXRG8iR@lists.linux.dev
X-Gm-Message-State: AOJu0YyxBrrYSOjiVYBKAWVEvsssM5P6hHwKMPDQ4r5HmXmOBRX1o3zd
	Vl4Uoj/r+uaH+v2VORAUzlRqw3LHVdDoNuNTzTSDwcwEV/DyenzB
X-Gm-Gg: ASbGnctGAT/9hqGzerXiX1cNoiZ6boGn6LH0Uv1oGbeDaU655pANUgcJXV0jAyrwVx6
	Z1KVWpBS1FBLmMXReNifxGUpgOPLnboqoFLWUcZpmu5hnizlRd2s+GLiLKkeMeSjzETAl6MPeb8
	lUoiSWnlSEjXKmxo9jXsAlJ2BuQwnNUu/8eneZzKdqtcDxGEWFuM6+YxTFJshMv/sVZu1PwGMW1
	S//wIJk+6B3MaC+CDDjvFC2t9b6D2fx3pteUyb7biVcpmG1Y6bDi6H9rLaOQ+GApUjzuxcxx2pL
	8IhgF/rvZ3fXR4Ingt9/Qp6LcQw=
X-Google-Smtp-Source: AGHT+IEU+AhI1LPTMlBAZhdfkmR2enC56rLSSq7c1rzidH8mWKvqC7GLYK1D/el7nk+baUDLHMW1cw==
X-Received: by 2002:a05:6000:186f:b0:38a:9ffb:fe2f with SMTP id ffacd0b85a97d-38bf55be471mr23011179f8f.0.1737632170958;
        Thu, 23 Jan 2025 03:36:10 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32222d1sm19093221f8f.38.2025.01.23.03.36.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2025 03:36:09 -0800 (PST)
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
In-Reply-To: <151b7546-a12c-4383-96e7-a6099a7a298f@jolla.com>
Date: Thu, 23 Jan 2025 15:35:56 +0400
Cc: daniel antoine <univac55@gmail.com>,
 Grant Erickson <gerickson@nuovations.com>,
 Gabriel Sanches <gabriel.sanches@prevas.dk>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B68D8F3-1636-472F-8496-614B85AE52CE@gmail.com>
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
 <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
 <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com>
 <DA3FEE9B-62E5-4A2E-920F-ADFAE67CDB9A@gmail.com>
 <151b7546-a12c-4383-96e7-a6099a7a298f@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3826.200.121)

Looking here: =
https://git.kernel.org/pub/scm/network/connman/connman.git/log/ I=E2=80=99=
m not finding "wireguard: Regular reresolve endpoint address=E2=80=9D =
and the first page of log goes back to December =E2=80=9923. Are we =
using the wrong upstream?

Christian

> On 23 Jan 2025, at 3:22=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>=20
> Hi Christian,
>=20
> That is actually in upstream, all the commits regarding WireGuard =
before July 10, 2024 are taken from the latest upstream and the changes =
after that are new features.
>=20
> Well, the vpn.c changes do depend on having the ASSOCIATION state also =
for VPNs to be implemented, that was proposed in the RFC =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97 as the state =
transitions depend on that bit. But it does not seem to be depending on =
the gateway.c/connection.c. Well, I can try to squeeze time to address =
the issues Daniel earlier raised on that RFC and push them to upstream, =
then make a big change on the vpn.c and wireguard.c.
>=20
> Br,
> Jussi
>=20
>=20
> On 1/23/25 13:12, Christian Hewitt wrote:
>> You don't often get email from christianshewitt@gmail.com. Learn why =
this is important<https://aka.ms/LearnAboutSenderIdentification>
>> Ohh.. I would be VERY keen to see support for FQDN=E2=80=99s =
resolving to dynamic IP=E2=80=99s upstreamed so this looks interesting:
>> =
https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d703f972=
b866fdbd8bd
>> Is that feature dependent on any other changes? (being lazy.. I =
didn=E2=80=99t read all the commits in that branch yet!).
>> Christian
>> On 23 Jan 2025, at 3:06=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>> Hello,
>> Regarding WireGuard, I had to make a bunch of changes to the latest =
version of it to get it running properly on our fork (yes, we upgrade it =
slowly, now 1.38): =
https://github.com/sailfishos/connman/commits/master/connman/vpn
>> But I haven't had time to figure out all that is needed for upstream =
to be sent first, like this RFC edit that was forgotten because of... =
"eastern winds blowing into our direction": =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97
>> And then the connection.c was modified a lot (and renamed) and I'm =
not sure if these will work on top of that anymore. Mostly because we =
have features that may not have been compatible with latest upstream, =
like adding a support  for two different devices to be belonging into =
one service to facilitate CLAT support =
https://github.com/sailfishos/connman/commits/master/connman/src/connectio=
n.c etc. etc. etc.
>> At some point I'll start pushing changes but not sure when I have =
time. Mostly they could be RFCs as the changes are big.
>> BR,
>> Jussi
>> On 1/23/25 12:45, daniel antoine wrote:
>> Hi
>> I have opened a ticket for connman-vpn not working with wireguard  in
>> April 2024. If you give me the patches I can test them
>> Best regards
>> Daniel
>> Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
>> <gerickson@nuovations.com> a =C3=A9crit :
>> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches =
<gabriel.sanches@prevas.dk> wrote:
>> I was testing connman's wireguard plugin and got a segmentation =
fault.
>> Looking at the backtrace revealed that there are some typos in the =
`src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 =
variables instead of ipv6 regarding vpn.
>> I simply changed them to ipv6 and got it working.
>> not related to the patch:
>> I had to manually add ip route so the other devices could be pinged
>> The plugin adds routes for the WireGuard.DNS configuration setting
>> # ip route
>> 1.1.1.1 dev wg0 scope link
>> 8.8.8.8 dev wg0 scope link
>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
>> 10.42.0.1 dev end1 scope link
>> <vpn host ip> via 10.42.0.1 dev end1
>> the missing route added manually:
>> ip route add 10.33.0.0/16 dev wg0 scope link
>> an equivalent wireguard file adds it properly (using wg-quick)
>> Is the plugin lacking some implementation?
>> ---
>> src/gateway.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>> diff --git a/src/gateway.c b/src/gateway.c
>> index 16c87f83..b2c211e2 100644
>> --- a/src/gateway.c
>> +++ b/src/gateway.c
>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct =
connman_service *service,
>>                                       is_gateway_config_vpn(
>>                                               =
new_gateway->ipv4_config);
>> -             is_vpn6 =3D do_ipv4 &&
>> -                                     new_gateway->ipv4_config &&
>> +             is_vpn6 =3D do_ipv6 &&
>> +                                     new_gateway->ipv6_config &&
>>                                       is_gateway_config_vpn(
>> -                                             =
new_gateway->ipv4_config);
>> +                                             =
new_gateway->ipv6_config);
>>       } else {
>>               if (do_ipv4 && new_gateway->ipv4_config)
>> --
>> 2.43.0
>> Gabriel,
>> Great catch on this copy-and-paste typo; thank you!
>> Best,
>> Grant
>=20

