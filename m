Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.165.39.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883720;
	b=klCn4nNI39TqTRL76Zi5XD/xb9017dwJiAKv8AJBR8egxlNlR9+B3B9lyNBc6iFh28hk
	 IWKwoM3G5/5zBCVaTo34wDBjEuoE1vemhcCxYPCk9DLXi8WjiN0BOp6qiJHVLhR7GLFvF
	 3Ki1X1FJ7QK1Zl5+JixiLDNrqoeLG4l5yTqdy2BpMJ6awQRoCmh7X0RDOJfyw9wdinbHP
	 Ufx5c/3uXX9dAwQPUgk5po/YKf4k7AcUHQw8iX0GM2CMaPvlXBF/5RQ3oQOVLpadslGXu
	 SEO4tfxfaYy5+jdX15H2pIaVbM89s9Cjt/o7UM6l3dU9BxSAuWBSE5lGtEf8n8APBXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883720;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:x-ovh-tracer-id:
	 X-VR-SPAMSTATE:X-VR-SPAMSCORE:X-VR-SPAMCAUSE;
	bh=L0f9I4x8cl1ZrTq4pZ1bKan5FaiLIV0kuN+HhUZaQ0s=;
	b=BvyIi5st9uIlzokY9jol/i6TcO/dbYZKITIj9PWmuVvLjvab4Bg9qOYua8n2AoWJNx83
	 HSf+elZAAUbtk+ZmS8GmF4VAIN6JWegPT/e3mSjCUDEP5oNIwScn7o90JtY3oGo1BdoLA
	 PkbjDKenUZOeNFaUFr82OQBtwELGoVG8bF+Bfg3XSCcyGOjHDaw+H9hq8rgGKdJHQuMWH
	 CQ3P9xc97q23c8+YZkAyZOF1X6sMFsXiNnapKg+7I1mEHmdkrFxxjFrs8RnCAoY9bYr/8
	 MutQygM24/3305dsUWB1bGDPQUdRTW4OGDXgdMnnUkSt1nDtKX+Oel5o+LUPA9SKmUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=samnazarko.co.uk;
	spf=pass smtp.mailfrom=samnazarko.co.uk;
	arc=none smtp.remote-ip=188.165.39.164
Received: from 4.512.mail-out.ovh.net (4.512.mail-out.ovh.net [188.165.39.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CBB606A329
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53CBB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samnazarko.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samnazarko.co.uk
Received: from ex.mail.ovh.net (unknown [10.111.182.245])
	by mo512.mail-out.ovh.net (Postfix) with SMTP id 4jL2Wh2BrDz69vr
	for <connman@lists.linux.dev>; Thu,  5 Nov 2026 13:01:52 +0000 (UTC)
From: Sam G Nazarko <email@samnazarko.co.uk>
To: <connman@lists.linux.dev>
Subject: [RFC PATCH 1/6] dnsproxy: Pass the protocol to cache_update()
Date: Thu, 5 Nov 2026 13:01:40 +0000
Message-ID: <20261105130145.523935-2-email@samnazarko.co.uk>
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
x-ovh-tracer-id: 9097271247809138668
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFM1Gfex4DDr5KdJAbPHqToa9nfMNNiZRyNW5b79/2vj/x5Lmwg57pJqDkLFO61imTUk9xeVb6fZecuiR9+ajPf276IC2Ht7Gw3XO/kEJy9AkGZamwjbMdBKeS/m+yQ8KGnIbW6elHYd7x+FnDGY1dkplcWfpf7118IlLw9XqkgwMKKCoy2VRsMaSiFu44Q0wSZs3uRkExZES552zlQLCbrM5ThUcrTavsiuTeNmyg0fkTP4IVz7fje4HsYiONQpAoiY0ttM8aSBEm1G42eDzyBRZAhzoEiUd7oXwAKbqbq3vllwfNXja/zyNsbRDCI54KxoyaUTvRIgHrprU83K7d5JJGHTk0TZ1TPtG3UTodoaF9guM1BXmCBZXbIWeDxrmwREyWmALn0p719WqF+JNVpGlNqDI8fAscYkbMVONIEfEXVkgZjCqI7hwwwHirXbCYodIpwwTh/eZTWjUN7auBpa3/zTjErZ57CnYZSJyXMXuaXzq+/OJXhtOx5hFPOmYTJ2SSp3UUiV9CqKMOpUdLmFk+aK364PpLS7N4Aks6ujXQXigAjjwbjADfRLBi3ELFK024zSf0zFPqUw2viU2XOgJUF/oJAIN6tTyRjh/euB9fpO74gXVA48nq8buJkJGEM2NukuPUhqacQKjC7zxLd4/XMFtd52bBqahE4476W8g

cache_update() takes the server only to look at its protocol, and
forward_dns_reply() takes the server only to pass it on, although it
already receives the protocol. Pass the protocol instead, so that
replies which do not come from a server_data, such as DNS over HTTPS
replies, can be cached and forwarded too.
---
 src/dnsproxy.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 1140e2e7..9a7fe516 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1533,9 +1533,9 @@ static int reply_query_type(const unsigned char *msg,=
 int len)
 /*
  * update the cache with the DNS reply found in msg
  */
-static int cache_update(struct server_data *srv, const unsigned char *msg,=
 size_t msg_len)
+static int cache_update(int protocol, const unsigned char *msg, size_t msg=
_len)
 {
-	const size_t offset =3D protocol_offset(srv->protocol);
+	const size_t offset =3D protocol_offset(protocol);
 	int err, ttl =3D 0;
 	uint16_t *lenhdr;
 	size_t qlen;
@@ -1600,7 +1600,7 @@ static int cache_update(struct server_data *srv, cons=
t unsigned char *msg, size_
 				(offset ? 0 : DNS_HEADER_TCP_EXTRA_BYTES);
 			data->data =3D g_malloc(data->data_len);
 			ptr =3D data->data;
-			if (srv->protocol =3D=3D IPPROTO_UDP) {
+			if (protocol =3D=3D IPPROTO_UDP) {
 				/* add the two bytes length header also for
 				 * UDP responses */
 				lenhdr =3D (void*)ptr;
@@ -1742,7 +1742,7 @@ static int cache_update(struct server_data *srv, cons=
t unsigned char *msg, size_
 		question, type, ttl,
 		sizeof(*entry) + sizeof(*data) + data->data_len + qlen,
 		data->data_len,
-		srv->protocol =3D=3D IPPROTO_TCP ?
+		protocol =3D=3D IPPROTO_TCP ?
 			(unsigned int)(data->data[0] * 256 + data->data[1]) :
 			data->data_len);
=20
@@ -2329,7 +2329,7 @@ static struct request_data* lookup_request(
 }
=20
 static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
-			struct server_data *data, struct request_data *req)
+						struct request_data *req)
 {
 	const size_t offset =3D protocol_offset(protocol);
 	struct domain_hdr *hdr =3D (void *)(reply + offset);
@@ -2377,7 +2377,7 @@ static int forward_dns_reply(char *reply, size_t repl=
y_len, int protocol,
 		memcpy(req->resp, reply, reply_len);
 		req->resplen =3D reply_len;
=20
-		cache_update(data, (unsigned char*)reply, reply_len);
+		cache_update(protocol, (unsigned char *) reply, reply_len);
=20
 		g_free(new_reply);
 	}
@@ -2500,7 +2500,7 @@ static gboolean udp_server_event(GIOChannel *channel,=
 GIOCondition condition,
 		/* invalid / corrupt request */
 		return TRUE;
=20
-	res =3D forward_dns_reply((char*)buf, len, IPPROTO_UDP, data, req);
+	res =3D forward_dns_reply((char *) buf, len, IPPROTO_UDP, req);
=20
 	/* on success or no further responses are expected, destroy the req */
 	if (res =3D=3D 0 || req->numresp >=3D req->numserv)
@@ -2705,7 +2705,8 @@ hangup:
 			/* invalid / corrupt request */
 			return TRUE;
=20
-		res =3D forward_dns_reply((char*)reply->buf, reply->received, IPPROTO_TC=
P, server, req);
+		res =3D forward_dns_reply((char *) reply->buf, reply->received,
+						IPPROTO_TCP, req);
=20
 		g_free(reply);
 		server->incoming_reply =3D NULL;
--=20
2.34.1

