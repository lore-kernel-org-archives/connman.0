Received: from gmmr3.centrum.cz (gmmr3.centrum.cz [46.255.225.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A43FC2
	for <connman@lists.linux.dev>; Mon, 30 Aug 2021 06:54:03 +0000 (UTC)
Received: from gmmr-1.centrum.cz (unknown [10.255.254.11])
	by gmmr3.centrum.cz (Postfix) with ESMTP id F3CAB18000078;
	Mon, 30 Aug 2021 08:52:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=centrum.cz; s=mail;
	t=1630306323; bh=wOdBaAqHmLKdL/nTjWcKMMo6rxMmTGEu9tpmTNrHEU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kfcWS71CrnbUgFeASnNUxPGA+1t0GjpymOVyElPgR+8H/MNc4Yw/UsyIt9/Mb5ypI
	 UMGO9qa05X9KxTjLwBFf5edSo4FU+SSmC7E7+VN1sLPllKnupw4X30LEYVjgpopRkj
	 ib2xEsmQYuhYR3aMX88SrLa+qJKj9bX3WbhhYJU8=
Received: from vm1.excello.cz (vm1.excello.cz [IPv6:2001:67c:1591::3])
	by gmmr-1.centrum.cz (Postfix) with QMQP
	id EFD4B3000DD7E; Mon, 30 Aug 2021 08:52:02 +0200 (CEST)
Received: from vm1.excello.cz by vm1.excello.cz
 (VF-Scanner: Clear:RC:0(46.255.225.205):SC:0(-7.6/5.0):CC:0:;
 processed in 0.3 s); 30 Aug 2021 06:52:02 +0000
X-VF-Scanner-ID: 20210830065202.698177.16066.vm1.excello.cz.0
X-Spam-Status: No, hits=-7.6, required=5.0
Received: from gmmr-3.centrum.cz (46.255.225.205)
  by out2.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384); 30 Aug 2021 08:52:02 +0200
Received: from gm-smtp11.centrum.cz (unknown [10.255.254.11])
	by gmmr-3.centrum.cz (Postfix) with ESMTP id 9656B200584CF;
	Mon, 30 Aug 2021 08:52:02 +0200 (CEST)
Received: from latitudemachine.localnet (unknown [193.165.137.202])
	by gm-smtp11.centrum.cz (Postfix) with ESMTPA id 896FC18054D2C;
	Mon, 30 Aug 2021 08:52:02 +0200 (CEST)
From: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, Santtu Lakkala <santtu.lakkala@jolla.com>, Jussi Laakkonen <jussi.laakkonen@jolla.com>
Subject: Re: Re: [PATCH] make possible to use alternative auth group with 2nd password
Date: Mon, 30 Aug 2021 08:52:01 +0200
Message-ID: <15534700.KoKU9GZOxT@latitudemachine>
In-Reply-To: <20210805061457.abhvax5ow55z4hwt@beryllium.lan>
References: <1666033.JRX4bv1jlI@latitudemachine> <20210805061457.abhvax5ow55z4hwt@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2466957.ALhgOfSB0L"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2466957.ALhgOfSB0L
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
To: Daniel Wagner <wagi@monom.org>
Cc: connman@lists.linux.dev, Santtu Lakkala <santtu.lakkala@jolla.com>, Jussi Laakkonen <jussi.laakkonen@jolla.com>
Subject: Re: Re: [PATCH] make possible to use alternative auth group with 2nd password
Date: Mon, 30 Aug 2021 08:52:01 +0200
Message-ID: <15534700.KoKU9GZOxT@latitudemachine>
In-Reply-To: <20210805061457.abhvax5ow55z4hwt@beryllium.lan>
References: <1666033.JRX4bv1jlI@latitudemachine> <20210805061457.abhvax5ow55z4hwt@beryllium.lan>

Hello guys.=20

Did you find some time to look at this patch? It would be great to support=
=20
openconnect with second factor authentication and alternative groups.

Btw, if I understand the code, connman form API doesn't support updating=20
of form fields dynamically right? (After change of openconnect group)

Lukas

Dne =C4=8Dtvrtek 5. srpna 2021 8:14:57 CEST Daniel Wagner napsal(a):
> Hi Lukas,
>=20
> On Wed, Aug 04, 2021 at 06:39:39PM +0200, Luk=C3=A1=C5=A1 Karas wrote:
> > Some servers are configured with multiple authentication groups.
> > OpenConnect request just authentication entries that are valid
> > for specific group (process_auth_form method). So, authentication
> > group have to setup first, and new form have to be requested then.
> >=20
> > Some authentication groups may require secondary password.
> > For example one-time password from Google Authenticator app.
>=20
> From my quick glance it looks reasonable.
>=20
> @Santtu, as you have done some serious work recently on the plugin, do
> have any objections?
>=20
> Daniel
--nextPart2466957.ALhgOfSB0L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEHpwLEdVNCIHcrTqZhcquo3dMC18FAmEsgBEACgkQhcquo3dM
C19rAAf+O1VLQFPh01t4IGVfwW19isW5PE0QxC3fay1OiKYTGgRAT2vry8Rc31Su
LkMYxnrG4y9JHmJe3bV1UUQDa2ec096UHH1v2EMlUgff4IK8xP3e1Nk4QTbHcxZ+
wXBzo3hCe6/YB7diDRSknaVfCDnTA7RP6gcoqZNpOHaX7xST3Gq4Xt9DiDYOJgH+
zJtbQUXjYiA7QYDTJ88+18erL0X6klOVnDYRg19STYYqrdccnFJnmFoMzVdR9W5M
n1Zk1cJIj+XiJh/VyC9PQfF/cmCE5PbHiSb4Dqdz88+W1eoz1hGJzRd0H0xfOCXE
rUwEVdb0nps/JTnDdg8wnOXB08L8FQ==
=gQrb
-----END PGP SIGNATURE-----

--nextPart2466957.ALhgOfSB0L--



