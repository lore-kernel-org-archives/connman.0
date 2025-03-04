Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8711DC046
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059592; cv=none; b=DKsoKzwg9/hkFnKCtgk9EHF1U2mT4PlbJn7nTxAVwTY1wNxpwCjS33sqHs3dZ352l+LI92YVMaHwgsNERrQpVrx+KZIEIgIvXIHeMYiqUYnheH+v+4FoiqMC5grxOrCyoOo1KbTpRgmtArKqxwCUQ/U+9gTb3GZy0pyzBHBqfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059592; c=relaxed/simple;
	bh=4nj74Xta146bwIYyM6e+pXmc3KZa6CdkUjRcifYYYWg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+zmU//V8mwjK7IhPtXdgxE6FyDylhGXkj9UM5HgBGCuY0DIhQSq++XOB+K1vyxim1+wFzymC+FfatNHyUsv2/mDYbCh2Y7zfa6LlJfz330kh6P1G/oQr4GZKz0VdajXNeKwiL39IEPa5FI2T4swUtK1YL4nL19/oVCJTAMlAd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=f41IAbQV; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="f41IAbQV"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 82137164B51
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:49 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 38AB3125163
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:49 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 07/22] gweb: Add an OS err parameter to 'call_result_func'.
Date: Mon,  3 Mar 2025 19:39:29 -0800
Message-ID: <4358a366915e876dc60ac5ea5dc2e3846601b438.1741059516.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1741059516.git.gerickson@nuovations.com>
References: <cover.1741059516.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=NK7Zt5YCiFxbYL1MjlRCqeVaXwqWgGmwUCiu6Pncj1g=; b=f41IAbQV9GlfUmlo2p+1shGSNTqtEDOJCHx0ImXR7sNF2gwTOalViOh02kcs06NG0ofanItOxaQXR0BTmL2U0F4TkCbwF2weQd0AXiS2cQde7I4ictegZkSarjtBHLRkauCxBTbs/C4qGmVw21NmIExjKYvfYRE5P1ZB5pSEE0b/xFeQkV9wIrS1PL0/dudrwEoKr5nh1TjGRI5meryrLrMgRm4eaDqYowTjFLvyL1CEIcvM9L8hn9k4TFWHJcNIewff75h1GsZTLhZFCKWnvHDpEWFqolEOY1ZPhQZ0ScO0ZR8rJ4nndPgAGiSm9FStR6QfmZIRijteT8gLqTM0ww==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

This allows populating the 'struct _GWebResult' 'err' data member for
operating system-related web request session failures and the use of
'g_web_result_get_err' for interested clients, such as WISPr.
---
 gweb/gweb.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 72f83d8f27e4..f5accf80cbeb 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -164,17 +164,21 @@ static void _debug(GWeb *web, const char *file, const char *caller,
 	va_end(ap);
 }
 
-static inline void call_result_func(struct web_session *session, guint16 status)
+static inline void call_result_func(struct web_session *session,
+					int err, guint16 status)
 {
+	debug(session->web, "session %p err %d status %d result_func %p",
+		session, err, status, session->result_func);
 
 	if (!session->result_func)
 		return;
 
+	session->result.err = err;
+
 	if (status != GWEB_HTTP_STATUS_CODE_UNKNOWN)
 		session->result.status = status;
 
 	session->result_func(&session->result, session->user_data);
-
 }
 
 static inline void call_route_func(struct web_session *session)
@@ -219,7 +223,7 @@ static gboolean connect_timeout_cb(gpointer user_data)
 	session->result.buffer = NULL;
 	session->result.length = 0;
 
-	call_result_func(session, GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT);
+	call_result_func(session, -ETIMEDOUT, GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT);
 
 	return G_SOURCE_REMOVE;
 }
@@ -960,7 +964,7 @@ static int decode_chunked(struct web_session *session,
 			if (session->chunk_left <= len) {
 				session->result.buffer = ptr;
 				session->result.length = session->chunk_left;
-				call_result_func(session,
+				call_result_func(session, 0,
 					GWEB_HTTP_STATUS_CODE_UNKNOWN);
 
 				len -= session->chunk_left;
@@ -976,7 +980,7 @@ static int decode_chunked(struct web_session *session,
 			/* more data */
 			session->result.buffer = ptr;
 			session->result.length = len;
-			call_result_func(session,
+			call_result_func(session, 0,
 				GWEB_HTTP_STATUS_CODE_UNKNOWN);
 
 			session->chunk_left -= len;
@@ -1002,7 +1006,7 @@ static int handle_body(struct web_session *session,
 		if (len > 0) {
 			session->result.buffer = buf;
 			session->result.length = len;
-			call_result_func(session,
+			call_result_func(session, 0,
 				GWEB_HTTP_STATUS_CODE_UNKNOWN);
 		}
 		return 0;
@@ -1014,7 +1018,7 @@ static int handle_body(struct web_session *session,
 
 		session->result.buffer = NULL;
 		session->result.length = 0;
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
+		call_result_func(session, 0, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
 	}
 
 	return err;
@@ -1107,7 +1111,7 @@ static void received_data_finalize(struct web_session *session)
 	session->result.buffer = NULL;
 	session->result.length = 0;
 
-	call_result_func(session, code);
+	call_result_func(session, 0, code);
 }
 
 static bool received_data_continue(struct web_session *session,
@@ -1223,7 +1227,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 		session->result.buffer = NULL;
 		session->result.length = 0;
 
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
+		call_result_func(session, -EIO, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
 
 		return FALSE;
 	}
@@ -2257,14 +2261,14 @@ static void handle_resolved_address(struct web_session *session)
 	ret = getaddrinfo(session->address, port, &hints, &session->addr);
 	g_free(port);
 	if (ret != 0 || !session->addr) {
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
+		call_result_func(session, 0, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
 		return;
 	}
 
 	call_route_func(session);
 
 	if (create_transport(session) < 0) {
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_CONFLICT);
+		call_result_func(session, 0, GWEB_HTTP_STATUS_CODE_CONFLICT);
 		return;
 	}
 }
@@ -2285,7 +2289,7 @@ static void resolv_result(GResolvResultStatus status,
 	struct web_session *session = user_data;
 
 	if (!results || !results[0]) {
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_NOT_FOUND);
+		call_result_func(session, 0, GWEB_HTTP_STATUS_CODE_NOT_FOUND);
 		return;
 	}
 
@@ -2347,6 +2351,7 @@ static guint do_request(GWeb *web, const char *url,
 	debug(web, "host %s", session->host);
 	debug(web, "flags %lu", session->flags);
 	debug(web, "request %s", session->request);
+	debug(web, "result_func %p", func);
 
 	if (type) {
 		session->content_type = g_strdup(type);
-- 
2.45.0

