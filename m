Received: from gmmr3.centrum.cz (gmmr3.centrum.cz [46.255.225.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320D72
	for <connman@lists.linux.dev>; Fri, 18 Jun 2021 09:29:08 +0000 (UTC)
Received: from gmmr-4.centrum.cz (unknown [10.255.254.15])
	by gmmr3.centrum.cz (Postfix) with ESMTP id 815AF18009566
	for <connman@lists.linux.dev>; Fri, 18 Jun 2021 11:27:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=centrum.cz; s=mail;
	t=1624008429; bh=H4Ei3a/ub9T0z5ooXtocRWY559x2Y6Ie0aOZYD8W75k=;
	h=From:To:Subject:Date:From;
	b=VN4ZC/MEWIA3IOEteEYjOBcZCq2toCfiYFwAxNH1j98rp0Ihf7PDZ1yx2oYGjg06I
	 3Azk2jawwyE3uJc4I5Y/pAohlTxH8vyIVM0unOniClush/+ux1ml5eLGXjLil5D+IV
	 DPRyU33NMzeD3KiY4ffrh8mxapJOwtLqZzQGmIj8=
Received: from vm2.excello.cz (vm2.excello.cz [212.24.139.173])
	by gmmr-4.centrum.cz (Postfix) with QMQP id 7F6CF10003925
	for <connman@lists.linux.dev>; Fri, 18 Jun 2021 11:27:09 +0200 (CEST)
Received: from vm2.excello.cz by vm2.excello.cz
 (VF-Scanner: Clear:RC:0(2a00:da80:1:502::8):SC:0(-7.7/5.0):CC:0:;
 processed in 0.3 s); 18 Jun 2021 09:27:09 +0000
X-VF-Scanner-ID: 20210618092709.187472.18026.vm2.excello.cz.0
X-Spam-Status: No, hits=-7.7, required=5.0
Received: from gmmr-4.centrum.cz (2a00:da80:1:502::8)
  by out1.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384); 18 Jun 2021 11:27:09 +0200
Received: from gm-smtp10.centrum.cz (unknown [10.255.254.22])
	by gmmr-4.centrum.cz (Postfix) with ESMTP id 2704220056054
	for <connman@lists.linux.dev>; Fri, 18 Jun 2021 11:27:09 +0200 (CEST)
Received: from latitudemachine.localnet (unknown [193.165.137.202])
	by gm-smtp10.centrum.cz (Postfix) with ESMTPA id 22881C0638FF
	for <connman@lists.linux.dev>; Fri, 18 Jun 2021 11:27:09 +0200 (CEST)
From: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
To: connman@lists.linux.dev
Subject: [PATCH] replace strncopy by memcpy
Date: Fri, 18 Jun 2021 11:27:07 +0200
Message-ID: <1834096.Zu5ogFxJLL@latitudemachine>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1780249.IuOgQU6FN5"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart1780249.IuOgQU6FN5
Content-Type: multipart/mixed; boundary="nextPart3499806.aVDzxt9AYX"; protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
To: connman@lists.linux.dev
Subject: [PATCH] replace strncopy by memcpy
Date: Fri, 18 Jun 2021 11:27:07 +0200
Message-ID: <1834096.Zu5ogFxJLL@latitudemachine>

This is a multi-part message in MIME format.

--nextPart3499806.aVDzxt9AYX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

This patch fixes build with GCC 10.3.0, that fails with warning/error:

  '__builtin_strncpy' specified bound depends on the length
  of the source argument [-Werror=stringop-overflow=]

Destination buffer size is is checked properly,
memcpy is equivalent to strncpy here as pointed by Santtu.

This patch replaces my previous one:
"dnsproxy: Suppress GCC warning stringop-overflow"

Lukas

--nextPart3499806.aVDzxt9AYX
Content-Disposition: attachment; filename="0001-replace-strncopy-by-memcpy.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="utf-8"; name="0001-replace-strncopy-by-memcpy.patch"

From 3dca8ec863d60a3bfd81baeb56255742c242ad93 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Karas?= <lukas.karas@centrum.cz>
Date: Fri, 18 Jun 2021 11:09:04 +0200
Subject: [PATCH] replace strncopy by memcpy

Destination buffer size is is checked properly,
but GCC 10.3.0 analysis fails to detect it and prints stringop-overflow warning.
Memcpy is equivalent to strncpy here, because ulen = strlen(name) + 1.
---
 src/dnsproxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 38dbdd71..4b65b379 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1791,7 +1791,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 		ulen = strlen(name) + 1;
 		if ((uptr + ulen) > uncomp_end)
 			goto out;
-		strncpy(uptr, name, ulen);
+		memcpy(uptr, name, ulen);
 
 		debug("pos %d ulen %d left %d name %s", pos, ulen,
 			(int)(uncomp_end - (uptr + ulen)), uptr);
-- 
2.27.0


--nextPart3499806.aVDzxt9AYX--

--nextPart1780249.IuOgQU6FN5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEHpwLEdVNCIHcrTqZhcquo3dMC18FAmDMZusACgkQhcquo3dM
C19HAwf/dw1sEO/OCSrmyfeWnFZW6GUGJSS9NG31NK68ljRI/16MbpSx6DIYbSk1
MaN5TWJQ1iTKEGjqUOi9cKceysM9mr1hOMXe6+trQK1pi4Yjf94nIAbKXNwMjh3b
VTCEoUFknyWYJ0Bkm2WQj4t/ZlB5rXZrBdtEIAo2UZig16iJugK0pE+OkiMa4V9D
Cu0fCyX3kH6XIACQpNKP/esyZNnesBXXGFVwF7Hbal9AkgIbUAye2/BGkH1fS6Qc
blJdVMhBOmX2ewqpKbLSpuCRlHkHkRe/Kh195jCB0JAG4ZgVYh2dKxc0P2sZJhdx
DjlDpY5fU5MDMyM4vgEGOO8alPqpcw==
=Uzxk
-----END PGP SIGNATURE-----

--nextPart1780249.IuOgQU6FN5--



