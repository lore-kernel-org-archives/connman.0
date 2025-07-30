Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2AF635
	for <connman@lists.linux.dev>; Wed, 30 Jul 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867222; cv=none; b=UpjSh/ExJ0M+/bDmdFbXUsrsnOhzl2Kh6R3W+n/6bFLIl+Bi0hFGc0cKD/08cfV6KZI9R08HGrBbG/eppBRqJs2qkwk1XdjpN8J8zcDfu4bgfoxGPJdA4lJiBze3XqNgiEb7lMZrsc6SpSbFYEYlFtsWo5nPMxjXlIXeIpV9rEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867222; c=relaxed/simple;
	bh=40D5yxOSE7mGyCHnGFlmZT2v9LGii3p+rLM2n7PfOEg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=rs3A58u4QqnSRyvRMVkTcP+aKDOe3KYge1XGKXr4hcC2CUrLuwnuw0/6hNMKxy3235fZnLrbH3j6C2WYje8b5WDxYGnZVBmwJ2k3L1Hk4NGWFFWf9wip3oSEfq4c6Xe7/bx83c6/iH/Va4gVmeZ6G+hDU9mCaAF19gZWPO8B8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BETASllQ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BETASllQ"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250730092017euoutp01379c97369d5238948920f94b3afb585e~W-PEjWS5x1080110801euoutp01M;
	Wed, 30 Jul 2025 09:20:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250730092017euoutp01379c97369d5238948920f94b3afb585e~W-PEjWS5x1080110801euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753867217;
	bh=9AUQ4shNQt6Z9LAxfAACaNTrMGvjHdDFSGCDFPOHTUA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:From;
	b=BETASllQt1LdCt/4OZMkUBiKo5zGlg1NEoPJxO8SkwcqCGt60WrH9/TyVD0r79SPn
	 TFdK50y8yYa39Zc0f9TTR9nmpmi4E0GuEwYdPufZ0FFZcMvrg8tV21fVtpr8kTuZEq
	 iXCpuNaSmbCALTFoT+1y291CHPHZEsOe/bszvIMU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250730092017eucas1p2c3851407d61294f44bc90964d38f5155~W-PEFLCSU0798107981eucas1p2Q;
	Wed, 30 Jul 2025 09:20:17 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250730092016eusmtip15a61140708958282ad811b57d90402f6~W-PEBY3K_2748827488eusmtip1u;
	Wed, 30 Jul 2025 09:20:16 +0000 (GMT)
From: Lukasz Stelmach <l.stelmach@samsung.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev,  m.szyprowski@samsung.com,
	k.lewandowsk@samsung.com
Subject: Re: [PATCH] Adjust printf(3) formats for 32-bit platforms
In-Reply-To: <3717461C-D785-4074-B43B-6297BCBE0EED@nuovations.com> (Grant
	Erickson's message of "Mon, 28 Jul 2025 15:37:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 30 Jul 2025 11:20:16 +0200
Message-ID: <oypijd5xfarq5r.fsf%l.stelmach@samsung.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
	protocol="application/pgp-signature"
X-CMS-MailID: 20250730092017eucas1p2c3851407d61294f44bc90964d38f5155
X-Msg-Generator: CA
X-RootMTR: 20250721141728eucas1p26fc6074b92a22ad65366edd47a7c588a
X-EPHeader: CA
X-CMS-RootMailID: 20250721141728eucas1p26fc6074b92a22ad65366edd47a7c588a
References: <CGME20250721141728eucas1p26fc6074b92a22ad65366edd47a7c588a@eucas1p2.samsung.com>
	<20250721141712.796989-1-l.stelmach@samsung.com>
	<3717461C-D785-4074-B43B-6297BCBE0EED@nuovations.com>

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2025-07-28 pon 15:37>, when Grant Erickson wrote:
> On Jul 21, 2025, at 7:17=E2=80=AFAM, =C5=81ukasz Stelmach <l.stelmach@sam=
sung.com> wrote
>> On 32-bit platforms time_t may be defined as long long int to make it
>> 64-bit wide and y2038 compatible. On 64-bit platform with LP64 data model
>> ABI long long is also 64-bit, so it is convenient and safe to always
>> cast time_t to long long and use %lld/%llu format on all platforms.
>
> =C5=81ukasz:
>
> Had you considered using the mnemonics in inttypes.h to avoid the cast su=
ch as:
>
> 	selection_str =3D g_strdup_printf("%s:%=E2=80=9D PRId64 "",
> 	device->last_user_selection_ident, device->last_user_selection_time)
>

Yes, I had. Alas, there is no mnemonic for time_t in glibc like for
example PRIdTT that matches time_t on current platform and time_t may be
different on different platforms. Using PRId64 would cause problems on
some 32-bit platforms. Even on the same hardware glibc may be configured
in different ways. With newer gcc even same sized types (e.g long and
long long on ILP64 platforms) trigger warnings/errors when checking
printf(3) formats and arguments. I figure casting "upwards" to long long
is the safest and most portable, albeit not too pretty, way to solve
this problem.

Take for example this code

=2D-8<---------------cut here---------------start------------->8---
#include <stdio.h>
long a =3D 1L;
long long b =3D 1LL;

int main(int ac, char  *av[]) {
  printf("sizeof(a): %ld\n", sizeof(a));
  printf("sizeof(b): %ld\n", sizeof(b));

#ifdef WITH_ERRORS
  printf("%ld %ld\n", a, b);
  printf("%lld %lld\n", a, b);
#endif
}
=2D-8<---------------cut here---------------end--------------->8---

Compile it once

    gcc -o longs longs.c
=20=20=20=20
and run and then trigger the warnings

    gcc -Wformat -DWITH_ERRORS -o longs longs.c

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmiJ49AACgkQsK4enJil
gBDlxwf/Zot+Erwe8gxAGi3ZQvGU6rP9LOyua9C8WlorbKwTmvn+TcQisYXAHbGe
J37o55OGTpYT1uAE/QFqbQWayfzrD0BTS4z9P94W1wZwiPzj/IYmRDnqR5rsuklm
UEZgWpWqyUYCCE0uozogGTXFuuH5rve4c4BInLQkUn4QFKh6fLcwWI9HQix4dWcW
/rC5Wb3BDxr+uqTMnKafFVU8oNuGa4OLls0nQ6sO3StLuwRk5ulUympkWfi0shnx
Uqc2PnXKPumCL5vQprVs94koAZAvN36f1/psJJF3sOO4PsXIZQvSbHLbkdbmleY2
IqVMHQcAFGlMWHukI7KiEXXlPqbF1Q==
=btaR
-----END PGP SIGNATURE-----
--=-=-=--
