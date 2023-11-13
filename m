Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A51CFAC
	for <connman@lists.linux.dev>; Mon, 13 Nov 2023 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2Oc3IR9"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-507cd62472dso5983518e87.0
        for <connman@lists.linux.dev>; Mon, 13 Nov 2023 04:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699877451; x=1700482251; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIZKv3uVuQPB4JgfoTuobxgD3lCDnny1WphGwtw8uJw=;
        b=B2Oc3IR91jQAtCZYFp3tAdaGWM8NNDFUTmR5eps1op6gv8vL4mcZ/Gx/8BxzahG6qo
         pVnD9BGTgDdoc4ozGjM395OhRU6oG5ThAWE0IIDLitEk3R8q1PisGT0u60ZKlJvSdUDV
         FraM699zk7RguPWhk9nZpKz526wdgxpU4O+7vEIV6o52ZHxzVWmVMNEMPylV2244Qg3L
         er87vjOw5I/lc47OIf1dESRceSow4Icintw0PC/wNxvD2XEcE9oPgORmk8iF4usA7Ni2
         JTLXaDXjsBOVzbKr3r9Vn/ATUuC7BbirBb8MpNZFqKG2FA5knqeTDLnD6WNlPP0Zj51b
         1nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699877451; x=1700482251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIZKv3uVuQPB4JgfoTuobxgD3lCDnny1WphGwtw8uJw=;
        b=vkUQ4pSq2u4KT4wGCe77iS9CQpQe5Yzy0yCpakO3jB8Yi/N6FyZHRAHBNnysaxOLfP
         XILwm8cszGRmYhMxHUyY8Rejrdht01l4CjX3z/y0fmp8r6Mzh7kMGoTBnZZ2BuPu3fFu
         Sq+FtHWpZu6Z+hOhc65ijgyQ/CKsj1nKmxPkrAfpNOR8KdqfIppDoG7648mfoRjQlwJa
         ixUNE+tr4jWcl24YqC2lvBKjTUJ73wjxGmBb3rC6M22+Q7GpQ6oGMz76fPfWm+BT2gzk
         xgjov3Rbt3AxGVYoCXeXR0bwUAaRFUv2C6LiyS06CYrqpg05wn7gWPjU/Pk6vMXQZCgA
         tWSg==
X-Gm-Message-State: AOJu0Yy+psU7vS1avrCAjJmhWrEEHoYLtOhjxxuCVhGEARH011Q4FpPR
	7KWa6XysJ+QDn0IT4/8bhsh+FH1N5A0=
X-Google-Smtp-Source: AGHT+IEZB6enTl/9GxMWVBBtkh7MkDjNh4WkIdjjlK7AB5G7V8tDXpSOtl5OVh/6fK4MDi+R5UGhOw==
X-Received: by 2002:ac2:48a6:0:b0:504:7d7e:78dd with SMTP id u6-20020ac248a6000000b005047d7e78ddmr2057912lfg.23.1699877450373;
        Mon, 13 Nov 2023 04:10:50 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id eo10-20020a056512480a00b004fba077e654sm946514lfb.194.2023.11.13.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 04:10:49 -0800 (PST)
Date: Mon, 13 Nov 2023 13:15:07 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: connman@lists.linux.dev, marcel@holtmann.org
Subject: Re: [PATCH] doc: add the optional freq parameter to the connmanctl
 manpage
Message-ID: <ZVITS36WkHlQ719A@gmail.com>
References: <20230629100000.49254-1-marcus.folkesson@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/V0WUJFwc8w23DIv"
Content-Disposition: inline
In-Reply-To: <20230629100000.49254-1-marcus.folkesson@gmail.com>


--/V0WUJFwc8w23DIv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Marcel,

Do you mind apply this patch as well?

Best regards,
Marcus Folkesson

On Thu, Jun 29, 2023 at 12:00:00PM +0200, Marcus Folkesson wrote:
> Add 'freq' to the parameter list used for WiFi Tethering.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  doc/connmanctl.1.in | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/connmanctl.1.in b/doc/connmanctl.1.in
> index d87472c3..cf662ca3 100644
> --- a/doc/connmanctl.1.in
> +++ b/doc/connmanctl.1.in
> @@ -10,7 +10,7 @@ SYNOPSIS
>  .BI enable \ technology\fR|offline\ |
>  .BI disable \ technology\fR|offline\ |
>  .BI tether \ technology\ \fRon|off\ |
> -.BI tether\fR\ wifi\ on|off\  ssid\ passphrase\fR\ |
> +.BI tether\fR\ wifi\ on|off\  ssid\ passphrase\ freq\fR\ |
>  .BR services \ [\fIservice\fR]\ |
>  .BI peers \ peer\fR\ |
>  .BI scan \ technology\fR\ |
> @@ -86,7 +86,7 @@ by default since tethering it usually breaks local netw=
orks. See
>  for enabling.
>  .PP
>  .TP
> -.BR tether\ wifi\ on \ |\  off \ \fIssid\ passphrase
> +.BR tether\ wifi\ on \ |\  off \ \fIssid\ passphrase\ [freq]
>  Enable or disable wireless tethering, as well set the SSID and passphras=
e.
>  .PP
>  .TP
> --=20
> 2.40.1
>=20

--/V0WUJFwc8w23DIv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmVSE0YACgkQiIBOb1ld
UjLVThAAhzNPLwf2UxAsqEUsQONfiRbhBFkho6LJuHRcFavlSBJkvmCr4KN7h1ld
8CNyKgWk0faCzgC81+GHoo3BjMyDVebkvZUeUKSNMeC8XsWaaGhsdbt5j02JjPq2
LoE90Jg1bT5u3MrHEJXzZKyHsYCfjDrnsVKpCxCjYG1U1cPDrXSDmJSDrg4ePoSz
ljTFsMzml93a7mVlewbHSeroDWWc6nwEiIDLOJ5fz8lE9H4tDkysLIuZSnOQStmy
21K1jjeqjWLaA6BIzOR7+uwPk6FBUsMEshBAP2Kzz8sp2xfTSV/Gn6Yi5kdKzIED
62AnqjTHo1l7T4EhVhXBIsj8b6bJMH0vQMF2XzlFa93TT+whAUNVUEgGK0W7XD+i
x0E5Y/jQkwFOXfl7RyyxZ1LTOgcTlTAVuMWJOOPIS5zSUlTQ0WO0fKvoiK3qTvKW
k4qg8RFNJvVYsof+/SnxQ4GpK2V8kD6P+VUEI7wSNXYF//820zr9zynhNho4BBKt
3AbEBPNo1Tma92Fdhx4GDfgNir1iY3WVokTkpfqw+f8+IgHt2+PMh8v9EiDDVG9f
uB2XMvo/mi99Zkd5y8L1kr7ZWJnzHWPGyCiPk6N5Er1Xt7bdwoCGdistDxtXrcrl
cu5Tw8+SPWiuyDIBeNy22a8AND1bUFwLF9y+0zrGGzgi6SnXuyI=
=+kj7
-----END PGP SIGNATURE-----

--/V0WUJFwc8w23DIv--
