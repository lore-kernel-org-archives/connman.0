Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B46FA1
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWnEBFQm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3333074512bso147242f8f.1
        for <connman@lists.linux.dev>; Tue, 05 Dec 2023 19:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701833121; x=1702437921; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjA1lOjqaVmYeh3NEm8JdohyaQEblB9GErmPC0P9KxE=;
        b=UWnEBFQmAp0a0Bh72G2Atpjwao150VTH1zwNsgl+DCxRxtEwkJtpNpApyjWiOCP4qK
         LDLjiKA2k+Q7PwICSZnuW0x2Zg2HEKiCFWVEKD1nZCTMoLKClxHrXlMO21OH3kkuSMXq
         H9VA6kxqDm2M8vTU06YsLDbeB2j0ZFNXfe8Ltt23JjPpg1io6SV8vFNYXeRC2MW29xaL
         p1YV9tYHxJnaIZMY9he3EjxVBJXh+VAidQ1ZsqGnzMX+X7ZSfscKgNSGjnklfBdA6EEV
         ID+aojIwlz3c9u57WAuah72UD0NLxJJgNaOiWam61QxEHg9rrrH2/65qpRRmY/Qv7/GV
         /lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833121; x=1702437921;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjA1lOjqaVmYeh3NEm8JdohyaQEblB9GErmPC0P9KxE=;
        b=HIwNzEG7DHBPBKxtZmEOcBaHntRxE0yjmA+7Aiy6ZsTO2lyM10fyTKhgmhjfYVAqyU
         3m0QZBY8W54XwesWPGMBv7zONl0UPLQo9Zf3f43FxtbfS7SqhV0VgveA5jgIabdi9vAo
         Mwuhuzgmg6rQ/gjeRu207eLRPqv/B3Wy5aBWXnW8YecdNb0jtn5I+c1JY10NEyPlTUzS
         d71x6H6L6/58GXm6vEeYOGdMZHFDp1ja1g/8Zxeqhi+vFG1J9pkfTq1SwLtI8IFH49Dl
         lMKsqHC/QRUBmf5+T7nYZhKN7kFEBOJGY4GqKcjowNEk2IkYqFTibwmYcvC7b+2xw4H8
         v9dg==
X-Gm-Message-State: AOJu0YzNcS2oBLd6t0Yo4XzsWnWdxZd02kUSdpYbdljgSUDWlL9Q1+I5
	YuTWDbSxhIeXFgzYU/ryhcc=
X-Google-Smtp-Source: AGHT+IG8E2OiV+vOuACgLv+yHj0qU73/RxPxYXqHtlq4VCSMDI+YcTNnR+I+WPePKVGweTkk3drdUQ==
X-Received: by 2002:a05:600c:241:b0:40b:5e56:7b4d with SMTP id 1-20020a05600c024100b0040b5e567b4dmr1174428wmj.150.1701833121045;
        Tue, 05 Dec 2023 19:25:21 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040b4fca8620sm24223597wmo.37.2023.12.05.19.25.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 19:25:20 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: =?utf-8?Q?Re=3A_Regression_caused_by_=22Don=27t_add_route_for_inv?=
 =?utf-8?Q?alid_dst_and_gateway_address_combinations=E2=80=9D?=
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <73D64378-2195-4669-8B60-39F808190977@nuovations.com>
Date: Wed, 6 Dec 2023 07:25:07 +0400
Cc: =?utf-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>,
 connman@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2EBE2D4-B9C6-4BD8-844E-684951B9AA42@gmail.com>
References: <A9CCB4B1-2A45-4C97-95E4-FBEDFAA8CD13@gmail.com>
 <83d7e315-a25c-4c2c-9ddc-9abde56ebeff@gmail.com>
 <73D64378-2195-4669-8B60-39F808190977@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

> On 5 Dec 2023, at 8:57=E2=80=AFpm, Grant Erickson =
<gerickson@nuovations.com> wrote:
>=20
> On Nov 22, 2023, at 8:07 AM, B=C3=B6sz=C3=B6rm=C3=A9nyi Zolt=C3=A1n =
<zboszor@gmail.com> wrote:
>> Someone with a bigger hammer should look into this.
>>=20
>> I guess there is a difference between
>> * intentional default gw with all-zero network and netmask bits for =
VPN
>> * dhcp not responding on an interface and then adding a route with =
all-zero gateway and netmask values
>>=20
>> 2023. 11. 22. 15:53 keltez=C3=A9ssel, Christian Hewitt =C3=ADrta:
>>>=20
>>> [=E2=80=A6]
>>>=20
>>> And =E2=80=9Call-traffic=E2=80=9D is routing through the tunnel =
again.
>>>=20
>>> I don=E2=80=99t code so can=E2=80=99t figure out how to fix this =
myself. I=E2=80=99ll happily test any patches you share though, and can =
provide remote access to test devices if needed.
>=20
> Zolt=C3=A1n and/or Christian,
>=20
> Are either of you running this down or working on a patch to revert =
the prior one until a more comprehensive solution can be found?
>=20
> Christian, based on your =E2=80=9Cdon=E2=80=99t code=E2=80=9D comment, =
I suspect you are not. :-)

Correct. I=E2=80=99m a competent patch wrangler and scripter but I =
don=E2=80=99t do proper coding.

> I have some patches that should be flowing shortly that add =
low-priority default routes for non-default service network interfaces. =
Those may allow the infrastructure to better address this but could also =
confound and complicate this by introducing potentially additional VPN =
breakage since that=E2=80=99s not a use case I currently have a DUT =
configuration for.

I=E2=80=99m not subscribed to the mailing list but I keep an eye on =
patchwork and can test anything flagged to me (feel free to cc). =
WireGuard is pretty simple to test on most devices and I can provide =
access to a server if that will help move things forwards.

Christian

