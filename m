Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.45.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883707;
	b=iaF++sk7ddnyZiPMR0YfS/7SG6nNb4yVzKRY8Z0fZBwn1C5+ZbE4XaNw8zuDSjrgnDFw
	 4EwX90pJGWYNTWemsD9lZwC/yPTSzSXOjMHykiJ0l2u0KuaOmBP9XGxoHdtsoP7PycNIb
	 OQPQb4gOABYvfCN2Bq+Fyd48HbQDpqyqMroeaMlXgf3wDVm3atld70s6Ie40odYxgd1ll
	 WH27wNGg83HGf4o0NiZcuBOLejnnEHlG1H02sGWUjSJESkRMV7o3d0KVCv642I1ZRUe4i
	 Kz1xkX8Ldec7NBTUPTg91U0ZoFr5iiAwFc3bhnUKkMOTIcf0bH6m0ix0AfRPC86/OKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883707;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:x-ovh-tracer-id:
	 X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE;
	bh=iQQUCz4AJZa9orcHUhR7FBZW0DbiJsPoXldVnNwnhMQ=;
	b=cuVaxGgWnL4qXnE8lepXgL1713xVFy0MuZ//7cho8RFLDsIZaHeAgcDYZo4YN/O5mSrX
	 DACfRJD1Jg5t4Vhmh37Tkc3Ufo/CTaruZEV1KmGF6SmtxYwzeYiQaipN8VFMLzsmvdy93
	 obGlo4VmJxzuh2xIoqvnRRjgrHAuZ1qpiL5/Ic8FD6KiZUAHpc9YU+ZXMzY950Bfy5B5I
	 x+oxAfkZ9xGIWj5hxjnbnfKlRWLUKBdmnLUJBhVTKV5PpPdYKLEH3xb3U9zxfVXoMEwpG
	 6nrvobQ/DZYrSNKlqeBOsezNAeg5dAB0gQtupZuuhgMHNa9NKtpgGBbG1nbAhTcPn/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=46.105.45.98
Received: from 7.mo546.mail-out.ovh.net (7.mo546.mail-out.ovh.net [46.105.45.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB4606A332
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DFB4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.108.42.159])
	by mo546.mail-out.ovh.net (Postfix) with SMTP id 4jL2WQ6jGcz5wjp
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:38 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [PATCH 3/3] service: Keep the DUID when resetting IPv6 config
Date: Thu, 5 Nov 2026 13:01:31 +0000
Message-ID: <20261105130131.523894-4-email@samnazarko.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105130131.523894-1-email@samnazarko.co.uk>
References: <20261105130131.523894-1-email@samnazarko.co.uk>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: CAS1.indiv.local (172.16.1.1) To DAG16EX2.indiv.local
 (172.16.2.162)
x-ovh-tracer-id: 9093330601520779244
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFM1Gfex4DDr5KdJAbPHqToa9nfMNNiZRyNW5b79/2vj/x5Lmwg57pJqDkLFO61imTUk9xeVb6fZecuiR9+ajPf276IC2Ht7Gw3XO/kEJy9AkGZamwjbMdBKeS/m+yQ8KGnIbW6elHYd7x+FnDGY1dkplcWfpf7118IlLw9XqkgwMKKCoy2VRsMaSiFu44Q0wSZs3uRkExZES552zlQLCbrM5ThUcrTavsiuTeNmyg0fkTP4IVz7fje4HsYiONQpAoiY0ttM8aSBEm1G42eDzyBRZAhzoEiUd7oXwAKbqbq3vllwfNXja/zyNsbRDCI54KxoyaUTvRIgHrprU83K7d5IGpnQJbapINKrTr3AjOAmSl717SymAnUxyBMGsH6kiH5/czPqcRWDs0U9k4jlosqXobwXfWdT2YJ3CEnE4N0u1YNelLc29phAib2+wUtr9H9KqzbrmOwf3gOyyV0ZNjnbrs0XqVQBky2XXtZyQgbvTyDeKUZk2Ua+RkOqiaZfiqOlOEqhf3vDz/3kn9PjRlD0O0UrIyIic03lKID7pMC4j7NraFosvLXr6/ll1uAxCTFVYvOrRxAnXi8SrnndL8dvQd7z03yk/rXR2ehHyUefHpgHf4B2l3HOWaGai7qXtSxPZnjHyVKXTk1JI0ZZ0AiwD3YRSazOPYRPlkhA7KmFg

Setting IPv6.Configuration replaces the service's IPv6 configuration
with a new one that has no DHCPv6 DUID, and the following save drops
the stored DUID, so the next DHCPv6 start creates a different one.

Copy the DUID to the new configuration, as it identifies the client
rather than the configuration.
---
 src/service.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index d5869b14..96dcfd5e 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6335,12 +6335,17 @@ int __connman_service_reset_ipconfig(struct connman=
_service *service,
 	old_method =3D __connman_ipconfig_get_method(ipconfig);
 	index =3D __connman_ipconfig_get_index(ipconfig);
=20
-	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4)
+	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4) {
 		new_ipconfig =3D create_ip4config(service, index,
 				CONNMAN_IPCONFIG_METHOD_UNKNOWN);
-	else
+	} else {
 		new_ipconfig =3D create_ip6config(service, index);
=20
+		/* The DHCPv6 DUID belongs to the service, keep it */
+		__connman_ipconfig_set_dhcpv6_duid(new_ipconfig,
+				__connman_ipconfig_get_dhcpv6_duid(ipconfig));
+	}
+
 	if (array) {
 		err =3D __connman_ipconfig_set_config(new_ipconfig, array);
 		if (err < 0) {
--=20
2.34.1

