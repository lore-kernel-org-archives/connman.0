Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623561C29E
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1FE28730FE
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:58:56 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E01F47313B
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:58:55 -0500 (EST)
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
Subject: [PATCH 2/8] gweb: Factor out session transport closure.
Date: Sat, 11 Nov 2023 10:58:55 -0800
References: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
Message-Id: <FCE333B7-454D-46B5-BEE6-CEFC74346A18@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This factors out the three actions undertake to close a GWeb session
TCP tranport into a function, 'close_session_transport', that can be
reused both at object destruction time, when the reference count
reaches zero, but also when a TCP connection timeout occurs and the
connection needs to be aborted.
---
 gweb/gweb.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index bc0aa7a801a6..5f09cb3a99cf 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -154,6 +154,29 @@ static void _debug(GWeb *web, const char *file, =
const char *caller,
 	va_end(ap);
 }
=20
+static void close_session_transport(struct web_session *session)
+{
+	if (!session)
+		return;
+
+	debug(session->web, "closing session transport");
+
+	if (session->transport_watch > 0) {
+		g_source_remove(session->transport_watch);
+		session->transport_watch =3D 0;
+	}
+
+	if (session->send_watch > 0) {
+		g_source_remove(session->send_watch);
+		session->send_watch =3D 0;
+	}
+
+	if (session->transport_channel) {
+		g_io_channel_unref(session->transport_channel);
+		session->transport_channel =3D NULL;
+	}
+}
+
 static void free_session(struct web_session *session)
 {
 	GWeb *web;
@@ -171,14 +194,7 @@ static void free_session(struct web_session =
*session)
 	if (session->resolv_action > 0)
 		g_resolv_cancel_lookup(web->resolv, =
session->resolv_action);
=20
-	if (session->transport_watch > 0)
-		g_source_remove(session->transport_watch);
-
-	if (session->send_watch > 0)
-		g_source_remove(session->send_watch);
-
-	if (session->transport_channel)
-		g_io_channel_unref(session->transport_channel);
+	close_session_transport(session);
=20
 	g_free(session->result.last_key);
=20
--=20
2.42.0

