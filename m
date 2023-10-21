Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E30D52E
	for <connman@lists.linux.dev>; Sat, 21 Oct 2023 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE83XzCB"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso2828378e87.1
        for <connman@lists.linux.dev>; Sat, 21 Oct 2023 13:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697921957; x=1698526757; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZJBayHQmNv3dJhd6KnGk5T/puH25Qsn26JzFcFWP28=;
        b=DE83XzCBXoENws4fY8VVUZS2vboBtNQQk4895Flua68Oz6LZlqR9mN3nB/YA7R3pN/
         orf/EvKXSOUFVUrLWviCkeowFUna9C4ZEvbKPkKHBEouwigK4PV1764bbAf4ij5yzHMc
         BNaWW3FVgYHmNOACtuX17PMew2wYV2VhENSGSVBPh/k+p+8YueLT21vq5n/1i7YME9Kf
         nBVnYh3OsNsP0YCguUhnv+hTNOnv6JxwUIfhFLY36r819xr3OlOeDUTRT9oZCVG8+jJB
         MiWuBM4T1+npmhztfTqKTDgF5ocWd17yC24aY7xheYBQzwTB7FfA38pR5P3pIkSMA5uD
         J7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697921957; x=1698526757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZJBayHQmNv3dJhd6KnGk5T/puH25Qsn26JzFcFWP28=;
        b=ALjxqacNU56/iv5drctYe9W2JTbyaAtz0vQ+44Qm355WrkV3GU9kU9zzXERFcswg5a
         5Pk2rSaN7Bdg/J4P3++tFVpT4ecaxWK6G98Xx4FVj50nlMFsOBqTmcCdyjWqDB0DvLPK
         Bc3jgny6vf9si6kwJpjLv+9Yo71FYKjAhH9TuCruQDU7Rs7aW4VDFwQLfE2HW+ZDYCn8
         YWwx9+HWlTs5FSwnd3oCbS2xGrMlUCJ8wDPIIiactXCHQysHiBUTFnsslKif65XQwkfv
         4eXbemUt3na/ZVrT6UHax4OUv1vpYPxKr97V/+Eq1EsoB0oN+DMSWx0wNC+2enx7eVtV
         77Hg==
X-Gm-Message-State: AOJu0YyGZmr/CscyWe1C4w0uFjea68jcY7GWJL2GDUBYm8GRmqCiX603
	glRpePTjLLQTcK7eP/zvuMSGKkM1Brg=
X-Google-Smtp-Source: AGHT+IFtoApTf9lmBiinMDOOHNVPquNo9cVAsW96Zg8I/+U//eeAv37OVJBSBEca+zf/eWWaX35/sQ==
X-Received: by 2002:a05:6512:485:b0:507:a78a:9420 with SMTP id v5-20020a056512048500b00507a78a9420mr3505845lfq.62.1697921956476;
        Sat, 21 Oct 2023 13:59:16 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id e9-20020a05651236c900b004ff973cb14esm984107lfs.108.2023.10.21.13.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 13:59:15 -0700 (PDT)
Date: Sat, 21 Oct 2023 23:03:20 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] Address scan-build warning in 'get_ipv6_state'.
Message-ID: <lzgjx6yfrtbxigzdg4k56uhhrizqqwiqqh5boangtyvs2kgic3@jsexcbjotsdb>
References: <CAFEDF00-18C4-4712-807A-370425E6A110@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kqd6qs7unevpgmga"
Content-Disposition: inline
In-Reply-To: <CAFEDF00-18C4-4712-807A-370425E6A110@nuovations.com>


--kqd6qs7unevpgmga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 01:09:42PM -0700, Grant Erickson wrote:
> This addresses an "assigned value is garbage or undefined
> [core.uninitialized.Assign]" warning in 'get_ipv6_state'
> identified by clang/LLVM scan-build-11.
> ---
>  src/ipconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/ipconfig.c b/src/ipconfig.c
> index 34b1724a..9cd04979 100644
> --- a/src/ipconfig.c
> +++ b/src/ipconfig.c
> @@ -346,7 +346,7 @@ static int write_ipv6_conf_value(const char *ifname, =
const char *suffix,
> =20
>  static bool get_ipv6_state(gchar *ifname)
>  {
> -	int disabled;
> +	int disabled =3D 1;
>  	bool enabled =3D false;
> =20
>  	if (read_ipv6_conf_value(ifname, "disable_ipv6", &disabled) > 0)
> --=20
> 2.42.0
>=20
>=20
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--kqd6qs7unevpgmga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmU0PJMACgkQiIBOb1ld
UjL8lBAAk3zi7pX3liM34FFPHxvNNMC844viQaJGb8FMX0koy6lF/+q/vGiQnEH/
aJZPVdF1niA2rZuO2e13HfIlrf6pXgkG2MWDDjIsOSAf+qhvXRa4zLqjx43votbP
APDyVEBRENeme0AQlgAxyVl+nFuuTKscfMCW24YxH58qy81nSfhR6UvG2gGdoDec
tV7iD0Qw1zSI/7clmf7KuBTl97oLIVVjmuYDp32ClIOEC9XbNJESfbPMKYsYMzeZ
Nbx9k7JctF2GYEPRglkV2AZfJCIGslPfbycAZl7CLjMP4Byjy2RMDJQ0xPjG5HFA
Yv3G4FodMVttjrsovdXDWhEkOZ9LfEZTnl63RqM97HPed4SBz0GzswznjHUHZruB
bxClN3MWrpztHmO2jWgAlb6MzNfSiarVmT9NzJukaOZPOqhpseJ2r1jO3CqNmPgy
ZdD9gF9COJimgyy7y2AKbNHNkf0qvCOVXw01T0fMeMvxmiq2l8Nd+lfk0tY5no9N
/F9a8OdiUglIbYf7vW9WQ/ASAbOoR/32FzntItsVkKr3ZMvOE5jFAiPb6nu/XzEh
tj9LHFmvgMrT4KgWeCzLDIQtJP37dqDWXttwtj5CNr6DApwwzwX3QL6FOqXCtVBs
IipMuXnWrk8rM87P0V3s39m9JZW8K9mraSViFAxxsiR0TeCAHG0=
=rBrr
-----END PGP SIGNATURE-----

--kqd6qs7unevpgmga--
