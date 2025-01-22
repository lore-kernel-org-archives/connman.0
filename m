Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698D2135B9
	for <connman@lists.linux.dev>; Wed, 22 Jan 2025 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562338; cv=none; b=JZDoTubfnG7/UsLDBLe5meJErMkxqTEVjsdKnWr7Pf/hLxICUHNB7FP3/gsQqPIPf9FfV4oVBzQ5vFRunWx7LKcLAxebgJE78SUi+FUkA4cdsGQaBPKa9WUidB37xIj8598ZA+6xH9mpb0wfYRTF/7l0A+L/swvAFqtRi99QJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562338; c=relaxed/simple;
	bh=nRNVYjcoRYfT/pbt5KCfScMm91fNGgYaFm1gDNxXCl0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fqKZ380CfUF+OpRKtecy0Qxf0rXxPSponGZoTCTYtginjssU+xlxDlXnGZEPIOV8FrRuVWn0PkHT73dmsIEfctcyNNm+SG4UnrJ2Ka8dC6WI9IqdenlWmMK23jCYB+jyHkIDq2BcJNKKmhs2WY34zX6kxp7qz5Zcdqy6dMSL/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe9Z6MxH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe9Z6MxH"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43675b1155bso81727465e9.2
        for <connman@lists.linux.dev>; Wed, 22 Jan 2025 08:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737562335; x=1738167135; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRNVYjcoRYfT/pbt5KCfScMm91fNGgYaFm1gDNxXCl0=;
        b=Pe9Z6MxH3hIzR342eVnZHtrKAfn7ecMnseiOixnui2bVZaP5EjGuBEk93XPDtzy8lF
         4wGn7ZThxwEHpvZh21sE04Vl795mk1uz6FHzd6RXXFoz+wC9mBjvgUERz2f7tqOi5gI6
         0NHX0BDGjj2I5DFoZScfSZVv3y4BTsEPRRzkyWRKZjJQ+zHBaZsIM6GUSwNQ1HGEemAw
         HA5Us9ISJ2D5Ey+3V2G+k+3l6/HpF7Xp3KjdvNL5YPqjDUM21kbYinEOhzAT9LojMCZT
         Jya/eWskvTfqW1OWj34jnv5a0WyOm6fu3m1Uq4Rw6lyV7SX8CXMN425SodsKCOMRTBB8
         qQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737562335; x=1738167135;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRNVYjcoRYfT/pbt5KCfScMm91fNGgYaFm1gDNxXCl0=;
        b=Qh9/VxMTsFUXo1dR9BHL+jZpHuWovZ3CgVnsg3fF9OgNA1dKfi9Nn4TwvKwuiedb/R
         vmcPeo1Pev7TDIYaQZpxvmAWjUkVAbfunemUnVUE5U1IBzmG9bkne/1Qi0cJZIW08PGx
         7NsoZq67Mkh2pG+3bz3HVHuGaub5cBb1SSwjbGaOe8oZ9VLoRk5kUHP+hpMYyx88Tr/J
         2TfaumDSDF1he3PFdxOfPM1o5ylI1nyYsbczDrzoKMBZoDmsX2YtAOdvKn6igKjvBhY/
         +j7gimALID5aptaxWiK9CKOxmfhgz9OHiTueB61PlcS6gS666MvKZ8zxTuAZkrg9wdqH
         w3KQ==
X-Gm-Message-State: AOJu0Yx+VzsZ2nec6PxKMAS763VZgHfjo9xyMQs6wpEFasex653BWX3N
	zh58caM27bHSsHfzYR83A6iGsmBSYN/nAKvM6XILPG2FW+IjSq8Z
X-Gm-Gg: ASbGncu5DQFMY7u8Er5bzbGrSU64taHtimCmH3VNweZRNwRpz6Wq/OniydOAM1OtAf8
	p7NjLKf64ajEJvJRWM1H5S9a9/WHUeRgW4hfMAe7FRCnZ3o2j0NvWPBxY5NqZ859+LqP7OXTf2x
	yXOPEkJeMJ09hF33/bTQhYjShXlZb3CGTa9/TLf7HjgLK1HMK6A/Th+owJzMTuWoSi3f9SyupKF
	polSEHcpsy6ubmW+VvQQ34riVYgdKUfCmRfWwTLOFYrQw84HqvQUUshLaJbp0EV6rEXyVqIWZT4
	BIBVno+Tv3y1pO6I
X-Google-Smtp-Source: AGHT+IHYFZKXYtoOBt7LCtGUcsrbI1xzEqX3pA7e5W0MchdEAc+V1yoyCS792fMHt6CDiPzwOH0/vQ==
X-Received: by 2002:a05:600c:1d1d:b0:434:a815:2b5d with SMTP id 5b1f17b1804b1-4389141c211mr179481895e9.24.1737562334395;
        Wed, 22 Jan 2025 08:12:14 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31b6cacsm29509275e9.26.2025.01.22.08.12.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2025 08:12:13 -0800 (PST)
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
In-Reply-To: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
Date: Wed, 22 Jan 2025 20:12:01 +0400
Cc: "connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DDD5FC9E-46CA-446F-B5BC-F7EC66C23595@gmail.com>
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
To: Gabriel Sanches <gabriel.sanches@prevas.dk>,
 =?utf-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@gmail.com>,
 Grant Erickson <gerickson@nuovations.com>
X-Mailer: Apple Mail (2.3826.200.121)

> On 13 Jan 2025, at 5:59=E2=80=AFpm, Gabriel Sanches =
<gabriel.sanches@prevas.dk> wrote:
>=20
> Hi, =20
>=20
> I was testing connman's wireguard plugin and got a segmentation fault.
>=20
> Looking at the backtrace revealed that there are some typos in the =
`src/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 =
variables instead of ipv6 regarding vpn.
>=20
> I simply changed them to ipv6 and got it working.

Hello Gabriel,

I=E2=80=99d like to suggest a change to the commit message for a v2 =
patch
(removing the discussion and questions so it can be merged):

>>>
Subject: fix calculation of is_vpn6

Fix is_vpn6 to use ipv6 variables not ipv4 variables. This stops
the WireGuard plugin from faulting on startup.

Fixes: commit 823d5a2a8cc4 ("connection: Refactor =
=E2=80=98__connman_connection_gateway_add=E2=80=99=E2=80=9D)=E2=80=9D

Signed-of-by: Gabriel Sanches <gabriel.sanches@prevas.dk>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
<<<

^ You can add my Tested-by. The distro I maintain (LibreELEC) has
been using the same patch for a few months [0] - I=E2=80=99ve asked the
patch contributor to send it upstream but that hasn=E2=80=99t happened,=20=

so it=E2=80=99s great you have.

[0] =
https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/network/con=
nman/patches/connman-07-connman_gateway_add-fix-calculation-of-is_vpn6.pat=
ch

> not related to the patch:
> I had to manually add ip route so the other devices could be pinged
> The plugin adds routes for the WireGuard.DNS configuration setting
> # ip route
> 1.1.1.1 dev wg0 scope link=20
> 8.8.8.8 dev wg0 scope link=20
> 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83=20
> 10.42.0.1 dev end1 scope link=20
> <vpn host ip> via 10.42.0.1 dev end1
>=20
> the missing route added manually:
> ip route add 10.33.0.0/16 dev wg0 scope link
>=20
> an equivalent wireguard file adds it properly (using wg-quick)
>=20
> Is the plugin lacking some implementation?

The patch in [1] reverts an earlier change from Zolt=C3=A1n that broke
WireGuard routing. I=E2=80=99ve flagged this on the list at the time, =
but
then the very large refactoring changeset from Grant (requiring
this patch) total broke WireGuard so discussion on the earlier
issue fizzled out. If you=E2=80=99d like to submit the revert patch at
the same time as v2 of this patch - please do (no need for patch
attribution on the revert, though feel free to add my tested-by
again).

[1] =
https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/network/con=
nman/patches/connman-06-Revert-Don-t-add-route-for-invalid-dst-and-gateway=
-a.patch

Christian

> ---
> src/gateway.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/gateway.c b/src/gateway.c
> index 16c87f83..b2c211e2 100644
> --- a/src/gateway.c
> +++ b/src/gateway.c
> @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct =
connman_service *service,
> is_gateway_config_vpn(
> new_gateway->ipv4_config);
>=20
> - is_vpn6 =3D do_ipv4 &&
> - new_gateway->ipv4_config &&
> + is_vpn6 =3D do_ipv6 &&
> + new_gateway->ipv6_config &&
> is_gateway_config_vpn(
> - new_gateway->ipv4_config);
> + new_gateway->ipv6_config);
>=20
> } else {
> if (do_ipv4 && new_gateway->ipv4_config)
> --=20
> 2.43.0

