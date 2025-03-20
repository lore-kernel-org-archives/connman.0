Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6A22259E
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513964; cv=none; b=eEsJ/N7uSnXv0oS7Z4t+QH2yXj+3W9eUWC4v1pPId9Nr3XadZ8fCmY68fzqpw+9ecx8PyYItyRzxlX2xYuBJcq+s56NwOdjMBFjIIQOPNnViCBUjsCUEyQTvHOJgtv/HDm1pOhcP4js29a3S/A8zmx7ebdXn+cuQisORNIft0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513964; c=relaxed/simple;
	bh=FJDxKGcHSrWEqO6D9Uj/6DC0IkIphoojz+2v0wRBWy4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smHzVlaUuyqnaZiznoGADPZGo9KopwB0XQ8gMRv+w8btYRNG9nM6VtnqP2Y55AgtWovgte5D6s+ezOoUHeHbfUTsJijjgNy8ry9Uq+ltlYIVMTn0Fj1yFT1xtYzzcv2niGPIlMhNixWmGb5a7NfyNrtleN8AQMXnK9UhHIIt3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Cazbcs1Y; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Cazbcs1Y"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 00C1C164AD6
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:16 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id AA839125183
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:15 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 10/18] gweb: Added and leveraged 'call_result_func_{failure,success}' wrappers.
Date: Thu, 20 Mar 2025 16:39:01 -0700
Message-ID: <84263422c21dc7f9d388ef2d1d320231e19efe47.1742513884.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=2HcvaYk0YCDfxn8hKxB3Ga7qnMeuucfpl/hndhFsUd0=; b=Cazbcs1Yf/Et6C3Hd7JoriI4HpDIRUCanzgdVcySCaNcuLcl7c5CYTH4PkqfIou6+mfn1NgiONTDNL+LZ8wtOsrZw7YQTj6ZC8PajaudX4P5rgXyCf2lGQ3JgxUzTNpUnqb4Kv17WUSGMG6XYKt+OLdueOU1StUd2Iz35yCqkJwivHDH81PI0kERI+NPj6iN76B7IaAjV8iio0rifaPJGucKoaO/cOfyY8GmZf+QYLdeScWAZ2mQGu5Bh7azflixpK/Bjfxr3MojTlGSxQmr7kkuBNBkXKW3sJvcS9qf/sb8YC21C/8ureu6hMpNAYb3SjHLyByvnkCJmoOHYCgaEQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

These wrappers both self-document the GWeb result callback closures
and, for the success wrapper, reduce the parameter list by defaulting
the error parameter to 'NULL'.
---
 gweb/gweb.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 9 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 1915d3737eb0..7ad12c977ff8 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -185,6 +185,8 @@ G_DEFINE_QUARK(g-web-error-quark, g_web_error)
  *    information about an error that occurred during the GWeb request,
  *    if any.
  *
+ *  @sa call_result_func_failure
+ *  @sa call_result_func_success
  *  @sa do_request
  *
  *  @private
@@ -202,6 +204,62 @@ static void call_result_func(struct web_session *session,
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
@@ -253,7 +311,7 @@ static gboolean connect_timeout_cb(gpointer user_data)
 					G_IO_ERROR_TIMED_OUT,
 					message);
 
-	call_result_func(session, local_error);
+	call_result_func_failure(session, local_error);
 
 	if (local_error)
 		g_error_free(local_error);
@@ -997,7 +1055,7 @@ static int decode_chunked(struct web_session *session,
 			if (session->chunk_left <= len) {
 				session->result.buffer = ptr;
 				session->result.length = session->chunk_left;
-				call_result_func(session, NULL);
+				call_result_func_success(session);
 
 				len -= session->chunk_left;
 				ptr += session->chunk_left;
@@ -1012,7 +1070,7 @@ static int decode_chunked(struct web_session *session,
 			/* more data */
 			session->result.buffer = ptr;
 			session->result.length = len;
-			call_result_func(session, NULL);
+			call_result_func_success(session);
 
 			session->chunk_left -= len;
 			session->total_len += len;
@@ -1039,7 +1097,7 @@ static int handle_body(struct web_session *session,
 		if (len > 0) {
 			session->result.buffer = buf;
 			session->result.length = len;
-			call_result_func(session, NULL);
+			call_result_func_success(session);
 		}
 		return 0;
 	}
@@ -1057,7 +1115,7 @@ static int handle_body(struct web_session *session,
 			G_WEB_ERROR_CHUNK_DECODE,
 			message);
 
-		call_result_func(session, local_error);
+		call_result_func_failure(session, local_error);
 
 		if (local_error)
 			g_error_free(local_error);
@@ -1294,7 +1352,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 			g_io_error_from_errno(EIO),
 			g_strerror(EIO));
 
-		call_result_func(session, local_error);
+		call_result_func_failure(session, local_error);
 
 		if (local_error)
 			g_error_free(local_error);
@@ -2340,7 +2398,7 @@ static void handle_resolved_address(struct web_session *session)
 			G_WEB_ERROR_HOST_NOT_FOUND,
 			message);
 
-		call_result_func(session, local_error);
+		call_result_func_failure(session, local_error);
 
 		goto done;
 	}
@@ -2353,7 +2411,7 @@ static void handle_resolved_address(struct web_session *session)
 						g_io_error_from_errno(ret),
 						g_strerror(ret));
 
-		call_result_func(session, local_error);
+		call_result_func_failure(session, local_error);
 
 		goto done;
 	}
@@ -2388,7 +2446,7 @@ static void resolv_result(GResolvResultStatus status,
 				G_WEB_ERROR_HOST_NOT_FOUND,
 				message);
 
-		call_result_func(session, local_error);
+		call_result_func_failure(session, local_error);
 
 		if (local_error)
 			g_error_free(local_error);
-- 
2.45.0

