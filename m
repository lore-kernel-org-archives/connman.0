Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255F1B28C
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A8B5B730CE
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:59:15 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7386773108
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:59:15 -0500 (EST)
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
Subject: [PATCH 3/8] gweb: Leverage TCP connect timeout.
Date: Sat, 11 Nov 2023 10:59:15 -0800
References: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
Message-Id: <13557DEE-684A-4575-B186-47F3D8069C1B@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages the GWeb TCP connect timeout member and getter and adds
a new GLib TCP connect timeout identifier to the GWeb session object.

If the GWeb TCP connect timeout is greater than zero, a GLib connection
timeout timer and callback are added to the session such that, when they
expire, the in flight TCP connection is aborted and the session closure
function invoked with 'GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT'.

A TCP connect timeout of zero ('0') indicates that no explicit =
connection
timeout will be used and no timer or callback added to the session, =
leaving
the timeout to the underlying operating system and its network stack.
---
 gweb/gweb.c | 99 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 77 insertions(+), 22 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 5f09cb3a99cf..584f0106c5ee 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -75,6 +75,7 @@ struct web_session {
 	char *content_type;
=20
 	GIOChannel *transport_channel;
+	guint connect_timeout;
 	guint transport_watch;
 	guint send_watch;
=20
@@ -133,6 +134,8 @@ struct _GWeb {
 #define debug(web, format, arg...)				\
 	_debug(web, __FILE__, __func__, format, ## arg)
=20
+static void close_session_transport(struct web_session *session);
+
 static void _debug(GWeb *web, const char *file, const char *caller,
 						const char *format, ...)
 {
@@ -154,6 +157,70 @@ static void _debug(GWeb *web, const char *file, =
const char *caller,
 	va_end(ap);
 }
=20
+static inline void call_result_func(struct web_session *session, =
guint16 status)
+{
+
+	if (!session->result_func)
+		return;
+
+	if (status !=3D GWEB_HTTP_STATUS_CODE_UNKNOWN)
+		session->result.status =3D status;
+
+	session->result_func(&session->result, session->user_data);
+
+}
+
+static inline void call_route_func(struct web_session *session)
+{
+	if (session->route_func)
+		session->route_func(session->address, =
session->addr->ai_family,
+				session->web->index, =
session->user_data);
+}
+
+static gboolean connect_timeout_cb(gpointer user_data)
+{
+	struct web_session *session =3D user_data;
+
+	debug(session->web, "session %p connect timeout after %ums",
+			session, =
g_web_get_connect_timeout(session->web));
+
+	session->connect_timeout =3D 0;
+
+	close_session_transport(session);
+
+	session->result.buffer =3D NULL;
+	session->result.length =3D 0;
+
+	call_result_func(session, =
GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT);
+
+	return G_SOURCE_REMOVE;
+}
+
+static void add_connect_timeout(struct web_session *session,
+						guint timeout_ms)
+{
+	if (!session || !timeout_ms)
+		return;
+
+	debug(session->web, "add connect timeout %u ms", timeout_ms);
+
+	session->connect_timeout =3D g_timeout_add(timeout_ms,
+				connect_timeout_cb, session);
+}
+
+static void cancel_connect_timeout(struct web_session *session)
+{
+	if (!session)
+		return;
+
+	if (session->connect_timeout > 0) {
+		g_source_remove(session->connect_timeout);
+		session->connect_timeout =3D 0;
+
+		debug(session->web, "cancelled connect timeout");
+	}
+}
+
 static void close_session_transport(struct web_session *session)
 {
 	if (!session)
@@ -194,6 +261,8 @@ static void free_session(struct web_session =
*session)
 	if (session->resolv_action > 0)
 		g_resolv_cancel_lookup(web->resolv, =
session->resolv_action);
=20
+	cancel_connect_timeout(session);
+
 	close_session_transport(session);
=20
 	g_free(session->result.last_key);
@@ -485,26 +554,6 @@ done:
 	return timeout_ms;
 }
=20
-static inline void call_result_func(struct web_session *session, =
guint16 status)
-{
-
-	if (!session->result_func)
-		return;
-
-	if (status !=3D GWEB_HTTP_STATUS_CODE_UNKNOWN)
-		session->result.status =3D status;
-
-	session->result_func(&session->result, session->user_data);
-
-}
-
-static inline void call_route_func(struct web_session *session)
-{
-	if (session->route_func)
-		session->route_func(session->address, =
session->addr->ai_family,
-				session->web->index, =
session->user_data);
-}
-
 static bool process_send_buffer(struct web_session *session)
 {
 	GString *buf;
@@ -915,6 +964,8 @@ static gboolean received_data(GIOChannel *channel, =
GIOCondition cond,
 	gsize bytes_read;
 	GIOStatus status;
=20
+	cancel_connect_timeout(session);
+
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		session->transport_watch =3D 0;
 		session->result.buffer =3D NULL;
@@ -1075,7 +1126,8 @@ static inline int bind_socket(int sk, int index, =
int family)
 	return err;
 }
=20
-static int connect_session_transport(struct web_session *session)
+static int connect_session_transport(struct web_session *session,
+			guint connect_timeout_ms)
 {
 	GIOFlags flags;
 	int sk;
@@ -1133,6 +1185,8 @@ static int connect_session_transport(struct =
web_session *session)
 				G_IO_OUT | G_IO_HUP | G_IO_NVAL | =
G_IO_ERR,
 						send_data, session);
=20
+	add_connect_timeout(session, connect_timeout_ms);
+
 	return 0;
 }
=20
@@ -1140,7 +1194,8 @@ static int create_transport(struct web_session =
*session)
 {
 	int err;
=20
-	err =3D connect_session_transport(session);
+	err =3D connect_session_transport(session,
+			g_web_get_connect_timeout(session->web));
 	if (err < 0)
 		return err;
=20
--=20
2.42.0

