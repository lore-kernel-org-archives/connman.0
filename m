Received: from gmmr1.centrum.cz (gmmr1.centrum.cz [46.255.225.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC870
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 07:42:02 +0000 (UTC)
Received: from gmmr-4.centrum.cz (unknown [10.255.254.33])
	by gmmr1.centrum.cz (Postfix) with ESMTP id 5F7928043C2F
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 09:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=centrum.cz; s=mail;
	t=1623742837; bh=cK4/Y1TfnSLcPuJ40So+1+ibxNj1WretFfr2UjbgbQQ=;
	h=From:To:Subject:Date:From;
	b=AQBiPLms/oeIEG4Akm4ZvFiC9paDUvtKT/1SXkU8vTenly0MpLlDy72PTQ06v8lVK
	 v5JPIE1vg6aDcftrWjj5s04JbbD92l5rSFEm3KjP16y0SWtZOBK8rFkkUabRruRUUF
	 bGDAaaMJTonD/avYv6bHyMYWiOTARIDe/pQLv8zY=
Received: from vm2.excello.cz (vm2.excello.cz [212.24.139.173])
	by gmmr-4.centrum.cz (Postfix) with QMQP id 5DA7A100009C3
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 09:40:37 +0200 (CEST)
Received: from vm2.excello.cz by vm2.excello.cz
 (VF-Scanner: Clear:RC:0(2a00:da80:0:502::7):SC:0(-7.7/5.0):CC:0:;
 processed in 0.4 s); 15 Jun 2021 07:40:37 +0000
X-VF-Scanner-ID: 20210615074036.934736.5588.vm2.excello.cz.0
X-Spam-Status: No, hits=-7.7, required=5.0
Received: from gmmr-1.centrum.cz (2a00:da80:0:502::7)
  by out1.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384); 15 Jun 2021 09:40:36 +0200
Received: from gm-smtp11.centrum.cz (unknown [10.255.254.36])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id DD9F92005B982
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 09:40:36 +0200 (CEST)
Received: from latitudemachine.localnet (unknown [193.165.137.202])
	by gm-smtp11.centrum.cz (Postfix) with ESMTPA id D18D118054D37
	for <connman@lists.linux.dev>; Tue, 15 Jun 2021 09:40:36 +0200 (CEST)
From: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
To: connman@lists.linux.dev
Subject: [PATCH] dnsproxy: Suppress GCC warning stringop-overflow
Date: Tue, 15 Jun 2021 09:40:36 +0200
Message-ID: <2664831.oeSPPojSJB@latitudemachine>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5366202.sj8mIoeC0D"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart5366202.sj8mIoeC0D
Content-Type: multipart/mixed; boundary="nextPart6772910.5jC5zRqg1M"; protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
To: connman@lists.linux.dev
Subject: [PATCH] dnsproxy: Suppress GCC warning stringop-overflow
Date: Tue, 15 Jun 2021 09:40:36 +0200
Message-ID: <2664831.oeSPPojSJB@latitudemachine>

This is a multi-part message in MIME format.

--nextPart6772910.5jC5zRqg1M
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi all. 

Recently added check for buffer size breaks build
with GCC 10.3.0, its internal analysis suspect that code
is not correct. Build fails with error:

  '__builtin_strncpy' specified bound depends on the length
  of the source argument [-Werror=stringop-overflow=]

on src/dnsproxy.c:1794

I not sure if suppressing compiler warning is a good practice 
in Connman, but it fixes build for me :-)

Lukas

--nextPart6772910.5jC5zRqg1M
Content-Disposition: attachment; filename="0001-dnsproxy-Suppress-GCC-warning-stringop-overflow.patch"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset="utf-8"; name="0001-dnsproxy-Suppress-GCC-warning-stringop-overflow.patch"

=46rom 3c605b7c2798ba5cb3ae8afdadc31f68337228b0 Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Luk=3DC3=3DA1=3DC5=3DA1=3D20Karas?=3D <lukas.karas@cent=
rum.cz>
Date: Tue, 15 Jun 2021 09:23:39 +0200
Subject: [PATCH] dnsproxy: Suppress GCC warning stringop-overflow
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Recently added check for buffer size breaks build
with GCC 10.3.0, its internal analysis suspect that code
is not correct. Build fails with error:

  '__builtin_strncpy' specified bound depends on the length
  of the source argument [-Werror=3Dstringop-overflow=3D]

on src/dnsproxy.c:1794

Signed-off-by: Luk=C3=A1=C5=A1 Karas <lukas.karas@centrum.cz>
=2D--
 src/dnsproxy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 38dbdd71..035593e9 100644
=2D-- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -41,6 +41,8 @@
=20
 #include "connman.h"
=20
+#pragma GCC diagnostic ignored "-Wstringop-overflow"
+
 #define debug(fmt...) do { } while (0)
=20
 #if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
=2D-=20
2.27.0


--nextPart6772910.5jC5zRqg1M--

--nextPart5366202.sj8mIoeC0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEHpwLEdVNCIHcrTqZhcquo3dMC18FAmDIWXQACgkQhcquo3dM
C18kHwgAtxeuM6TT9nPJVBmr3UaGirVXG2tOK3VBp+FU/FltjW4xxO0c2J5mir2v
UqWARtZqOY5k8Wo0HQ7zeJTBw0wQ0/KqbBb0rsjVWo2Yu9qNaUgO23hxuq4rGAP/
XQi7cWArAMwPb5STEzG4PtzWT9UOnyQAiN1bvlILYldIJGlraJ0OlwPuvws8oWQM
2bk0Jk5KeuP6ZRcjMYPIAP/970kjyxPSC1XCG84lru1P3WGAghEkyulvSHZwxTPS
pYXwRCIyhU5+wuBGIqxNfZNbfgCk10s8d17qnDWBPuYf6rxWi7XI1hX0R4/bmMDU
i9WYn1mvvPQIZpG/Ymex/xAahBiTDw==
=VVq8
-----END PGP SIGNATURE-----

--nextPart5366202.sj8mIoeC0D--



