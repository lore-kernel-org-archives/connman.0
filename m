Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2C1C2B1
	for <connman@lists.linux.dev>; Fri,  1 Dec 2023 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpV2lMBG"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50bc21821a1so2488022e87.0
        for <connman@lists.linux.dev>; Thu, 30 Nov 2023 22:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701412273; x=1702017073; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=74GGO/73dMW3fVERnrmJfcwONId80jAnGKMrGNUne3M=;
        b=gpV2lMBG1AizIDSFlpFU/bLnUJr+4R6DOJqqHXJTdA4vsRU1HoxDPfICe927nP/UIy
         cx5cf1E/KECeWlOWI7yD8QTgqYCvppQ94DzNtadDRIaXklAOheLKttpzOo+quN0qNOW0
         VOAYXxjH772sP3W2WVyqqdsriaUetzgHGxoy5khx50DR+EDyNe1vqjGRumx4Kb8h9X3f
         O6l3M1wnsHR3Av80uWMc5ctt8yTdiM1pm2ibMOl4pfZ9IjL4fAlHbQOf3kWOOcBacKvg
         Rcb2JcJbOGTTmwISMHjM8Bo/5VsMyLVJsFWm9CiYeXcnYS8rMXkDdVCXU964kH/m4LoV
         MmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701412273; x=1702017073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74GGO/73dMW3fVERnrmJfcwONId80jAnGKMrGNUne3M=;
        b=BkN98FIOCmKt+KLHl0N1/ef4YYn9WGgxZt1EaeGU0UsvBHPbX9+vTC/VVWzoDOlxxV
         N96/9qqkqRXQr2Pnna5RRrY8KQ0GKWjJT8vG9mrZq3Vtl2GrFTzMfUIq+W6Sy3bwYkns
         8yk5V8CAIHSNAMFSifXSqDMujeeCL9PD3V1OkVerNfXauTfzQDLw21ySQWIRhDvmHjOM
         to+nmxHJySdUZTZnAVS4u2S96yxMOB5Nql2YanA40s6jd4/i9INEE79pKQjc8Hf9bGL+
         JngIHZk5wyWF3j4lzzRsphnGx67kmGUTW8fcNeW69w+biHsUWd4CMz3U8MRecV5u6DwL
         G3zw==
X-Gm-Message-State: AOJu0YzOKZKVdLwhs0zpGcNwsIE9KOF8QLTp6tbs/JqqJmKoX0mUrPua
	2DElOuLDVjaUSVH7/U1+lLE=
X-Google-Smtp-Source: AGHT+IFLHTvjH8THKLtLfSocmYzDSRmmCBsLdGFQHeep1Zj1ttOl4O93+I2y4oH8pjvSTK49eLKkTQ==
X-Received: by 2002:a19:9153:0:b0:50b:d764:8041 with SMTP id y19-20020a199153000000b0050bd7648041mr354964lfj.116.1701412273020;
        Thu, 30 Nov 2023 22:31:13 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id bi3-20020a0565120e8300b0050aa6bd6d8csm344951lfb.178.2023.11.30.22.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:31:12 -0800 (PST)
Date: Fri, 1 Dec 2023 07:35:43 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: KeithG <ys3al35l@gmail.com>, connman@lists.linux.dev
Subject: Re: Thanks!
Message-ID: <ZWl-v9clAt13NeP3@gmail.com>
References: <CAG17S_PomgZSoy+Z=rS-u4_TM=S33G7FMAHRqnTaf+42U0LkMw@mail.gmail.com>
 <37635FF1-7B94-4E72-913B-D1AA38A2D466@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xqV+oBLhyTZRyimH"
Content-Disposition: inline
In-Reply-To: <37635FF1-7B94-4E72-913B-D1AA38A2D466@nuovations.com>


--xqV+oBLhyTZRyimH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I can only agree with Keith, thank you.

Best regards,
Marcus Folkesson

On Wed, Nov 29, 2023 at 08:59:47AM -0800, Grant Erickson wrote:
> On Nov 29, 2023, at 6:45 AM, KeithG <ys3al35l@gmail.com> wrote:
> > A big thanks to Grant and Marcel for tackling all these issues. I was
> > concerned that connman may go away, but this renewed effort gives me
> > hope that it'll keep going for a bit longer.
>=20
> Keith,
>=20
> You=E2=80=99re welcome!
>=20
> Best,
>=20
> Grant
>=20
> --=20
> Principal
> Nuovations
>=20
> gerickson@nuovations.com
> http://www.nuovations.com/
>=20
>=20

--xqV+oBLhyTZRyimH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmVpfrsACgkQiIBOb1ld
UjLzExAAxXdl73CFQV6exbHuTHlrIxULB3aIq0gtrrDK/WhH2CklWpycyXcZMEL2
feWQ9hslIj8oWm9AXQVkhzDOW/dOrxfHLt/JXsDxEciwnPO/epamynqcUo6ZvSOa
aFQQLLbnSRsijN6UsxbLE7e6SY5EuR9/rPZ2D7/zSo4VV6Nnn8ri3fxBGATLMOu8
f+AdPX9EhNeWSP/RgiiWqm0oinJS7cIoj7VfMB2DP7gWMFMZIm5+79bEvSbovGty
4rc6UeFufxRyceiTiPM7+vndNSXvLuu7aGVnCjY7WqhKRa425k/hZ2Zz8QIJ8lI2
Y2rtFkVPnFPxb1pijM5P8IV8pT523islZt1O2n8iUlvllZZOVlrbbi8XXsDE3MR3
yhP9O33u0JrBlgEmW/c6jzoRsB2ZtvKyJPEPbSZRevr3C1ILXmyt7Xvrs6T0BTcq
Q49BOKmeYE4tjtqFTqq3eb+9tu22nhzz3O4BITdchtlAKZrqJ4J4jI3/mYs0+xp9
aL04J2gckfaGxFv9ghPEDox9IqXXPoVrHx6APGQBWlEYkIA/Waqul7cNAOBr85IE
DsAMlTLbsUj/T8WF6LgiUuz7j62+/7MHgcqMvBzPAy/mEgSYS2KVgZrLA6vF5WRk
DTJl7YohJG7ud7PAEjs1w5c4ZgBlxdfZSVAfHY6dugJY+IaKd2s=
=RWCH
-----END PGP SIGNATURE-----

--xqV+oBLhyTZRyimH--
