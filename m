Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0918117FF9
	for <connman@lists.linux.dev>; Fri, 18 Aug 2023 10:29:59 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4ffa01fc987so1333656e87.1
        for <connman@lists.linux.dev>; Fri, 18 Aug 2023 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692354597; x=1692959397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqtmKHPL6Soh/YetQPjn5omJMvcELaMelgwVl00x++A=;
        b=iwBXbMjd1O+o9HBoAKYCPccT7ZnatHuk09RDTJ6f2LS0EA6mIG2V+LWUgiTPfw70GM
         oq4LUofxPeD/vDx+n/Imzusgcyh7yWRHIxrdznsfF/pegWCt4v2yVoXOp7d9pBizg4gR
         gpa8IQXq965OIE999pP2XToHz5EzVrprRiZbCMAcwruH+FWRB3ppcnJMNjBCn9bXX1Wl
         yJDT2xRBMm/uMHXTf7T91Gz8I+RNguL1o+M7BQpAHVpygmnLo33+B1v/kFRm18g4w3u3
         JDBJ6lZYB8jjBycHf3TIZPzbOgNb8EyKIFHGiZ4uAmdQrzJQYJ5AaPWdXBcXNnQdaZ/7
         GscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692354597; x=1692959397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqtmKHPL6Soh/YetQPjn5omJMvcELaMelgwVl00x++A=;
        b=dw3xYUJ275b6mfht39zPE3ADda8xUuJXgG53HHcRCJZjed/Cd3A8QlN/Ims2iuYJPT
         IYs8Curr5U1tYcpt6saLC+Cm9nVc03bvybay2p+vHZLmB6hxy9LrIaZBMKt3SPjCdKvg
         ZsOylhQ+uXl2f9zfBe6JEPVIaLGsjLK2YrBXqWWufxO/caBgiPiVa6nQvAAj5M6lrivF
         519v4uP/sfSJLwf/oDkTIhOBTJOkOsaoFRCVx8Rysgu04GMxCFgIkG8P9dIwt/6BFaar
         W0SBekzggyRoTxsztInm9rCzpDxuSEfPB/3sYb7M6ivv6A3HyuIsYcdNnvNrfv08JgsG
         emCg==
X-Gm-Message-State: AOJu0Yxhb7RZaG2pLvGNSz7OQvB4FFuMjfaRHdjGCail0rnyu8uijCh+
	xGMq63f1KHAeuzxpM2Faavqdk0djGHgLxAS9
X-Google-Smtp-Source: AGHT+IF9v8gQ//1ZvnvyWrsYgtmmR/o7qCVNP5Es7VcZupwXJHsEctfC6GePI3InpDETICmJ73KbeA==
X-Received: by 2002:a05:6512:158f:b0:4fd:f0b7:d1f8 with SMTP id bp15-20020a056512158f00b004fdf0b7d1f8mr1877865lfb.23.1692354597279;
        Fri, 18 Aug 2023 03:29:57 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id j22-20020ac24556000000b004ff7f62a16asm281502lfm.284.2023.08.18.03.29.56
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:29:56 -0700 (PDT)
Date: Fri, 18 Aug 2023 12:32:28 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: connman@lists.linux.dev
Subject: Re: [PATCH] doc: add the optional freq parameter to the connmanctl
 manpage
Message-ID: <ZN9IvM5jGHuVlXv1@gmail.com>
References: <20230629100000.49254-1-marcus.folkesson@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ez+8O1Ga0KkF3sRt"
Content-Disposition: inline
In-Reply-To: <20230629100000.49254-1-marcus.folkesson@gmail.com>


--ez+8O1Ga0KkF3sRt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Ping?

Is the mailing list still active?

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

--ez+8O1Ga0KkF3sRt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTfSLgACgkQiIBOb1ld
UjJK7RAAoO1EEKA+FQB77+LMsK+elogXSIY4bIja+G45wOft2QTZ3t6tCoFDVdBa
Hsq9yJkmi1N0LeRCJaPWFh/e7XuPad5td2p+hhvnxEvHE7YTrHO1iBw5OYZN1D5S
WMi+TEVzeMCSJwxDqG1nv5eiiXZvZ1TmSZk0v2rLUHTp+53MxpI8eJoisT4cTXLP
AB4av6a1OsyDlo1vvpOY6eJxBluhO7jWj5XY4DpAud+cPOZkSgUFxKNr8Rmlbz/C
F3JvfqkX6yUAk8Dz/HTU0o+rUsCVqm9Heha63Ui8YiUgiM2etY2oWw/bxE4OULLB
PoaK71gdhwTcc9NYq03MItGngcZEjwLdU76GehP94IPIaKX93z4CRD06p9iCjY/a
H1Jj4Hj8bWLsYmP+NG+Fc4fQDRy2rt/NTqpaK/+nl4GvcrVNBbW6jxM1aTZESy8b
pMRHEGA/iGewAkstVs5xZIX+97KyVdxEtJN2kz3T9Lp5lKbt+JFA3aajJ91RjxNx
xezC3Fp8202Sh75kd+0JKf3ScQifqoRWcURQ+qX6BxS0TIY79jBPLRUuzMWYRaWR
u+CLL7Qi7SeHRjbN0sqMzymNPHvOAAesipVmm74oXkzKf28DeyPZjDkbMAp5Sv0T
Z9iKd0xQePi7PomQkA0Uw7V5P93Efk8fjS6tHLGP6Q/OiM6an+8=
=Q2DB
-----END PGP SIGNATURE-----

--ez+8O1Ga0KkF3sRt--
