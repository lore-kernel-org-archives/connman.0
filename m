Received: from gmmr2.centrum.cz (gmmr2.centrum.cz [46.255.227.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057203FC1
	for <connman@lists.linux.dev>; Tue, 31 Aug 2021 05:24:02 +0000 (UTC)
Received: from gmmr-1.centrum.cz (unknown [10.255.254.24])
	by gmmr2.centrum.cz (Postfix) with ESMTP id 0A82A6000DF2;
	Tue, 31 Aug 2021 07:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=centrum.cz; s=mail;
	t=1630387370; bh=f1PQ9fv6gkAvMzh1vwjNw6hxZyYGdaubEy3dVWaxfe0=;
	h=From:To:Cc:Subject:Date:From;
	b=CAAn2KgTYqXYxV3V2iGEMwUxqt672Yitz5VuYaiReko+dE+aCN1U0gFO0ySYtG0UW
	 oJLgPFiq7sbkWckmLW92/ndEtanxbZ0LRmM3DuUBvEqZP/HPrC7gRhsXZOgmH3CKEX
	 6Sq/zgNKABGH+TYQWdMdx1jjyaqB9mGPL6PA+3Dc=
Received: from vm1.excello.cz (vm1.excello.cz [IPv6:2001:67c:1591::3])
	by gmmr-1.centrum.cz (Postfix) with QMQP
	id 0771B3000F57E; Tue, 31 Aug 2021 07:22:50 +0200 (CEST)
Received: from vm1.excello.cz by vm1.excello.cz
 (VF-Scanner: Clear:RC:0(2a00:da80:0:502::7):SC:0(-8.7/5.0):CC:0:;
 processed in 0.4 s); 31 Aug 2021 05:22:50 +0000
X-VF-Scanner-ID: 20210831052249.643131.6982.vm1.excello.cz.0
X-Spam-Status: No, hits=-8.7, required=5.0
Received: from gmmr-1.centrum.cz (2a00:da80:0:502::7)
  by out2.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384); 31 Aug 2021 07:22:49 +0200
Received: from gm-smtp11.centrum.cz (unknown [10.255.254.11])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id 8A5912005B9A5;
	Tue, 31 Aug 2021 07:22:49 +0200 (CEST)
Received: from latitudemachine.localnet (unknown [193.165.137.202])
	by gm-smtp11.centrum.cz (Postfix) with ESMTPA id 8144D18054D35;
	Tue, 31 Aug 2021 07:22:49 +0200 (CEST)
From: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] documentation of new openconnect input fields
Date: Tue, 31 Aug 2021 07:22:47 +0200
Message-ID: <6068893.KbCWHUxhU6@latitudemachine>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8200875.0nS6bDsfTd"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart8200875.0nS6bDsfTd
Content-Type: multipart/mixed; boundary="nextPart3308353.V8tTSKWl0a"; protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: =?utf-8?B?THVrw6HFoQ==?= Karas <lukas.karas@centrum.cz>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] documentation of new openconnect input fields
Date: Tue, 31 Aug 2021 07:22:47 +0200
Message-ID: <6068893.KbCWHUxhU6@latitudemachine>

This is a multi-part message in MIME format.

--nextPart3308353.V8tTSKWl0a
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Daniel. 

Here is documentation of new openconnect input fields.

 - authentication group (OpenConnect.Group)
 - second password (OpenConnect.SecondPassword, OpenConnect.UseSecondPassword)

Regards, Lukas

--nextPart3308353.V8tTSKWl0a
Content-Disposition: attachment; filename="0001-documentation-of-new-openconnect-input-fields.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="utf-8"; name="0001-documentation-of-new-openconnect-input-fields.patch"

From c30c0f4cc76b324e69e6deb0c1101ca0bb87649c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Karas?= <lukas.karas@centrum.cz>
Date: Tue, 31 Aug 2021 07:07:57 +0200
Subject: [PATCH] documentation of new openconnect input fields

Recently added input fields:
 - authentication group (OpenConnect.Group)
 - second password (OpenConnect.SecondPassword, OpenConnect.UseSecondPassword)
---
 doc/vpn-agent-api.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/vpn-agent-api.txt b/doc/vpn-agent-api.txt
index ffa6fadd..ecc8faaa 100644
--- a/doc/vpn-agent-api.txt
+++ b/doc/vpn-agent-api.txt
@@ -85,6 +85,10 @@ Fields		string Username
 			Return the OpenConnect cookie value that is used for
 			authenticating the VPN session.
 
+		string OpenConnect.Group
+
+			Choose authentication login group.
+
 		string OpenConnect.PKCSClientCert
 
 			Informational field containing a PKCS#1/PKCS#8/PKCS#12
@@ -96,12 +100,21 @@ Fields		string Username
 			Password for decrypting PKCS#8/PKCS#12 client
 			certificate.
 
+		string OpenConnect.SecondPassword
+
+			Second factor password for authentication.
+
 		string OpenConnect.ServerCert
 
 			Return the OpenConnect server hash used to identify
 			the final server after possible web authentication
 			logins, selections and redirections.
 
+		boolean OpenConnect.UseSecondPassword
+
+			Indicates that second factor password is used
+			for selected authentication group.
+
 		string OpenConnect.VPNHost
 
 			Return the final VPN server to use after possible
-- 
2.27.0


--nextPart3308353.V8tTSKWl0a--

--nextPart8200875.0nS6bDsfTd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEHpwLEdVNCIHcrTqZhcquo3dMC18FAmEtvKgACgkQhcquo3dM
C19m2Af+NTXfDwvlfiP9954oBQfUsPgUx7UkUvSHHjeeLOTihtGttG13iANG1j3i
y1seI0zGKWjjsZU4zy3cGuKSNSIgHghPL9usHa/SquU5rq9gHawF5v1RuX7Jo/FR
/Yb07UWBHKolAvN9Kh5mjhwngsxJr8qDunvpG5XKgrXMZb4ahXNfxwtYwgEe4OA5
qyXCjeRgs1roOdV7sos97sxLVyhYJpQVoBGC2s+I/M8Otc2Hr3biGUNZmTJ7n8l/
xDqaR/QVhyPYvv3WNdH4kWncabf0x9YZUU6O4Asl3CrEIvmQ/0CdIpggGr43gkYY
ntnHGQEIUviGg8Gdg1pnkMjFGqylpw==
=HFXN
-----END PGP SIGNATURE-----

--nextPart8200875.0nS6bDsfTd--



