Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684820DD7F
	for <connman@lists.linux.dev>; Thu, 23 Jan 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629166; cv=none; b=RKl6gVAq27rygJ6GghSp3iY68ukxck9xPGpH0aYrRI1y+qs4VyrybRgoR93vdXXs5DRPRdaal1HjFR4mt0x6LSrBo9vbLZlZCCHvdfBZjbyzIhzyFX6yFnFTlulEP0D4UAiIQo6gtA3omVZMOkc4FrmxqLGPmM69pCxSv5uedjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629166; c=relaxed/simple;
	bh=/mhCohjvg4QSn6ck6/Fx1hh4FpSswEWHwlcZE4fM/TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azzPQb/jjT5qMSADrmvDD1vCViiUmXU+UQQdtbpkcF6tLIZ1DVwnYsvu042jQFO5v7Vr4BiiXxlm41BQ3teyzfJxk2/rSXlsIVDJgJVhcHLsESka5ASfvYOMcN7dx4XuPHofi4wcGL3voewM7qkEPT0S3qTC68cNyQDMiPzMBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLc5OGNk; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLc5OGNk"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-51c8460328dso235292e0c.3
        for <connman@lists.linux.dev>; Thu, 23 Jan 2025 02:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737629164; x=1738233964; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqylWyWKJSaeA+ZcEQWNxTz1UST+RRArD1N1x0BS5d8=;
        b=VLc5OGNkvBYAdEXChRS8Tb1Zg9y6FEoLoZ1fUDJkDf9/ijCqBn0T4aoWdO+Sz0ZtnD
         MTvfufjbGL5AJOqaQ4tQTUhvlfNryD+lFsAf9Kj2NarxzGbUJs5gtZ7RG0O4kdO44FiD
         e6A7uXmItFNtMFkIybBsrhDU+9oGWs0e03R/+w3rrgyqxCfP20zew4Uk8P0KvGsDt+rs
         lphRCRBKheDAIu3fF1wQIR0b4gxAlzL0MEYnTS+fJFCkrlzW5x+KSuHmDlYxamrzPC+z
         VafWlPm2C+j9yWzfLWWaz4inpUUdzU440PVE6JSpSi6lq23pmfnzElabm4YfHHk49XS+
         iXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737629164; x=1738233964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqylWyWKJSaeA+ZcEQWNxTz1UST+RRArD1N1x0BS5d8=;
        b=B7wWo4L8J0O8Tm3dC578YVj5sziSC80i7hrVtrZ4qd1BlVKafZfOLIEp2zl5AVbZfU
         Q0+Ugeb9xji04IJsK3AeYXICZbGg5v9jF/3irzJ9oluMVEw3vi+TTw6p/bMIiJ6lLgtU
         u+ht4OLKxHHCpzXq6BvbC1Lg4hEdPrQHgKhNbq5DFFPiNo/RUn+aV7ETMbA7GyT8AV5J
         V8TaqQ1LP/V8rqfxqtfP2x19NAuNHF3tWU3PCHDUn52e46UGNWRgWi/p1gtz0JDdpg0N
         7XgJkSWXq9xbcdU+e6ov1lCuv5i60doXaSLn4RPQQLxU9vtfk25ZWtlm1g7ifd5mrJxx
         58ew==
X-Forwarded-Encrypted: i=1; AJvYcCVQtcnuBDdVN3TAcP5knAFJ6Sjxme4OBUguxgxGj3612m+zeWabF8Z1gu9FATxA++lYymekW8qG@lists.linux.dev
X-Gm-Message-State: AOJu0Yyzf7c929Q89H8JUvGHU6tHU75YfIOtPdRegxQcouRhLJSJLQDe
	kdVGxt6rlDg8IwMjrbdVVxrFNFYKwgsIpm9GBBe/2NwrKDvqDl9TlEC14JzErSN7xq++WEJHN6E
	rWn+FA10hkw3GdFT/9Na5H56i4K1Q3Y9E
X-Gm-Gg: ASbGncsz7S0iTIpa/UgPxLD5DOpYRSQqRe7wUG4uMbBj3Z9hlS1ynZxzBKcExbkxUNM
	zaeDIn8aAJSJ7keXm5Rzc27w3Ta+kzrS+lPY+gYERsCcfa9X6zNj1uVabFQR+PF2LtyGthZvlYf
	XGSm34x2FT4cx3j+nXOTo=
X-Google-Smtp-Source: AGHT+IGqVHDV3aqfzKSFX1SdytXyXf7NsOSDnmRRa80z8W8zbr7fkDxR4fDILfJKSvccIVqJhHb6Q/GMbOsTpPBWp5w=
X-Received: by 2002:a05:6122:2a4f:b0:518:8ac7:396b with SMTP id
 71dfb90a1353d-51d5b3691b4mr17227588e0c.8.1737629163830; Thu, 23 Jan 2025
 02:46:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <DB6PR10MB184509788A86F13B5F8C7378E11F2@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
 <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
In-Reply-To: <D398EEE6-A14B-44E1-9A05-3810B79A3B25@nuovations.com>
From: daniel antoine <univac55@gmail.com>
Date: Thu, 23 Jan 2025 11:45:53 +0100
X-Gm-Features: AWEUYZkOEyXkbuQWLCT6-1SrFxdcrP9ZADWe4k0UuvqE1slrqyGbb7XPfAC5LeI
Message-ID: <CA+iibzD4V7GT4ycXEKLk5PKJ4z4gJeupaNf7tUee57q8SQY1NQ@mail.gmail.com>
Subject: Re: [PATCH] gateway: Fix typo when setting 'is_vpn6'
To: Grant Erickson <gerickson@nuovations.com>, christianshewitt@gmail.com
Cc: Gabriel Sanches <gabriel.sanches@prevas.dk>, 
	"connman@lists.linux.dev" <connman@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I have opened a ticket for connman-vpn not working with wireguard  in
April 2024. If you give me the patches I can test them

Best regards

Daniel

Le mer. 22 janv. 2025 =C3=A0 18:01, Grant Erickson
<gerickson@nuovations.com> a =C3=A9crit :
>
> On Jan 13, 2025, at 5:59=E2=80=AFAM, Gabriel Sanches <gabriel.sanches@pre=
vas.dk> wrote:
> > I was testing connman's wireguard plugin and got a segmentation fault.
> >
> > Looking at the backtrace revealed that there are some typos in the `src=
/gateway.c` file where `is_vpn6` was incorrectly set using ipv4 variables i=
nstead of ipv6 regarding vpn.
> >
> > I simply changed them to ipv6 and got it working.
> >
> > not related to the patch:
> > I had to manually add ip route so the other devices could be pinged
> > The plugin adds routes for the WireGuard.DNS configuration setting
> > # ip route
> > 1.1.1.1 dev wg0 scope link
> > 8.8.8.8 dev wg0 scope link
> > 10.42.0.0/24 dev end1 proto kernel scope link src 10.42.0.83
> > 10.42.0.1 dev end1 scope link
> > <vpn host ip> via 10.42.0.1 dev end1
> >
> > the missing route added manually:
> > ip route add 10.33.0.0/16 dev wg0 scope link
> >
> > an equivalent wireguard file adds it properly (using wg-quick)
> >
> > Is the plugin lacking some implementation?
> >
> > ---
> > src/gateway.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/src/gateway.c b/src/gateway.c
> > index 16c87f83..b2c211e2 100644
> > --- a/src/gateway.c
> > +++ b/src/gateway.c
> > @@ -3704,10 +3704,10 @@ int __connman_gateway_add(struct connman_servic=
e *service,
> >                                       is_gateway_config_vpn(
> >                                               new_gateway->ipv4_config)=
;
> >
> > -             is_vpn6 =3D do_ipv4 &&
> > -                                     new_gateway->ipv4_config &&
> > +             is_vpn6 =3D do_ipv6 &&
> > +                                     new_gateway->ipv6_config &&
> >                                       is_gateway_config_vpn(
> > -                                             new_gateway->ipv4_config)=
;
> > +                                             new_gateway->ipv6_config)=
;
> >
> >       } else {
> >               if (do_ipv4 && new_gateway->ipv4_config)
> > --
> > 2.43.0
>
> Gabriel,
>
> Great catch on this copy-and-paste typo; thank you!
>
> Best,
>
> Grant
>
>
