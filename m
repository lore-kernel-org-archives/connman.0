Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5155667
	for <connman@lists.linux.dev>; Sat, 21 Oct 2023 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhBz2w6U"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-507975d34e8so2937023e87.1
        for <connman@lists.linux.dev>; Sat, 21 Oct 2023 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697922097; x=1698526897; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHGUAktOK1u8+fUwO4ym1gv0rWeuexQjDU8BpkwrDhI=;
        b=JhBz2w6Uu1D8J/yZ6n9nbnR32RXVoku1RMGnsc31Y/FXPUBbPQ+inTpKDbAOhxMBIw
         ESQG6GgyXUN2yEScgeOG7rk4k7ecxm2xa7coqI7hoaE4c6QxSvg80qU/mdX+bWv4FpQd
         P/LOnRARLSwcYrWHdKYMr4UGon3qKqWdnMA/XpvLiT5n6msdU7UDwGw4BGkFNuMPwrSk
         aZ5oMQ2AuaX/xi/cYoojYAN0vOkf8X40Fts5ubJJWrUP257BTY9CgrVZrmWAEbBa106C
         iXulmPWc7icR+mZvpEM7fmnONlgGHiZYNV638Iz7s1ziw0JxCTmMhixmv589ryALWPen
         Od4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697922097; x=1698526897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHGUAktOK1u8+fUwO4ym1gv0rWeuexQjDU8BpkwrDhI=;
        b=rf5D+rHnUumFGZ7Gi2dfgNXBI5N4KeHRrycX8McFV4Yhj76p6Z9e+zL6lnlgaxG1St
         zl/ULkNUBoMgtUh34epWRzE2sgc5vHfC2rVhtsOTcq2EjPulVxIqeVs/rUbxUr18hg5k
         O33uWHqxyZTpKOX6bTL0vInIc2UTeyLx8sez6NkTU76SbBgP5pVzwA+lxxOJvXhFVe+9
         uVpvCtmesKek5+H8vagI3O9w+FBjg46gaBqnaDPz3ckcxLm+ApvCGcCeTT/Pp3NnsqYQ
         qNrE7pbX5iOj8CoL4sfUo3ja4MSyppa3SRQyrBF3av4gRDJeo6jp9d/if8MIEhRw8rwB
         yvWQ==
X-Gm-Message-State: AOJu0YwbsQ22VRaTUSYn8m88xk2OJsP/WqFC8xCJUaKMwBiFiVvJ7HHp
	yfimBlXMqBPS/BZ3JjKWEHE=
X-Google-Smtp-Source: AGHT+IFfb4AmcinMDOpGtnbNyA2z1s5d9aMe7ofjCsVzzmpU1seFzM51JHE1GkkxvOfhV5hfMevTaw==
X-Received: by 2002:ac2:51a5:0:b0:500:af69:5556 with SMTP id f5-20020ac251a5000000b00500af695556mr3667661lfk.29.1697922096716;
        Sat, 21 Oct 2023 14:01:36 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id q25-20020ac25a19000000b0050089b26ea1sm985759lfn.276.2023.10.21.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 14:01:36 -0700 (PDT)
Date: Sat, 21 Oct 2023 23:05:40 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] Add self-documenting Linux rp_filter enum.
Message-ID: <xbqhcmu7wzojktr7qj2gwhv46vt46lbqvfz4aglcnbidh4cj3o@xcmxarhgp7lb>
References: <A838BEF3-E296-4B5A-9B84-8D5D0805FB67@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3jprefveh4y5acv"
Content-Disposition: inline
In-Reply-To: <A838BEF3-E296-4B5A-9B84-8D5D0805FB67@nuovations.com>


--u3jprefveh4y5acv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 01:19:24PM -0700, Grant Erickson wrote:
> This improves self-documentation of the Linux reverse path filtering
> (rp_filter) validation setting values by introducing a file scope
> enumeration for the possible valid values
> ---
>  src/ipconfig.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/src/ipconfig.c b/src/ipconfig.c
> index 34b1724a..18240458 100644
> --- a/src/ipconfig.c
> +++ b/src/ipconfig.c
> @@ -40,6 +40,14 @@
> =20
>  #include "connman.h"
> =20
> +/* Linux reverse path filtering (rp_filter) validation setting values.
> + */
> +enum {
> +	__CONNMAN_LINUX_RP_FILTER_SETTING_NO_VALIDATION          =3D 0,
> +	__CONNMAN_LINUX_RP_FILTER_SETTING_STRICT_MODE_VALIDATION =3D 1,
> +	__CONNMAN_LINUX_RP_FILTER_SETTING_LOOSE_MODE_VALIDATION  =3D 2,
> +};
> +
>  struct connman_ipconfig {
>  	int refcount;
>  	int index;
> @@ -406,11 +414,11 @@ static int set_rp_filter(int value)
>  	/* 0 =3D no validation, 1 =3D strict mode, 2 =3D loose mode */
>  	switch (value) {
>  	case -1:
> -		value =3D 0;
> +		value =3D __CONNMAN_LINUX_RP_FILTER_SETTING_NO_VALIDATION;
>  		/* fall through */
> -	case 0:
> -	case 1:
> -	case 2:
> +	case __CONNMAN_LINUX_RP_FILTER_SETTING_NO_VALIDATION:
> +	case __CONNMAN_LINUX_RP_FILTER_SETTING_STRICT_MODE_VALIDATION:
> +	case __CONNMAN_LINUX_RP_FILTER_SETTING_LOOSE_MODE_VALIDATION:
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -421,6 +429,7 @@ static int set_rp_filter(int value)
> =20
>  int __connman_ipconfig_set_rp_filter()
>  {
> +	const int default_value =3D __CONNMAN_LINUX_RP_FILTER_SETTING_LOOSE_MOD=
E_VALIDATION;
>  	int value;
> =20
>  	value =3D get_rp_filter();
> @@ -428,10 +437,10 @@ int __connman_ipconfig_set_rp_filter()
>  	if (value < 0)
>  		return value;
> =20
> -	set_rp_filter(2);
> +	set_rp_filter(default_value);
> =20
> -	connman_info("rp_filter set to 2 (loose mode routing), "
> -			"old value was %d", value);
> +	connman_info("rp_filter set to %d (loose mode routing), "
> +			"old value was %d", default_value, value);
> =20
>  	return value;
>  }
> --=20
> 2.42.0


Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--u3jprefveh4y5acv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmU0PR8ACgkQiIBOb1ld
UjJjcQ/+P0fv7wphPwfYB0WZVyGPFnAa51bbXR3breqj7KOG3PNhqjqYZp/wCQWc
hTjhjrUBuhQ5WOdLZ3Zxthm1zBqLxa8CF8Z7Lk4VwKi60QYX0uM7FqVgCCS5smna
Db9EMLHnDUcEf9+kjS+FrFrN7eFv+ICdiqXPKV3Kf3TPRQh4Lr3TZARtZ+hP6qzU
6Hqpp2gt4Gysm+OfWIQijbzJ8RayZtnF5DUoAwuas+uoF/8leHmxpvZrnMM0RBgH
hK4DzWmmCPrXXlbPCfhgaY/fQgeZ5rGfJtljDVjuE0Xz9ytMD4XZgPxeNrRvfG5Z
5J2j0s36tcQ7oscihw2bG465qtZET56NslZU2v2EeU406C4Fgy7dTp1ldRJIME3Y
dDTI9BKjpemZi9a0Ooguhu58lJ10jKzIbKuMGc2MxSpjhr2cz5WZoSdkOjpC6gH4
DQleir7CET23XmFT0gVvAL1GAUBwW17lHOd5e+7yCCGd6idZgDVEa8aB1iElVe/O
Tyyhee9Rd2apVXR6Z/SIVrQHZce++MSBdITsH7O+hqsC01O1ULQs+MyqfUHZ9aOw
xxNaq7gaMCJi/Ex0WIQEWHF8zb7pabzrTGg7j5ePvvZ0dK4bXLvxcrh1I/qh23ux
GZ8UQgfcmnukrytwvWPAlVTOA3BYiZIcDBLQXDjbUVGW6gCtVTA=
=MHBt
-----END PGP SIGNATURE-----

--u3jprefveh4y5acv--
