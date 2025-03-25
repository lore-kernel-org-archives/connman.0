Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A71EF094
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878780; cv=none; b=Z4RkjBFqOIhiZK6TeKHzMdKN9sk7HaHsl6DsKi8ucjF1rH9g84zIXaLxoDyqKv7pja73Aieu4D0G6nK2CR1I2HVMnww1R/m15GfMvZ7LEmkdPOUFh6TvIVE83YDr21+1x0APF/Ax4S1Z+/FfDp/9WsY4niyi/nRLnAZrv/WF2dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878780; c=relaxed/simple;
	bh=N6EwaZGJRQhJ0sqWdXUn/kp1nvsvQyzxKr6J8/CRaTE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmyN5DCvs1m9to+SnePOt2LUuGJKYIEyLR69ju0Mr7URMIcE/KmeRdsBcjB/ezocz/+st3heInS624z1yssVcG6PI4CGuApNVB5ybFFOrfnWFpPUJsT5FbMqYGYsraI7FraIm5I8SkLLpysIDWAMm3p7Cmf3+YDzQJdiiWdyGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=V775PTO+; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="V775PTO+"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id D37A0164A59
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:30 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 874B3125166
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:30 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v4 3/9] gweb: Close web request session finalization 'hole'.
Date: Mon, 24 Mar 2025 21:59:21 -0700
Message-ID: <a30e8811784285dfa3a26ef314a52ef96fba8cf4.1742878567.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Diqn7ZWdgxIlQEkKt35+MJWZvagwWO1yUMRy3kHu+1o=; b=V775PTO+7w9qJsK9hgl303bV3+jr9x4pm3vHz5r9u+ja13n5Sj7XH6Ye61Vurxqs6HW5akkAV3cL+EGDS1Zx+eRFKSslAy9biNnXudnAqitmlBTCHjTaiJf3LrbXO4iJsCJEf3hkg8F69Y3CloMySjl1wUwXS4LyuILZ5InhhCl9dImRaKpkomQHpLvELSPVc8Yfjit25gtImIPnaUNKy197SRldi7zrtzYeDUcYyHcisT/3jsMSWTC9/V10elQeHqx3nwQxN715kKM5Az0wBIB8bq0qvvS15VQHx+HTPXMZHmat0LfaBwCF/VAyUUPYMYqmmJcwk6ROi0eZKPAxDw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

There exist two "holes" in the finalization of web request sessions
that can, for example in a client such as WISPr, leave one or both of
IPv4 and IPv6 "online" HTTP-based Internet reachability checks
"dangling" and non-renewing such that an expected active, default
network service failover does not occur when it should.

The first of those two failure "holes" involves an end-of-file (EOF)
condition. In the normal case, there are a series of one or more data
receipts for the web request as headers and, if present, the body of
the request response are fulfilled. When there is no further data to
send, the final receive completes with 'g_io_channel_read_chars'
returning 'G_IO_STATUS_EOF' status and zero (0) bytes read. This should
and does lead to a successful EOF closure of the web request.

However, there is a second EOF case that appears to happen with a
random distribution in the nginx server backing the default "online"
HTTP-based Internet reachability check URLs,
'ipv[46].connman.net/online/status.html'. In that case, the nginx
server appears to periodically do an unexpected and spontaneous remote
connection close after the initial connection but before any data has
been received. Presently, all such failures hit the same
error-handling block which effectively maps such a failure to the
effective "null" 'GWEB_HTTP_STATUS_CODE_UNKNOWN' status
value. Unfortunately, clients such as WISPr have no way to distinguish
this as an actual failure or success and so it lands on the case:

	case GWEB_HTTP_STATUS_CODE_UNKNOWN:
		wispr_portal_context_ref(wp_context);
		__connman_agent_request_browser(wp_context->service,
				wispr_portal_browser_reply_cb,
				wp_context->status_url, wp_context);

which does not "bookend" the original, initiating WISPr web request
and leaves the original request "dangling" and non-renewed, eventually
leading to the aforementioned "hole".

To handle this failure EOF case, if GWeb asked for a non-zero amount
of data from 'g_io_channel_read_chars' but received none and has
accumulated no headers thus far upon receiving the status
'G_IO_STATUS_EOF', then GWeb assumes that the remote peer server
unexpectedly closed the connection, and synthesizes a new GError with
the error 'ECONNRESET'. With the addition of the optional, immutable
GError parameter to the GWebResult callback function, clients such as
WISPr can now distinguish between a HTTP non-response in which no HTTP
data was received and one in which HTTP data was received and the
status can be disguished by the HTTP status code.

The second of the two failure "holes" involves the case where
'g_io_channel_read_chars' returns 'G_IO_STATUS_ERROR' status. Prior to
this change, this funneled to the same "hole" as the 'G_IO_STATUS_ERROR'
failure with the same consequence to clients such as WISPr.

To handle this error case, GWeb now passes a glib GError pointer to
'g_io_channel_read_chars'. If it is set, GWeb passes the GError
through to the GWebResult callback function. Otherwise, it synthesizes
a GError anew from 'EIO'. As with the failure EOF case, this allows
clients to distinguish and handle such failures and to successfully
"bookend" their initial web request.
---
 gweb/gweb.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 6 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 07b50d07a93a..10f1cf1df0b2 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1228,14 +1228,62 @@ static void add_header_field(struct web_session *session)
 	}
 }
 
-static void received_data_finalize(struct web_session *session)
+static void received_data_finalize(struct web_session *session,
+				GIOStatus status, gsize bytes_available,
+				gsize bytes_read, const GError *error)
 {
+	g_autoptr(GError) local_error = NULL;
+	const GError *passed_error = NULL;
+
 	session->transport_watch = 0;
 
 	session->result.buffer = NULL;
 	session->result.length = 0;
 
-	call_result_func(session, NULL);
+	/* Handle post-channel read errors, which could be either
+	 * G_IO_STATUS_ERROR or G_IO_STATUS_EOF.
+	 *
+	 * For G_IO_STATUS_ERROR, simply pass through the GError, if
+	 * non-null. If there is no GError, create a GError anew based on
+	 * EIO.
+	 *
+	 * For G_IO_STATUS_EOF, this could occur at the end of a nominal,
+	 * successful get. That is, some number of headers, with or
+	 * without a body, termiated by an expected end-of-file (EOF)
+	 * condition. However, G_IO_STATUS_EOF can also happen as a result
+	 * of the remote peer server unexpectedly terminating the
+	 * connection without transferring any data at all. The only
+	 * reasonable recovery for this case it to fail the request,
+	 * synthesizing ECONNRESET as the error, and to let the client
+	 * request again.
+	 *
+	 * If we asked for a non-zero amount of data but received none and
+	 * have accumulated no headers thus far, then we assume that the
+	 * remote peer server unexpectedly closed the connection;
+	 * otherwise, we assume it is a normal EOF closure.
+	 */
+
+	if (status == G_IO_STATUS_ERROR) {
+		if (error != NULL)
+			passed_error = error;
+		else {
+			local_error = g_error_new_literal(G_IO_ERROR,
+				g_io_error_from_errno(EIO),
+				g_strerror(EIO));
+			passed_error = local_error;
+		}
+	} else if (status == G_IO_STATUS_EOF) {
+		if (bytes_available > 0 &&
+				bytes_read == 0 &&
+				!g_web_result_has_headers(&session->result, NULL)) {
+			local_error = g_error_new_literal(G_IO_ERROR,
+				g_io_error_from_errno(ECONNRESET),
+				g_strerror(ECONNRESET));
+			passed_error = local_error;
+		}
+	}
+
+	call_result_func_failure(session, passed_error);
 }
 
 static bool received_data_continue(struct web_session *session,
@@ -1356,9 +1404,11 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
 	struct web_session *session = user_data;
+	const gsize bytes_available = session->receive_space - 1;
 	gsize bytes_read;
 	GIOStatus status;
 	g_autoptr(GError) local_error = NULL;
+	g_autoptr(GError) error = NULL;
 
 	/* We received some data or condition, cancel the connect timeout. */
 
@@ -1387,16 +1437,17 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 
 	status = g_io_channel_read_chars(channel,
 				(gchar *) session->receive_buffer,
-				session->receive_space - 1, &bytes_read, NULL);
+				bytes_available, &bytes_read, &error);
 
-	debug(session->web, "bytes read %zu status %d", bytes_read,
-		status);
+	debug(session->web, "bytes read %zu status %d error %p", bytes_read,
+		status, error);
 
 	/* Handle post-channel read errors, which could be either
 	 * G_IO_STATUS_ERROR or G_IO_STATUS_EOF.
 	 */
 	if (status != G_IO_STATUS_NORMAL && status != G_IO_STATUS_AGAIN) {
-		received_data_finalize(session);
+		received_data_finalize(session, status,
+			bytes_available, bytes_read, error);
 
 		return FALSE;
 	}
@@ -2520,6 +2571,7 @@ static guint do_request(GWeb *web, const char *url,
 	debug(web, "host %s", session->host);
 	debug(web, "flags %lu", session->flags);
 	debug(web, "request %s", session->request);
+	debug(web, "result_func %p", func);
 
 	if (type) {
 		session->content_type = g_strdup(type);
-- 
2.45.0

