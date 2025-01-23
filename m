Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345111CAA75
	for <connman@lists.linux.dev>; Thu, 23 Jan 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630854; cv=none; b=u/635yzOIGaLn2mLg3I9a4iWAh/6ydFL0GyXF0RhDm1T4Ck1niMkfIg674f6P2B/ZCyagk69B5nV2asa62ugv810i0KPbZ9et+pTBZY+tRWN0rSXIF1B+tWOr6xRSuXI0bCV6o7k9Ier8iO9ekK6mq3+gLVOF9tFpE+NIK6MglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630854; c=relaxed/simple;
	bh=6Z85pc1lwYiaoCKxE4i8vfdcYUgRulz2+SmV3YluJ78=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=C5ZG1YGao3/Q+E8qqeYCXDPaGurNdfuvmSl0GsXLSklspjcUSNtY3SIbsjxmtVjJVJv1jzEO35Od5uf+H5K8Jkv9qcodOhsU/cGsfuNpaPD4daKWmjtRE46kfyv0ZVeuMt9w1W2e7Rt2E/8nvH0RNXHfry8yZ3zni7rUQldUlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+StvcYG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+StvcYG"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38637614567so350781f8f.3
        for <connman@lists.linux.dev>; Thu, 23 Jan 2025 03:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737630851; x=1738235651; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt8Exbn0MfaDQtjjXd5BFj1njnTvb4WV93vBabHp4Qs=;
        b=j+StvcYGTt49vEdP3BW0TA5sBG4MZ2x91FGsnzYro5TswsL+wqqs902BGkEIqoqBTC
         MXhg76uuvhEfp4+RXBmFGc+wit2nXbExClVIC6XhQjNuBkP6F0yMFMexoeu+N8KpsrEz
         zs5qPUNwXl6T+de0P3zgaYMktByv8vZ5u8NAeHfEFcGEcklqx8Y9aClaIUpmfxAA4HIp
         5IetUBfCwCANi6BW+bYoQsXajcUfL//I6zxiCHdJaQ5tucOfJcLILQ8mbOd7TdFs4bVF
         WJZbcE3tPsgxauh3AgQEyzS2SRIfrnrY71/9OxIB1NPWQElb6rCSzkn3oRMQOmjgo6Zg
         04Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737630851; x=1738235651;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt8Exbn0MfaDQtjjXd5BFj1njnTvb4WV93vBabHp4Qs=;
        b=KxcXai73/RDqDes9bTn1vkqLtEOhe+fjjAdEN2F+m4wpghu/5Lr9stX/tROoE2mWdc
         j+4oNIhP+eWWoqSZsS9vFoEt2USL6rhNkbCD3zFfAve+/lRB33tNbNvxo4hMTTistl9y
         mM9IlZIVfA9n7vzPnVTYVI5mI2VeNKervAV2QyOodxvYbe2xckQ2s/e/sIqkEKZTuyIR
         RsIZsZLvxH5YygViJ+etI/wCRSKRg1NjBqu4hv/ItZiWU6ZtMGRAYq2S3eTVXbrzRAt0
         B3orYyq6OhOKFBlLnmAkay+D3Vl39MYHPAFhyCLXY26c/UItfS4c4xIkCZt8SPxQwEpL
         K09A==
X-Forwarded-Encrypted: i=1; AJvYcCXahmOWYjUR9xNU2nrX55dYb8VljSeuB/ojjSA1sqFEn0F2lVcZ/TRaWNoF4/6kPUQqx2JCs5IA@lists.linux.dev
X-Gm-Message-State: AOJu0YyADDVchojx8f0esj4xCif8S6shrTmFokrErv9Go/6GZbGWEJZm
	fUzQusCvu828EHxFUZzjAEsYDaEtwOjv+j1i3wwUPjvpkpikrBhT
X-Gm-Gg: ASbGncu47V9g9l5WZowpo0YI9MrbzqbpyinQbhL6G/yOcv/m6+i4XMOIKCdfHVjXyUO
	qr5wccF0A+VTP1xu9LKn2qlSgB4p4GejrrcPHV7ChBm+mW1dxi9nUvNV+Zi6P1oo6WyfkoHV/Uw
	HqT1pfXbi1pjXJsDDOv6XjL+fEoOz5/lT085Fq2capzAGaRjxR8P2f4VGgY49QmV+uTzhmXqoUP
	wwjdkmZxJCaBn9tnCPmPzuSdaEog3ZBvQzD+tiDVcuoDkkuJvunyETEx3IzZDLyCADLNDFOQZe3
	vfZy0luEg6IjQwEANFKuU6knUlOB4mUdhmv37A==
X-Google-Smtp-Source: AGHT+IEE8MOqGyfCnFOboC1QEZ+lJxWCduK0RhZpyY77zM/srbVTFoyC6zFNSygV2w99+V6wEXIYRw==
X-Received: by 2002:adf:cc90:0:b0:38a:4b8a:e47d with SMTP id ffacd0b85a97d-38bf5674f99mr18267832f8f.26.1737630851338;
        Thu, 23 Jan 2025 03:14:11 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327dee3sm18716256f8f.86.2025.01.23.03.14.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2025 03:14:10 -0800 (PST)
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
In-Reply-To: <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com>
Date: Thu, 23 Jan 2025 15:13:57 +0400
Cc: daniel antoine <univac55@gmail.com>,
 Grant Erickson <gerickson@nuovations.com>,
 Gabriel Sanches <gabriel.sanches@prevas.dk>,
 "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F2A047E-FF86-498A-95E4-0FC0D1DC3C6D@gmail.com>
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
 <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
 <05bf9af0-ad84-4613-9f13-fa10579b9bd8@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
X-Mailer: Apple Mail (2.3826.200.121)

Ohh.. I would be VERY keen to see support for FQDN=E2=80=99s resolving =
to dynamic IP=E2=80=99s upstreamed so this looks interesting:

=
https://github.com/sailfishos/connman/commit/adb6ab2b49a2b822e6517d703f972=
b866fdbd8bd

Is that feature dependent on any other changes? (being lazy.. I didn=E2=80=
=99t read all the commits in that branch yet!).

Christian

> On 23 Jan 2025, at 3:06=E2=80=AFpm, Jussi Laakkonen =
<jussi.laakkonen@jolla.com> wrote:
>=20
> Hello,
>=20
> Regarding WireGuard, I had to make a bunch of changes to the latest =
version of it to get it running properly on our fork (yes, we upgrade it =
slowly, now 1.38): =
https://github.com/sailfishos/connman/commits/master/connman/vpn
>=20
> But I haven't had time to figure out all that is needed for upstream =
to be sent first, like this RFC edit that was forgotten because of... =
"eastern winds blowing into our direction": =
https://lore.kernel.org/connman/20221213140707.278313-5-jussi.laakkonen@jo=
lla.com/T/#mbced39d72dd424884fe105a66fea02a83c708f97
>=20
> And then the connection.c was modified a lot (and renamed) and I'm not =
sure if these will work on top of that anymore. Mostly because we have =
features that may not have been compatible with latest upstream, like =
adding a support  for two different devices to be belonging into one =
service to facilitate CLAT support =
https://github.com/sailfishos/connman/commits/master/connman/src/connectio=
n.c etc. etc. etc.
>=20
> At some point I'll start pushing changes but not sure when I have =
time. Mostly they could be RFCs as the changes are big.
>=20
> BR,
> Jussi
>=20
>=20
> On 1/23/25 12:45, daniel antoine wrote:
>> Hi
>> I have opened a ticket for connman-vpn not working with wireguard  in
>> April 2024. If you give me the patches I can test them
>> Best regards
>> Daniel
>> Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
>> <gerickson@nuovations.com> a =C3=A9crit :
>>>=20
>>> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches =
<gabriel.sanches@prevas.dk> wrote:
>>>> I was testing connman's wireguard plugin and got a segmentation =
fault.
>>>>=20
>>>> Looking at the backtrace revealed that there are some typos in the =
`src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 =
variables instead of ipv6 regarding vpn.
>>>>=20
>>>> I simply changed them to ipv6 and got it working.
>>>>=20
>>>> not related to the patch:
>>>> I had to manually add ip route so the other devices could be pinged
>>>> The plugin adds routes for the WireGuard.DNS configuration setting
>>>> # ip route
>>>> 1.1.1.1 dev wg0 scope link
>>>> 8.8.8.8 dev wg0 scope link
>>>> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
>>>> 10.42.0.1 dev end1 scope link
>>>> <vpn host ip> via 10.42.0.1 dev end1
>>>>=20
>>>> the missing route added manually:
>>>> ip route add 10.33.0.0/16 dev wg0 scope link
>>>>=20
>>>> an equivalent wireguard file adds it properly (using wg-quick)
>>>>=20
>>>> Is the plugin lacking some implementation?
>>>>=20
>>>> ---
>>>> src/gateway.c | 6 +++---
>>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/src/gateway.c b/src/gateway.c
>>>> index 16c87f83..b2c211e2 100644
>>>> --- a/src/gateway.c
>>>> +++ b/src/gateway.c
>>>> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct =
connman_service *service,
>>>>                                       is_gateway_config_vpn(
>>>>                                               =
new_gateway->ipv4_config);
>>>>=20
>>>> -             is_vpn6 =3D do_ipv4 &&
>>>> -                                     new_gateway->ipv4_config &&
>>>> +             is_vpn6 =3D do_ipv6 &&
>>>> +                                     new_gateway->ipv6_config &&
>>>>                                       is_gateway_config_vpn(
>>>> -                                             =
new_gateway->ipv4_config);
>>>> +                                             =
new_gateway->ipv6_config);
>>>>=20
>>>>       } else {
>>>>               if (do_ipv4 && new_gateway->ipv4_config)
>>>> --
>>>> 2.43.0
>>>=20
>>> Gabriel,
>>>=20
>>> Great catch on this copy-and-paste typo; thank you!
>>>=20
>>> Best,
>>>=20
>>> Grant
>>>=20
>>>=20
>=20

