Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97051EF096
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878779; cv=none; b=lvbPEEL6s5fJhpjgDImQokaVNlNO1ru8453MpaOJ58QcEwciUPEy69AAswb9qC0tExdyzj4xTaLiCJ8nOMnFAqe5bzQd6/SNqexs9UzvyOHjdMJAOaB5YNTkzbPveBcYPJ26fl66bBaL3Dsmo6bb3sUZklmE9ciVuc6qqr+Jdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878779; c=relaxed/simple;
	bh=KMpTMGaPrAa+KfbdVp8H+ydsrku7uBNZj0GiNOb+fVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjaPmhlETIUhK0dI2Bt/pGUrfNOPAjZk+vlUipvc1oInhxDgNftwMYJuLpnzA2y/QXnK1KR0fkqXMmpQEiay12kxGm7RB8AYDrrgsKx4pj/c78wIoUmQXlL1y8ta7LAysWhyYvKvAEIw+Hz55ikTJ1zi40IQXfFldiSS1cMZ8HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=CaWxNp+/; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="CaWxNp+/"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E9315164AA7
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:29 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 996D1125166
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:29 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v4 1/9] gweb: Adopt optional, immutable GError instance for GWeb result errors.
Date: Mon, 24 Mar 2025 21:59:19 -0700
Message-ID: <3b6a4007cf3688680ac411538019de0cfbea35ca.1742878567.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742878567.git.gerickson@nuovations.com>
References: <cover.1742878567.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=XfaAmsgRU4nPxgxXhNNB5NEI+OJZOLS4mv/YTAUe7X8=; b=CaWxNp+/VxjwALebf9QoTsejVBYthy0caBz+rTjuCUYQUJFnf0yvg9xUutr5/grbFv6CNkH/VVGr3wDI0ad4yskjraq3e464uKwzucxfU3zKdE4/oEKfGSpaZJOhkdEoD2hL5aXth4IrHDH1MgdjOeVwcPOZrAp9WkWxryJJ0WyB3CFIL7s93djkr+ShrQVjsnpdbDoG6DpSweTM3+n0ezlONb7nggq4BIVjpyOGruLQeRlWbiuKma8G3YEozCIF3R1PVbeE7S7E0HU2/HA3jeS1bf5xrCKZwrHpq8N/I5q84V7zWvmNk++b22TkdTp3qkCnjDMoZDPr6qs6wFDBdA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

In the following instances, GWeb can fail before initiating or while
processing a web request:

  1. TCP connection timeout to the remote server peer.
  2. Decoding a chunked response.
  3. Non-successful events (that is, G_IO_NVAL, G_IO_ERR, or G_IO_HUP)
     from 'g_io_add_watch'.
  4. GResolve "host not found" DNS forward resolution failure.
  5. Transport creation failure from 'create_transport'.

Rather than trying to overload 'GWEB_HTTP_STATUS_CODE_' error
enumerations from actual web server responses for these non-response
or response-in-progress failures, the signature of 'GWebResultFunc' is
amended to take an optional pointer to an immutable GError instance
which describes one of the five errors above on a GWeb request
failure.
---
 gweb/gweb.c      | 99 +++++++++++++++++++++++++++++++++---------------
 gweb/gweb.h      |  2 +-
 src/6to4.c       |  3 +-
 src/wispr.c      |  5 ++-
 tools/web-test.c |  2 +-
 tools/wispr.c    |  2 +-
 6 files changed, 76 insertions(+), 37 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 0e18e9d5d978..a736c32ef0a5 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -39,6 +39,8 @@
 #include <netinet/tcp.h>
 #include <ifaddrs.h>
 
+#include <gio/gio.h>
+
 #include "giognutls.h"
 #include "gresolv.h"
 #include "gweb.h"
@@ -210,28 +212,26 @@ G_DEFINE_QUARK(g-web-error-quark, g_web_error)
  *    A pointer to the mutable web session request for which to invoke
  *    the closure callback.
  *
- *  @param[in]  status
- *    HTTP status code on success to set in the @a session result
- *    structure. Note that #GWEB_HTTP_STATUS_CODE_UNKNOWN acts as a
- *    null value such that the status is only set if the value is
- *    not #GWEB_HTTP_STATUS_CODE_UNKNOWN.
+ *  @param[in]  error
+ *    An optional pointer to the immutable GError structure containing
+ *    information about an error that occurred during the GWeb request,
+ *    if any.
  *
  *  @sa do_request
  *
  *  @private
  *
  */
-static inline void call_result_func(struct web_session *session, guint16 status)
+static void call_result_func(struct web_session *session,
+					const GError *error)
 {
+	debug(session->web, "session %p error %p result_func %p",
+		session, error, session->result_func);
 
 	if (!session->result_func)
 		return;
 
-	if (status != GWEB_HTTP_STATUS_CODE_UNKNOWN)
-		session->result.status = status;
-
-	session->result_func(&session->result, session->user_data);
-
+	session->result_func(error, &session->result, session->user_data);
 }
 
 static inline void call_route_func(struct web_session *session)
@@ -265,9 +265,14 @@ static inline void call_route_func(struct web_session *session)
 static gboolean connect_timeout_cb(gpointer user_data)
 {
 	struct web_session *session = user_data;
+	g_autofree char *message = NULL;
+	g_autoptr(GError) local_error = NULL;
+
+	message = g_strdup_printf("connect timeout to %s after %ums",
+		session->address, g_web_get_connect_timeout(session->web));
 
-	debug(session->web, "session %p connect timeout after %ums",
-			session, g_web_get_connect_timeout(session->web));
+	debug(session->web, "session %p %s",
+			session, message);
 
 	session->connect_timeout = 0;
 
@@ -276,7 +281,11 @@ static gboolean connect_timeout_cb(gpointer user_data)
 	session->result.buffer = NULL;
 	session->result.length = 0;
 
-	call_result_func(session, GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT);
+	local_error = g_error_new_literal(G_IO_ERROR,
+					G_IO_ERROR_TIMED_OUT,
+					message);
+
+	call_result_func(session, local_error);
 
 	return G_SOURCE_REMOVE;
 }
@@ -1017,8 +1026,7 @@ static int decode_chunked(struct web_session *session,
 			if (session->chunk_left <= len) {
 				session->result.buffer = ptr;
 				session->result.length = session->chunk_left;
-				call_result_func(session,
-					GWEB_HTTP_STATUS_CODE_UNKNOWN);
+				call_result_func(session, NULL);
 
 				len -= session->chunk_left;
 				ptr += session->chunk_left;
@@ -1033,8 +1041,7 @@ static int decode_chunked(struct web_session *session,
 			/* more data */
 			session->result.buffer = ptr;
 			session->result.length = len;
-			call_result_func(session,
-				GWEB_HTTP_STATUS_CODE_UNKNOWN);
+			call_result_func(session, NULL);
 
 			session->chunk_left -= len;
 			session->total_len += len;
@@ -1052,6 +1059,8 @@ static int handle_body(struct web_session *session,
 				const guint8 *buf, gsize len)
 {
 	int err;
+	g_autofree char *message = NULL;
+	g_autoptr(GError) local_error = NULL;
 
 	debug(session->web, "[body] length %zu", len);
 
@@ -1059,19 +1068,25 @@ static int handle_body(struct web_session *session,
 		if (len > 0) {
 			session->result.buffer = buf;
 			session->result.length = len;
-			call_result_func(session,
-				GWEB_HTTP_STATUS_CODE_UNKNOWN);
+			call_result_func(session, NULL);
 		}
 		return 0;
 	}
 
 	err = decode_chunked(session, buf, len);
 	if (err < 0) {
-		debug(session->web, "Error in chunk decode %d", err);
+		message = g_strdup_printf("Error in chunk decode %d", err);
+
+		debug(session->web, message);
 
 		session->result.buffer = NULL;
 		session->result.length = 0;
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
+
+		local_error = g_error_new_literal(G_WEB_ERROR,
+			G_WEB_ERROR_CHUNK_DECODE,
+			message);
+
+		call_result_func(session, local_error);
 	}
 
 	return err;
@@ -1157,14 +1172,12 @@ static void add_header_field(struct web_session *session)
 
 static void received_data_finalize(struct web_session *session)
 {
-	const guint16 code = GWEB_HTTP_STATUS_CODE_UNKNOWN;
-
 	session->transport_watch = 0;
 
 	session->result.buffer = NULL;
 	session->result.length = 0;
 
-	call_result_func(session, code);
+	call_result_func(session, NULL);
 }
 
 static bool received_data_continue(struct web_session *session,
@@ -1287,6 +1300,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 	struct web_session *session = user_data;
 	gsize bytes_read;
 	GIOStatus status;
+	g_autoptr(GError) local_error = NULL;
 
 	/* We received some data or condition, cancel the connect timeout. */
 
@@ -1302,7 +1316,11 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 		session->result.buffer = NULL;
 		session->result.length = 0;
 
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
+		local_error = g_error_new_literal(G_IO_ERROR,
+			g_io_error_from_errno(EIO),
+			g_strerror(EIO));
+
+		call_result_func(session, local_error);
 
 		return FALSE;
 	}
@@ -2320,6 +2338,7 @@ static void handle_resolved_address(struct web_session *session)
 	struct addrinfo hints;
 	g_autofree char *port;
 	int ret;
+	g_autoptr(GError) local_error = NULL;
 
 	debug(session->web, "address %s", session->address);
 
@@ -2335,15 +2354,26 @@ static void handle_resolved_address(struct web_session *session)
 	port = g_strdup_printf("%u", session->port);
 	ret = getaddrinfo(session->address, port, &hints, &session->addr);
 	if (ret != 0 || !session->addr) {
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
+		local_error = g_error_new(G_WEB_ERROR,
+			G_WEB_ERROR_HOST_NOT_FOUND,
+			"could not resolve %s: %s",
+			session->address,
+			gai_strerror(ret));
+
+		call_result_func(session, local_error);
+
 		return;
 	}
 
 	call_route_func(session);
 
-	if (create_transport(session) < 0) {
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_CONFLICT);
-		return;
+	ret = create_transport(session);
+	if (ret < 0) {
+		local_error = g_error_new_literal(G_IO_ERROR,
+						g_io_error_from_errno(ret),
+						g_strerror(ret));
+
+		call_result_func(session, local_error);
 	}
 }
 
@@ -2361,9 +2391,16 @@ static void resolv_result(GResolvResultStatus status,
 					char **results, gpointer user_data)
 {
 	struct web_session *session = user_data;
+	g_autoptr(GError) local_error = NULL;
 
 	if (!results || !results[0]) {
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_NOT_FOUND);
+		local_error = g_error_new(G_WEB_ERROR,
+				G_WEB_ERROR_HOST_NOT_FOUND,
+				"could not resolve %s",
+				session->host);
+
+		call_result_func(session, local_error);
+
 		return;
 	}
 
diff --git a/gweb/gweb.h b/gweb/gweb.h
index fb29498e90ad..75629500ef9c 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -125,7 +125,7 @@ typedef struct _GWeb GWeb;
 typedef struct _GWebResult GWebResult;
 typedef struct _GWebParser GWebParser;
 
-typedef bool (*GWebResultFunc)(GWebResult *result, gpointer user_data);
+typedef bool (*GWebResultFunc)(const GError *error, GWebResult *result, gpointer user_data);
 
 typedef bool (*GWebRouteFunc)(const char *addr, int ai_family,
 		int if_index, gpointer user_data);
diff --git a/src/6to4.c b/src/6to4.c
index 5542b339691a..fe1fee0848db 100644
--- a/src/6to4.c
+++ b/src/6to4.c
@@ -233,7 +233,8 @@ static gboolean unref_web(gpointer user_data)
 	return FALSE;
 }
 
-static bool web_result(GWebResult *result, gpointer user_data)
+static bool web_result(const GError *error,
+		GWebResult *result, gpointer user_data)
 {
 	guint16 status;
 
diff --git a/src/wispr.c b/src/wispr.c
index 7f850bc5f5aa..c3d8b13a9610 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -133,7 +133,7 @@ struct connman_wispr_portal {
 	struct connman_wispr_portal_context *ipv6_context;
 };
 
-static bool wispr_portal_web_result(GWebResult *result, gpointer user_data);
+static bool wispr_portal_web_result(const GError *error, GWebResult *result, gpointer user_data);
 
 /**
  *  A dictionary / hash table of network interface indices to
@@ -1001,7 +1001,8 @@ static bool wispr_manage_message(GWebResult *result,
 	return false;
 }
 
-static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
+static bool wispr_portal_web_result(const GError *error, GWebResult *result,
+		gpointer user_data)
 {
 	struct connman_wispr_portal_context *wp_context = user_data;
 	const char *redirect = NULL;
diff --git a/tools/web-test.c b/tools/web-test.c
index a65e6c115c41..f3efa22c4749 100644
--- a/tools/web-test.c
+++ b/tools/web-test.c
@@ -43,7 +43,7 @@ static void sig_term(int sig)
 	g_main_loop_quit(main_loop);
 }
 
-static bool web_result(GWebResult *result, gpointer user_data)
+static bool web_result(const GError *error, GWebResult *result, gpointer user_data)
 {
 	const guint8 *chunk;
 	gsize length;
diff --git a/tools/wispr.c b/tools/wispr.c
index ef7b60d3f5ca..0c794ccbc4c2 100644
--- a/tools/wispr.c
+++ b/tools/wispr.c
@@ -492,7 +492,7 @@ static bool wispr_route(const char *addr, int ai_family, int if_index,
 	return true;
 }
 
-static bool wispr_result(GWebResult *result, gpointer user_data)
+static bool wispr_result(const GError *error, GWebResult *result, gpointer user_data)
 {
 	struct wispr_session *wispr = user_data;
 	const guint8 *chunk;
-- 
2.45.0

