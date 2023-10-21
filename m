Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DECD52E
	for <connman@lists.linux.dev>; Sat, 21 Oct 2023 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3IAZO2E"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507d7b73b74so2861738e87.3
        for <connman@lists.linux.dev>; Sat, 21 Oct 2023 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697921992; x=1698526792; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hAsmyjNmRrrXDDoEFoguYBNNUnrsf6FsmQC3pqrA0R8=;
        b=V3IAZO2EGrP3oubz8xfh+nc514sV2TXKM+Mp3V4m9vI760AJOb+Lsau/R0CHBgY6M7
         PgDCMiNuNPiIEe9HsBG66qW5Xaqzc+tJE6TcDZMfAWRFZf2epXZjxM8OyttJXorwqmZt
         tva4EX9SyfnAtDh7h1jNttJ8AUfPjeH1gaR0DLFwfKcwA7m+HSVzb53uuMjco1verXVZ
         0+VThbbl0dl5cL/MgaNm/NU1eBD2tSUHr9yYGtD8HyIRryzUFLiZUqKJWPg5ETRAlTbo
         3+h6NSIE+WZW3nxBdfNt1lyG3UsQKhxoTMsJNF8C9Lfg3LmV35KbhV8gS4s4n1gcqsRU
         7GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697921992; x=1698526792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAsmyjNmRrrXDDoEFoguYBNNUnrsf6FsmQC3pqrA0R8=;
        b=Yl/uH3KtZIxTz5CXi5jUhGgxPV38HITtlO3C0AclMmgRl73/zJcl6mCKFEX0JWilx7
         X0/s3sPHlQQbrnFwW3erzPK8A0lP3COcpcpF9ylIFOHPZynt6xYUirceigqGTucY1i5Q
         9m4w5U/EkHZ+YEFJsZfzFWOH5BKDxN5AbGjMZwWMlVl0O7SNUTndM8wSkvsqUtDZhgTG
         llzMn4ROoqCaiaxp2DFV6rewnB2NceXy9FZ7W4gz7B4eP3pU0peHFg0ia0XtLZ/dWxYK
         JXmilJm3nmT2ChCOQYGQ+GEDGO3ag7uwI1dPaokyeVWkEo3NnjHMbsPrC5l+1eiFb4Wd
         wk0A==
X-Gm-Message-State: AOJu0YxwrLZ1zrbYL1HdjVM9RaKqaCNKQUabgn+Nw+aK3f17xk2I7VCD
	oRzc0hQTF1pow4aWVIvOh5I1uA0Ry+I=
X-Google-Smtp-Source: AGHT+IE11OTnxrps72sFzI97ex+F39StkNsVw9eJY+Ed+vxPkVOoHECv/iPWvcSNmehAoODl8lubGA==
X-Received: by 2002:a05:6512:55a:b0:4f8:7513:8cac with SMTP id h26-20020a056512055a00b004f875138cacmr3595059lfl.48.1697921992075;
        Sat, 21 Oct 2023 13:59:52 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id t16-20020a056512209000b00507b869b068sm992101lfr.302.2023.10.21.13.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 13:59:51 -0700 (PDT)
Date: Sat, 21 Oct 2023 23:03:55 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev
Subject: Re: [PATCH] Address scan-build warning in 'get_ipv6_privacy'.
Message-ID: <w5yb67fptn5nh2pup3b5nx55c4h73ca32hslansvhqel24mz6p@ivechjtum42m>
References: <2CAC0923-E904-4671-8989-F06F9CAB6213@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xjbglhhv572oe2un"
Content-Disposition: inline
In-Reply-To: <2CAC0923-E904-4671-8989-F06F9CAB6213@nuovations.com>


--xjbglhhv572oe2un
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 01:10:04PM -0700, Grant Erickson wrote:
> This addresses an "undefined or garbage value
> returned to caller [core.uninitialized.UndefReturn]"
> warning in 'get_ipv6_privacy' identified by clang/LLVM
> scan-build-11.
> ---
>  src/ipconfig.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/src/ipconfig.c b/src/ipconfig.c
> index 9cd04979..28c0ae0b 100644
> --- a/src/ipconfig.c
> +++ b/src/ipconfig.c
> @@ -366,13 +366,12 @@ static int set_ipv6_state(gchar *ifname, bool enabl=
e)
> =20
>  static int get_ipv6_privacy(gchar *ifname)
>  {
> -	int value;
> +	int value =3D 0;
> =20
>  	if (!ifname)
> -		return 0;
> +		return value;
> =20
> -	if (read_ipv6_conf_value(ifname, "use_tempaddr", &value) < 0)
> -		value =3D 0;
> +	read_ipv6_conf_value(ifname, "use_tempaddr", &value);
> =20
>  	return value;
>  }
> --=20
> 2.42.0
>=20
>=20
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--xjbglhhv572oe2un
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmU0PLcACgkQiIBOb1ld
UjKBlhAAhOwU+3z/vxTbL8+B4FpG49dxx+OW2KhrKUp5gUmLFUSZ8EYpkv47T9D7
SaVuzm1KlIZzy6FVY2eEguw+qdP1fqGB1iZWtmlgdvQopVVA81iE9dAXRCO8CudM
TPOufxx1k6TEavxG/x/Hezt6H+ey0EtlyzcJbYQJ1aC9gzRmA3F1SaADjasEX279
3JkiF4F0hCK5LepLUnFtx7vN/jBwuK9MuqfW3KHO+w5nlamp6ABn29znorl+5sDL
okN6vqyyjY2H6P76MuvdZcA8I2kU8VaJU7qM02Z058D8AfSztBSjU9Nr4WsA4FsE
fiJH6ilvpMNtWkRjEWYWWFV7kigI0w2u0GO1QW+nR0/wA6lyOkdUJbYx3Z4OPMZW
YLpgyiyKT814bEZfr0SslSfwiioApbh9dkx9C26G+Rjuk9J3Z0wCo8aNzqD0foNi
L+GScTCwuEw3VlLqWsvVwGEWm2J0peuOpQ087Z6o3jAmj2w/N8QwlrFq6HJfl7G5
VT4naW78HCp7vmQqKs41J2pIcmuFKaXUw80Tqe0LQnD9faHBQRil443i3BXU1Ana
i+KznHMMH7xE8+4YMaYiN9UALKaW9oL8Uzmuoi3g+/lKMrCekwzZpjU6hYVPRZxg
OtagN5yQWklrPwi+2G1BzLzORuvh+2xzNEESSRzlVAZCal9n1xM=
=8SYD
-----END PGP SIGNATURE-----

--xjbglhhv572oe2un--
