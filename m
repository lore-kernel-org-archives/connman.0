Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=146.59.177.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883707;
	b=m8/mUtZO2hMlnscVnjfngLNLReCLgD+Xm3GSzT1i8cB2j+KoebnmO0x0QRz/IFRYmXh5
	 2HVGvM0WnqX8VFm1jMkRxEV28v3+xQ1l3a9+S0hfZixQXrW5yUwtFVJg2c0ETBhPuTJ9O
	 kI8puIjyKlHziU9Qb+tNYYZa0bCdwn8othwyqtY7ns4hNg6v1x8bzSQrWIR+IMfMaKrVj
	 Wok6p9QLUCIIgmp1519n44GrHzQuFO9rj0BVsLVxtelYZGa9WyycIOcJWm7YyiFhnzFEM
	 hAMAXqNhUu8Da3oYWoJUIoQ+PsjA6W6Nbsy3vF3FXfrOFStwxLti1REWdMR1dOjQAUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883707;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:x-ovh-tracer-id:
	 X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE;
	bh=+yDCAzqUxWHG3JbMYOc81mnV2P2J+uhTZBGioOclDK8=;
	b=KBv3NA8/MHwp4JLG+TluAGHV71ORpMgCgSPU8N6ozmmdw6Mqvhpg108ybOaYd7F6Z7Z9
	 iJM9PJmbQrq4ElRZ5duWR0WEfzmf4V93kdX4FYVkZiq9oxaNHLlYFT0ShRHgLws3Lf2XD
	 bA/1nAi8dZnfUnEzdNlk0Se9o5jfY5s7PxSFYbMCMeMb8kR169JomNkVxcAnMmpBnox0V
	 3iD7vLlrSqmh99e7OMfxJzn55BbRHLunUDV9HWuw0b3fVqwaO/EKLxmot0sirtbb0pgwm
	 c37iOe4qy0W+azVSQLfX+YqaINAhVR3px0bIhUzHGgwlVDHQL3HCRgzuXFDofEchHLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=146.59.177.42
Received: from smtpout11.mo541.mail-out.ovh.net (smtpout11.mo541.mail-out.ovh.net [146.59.177.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062C606A336
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8062C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.108.42.159])
	by mo541.mail-out.ovh.net (Postfix) with SMTP id 4jL2WQ5CDjz68GK
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:38 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [PATCH 2/3] dhcpv6: Replace an invalid stored DUID
Date: Thu, 5 Nov 2026 13:01:30 +0000
Message-ID: <20261105130131.523894-3-email@samnazarko.co.uk>
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
x-ovh-tracer-id: 9093330599437848556
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTF/6WAJh3HhOrLscjSJzNvxJSRs2p5sC+dA5lquWe8u5gCjirEcWAS4wgDUeR6ys2GAtYg+lsOP5e9tReU+TK93OJ37RPu+VcwBdMCtBIHIz7fGzFqusCM4sE93KZz0q0fKNNinOjyNVPP5SdlbtvIOIvgVeKYHLfDRxb2+CnOezWsu6NXSCA77rwgmXGvYynZAdhqOfOKizRhWG0kNlaGton6Xjuq0m3VMfNEcHu0TMSudq1pevT4e6B4ll3KXABzNHWRwwWawwj0rFMw4EKwJUz5I1bZZ8cx+i5mgryCUX8NcABjWRujCinlBUb5k0iPjOonrqXS1YHcFCVHssaF4R/mF/TpPzBlZEm4b6kAtkQLbhApaquYGxX+ZAOwdXHPc240rCmlTCuAnhC0624APnRjhwSnp99sCwIGS7p34uWlliHa+ku7W254kbIx1tybhaE7ubMWAmCYZ4lWhe9voxMamDOevlYmoJ7xiRBZLHrvLEoojKpDSCdunMBbCPpceb+xAhMSvHqzM5gN4o6+4TglxXWwMobtqI2RBbBjzWfAL+SsekbL1EYCxWoBk0z2OzJQC8msToSbsFGei/KvRm1WRjlfXIZN7dRgId6Dv6Ved7dRIXMDvKyzVlVpMU5b9EzQdtcrgvO9eX3SjDCoIYh+TBTvl4nJ8lmBDlU2ifA

A stored DUID is decoded with sscanf() without checking the result, so
a value that is not hex leaves bytes uninitialised, and a value with an
odd number of digits or fewer than three octets is used as is. Such a
value is never replaced, since a DUID is only created when none is
stored.

Accept only DUIDs of 3 to 130 octets (RFC 8415, section 11.1) written
as hex digits, and create and store a new DUID-LLT otherwise. Capping
the length also keeps the comparison with the server's reply within the
size a DUID can have.
---
 src/dhcpv6.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/src/dhcpv6.c b/src/dhcpv6.c
index 7b286ba5..9acdc9ed 100644
--- a/src/dhcpv6.c
+++ b/src/dhcpv6.c
@@ -183,6 +183,23 @@ static gchar *convert_to_hex(unsigned char *buf, int l=
en)
 	return ret;
 }
=20
+/* A DUID is 3 to 130 octets long (RFC 8415, section 11.1) */
+static bool valid_hex_duid(const char *hex)
+{
+	size_t len =3D hex ? strlen(hex) : 0;
+	size_t i;
+
+	if (len < 6 || len > 260 || len % 2)
+		return false;
+
+	for (i =3D 0; i < len; i++) {
+		if (!g_ascii_isxdigit(hex[i]))
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * DUID should not change over time (RFC 8415, section 11), so it is kept
  * with the service's IPv6 configuration and saved with the service.
@@ -201,18 +218,17 @@ static int set_duid(struct connman_service *service,
 		return -EINVAL;
=20
 	hex_duid =3D __connman_ipconfig_get_dhcpv6_duid(ipconfig);
-	if (hex_duid) {
-		unsigned int i, j =3D 0, hex;
+	if (valid_hex_duid(hex_duid)) {
 		size_t hex_duid_len =3D strlen(hex_duid);
+		size_t i;
=20
 		duid =3D g_try_malloc0(hex_duid_len / 2);
 		if (!duid)
 			return -ENOMEM;
=20
-		for (i =3D 0; i < hex_duid_len; i +=3D 2) {
-			sscanf(hex_duid + i, "%02x", &hex);
-			duid[j++] =3D hex;
-		}
+		for (i =3D 0; i < hex_duid_len; i +=3D 2)
+			duid[i / 2] =3D g_ascii_xdigit_value(hex_duid[i]) << 4 |
+				g_ascii_xdigit_value(hex_duid[i + 1]);
=20
 		duid_len =3D hex_duid_len / 2;
 	} else {
--=20
2.34.1

