Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E30C2DF
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/DFHmAa"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so6263271fa.2
        for <connman@lists.linux.dev>; Thu, 19 Oct 2023 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697783121; x=1698387921; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHkETmubLvRv1To3lmCCrYLnUni8d2ffwxI87btHysc=;
        b=R/DFHmAa1GmrujxrodjiT1+9EkERCBjOpUt4Zx2GHWftVTo4CbDl5uvC58pT2g997w
         /SU4T7yzuMRc3Fr0KL7IicfPoagbRbISH0F0V7wNWZQqhg4KpyXgVM/egzS+Z1aTQLtw
         1hh0g5cL26aJyh78J1sO34LWfMllPAHyNoQ3pye93E6lq1hmZMjr3JdcpCehFaVuIkdn
         cjyR7fjfb5dpYOeueOoPiUZhpjjTbex8qvnav/3xNveMLx9rrwJp+zljeYiRUSSswWfl
         yzCbJ/jyRROkzpFUk4EjN6+HM5zoYxgvrZLECCO14i8Vzxy1OW65VTu0G9DXfA+bRydJ
         ZYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697783121; x=1698387921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHkETmubLvRv1To3lmCCrYLnUni8d2ffwxI87btHysc=;
        b=OwHutNK0na6FoM/N3hVIZ1Xizs+8msrMaT7ki14YqbLEsk/VsAMXXJNwRiUd1w7Qst
         nDZg2h/K7aLX3Bz2EGtQuJboGBq9baTAAQhACVwvHD5ibSZ4ocqES5cEnf6lmt6NpiW/
         kvX7XL/R976CToiW05pi1Kfn7E9GrGuEKrEc1uTLrbVS6vlxBrKtufGiI/Y4c1MVn5U3
         Q4ZSOOOs6/t9sjKyzjolJeQhTknZnmhCcB/YbHhIUU/MrgzInyCFK2sKy2Z1Gn6LfsmP
         TQU3TDNUfnSu0P0fGqJH/Z4DBlpN36oOF6+Dsd3HV8r/AWEAzdE/D34UAt9RhoOyU7DK
         NofQ==
X-Gm-Message-State: AOJu0YxSqdoNIosHt8sEc2Gd6oPUV9Ac3R/gN2Rx6LFBMJj+5Vqumyer
	ekGl3XMzxpoKkk0Tpq8xzbysaFDtYss=
X-Google-Smtp-Source: AGHT+IE8YkbAvvxDyzXnsYRlXTJQ3uShc1BK4KJFWy0aI9EWUpT0ZJaFhWmVGMLXr9gIFidGtGtCeA==
X-Received: by 2002:a05:651c:2208:b0:2bc:f41a:d9bc with SMTP id y8-20020a05651c220800b002bcf41ad9bcmr781370ljq.25.1697783120851;
        Thu, 19 Oct 2023 23:25:20 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b70a8478ddsm230782ljb.44.2023.10.19.23.25.19
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 23:25:20 -0700 (PDT)
Date: Fri, 20 Oct 2023 08:29:24 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: connman@lists.linux.dev
Subject: Re: [PATCH] doc: add the optional freq parameter to the connmanctl
 manpage
Message-ID: <ZTIeRBS6l2cdDO6p@gmail.com>
References: <20230629100000.49254-1-marcus.folkesson@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s+yPs6QUqgNQSO2L"
Content-Disposition: inline
In-Reply-To: <20230629100000.49254-1-marcus.folkesson@gmail.com>


--s+yPs6QUqgNQSO2L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Ping

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

--s+yPs6QUqgNQSO2L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmUyHkAACgkQiIBOb1ld
UjKkaBAAkdTCCBSD3aKOxkpUfv9fqztgTmtx5i2CTzHEvXlTFNCVCK1eOfsuj54p
dDXOVco5x0kFnStq8pVCl4o+NNP2/qoogmp+BQfp+s2TWJKEWv22XIhlE0A/fKIB
tP6+LcgSDpAb3oljDRTVUZB9r5YsADSVkSS37tbaLlXQo2IFPL2qeTXW0PFDHPOU
KwmvCokSmKe/V5fjHa2zz3FFgLmFJlZO6Wzq8aAOWyYkKLmdCXla3z122OMZE47J
9th+8pcyoB8r/XOEfQwz2obytghJUkTC+xScp9xBDzJR6yYOBlPB6GcAazCrFFsy
EPvq/RDVYl/AARgm6fkfx9yOixh/Q0UA6dAZgWyPZ3yrXw8z2ujrYDuDul9ih9ps
4ihFZxanvDXNNEKu/zXy/OC/h848fnqpXZKg4S2iPWrjGkQkWAVaYK2/MkauRmj6
uNsjHVKiaXGn6enlvn2W5eqFlFD0Ar/0qcg9U3RIFhIis2Ak9m9ADfPJGKxY4iQL
k77YI+SJqpKlq+m7Y11bjR+ajO1pZW8LMYJsDaMm94fUuR/P+0GdOMFgZXHX9yqB
HwrV0LJ2MQI1V/FVeIbjNv03+k4upRUe5FVlLFd3ZsdYGG/cg/lqthvCPyw94f1n
h14K5cYFlHAghJPYG7M2GdGNU367AzaE+ISc8v++GNVHJw59jm0=
=7W50
-----END PGP SIGNATURE-----

--s+yPs6QUqgNQSO2L--
