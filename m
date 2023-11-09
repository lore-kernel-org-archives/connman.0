Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E5374E0
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 082A573128
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 18:47:21 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C766473146
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 18:47:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 2/3] gweb: Leverage GWebStatusCode mnemonics.
Date: Thu, 9 Nov 2023 15:47:20 -0800
References: <F9A20319-A6BC-47C5-8D71-884B705AAF3F@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <F9A20319-A6BC-47C5-8D71-884B705AAF3F@nuovations.com>
Message-Id: <5EC43994-893B-4097-914C-9E23D1B16AEB@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages the 'GWEB_HTTP_STATUS_CODE_*' GWebStatusCode mnemonics
from gweb.h for improved code self-documentation.
---
 gweb/gweb.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 13c6c5f2..97ff0ab2 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -451,7 +451,7 @@ static inline void call_result_func(struct =
web_session *session, guint16 status)
 	if (!session->result_func)
 		return;
=20
-	if (status !=3D 0)
+	if (status !=3D GWEB_HTTP_STATUS_CODE_UNKNOWN)
 		session->result.status =3D status;
=20
 	session->result_func(&session->result, session->user_data);
@@ -729,7 +729,8 @@ static int decode_chunked(struct web_session =
*session,
 			if (session->chunk_left <=3D len) {
 				session->result.buffer =3D ptr;
 				session->result.length =3D =
session->chunk_left;
-				call_result_func(session, 0);
+				call_result_func(session,
+					GWEB_HTTP_STATUS_CODE_UNKNOWN);
=20
 				len -=3D session->chunk_left;
 				ptr +=3D session->chunk_left;
@@ -744,7 +745,8 @@ static int decode_chunked(struct web_session =
*session,
 			/* more data */
 			session->result.buffer =3D ptr;
 			session->result.length =3D len;
-			call_result_func(session, 0);
+			call_result_func(session,
+				GWEB_HTTP_STATUS_CODE_UNKNOWN);
=20
 			session->chunk_left -=3D len;
 			session->total_len +=3D len;
@@ -769,7 +771,8 @@ static int handle_body(struct web_session *session,
 		if (len > 0) {
 			session->result.buffer =3D buf;
 			session->result.length =3D len;
-			call_result_func(session, 0);
+			call_result_func(session,
+				GWEB_HTTP_STATUS_CODE_UNKNOWN);
 		}
 		return 0;
 	}
@@ -780,7 +783,7 @@ static int handle_body(struct web_session *session,
=20
 		session->result.buffer =3D NULL;
 		session->result.length =3D 0;
-		call_result_func(session, 400);
+		call_result_func(session, =
GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
 	}
=20
 	return err;
@@ -876,7 +879,7 @@ static gboolean received_data(GIOChannel *channel, =
GIOCondition cond,
 		session->transport_watch =3D 0;
 		session->result.buffer =3D NULL;
 		session->result.length =3D 0;
-		call_result_func(session, 400);
+		call_result_func(session, =
GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
 		return FALSE;
 	}
=20
@@ -890,7 +893,7 @@ static gboolean received_data(GIOChannel *channel, =
GIOCondition cond,
 		session->transport_watch =3D 0;
 		session->result.buffer =3D NULL;
 		session->result.length =3D 0;
-		call_result_func(session, 0);
+		call_result_func(session, =
GWEB_HTTP_STATUS_CODE_UNKNOWN);
 		return FALSE;
 	}
=20
@@ -1225,14 +1228,14 @@ static void handle_resolved_address(struct =
web_session *session)
 	ret =3D getaddrinfo(session->address, port, &hints, =
&session->addr);
 	g_free(port);
 	if (ret !=3D 0 || !session->addr) {
-		call_result_func(session, 400);
+		call_result_func(session, =
GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
 		return;
 	}
=20
 	call_route_func(session);
=20
 	if (create_transport(session) < 0) {
-		call_result_func(session, 409);
+		call_result_func(session, =
GWEB_HTTP_STATUS_CODE_CONFLICT);
 		return;
 	}
 }
@@ -1253,7 +1256,7 @@ static void resolv_result(GResolvResultStatus =
status,
 	struct web_session *session =3D user_data;
=20
 	if (!results || !results[0]) {
-		call_result_func(session, 404);
+		call_result_func(session, =
GWEB_HTTP_STATUS_CODE_NOT_FOUND);
 		return;
 	}
=20
--=20
2.42.0

