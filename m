Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962D1EF088
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878778; cv=none; b=jUQ0wXgFwLGiM9rMP8JedUJ6s2qeh5sz2XTYBBsyLoZVoCGwpqqksYxDHS9w3r7Qek2GUKKU9tOQHVK+NP8xVD+RIN6naPqL/3EuPWudBqFQrgdgGPXYqrHQqAaw+9H/mrhlDoCF2FNlGLIIjML7uRDHgVFc0wwfmLSiznqbszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878778; c=relaxed/simple;
	bh=EfXKOCtqKtjjcmD3RgOr5BOvfxJTo2Ub6Eas7jO91ck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCd4yt6XK45X4G+7Lle6ZMOrSnzK2vnOMRBePYfntr9USBnfiz70q1e3EwjSQx5Ui/KF3AkxVXt4THxkyeulEnHnlDI0woZaDTYGhGnwVJReQQ0eGhES3NenWNhIsC1cfV/WOsOwUqp470yX6v2xvCyXTWPwolFkpCg1ov98z9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=PjBS3zJu; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="PjBS3zJu"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 6376F164AA8
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:30 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 1780F125166
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:30 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v4 2/9] gweb: Added and leveraged 'call_result_func_{failure,success}' wrappers.
Date: Mon, 24 Mar 2025 21:59:20 -0700
Message-ID: <fcda640506e5673f1dc7f27ad562d96ba47f5e67.1742878567.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=nPRYjhe+DwEbGMBF2qkTZbKdMgB3pEBsRhCYLsCJP48=; b=PjBS3zJuN7ygCyKPTix9SdyGdgFB2BiCwIihBwQOmOZKgoEF5FRgucKoaUF4O+ey3bXlyuc03p8xW1qNj068vYHAeeHVZWxKgv1VU5LASm4JGvpx0gMN+5NDJSXpawLgsJiXw9h4JyGgoGrtEcU6ckogK+lXMxo/rDU6KphkA2IRK6zVZiIukiHMTVg9WclLdhiQ1FiI7Y04Izzjg9l1DicnqtRGvxrOJ9nQ9rOTsCjF+0yeBc1ITA41aDYI6qEYMKsICL7Zrz2FgwJdL04VK39gRAh48jtPUtQliEDsg0XIGmApRA9zeoHx+HkXeTzy0vz+a3GKbYwEqI0Op+CJOA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

These wrappers both self-document the GWeb result callback closures
and, for the success wrapper, reduce the parameter list by defaulting
the error parameter to 'NULL'.
---
 gweb/gweb.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 9 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index a736c32ef0a5..07b50d07a93a 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -217,6 +217,8 @@ G_DEFINE_QUARK(g-web-error-quark, g_web_error)
  *    information about an error that occurred during the GWeb request,
  *    if any.
  *
+ *  @sa call_result_func_failure
+ *  @sa call_result_func_success
  *  @sa do_request
  *
  *  @private
@@ -234,6 +236,62 @@ static void call_result_func(struct web_session *session,
 	session->result_func(error, &session->result, session->user_data);
 }
 
+/**
+ *  @brief
+ *    Invoke the closure callback on failure associated with the web
+ *    session request.
+ *
+ *  This closes the specified web session request on failure with @a
+ *  error by invoking the @a result_func originally assigned in
+ *  #do_request when the session was first initiated.
+ *
+ *  @param[in]  session
+ *    A pointer to the mutable web session request for which to invoke
+ *    the closure callback.
+ *
+ *  @param[in]  error
+ *    A required pointer to the immutable GError structure containing
+ *    informatino about an error that occurred during the GWeb
+ *    request.
+ *
+ *  @sa call_result_func
+ *  @sa call_result_func_success
+ *  @sa do_request
+ *
+ *  @private
+ *
+ */
+static inline void call_result_func_failure(struct web_session *session,
+					const GError *error)
+{
+	call_result_func(session, error);
+}
+
+/**
+ *  @brief
+ *    Invoke the closure callback on success associated with the web
+ *    session request.
+ *
+ *  This closes the specified web session request on success by
+ *  invoking the @a result_func originally assigned in #do_request
+ *  when the session was first initiated.
+ *
+ *  @param[in]  session
+ *    A pointer to the mutable web session request for which to invoke
+ *    the closure callback.
+ *
+ *  @sa call_result_func
+ *  @sa call_result_func_failure
+ *  @sa do_request
+ *
+ *  @private
+ *
+ */
+static void call_result_func_success(struct web_session *session)
+{
+	call_result_func(session, NULL);
+}
+
 static inline void call_route_func(struct web_session *session)
 {
 	if (session->route_func)
@@ -285,7 +343,7 @@ static gboolean connect_timeout_cb(gpointer user_data)
 					G_IO_ERROR_TIMED_OUT,
 					message);
 
-	call_result_func(session, local_error);
+	call_result_func_failure(session, local_error);
 
 	return G_SOURCE_REMOVE;
 }
@@ -1026,7 +1084,7 @@ static int decode_chunked(struct web_session *session,
 			if (session->chunk_left <= len) {
 				session->result.buffer = ptr;
 				session->result.length = session->chunk_left;
-				call_result_func(session, NULL);
+				call_result_func_success(session);
 
 				len -= session->chunk_left;
 				ptr += session->chunk_left;
@@ -1041,7 +1099,7 @@ static int decode_chunked(struct web_session *session,
 			/* more data */
 			session->result.buffer = ptr;
 			session->result.length = len;
-			call_result_func(session, NULL);
+			call_result_func_success(session);
 
 			session->chunk_left -= len;
 			session->total_len += len;
@@ -1068,7 +1126,7 @@ static int handle_body(struct web_session *session,
 		if (len > 0) {
 			session->result.buffer = buf;
 			session->result.length = len;
-			call_result_func(session, NULL);
+			call_result_func_success(session);
 		}
 		return 0;
 	}
@@ -1086,7 +1144,7 @@ static int handle_body(struct web_session *session,
 			G_WEB_ERROR_CHUNK_DECODE,
 			message);
 
-		call_result_func(session, local_error);
+		call_result_func_failure(session, local_error);
 	}
 
 	return err;
@@ -1320,7 +1378,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 			g_io_error_from_errno(EIO),
 			g_strerror(EIO));
 
-		call_result_func(session, local_error);
+		call_result_func_failure(session, local_error);
 
 		return FALSE;
 	}
@@ -2360,7 +2418,7 @@ static void handle_resolved_address(struct web_session *session)
 			session->address,
 			gai_strerror(ret));
 
-		call_result_func(session, local_error);
+		call_result_func_failure(session, local_error);
 
 		return;
 	}
@@ -2373,7 +2431,7 @@ static void handle_resolved_address(struct web_session *session)
 						g_io_error_from_errno(ret),
 						g_strerror(ret));
 
-		call_result_func(session, local_error);
+		call_result_func_failure(session, local_error);
 	}
 }
 
@@ -2399,7 +2457,7 @@ static void resolv_result(GResolvResultStatus status,
 				"could not resolve %s",
 				session->host);
 
-		call_result_func(session, local_error);
+		call_result_func_failure(session, local_error);
 
 		return;
 	}
-- 
2.45.0

