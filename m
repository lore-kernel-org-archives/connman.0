Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.105.45.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883706;
	b=fhyUbZFqzMMgcEMWEy+STAUH3LA3cVTPCGBdJ/PiPj4lI3u6V8Ipe+Vpw9XMcSWyVRPN
	 IX6SFJhaRKQwtHdvLvnS879N2OSF2USv7unvO2ihuHKKoCGFUTjJI/I89z1ivkfovblr7
	 Smoalk1o9OTFIVc2GSIs5LriTz0qlkiY34C/B8MgJhsIgW4GdTJPlPGagqVdX0fY5G9Hr
	 OE7TIAJLiSPoHL0ESlFc6fu5G2uy7ap18BSB6k2zz5lLbOtVX8wnWwAlvPFCjSTYlDwzU
	 IsOjPlREvRn6exXIR4TWzims2l1rvs88JVk5Y6ZLe9znSIpzR/mo8UNipFHn6mRpv9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883706;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 x-ovh-tracer-id:X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE;
	bh=Dx5OQhghWJwhOjkOfGu3m1bjt14UuQ0T1wmAxR9E+Qc=;
	b=Ftt+LXNjstDXd2Qx/pjc7qNBlfqdOpG+r7b0Z4TaXO4iMcRxrBLyf/Dtpel6owSBmEEY
	 GOU6Cv2W2SODpFyBC+/608lPUDEwf7CbZzgQjHJi99welqp+W27/M0Hq+MI5UiR15027n
	 b75pTVsBqynUYp589uMm5lq1LYw8MCiLVJ6AtpO3NzdHSDLUyPt17GMaDpeF/vAbI3G1h
	 b99N8dFQbdSgr/h3mpIrnRD2aeUkl6h2iAR8VAZ7OXu9x7DxVUkilUfc0R+MDyDd0vo/E
	 gzEka9PCLKDogcBJ7R9HDNWjdvIoBAmBNzgqvUtX/wClFw+cLQZ5OmCY47WgFDHLZ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=46.105.45.98
Received: from 7.mo546.mail-out.ovh.net (7.mo546.mail-out.ovh.net [46.105.45.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF6606A32D
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABBF6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.111.182.219])
	by mo546.mail-out.ovh.net (Postfix) with SMTP id 4jL2WQ3852z5wLw
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:38 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [PATCH 1/3] dhcpv6: Keep the DUID across service saves
Date: Thu, 5 Nov 2026 13:01:29 +0000
Message-ID: <20261105130131.523894-2-email@samnazarko.co.uk>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CAS1.indiv.local (172.16.1.1) To DAG16EX2.indiv.local
 (172.16.2.162)
x-ovh-tracer-id: 9093330599862390764
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFYSwGYvqilNOQ9rW+k8ZSujQG8Gw6PYmCB2jpIuF0VB3uBFm585TPLntElD7eRo4QitszO/ZQDDrFgMAVX57ldEvSFQOtq/qGntOkIrFRJ9WfyRYI00stHxoYdKFRBzt9pgTF6JPiQc/phZR4Ky+1tXMMSjgmt19+i5ft6dUJYTQA6f/dyTcX1UfINTgV8Kf7UaSX/SSUyQhrQqlTjOlryvYTxrGQEgWJ+PWwfy3EvAylehb6AhwCb+qTot6XiWRkbox861HPKVtYPstkW5TO5VEZTXd+nwnWG/NWKFhTd+/nszMBVMnr8yj3jBioC5dCWaWO5zUF2QC7BeETHnXa5kyZuTGC1e/Bn2JgangM4/raHuemXNetwHvpt3bNwgVIqgt+X0PaFiK1SZzIwnzYGTdfORzW0dpPkBdKbbYchHTvUh//Ea7Nm0a8GamJnP/36Tyk1r87wU/lfnViybi+2d3abbr67GhUvoQWEAytHcWb6oMp2M2RsDn2yBGRao9/jZNA4iCXGu4ZLX5noaGMJQUCd2ilRMc/8b20JGyh38Q/HTFD4Cxjm3yIQl8iDRiF/IlB6FRhZ0+IwGA/PVlO5YURIXaU1oM6tanV8E1LE+1C5NyvAiL//5I+TvJnvUAaDYczsHphlHl7eM6Q4fQthk1dSVNAnS7ZrtaNNoUNdWA

set_duid() stores a newly created DUID-LLT as IPv6.DHCP.DUID by editing
the service's settings file directly. Since commit 0f9e6af61527
("service: Store configuration in empty keyfile") service_save() writes
every service from an empty keyfile, so the next save drops the DUID.
The following DHCPv6 start then creates a new DUID-LLT, and as DUID-LLT
contains the current time the client presents a different DUID after
every restart or reconnect. DHCPv6 servers hand out a new lease each
time and can run out of addresses. RFC 8415, section 11.2 requires a
DUID-LLT to be kept in stable storage and reused.

Keep the DUID with the service's IPv6 configuration instead, so that it
is loaded and saved with the other IPv6 settings under the same
IPv6.DHCP.DUID key. DUIDs stored by earlier versions keep being used.

Switching to DUID-LL would also avoid the changing DUID, but that type
must not be used where the interface may be removable (RFC 8415,
section 11.4), and the stored value would still be lost.

Reported on the OSMC forum by Benjamin R=C3=A9veill=C3=A9.
---
 src/connman.h  |  4 ++++
 src/dhcpv6.c   | 42 +++++++++++++++---------------------------
 src/ipconfig.c | 26 ++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 7ebda7af..5c5107d8 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -446,6 +446,10 @@ char *__connman_ipconfig_get_dhcp_address(struct connm=
an_ipconfig *ipconfig);
 void __connman_ipconfig_set_dhcpv6_prefixes(struct connman_ipconfig *ipcon=
fig,
 					char **prefixes);
 char **__connman_ipconfig_get_dhcpv6_prefixes(struct connman_ipconfig *ipc=
onfig);
+void __connman_ipconfig_set_dhcpv6_duid(struct connman_ipconfig *ipconfig,
+					const char *duid);
+const char *__connman_ipconfig_get_dhcpv6_duid(
+					struct connman_ipconfig *ipconfig);
=20
 void __connman_ipconfig_load(struct connman_ipconfig *ipconfig,
 		GKeyFile *keyfile, const char *identifier, const char *prefix);
diff --git a/src/dhcpv6.c b/src/dhcpv6.c
index 0e6b1084..7b286ba5 100644
--- a/src/dhcpv6.c
+++ b/src/dhcpv6.c
@@ -184,37 +184,30 @@ static gchar *convert_to_hex(unsigned char *buf, int =
len)
 }
=20
 /*
- * DUID should not change over time so save it to file.
- * See RFC 3315 chapter 9 for details.
+ * DUID should not change over time (RFC 8415, section 11), so it is kept
+ * with the service's IPv6 configuration and saved with the service.
  */
 static int set_duid(struct connman_service *service,
 			struct connman_network *network,
 			GDHCPClient *dhcp_client, int index)
 {
-	GKeyFile *keyfile;
-	const char *ident;
-	char *hex_duid;
+	struct connman_ipconfig *ipconfig;
+	const char *hex_duid;
 	unsigned char *duid;
 	int duid_len;
=20
-	ident =3D connman_service_get_identifier(service);
-
-	keyfile =3D connman_storage_load_service(ident);
-	if (!keyfile)
+	ipconfig =3D __connman_service_get_ip6config(service);
+	if (!ipconfig)
 		return -EINVAL;
=20
-	hex_duid =3D g_key_file_get_string(keyfile, ident, "IPv6.DHCP.DUID",
-					NULL);
+	hex_duid =3D __connman_ipconfig_get_dhcpv6_duid(ipconfig);
 	if (hex_duid) {
 		unsigned int i, j =3D 0, hex;
 		size_t hex_duid_len =3D strlen(hex_duid);
=20
 		duid =3D g_try_malloc0(hex_duid_len / 2);
-		if (!duid) {
-			g_key_file_free(keyfile);
-			g_free(hex_duid);
+		if (!duid)
 			return -ENOMEM;
-		}
=20
 		for (i =3D 0; i < hex_duid_len; i +=3D 2) {
 			sscanf(hex_duid + i, "%02x", &hex);
@@ -225,29 +218,24 @@ static int set_duid(struct connman_service *service,
 	} else {
 		int ret;
 		int type =3D __connman_ipconfig_get_type_from_index(index);
+		char *hex;
=20
 		ret =3D g_dhcpv6_create_duid(G_DHCPV6_DUID_LLT, index, type,
 					&duid, &duid_len);
-		if (ret < 0) {
-			g_key_file_free(keyfile);
+		if (ret < 0)
 			return ret;
-		}
=20
-		hex_duid =3D convert_to_hex(duid, duid_len);
-		if (!hex_duid) {
+		hex =3D convert_to_hex(duid, duid_len);
+		if (!hex) {
 			g_free(duid);
-			g_key_file_free(keyfile);
 			return -ENOMEM;
 		}
=20
-		g_key_file_set_string(keyfile, ident, "IPv6.DHCP.DUID",
-				hex_duid);
+		__connman_ipconfig_set_dhcpv6_duid(ipconfig, hex);
+		g_free(hex);
=20
-		__connman_storage_save_service(keyfile, ident);
+		__connman_service_save(service);
 	}
-	g_free(hex_duid);
-
-	g_key_file_free(keyfile);
=20
 	g_dhcpv6_client_set_duid(dhcp_client, duid, duid_len);
=20
diff --git a/src/ipconfig.c b/src/ipconfig.c
index c2d7d2bc..01e3cfcc 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -63,6 +63,7 @@ struct connman_ipconfig {
 	int ipv6_privacy_config;
 	char *last_dhcp_address;
 	char **last_dhcpv6_prefixes;
+	char *dhcpv6_duid;
 };
=20
 struct connman_ipdevice {
@@ -1577,6 +1578,7 @@ void __connman_ipconfig_unref_debug(struct connman_ip=
config *ipconfig,
 	connman_ipaddress_free(ipconfig->address);
 	g_free(ipconfig->last_dhcp_address);
 	g_strfreev(ipconfig->last_dhcpv6_prefixes);
+	g_free(ipconfig->dhcpv6_duid);
 	g_free(ipconfig);
 }
=20
@@ -1803,6 +1805,25 @@ char **__connman_ipconfig_get_dhcpv6_prefixes(struct=
 connman_ipconfig *ipconfig)
 	return ipconfig->last_dhcpv6_prefixes;
 }
=20
+void __connman_ipconfig_set_dhcpv6_duid(struct connman_ipconfig *ipconfig,
+					const char *duid)
+{
+	if (!ipconfig)
+		return;
+
+	g_free(ipconfig->dhcpv6_duid);
+	ipconfig->dhcpv6_duid =3D g_strdup(duid);
+}
+
+const char *__connman_ipconfig_get_dhcpv6_duid(
+					struct connman_ipconfig *ipconfig)
+{
+	if (!ipconfig)
+		return NULL;
+
+	return ipconfig->dhcpv6_duid;
+}
+
 static void disable_ipv6(struct connman_ipconfig *ipconfig)
 {
 	struct connman_ipdevice *ipdevice;
@@ -2547,6 +2568,9 @@ void __connman_ipconfig_load(struct connman_ipconfig =
*ipconfig,
 		g_strfreev(ipconfig->last_dhcpv6_prefixes);
 		ipconfig->last_dhcpv6_prefixes =3D
 			store_get_strs(&is, "DHCP.LastPrefixes");
+
+		g_free(ipconfig->dhcpv6_duid);
+		ipconfig->dhcpv6_duid =3D store_get_str(&is, "DHCP.DUID");
 	}
=20
=20
@@ -2623,6 +2647,8 @@ void __connman_ipconfig_save(struct connman_ipconfig =
*ipconfig,
=20
 		store_set_strs(&is, "DHCP.LastPrefixes",
 				ipconfig->last_dhcpv6_prefixes);
+
+		store_set_str(&is, "DHCP.DUID", ipconfig->dhcpv6_duid);
 	}
=20
 	switch (ipconfig->method) {
--=20
2.34.1

