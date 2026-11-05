Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.33.248.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883722;
	b=UHlkE27L8y8K3ANNOFs9F4GFNi1B5unk3x6zkpWjkb/phk9/2q5CeTOQcgOowierLwl7
	 O3gj1jTo4RWlJkX+1cw8OBShqMY24dezw4Zb02Q/bJv5DZrmQKUE5RjzsODoNa1+rmmkL
	 XvTBtcw3qYQVljop+JUuXpUOC/TAT7yWBNCAKghqNjBfLYjBs6kPZsUm+zpQR1oYGptfj
	 wuZUX48Gbhgq66Mg170SvXUzV9VvYxN7N8wSYXSC1EAPe9BB28BunwRJFtSY3JZp11U/a
	 SnGYVd7WXcSM3TePuyRJEJH6e2J0PocXyv9Pe2GgyMtXj+pV18lUo/8oKXVTSN9ZvOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883722;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:x-ovh-tracer-id:
	 X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE;
	bh=bei8WyssXSdO0vJWtVd3CgZ2DUy4aDLoRw1/aHd+9ec=;
	b=UzjNIGeN1GBPoEgU4WG6yCvOhgYDLJxueVo9iCqoMOVPkeVXRKU8eoZOHOzjboraYZeq
	 WcplzsiaMFzD5toILJAo+wdKTcPBPn2WNBbk7akWq1sBzPwzTKftXQDF9XOuU7pF2fRxs
	 Y57CFi2hy6HL+z05UFR+Hwdk8x5QVeniibQrQPIjX2UvHXN0pF0PPaOqUFJ154gxFAsO9
	 YOx9NVUrkdGFt9iFVz00fioPjPZR4tY4jxVg+/lZRUgxe3pF/D+4gYQn3iy5i4DGMnTmw
	 8HRG6hQrIXFkZSxVlasSGvG25KiC2qhmntj+FIQFqwaff9ZBdJbSyDZmfo64lbD33Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=178.33.248.74
Received: from 11.511.mail-out.ovh.net (11.511.mail-out.ovh.net [178.33.248.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0658606A32D
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0658606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.111.182.218])
	by mo511.mail-out.ovh.net (Postfix) with SMTP id 4jL2Wk298nz9s81
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:54 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [RFC PATCH 6/6] tools: Allow DNS over HTTPS in dnsproxy-standalone
Date: Thu, 5 Nov 2026 13:01:45 +0000
Message-ID: <20261105130145.523935-7-email@samnazarko.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105130145.523935-1-email@samnazarko.co.uk>
References: <20261105130145.523935-1-email@samnazarko.co.uk>
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
X-ClientProxiedBy: CAS10.indiv.local (172.16.1.10) To DAG16EX2.indiv.local
 (172.16.2.162)
x-ovh-tracer-id: 9097834200783114220
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFM1Gfex4DDr5KdJAbPHqToa9nfMNNiZRyNW5b79/2vj/x5Lmwg57pJqDkLFO61imTUk9xeVb6fZecuiR9+ajPf276IC2Ht7Gw3XO/kEJy9AkGZamwjbMdBKeS/m+yQ8KGnIbW6elHYd7x+FnDGY1dkplcWfpf7118IlLw9XqkgwMKKCoy2VRsMaSiFu44Q0wSZs3uRkExZES552zlQLCbrM5ThUcrTavsiuTeNmyg0fkTP4IVz7fje4HsYiONQpAoiY0ttM8aSBEm1G42eDzyBRZAhzoEiUd7oXwAKbqbq3vllwfNXja/zyNsbRDCI54KxoyaUTvRIgHrprU83K7d5KPvouDhyu5NVroferf0TIhtIC9HYHwDD8nhpEWuV6cwNZTJ/LqmW/nR/azVW0XsP5bBdk/2e6czlYAFAA1bwPk9MZabQmKGCNH750StcKnKRv1UEdlsrkd+z8BRyrJLwJkQC6sdd0Srk7ZHZrM0lv9MbFvdoKk1xuqPzwPOK9BZoa6vGue2L1MIr1YRmIlfvWfTnQ9F1kgVpWGW4KS6yPHRO9ZYnSkKE4MMXFym8GL7M/BbMf0pQT+9Lsj6zmstyTFuq34V1qpcNcQYKqZwOOFCvd09+jZU2tYFUSdH94a3r4HKuZorPxRZs9BVSuY8M1x3A1Zldft58t8NyJp7gAw

Accept an optional DNS over HTTPS mode and server URLs, and log to
stderr with debug output selected by the CONNMAN_DEBUG environment
variable, to test DoH without a full connmand.
---
 tools/dnsproxy-standalone.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/dnsproxy-standalone.c b/tools/dnsproxy-standalone.c
index 1b9698bd..64056f4f 100644
--- a/tools/dnsproxy-standalone.c
+++ b/tools/dnsproxy-standalone.c
@@ -19,7 +19,8 @@ static GMainLoop *main_loop =3D NULL;
=20
 static void usage(const char *prog)
 {
-	fprintf(stderr, "%s: <listen-port> <dns-domain> <dns-server>\n", prog);
+	fprintf(stderr, "%s: <listen-port> <dns-domain> <dns-server> "
+			"[off|auto|on|strict [<doh-url>...]]\n", prog);
 	exit(1);
 }
=20
@@ -109,13 +110,17 @@ int main(int argc, const char **argv)
 	const char *server =3D argv[3];
 	guint signal =3D 0;
=20
-	if (argc !=3D 4)
+	if (argc < 4)
 	{
 		usage(argv[0]);
 	}
=20
 	port =3D to_uint(argv[1]);
=20
+	/* Log to stderr, with debug output selected like connmand -d */
+	__connman_log_init(argv[0], getenv("CONNMAN_DEBUG"), FALSE, FALSE,
+					"dnsproxy-standalone", "test");
+
 	__connman_util_init();
 	printf("Listening on local port %u\n", port);
 	__connman_dnsproxy_set_listen_port(port);
@@ -141,6 +146,16 @@ int main(int argc, const char **argv)
 	__connman_dnsproxy_append(15, domain, server);
 	__connman_dnsproxy_remove(15, domain, server);
=20
+	if (argc > 4) {
+		printf("Using DNS over HTTPS mode %s\n", argv[4]);
+
+		if (__connman_dnsproxy_configure_doh(argv[4],
+						(char **) argv + 5) < 0) {
+			fprintf(stderr, "invalid DNS over HTTPS settings\n");
+			return 1;
+		}
+	}
+
 	signal =3D setup_signalfd();
=20
 	main_loop =3D g_main_loop_new(NULL, FALSE);
@@ -150,6 +165,7 @@ int main(int argc, const char **argv)
 	__connman_dnsproxy_cleanup();
 	__connman_util_cleanup();
 	g_source_remove(signal);
+	__connman_log_cleanup(FALSE);
=20
 	return 0;
 }
--=20
2.34.1

