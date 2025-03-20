Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458C21D018
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513965; cv=none; b=Ny2/CBrPZ+iNLRsg2Y8iWYdfd1fRcjyjPeu6aJjcvcVecBLeRQKyzUOjTi2KtpGPMwIRlLcS8kt9Y3BHmgV4i9NqVsQqD7+9mGvy4LPR0vRj5sVuMGccbhl4nKhocrocBCmlEh6TftrcBDfLt99D/nV7CUaIUsB/JQXAKONsVXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513965; c=relaxed/simple;
	bh=jfYPQmpXymrcIsjRg/PaDNHSRkXUEtNXCnOyKjFbDVk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4Ylxh+EhbqjN8/QWIqaqzZdTCLxrAMfrPe80EMcOf4vrRDQxaPuRlTSAgQna9mIkxv/QCkNPf4fs7IeU6rxB9zPtod0OUDabSEZoSoaQf9gLAx9hevqUXKX4nSZwns7nAkd9wHHlqRH441YicRyyDGabDheyxnOBu1l8InVN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Si6VCXY/; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Si6VCXY/"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 87B97164AD1
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:15 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 3AA05125183
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:15 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 09/18] gweb: Adopt optional, immutable GError instance for GWeb result errors.
Date: Thu, 20 Mar 2025 16:39:00 -0700
Message-ID: <4e2b089631711aaa48079f8a63b74f61d28c9eae.1742513884.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742513884.git.gerickson@nuovations.com>
References: <cover.1742513884.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Y6+uQjoJZgq7OI+8xS4qMe80eJ8muySetFkple3HtwE=; b=Si6VCXY/SAsjcGpLsIBiVU6V5ApeazYlnpkcMzi9tBmi+1+YGZz5+2ak+PEdrIr/SZI1DZZSbwUunHguqPAd5wlTbVeZN/o32/O3svR8h/AXESdqyB0aow01E39FbE+f3GD7qZuVc64AzTXBk78qj8Y+apC8cqonENESSAvHGSRGmjbSxKbtiadqmYBUqODVw74H/XKqqIjX4RPI9A5a4WrDkYkJZRph5ESvRNvA3GBQXotfY7RSZKa9nJEOWM5GBYLeHco9SRNE37lidUv2b7lnj/OoWSjzc2kdbm1L0YidZwsN0io7hOt9mP3vYrexFJMT/M6zYjx3xlK8ELbAdA==
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
 gweb/gweb.c      | 125 +++++++++++++++++++++++++++++++++++------------
 gweb/gweb.h      |   2 +-
 src/6to4.c       |   3 +-
 src/wispr.c      |   5 +-
 tools/web-test.c |   2 +-
 tools/wispr.c    |   2 +-
 6 files changed, 101 insertions(+), 38 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index ad91d782e6e4..1915d3737eb0 100644
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
@@ -178,28 +180,26 @@ G_DEFINE_QUARK(g-web-error-quark, g_web_error)
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
@@ -233,9 +233,14 @@ static inline void call_route_func(struct web_session *session)
 static gboolean connect_timeout_cb(gpointer user_data)
 {
 	struct web_session *session = user_data;
+	g_autofree char *message = NULL;
+	GError *local_error = NULL;
+
+	message = g_strdup_printf("connect timeout to %s after %ums",
+		session->address, g_web_get_connect_timeout(session->web));
 
-	debug(session->web, "session %p connect timeout after %ums",
-			session, g_web_get_connect_timeout(session->web));
+	debug(session->web, "session %p %s",
+			session, message);
 
 	session->connect_timeout = 0;
 
@@ -244,7 +249,14 @@ static gboolean connect_timeout_cb(gpointer user_data)
 	session->result.buffer = NULL;
 	session->result.length = 0;
 
-	call_result_func(session, GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT);
+	local_error = g_error_new_literal(G_IO_ERROR,
+					G_IO_ERROR_TIMED_OUT,
+					message);
+
+	call_result_func(session, local_error);
+
+	if (local_error)
+		g_error_free(local_error);
 
 	return G_SOURCE_REMOVE;
 }
@@ -985,8 +997,7 @@ static int decode_chunked(struct web_session *session,
 			if (session->chunk_left <= len) {
 				session->result.buffer = ptr;
 				session->result.length = session->chunk_left;
-				call_result_func(session,
-					GWEB_HTTP_STATUS_CODE_UNKNOWN);
+				call_result_func(session, NULL);
 
 				len -= session->chunk_left;
 				ptr += session->chunk_left;
@@ -1001,8 +1012,7 @@ static int decode_chunked(struct web_session *session,
 			/* more data */
 			session->result.buffer = ptr;
 			session->result.length = len;
-			call_result_func(session,
-				GWEB_HTTP_STATUS_CODE_UNKNOWN);
+			call_result_func(session, NULL);
 
 			session->chunk_left -= len;
 			session->total_len += len;
@@ -1020,6 +1030,8 @@ static int handle_body(struct web_session *session,
 				const guint8 *buf, gsize len)
 {
 	int err;
+	g_autofree char *message = NULL;
+	GError *local_error = NULL;
 
 	debug(session->web, "[body] length %zu", len);
 
@@ -1027,19 +1039,28 @@ static int handle_body(struct web_session *session,
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
+
+		if (local_error)
+			g_error_free(local_error);
 	}
 
 	return err;
@@ -1125,14 +1146,12 @@ static void add_header_field(struct web_session *session)
 
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
@@ -1255,6 +1274,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 	struct web_session *session = user_data;
 	gsize bytes_read;
 	GIOStatus status;
+	GError *local_error = NULL;
 
 	/* We received some data or condition, cancel the connect timeout. */
 
@@ -1270,7 +1290,14 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 		session->result.buffer = NULL;
 		session->result.length = 0;
 
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
+		local_error = g_error_new_literal(G_IO_ERROR,
+			g_io_error_from_errno(EIO),
+			g_strerror(EIO));
+
+		call_result_func(session, local_error);
+
+		if (local_error)
+			g_error_free(local_error);
 
 		return FALSE;
 	}
@@ -2288,6 +2315,8 @@ static void handle_resolved_address(struct web_session *session)
 	struct addrinfo hints;
 	g_autofree char *port;
 	int ret;
+	g_autofree char *message = NULL;
+	GError *local_error = NULL;
 
 	debug(session->web, "address %s", session->address);
 
@@ -2303,16 +2332,35 @@ static void handle_resolved_address(struct web_session *session)
 	port = g_strdup_printf("%u", session->port);
 	ret = getaddrinfo(session->address, port, &hints, &session->addr);
 	if (ret != 0 || !session->addr) {
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
-		return;
+		message = g_strdup_printf("could not resolve %s: %s",
+			session->address,
+			gai_strerror(ret));
+
+		local_error = g_error_new_literal(G_WEB_ERROR,
+			G_WEB_ERROR_HOST_NOT_FOUND,
+			message);
+
+		call_result_func(session, local_error);
+
+		goto done;
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
+
+		goto done;
 	}
+
+ done:
+	if (local_error)
+		g_error_free(local_error);
 }
 
 static gboolean already_resolved(gpointer data)
@@ -2329,9 +2377,22 @@ static void resolv_result(GResolvResultStatus status,
 					char **results, gpointer user_data)
 {
 	struct web_session *session = user_data;
+	g_autofree char *message = NULL;
+	GError *local_error = NULL;
 
 	if (!results || !results[0]) {
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_NOT_FOUND);
+		message = g_strdup_printf("could not resolve %s",
+			session->host);
+
+		local_error = g_error_new_literal(G_WEB_ERROR,
+				G_WEB_ERROR_HOST_NOT_FOUND,
+				message);
+
+		call_result_func(session, local_error);
+
+		if (local_error)
+			g_error_free(local_error);
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

