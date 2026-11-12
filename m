Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457556;
	b=ZUHFdBAp6ZLmy6Z1aN+V1BirDtVtvgaX0uSK+44XwEllJRx0JcgFwV+otQ3mU4FKwjx7
	 sWZtA9NcEED8y8U8Mlb43hU+54NcQNxioHzFEUeN0tdjjFNbuZcRUKAIdq/ABaxU9EX23
	 QQ2JdQIE8oOP6AQWscLsk+7ogklXpxFqGWE5TWgUtIIJm0loHp1JTGYoygq2bTLheLlZi
	 ZYJFKPoAmOEG9CiNSMbmBnY0XIDhNpMDejdTvNv9HcD+Kdr7poNqE5zUyOX+eP0ZFAprY
	 hu+bOQgeUWnEvJo3Wta75mBPGA093M8bPbvS78IoYJrIwuQ2UMUK69h8UZdo+xGgGdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457556;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=llD8IXopdqdJom1EOcWz7jwaH3nQI4z/7CINFeH9MaA=;
	b=HElfOt6tQa3Nm4o9tjZt+TnPR7Gz8hQ2sFZE7RVixVhbNCyY/ehLHOxVXqMRj9tANJtt
	 0SmJsaaZgcf2wVmndB30xZ/aqgZNzzY5mO+c0M3oRKMUdn0h6rF+4Db1ZglUx+mZtJplU
	 RGEhMl6ebOaGMWy9UDnm06RgUZfGEitq9G9+PVCwl8L+yu9i5pgWp7AnmUhyVyXDDlKdO
	 BZnCtL6gJEV6/Ppg5hVWklQC/Rru/V1rVJ1YcY2V6P4u4iYOxbLMekLrK/V7S7DQOieHA
	 Dd8Rgdt7fPHgRUYqbauLMhKJtxakdOaFtwzsnpgOCBL6RrVB1kPU8IxflqZNqbp+cuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=Y5NUsFEK;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90269606A321
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 04:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90269606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=Y5NUsFEK
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 1F1311602BB;
	Wed, 11 Nov 2026 23:25:55 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id AAA6B124BF7;
	Wed, 11 Nov 2026 23:25:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Cc: giuseppe.eletto98@gmail.com
Subject: [PATCH 4/5] gweb: Add a receive inactivity timeout
Date: Wed, 11 Nov 2026 20:25:50 -0800
Message-ID: <20261112042551.1613107-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261112042551.1613107-4-gerickson@nuovations.com>
References: <20261112042551.1613107-1-gerickson@nuovations.com>
 <20261112042551.1613107-2-gerickson@nuovations.com>
 <20261112042551.1613107-3-gerickson@nuovations.com>
 <20261112042551.1613107-4-gerickson@nuovations.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=llD8IXopdqdJom1EOcWz7jwaH3nQI4z/7CINFeH9MaA=; b=Y5NUsFEK4XxdBYQt0MDgpgAakAWK6bWFNwdkeJQNxYPBixfmbLbngFoxpJCdfOfmoxLPCL28JQF08R0J/JSw7ZnuIV1ezewBUg8Cy0MzDKEqLk+gzwTnAUL/o2M1mS9k/I+ZOxOiwiNKYxfCNjgtFmWKbSSjPECRfkoG4w/VN95JOLNOSmLyh+gLz2B3xR7Wy4Z2aIVGATqDkTOUYibCN3JtVOP8UCjcWeeVnzhTsFKNt5b8DP0j32779xfctNbfRrigJeWWN33B9EpbQtC/lAJU6QY4dhvXZDb4e5h/dk3pPR18SanNVagUFnLMxSu1oqkJ8rouxllq3oXZGdkyLw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

The connect timeout set with g_web_set_connect_timeout runs from the
start of the connection until the first data is received from the
peer, at which point received_data cancels it. Nothing bounds the
request after that. A peer that sends part of its response, for
example its headers and some of a body shorter than its
Content-Length, and then nothing more, without closing the
connection, leaves the request waiting indefinitely, and its result
callback is never invoked.

Add a receive inactivity timeout, set with
g_web_set_inactivity_timeout. It is started each time received data
is processed and more is expected, and cancelled when the next data
or condition arrives, when the request ends, or when the session is
freed. If it expires, the transport is closed and the request fails
with G_IO_ERROR_TIMED_OUT and the message "no data from <address>
for <timeout>ms".

The timeout bounds the time between successive receipts of data, not
the total time of the request, so a slow peer that continues to make
progress is not failed. This mirrors how TCP itself times out on a
lack of progress rather than on total elapsed time. A value of zero,
the default, disables it, so existing users are unaffected until they
opt in.
---
 gweb/gweb.c | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 gweb/gweb.h |   3 +
 2 files changed, 201 insertions(+), 3 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index e3a2d2eecb7e..681ad3694bf9 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -110,6 +110,7 @@ struct web_session {
 
 	GIOChannel *transport_channel;
 	guint connect_timeout;
+	guint inactivity_timeout;
 	guint transport_watch;
 	guint send_watch;
 
@@ -160,6 +161,7 @@ struct _GWeb {
 	char *http_version;
 	bool close_connection;
 	guint connect_timeout_ms;
+	guint inactivity_timeout_ms;
 
 	GWebDebugFunc debug_func;
 	gpointer debug_data;
@@ -413,6 +415,112 @@ static void cancel_connect_timeout(struct web_session *session)
 	}
 }
 
+/**
+ *  @brief
+ *    Handle a receive inactivity timeout.
+ *
+ *  This callback handles a receive inactivity timeout for a GWeb
+ *  session: the peer, having sent some of its response, sent nothing
+ *  more for the inactivity timeout period. The session transport is
+ *  closed and the GWeb transaction is terminated with a
+ *  G_IO_ERROR_TIMED_OUT error.
+ *
+ *  param[in,out]  user_data  A pointer to the mutable GWeb session
+ *                            for which the receive inactivity timeout
+ *                            expired.
+ *
+ *  @returns
+ *    G_SOURCE_REMOVE (that is, FALSE) unconditionally, indicating
+ *    that the timeout source that triggered this callback should be
+ *    removed on callback completion.
+ *
+ *  @sa add_inactivity_timeout
+ *  @sa cancel_inactivity_timeout
+ *
+ */
+static gboolean inactivity_timeout_cb(gpointer user_data)
+{
+	struct web_session *session = user_data;
+	g_autofree char *message = NULL;
+	g_autoptr(GError) local_error = NULL;
+
+	message = g_strdup_printf("no data from %s for %ums",
+		session->address, g_web_get_inactivity_timeout(session->web));
+
+	debug(session->web, "session %p %s",
+			session, message);
+
+	session->inactivity_timeout = 0;
+
+	close_session_transport(session);
+
+	session->result.buffer = NULL;
+	session->result.length = 0;
+
+	local_error = g_error_new_literal(G_IO_ERROR,
+					G_IO_ERROR_TIMED_OUT,
+					message);
+
+	call_result_func_failure(session, local_error);
+
+	return G_SOURCE_REMOVE;
+}
+
+/**
+ *  @brief
+ *    Add a receive inactivity timeout.
+ *
+ *  This attempts to add a receive inactivity timeout and callback to
+ *  the specified GWeb session. The timeout is successfully added if
+ *  @a session is non-null and @a timeout_ms is greater than zero.
+ *
+ *  @param[in,out]  session     A pointer to the mutable GWeb session
+ *                              to add the receive inactivity timeout
+ *                              to.
+ *  @param[in]      timeout_ms  The time, in milliseconds, for the
+ *                              receive inactivity timeout. If zero
+ *                              ('0'), no timeout is added.
+ *
+ *  @sa cancel_inactivity_timeout
+ *  @sa inactivity_timeout_cb
+ *
+ */
+static void add_inactivity_timeout(struct web_session *session,
+						guint timeout_ms)
+{
+	if (!session || !timeout_ms)
+		return;
+
+	session->inactivity_timeout = g_timeout_add(timeout_ms,
+				inactivity_timeout_cb, session);
+}
+
+/**
+ *  @brief
+ *    Cancel a receive inactivity timeout.
+ *
+ *  This attempts to cancel a receive inactivity timeout, if any, for
+ *  the specified GWeb session.
+ *
+ *  @param[in,out]  session  A pointer to the mutable GWeb session
+ *                           for which to cancel the receive
+ *                           inactivity timeout.
+ *
+ *  @sa add_inactivity_timeout
+ *  @sa inactivity_timeout_cb
+ *
+ */
+static void cancel_inactivity_timeout(struct web_session *session)
+{
+	if (!session)
+		return;
+
+	if (session->inactivity_timeout > 0) {
+		g_source_remove(session->inactivity_timeout);
+		session->inactivity_timeout = 0;
+	}
+}
+
 /**
  *  @brief
  *    Close the TCP transport a GWeb sesssion.
@@ -472,6 +580,8 @@ static void free_session(struct web_session *session)
 
 	cancel_connect_timeout(session);
 
+	cancel_inactivity_timeout(session);
+
 	close_session_transport(session);
 
 	g_free(session->result.last_key);
@@ -820,6 +930,78 @@ done:
 	return timeout_ms;
 }
 
+/**
+ *  @brief
+ *    Set the receive inactivity timeout.
+ *
+ *  This sets the receive inactivity timeout, in milliseconds, for the
+ *  specified GWeb object.
+ *
+ *  The connect timeout (see #g_web_set_connect_timeout) runs until
+ *  the first data is received from the peer. The receive inactivity
+ *  timeout takes over from there: it is restarted each time data is
+ *  received and, if it expires, the request fails with
+ *  G_IO_ERROR_TIMED_OUT. Without it, a peer that sends part of its
+ *  response and then nothing more, without closing the connection,
+ *  leaves the request waiting indefinitely.
+ *
+ *  The timeout bounds the time between successive receipts of data,
+ *  not the total time of the request: a slow peer that continues to
+ *  make progress is not failed.
+ *
+ *  param[in,out]  web         A pointer to the mutable GWeb object
+ *                             for which the receive inactivity
+ *                             timeout is to be set.
+ *  param[in]      timeout_ms  The time, in milliseconds, for the
+ *                             receive inactivity timeout. A value of
+ *                             zero ('0') indicates that no receive
+ *                             inactivity timeout will be used.
+ *
+ *  @sa g_web_get_inactivity_timeout
+ *  @sa g_web_set_connect_timeout
+ *
+ */
+void g_web_set_inactivity_timeout(GWeb *web, guint timeout_ms)
+{
+	if (!web)
+		return;
+
+	debug(web, "timeout %ums", timeout_ms);
+
+	web->inactivity_timeout_ms = timeout_ms;
+}
+
+/**
+ *  @brief
+ *    Get the receive inactivity timeout.
+ *
+ *  This returns the receive inactivity timeout, in milliseconds, for
+ *  the specified GWeb object.
+ *
+ *  param[in]  web             A pointer to the immutable GWeb object
+ *                             for which the receive inactivity
+ *                             timeout is to be returned.
+ *
+ *  @returns
+ *    The receive inactivity timeout, in milliseconds. A value of zero
+ *    ('0') indicates that no receive inactivity timeout has been set.
+ *
+ *  @sa g_web_set_inactivity_timeout
+ *
+ */
+guint g_web_get_inactivity_timeout(const GWeb *web)
+{
+	guint timeout_ms = 0;
+
+	if (!web)
+		goto done;
+
+	timeout_ms = web->inactivity_timeout_ms;
+
+done:
+	return timeout_ms;
+}
+
 static bool process_send_buffer(struct web_session *session)
 {
 	GString *buf;
@@ -1461,13 +1643,20 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 	const gsize bytes_available = session->receive_space - 1;
 	gsize bytes_read;
 	GIOStatus status;
+	bool more;
 	g_autoptr(GError) local_error = NULL;
 	g_autoptr(GError) error = NULL;
 
-	/* We received some data or condition, cancel the connect timeout. */
+	/*
+	 * We received some data or condition, cancel the connect timeout
+	 * and any receive inactivity timeout. The latter is restarted
+	 * below if more data is expected.
+	 */
 
 	cancel_connect_timeout(session);
 
+	cancel_inactivity_timeout(session);
+
 	/* If there was a low-level I/O condition or error, there is
 	 * nothing more to do; simply fail the request.
 	 */
@@ -1507,10 +1696,16 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 	}
 
 	/* Otherwise, continue the session request and process the
-	 * received data.
+	 * received data and, if more is expected, (re)start the receive
+	 * inactivity timeout.
 	 */
 
-	return received_data_continue(session, bytes_read);
+	more = received_data_continue(session, bytes_read);
+	if (more)
+		add_inactivity_timeout(session,
+			g_web_get_inactivity_timeout(session->web));
+
+	return more;
 }
 
 static int bind_to_address(int sk, const char *interface, int family)
diff --git a/gweb/gweb.h b/gweb/gweb.h
index 75629500ef9c..5597a1e7f97a 100644
--- a/gweb/gweb.h
+++ b/gweb/gweb.h
@@ -163,6 +163,9 @@ bool g_web_set_http_version(GWeb *web, const char *version);
 void g_web_set_connect_timeout(GWeb *web, guint timeout_ms);
 guint g_web_get_connect_timeout(const GWeb *web);
 
+void g_web_set_inactivity_timeout(GWeb *web, guint timeout_ms);
+guint g_web_get_inactivity_timeout(const GWeb *web);
+
 void g_web_set_close_connection(GWeb *web, bool enabled);
 bool g_web_get_close_connection(GWeb *web);
 
-- 
2.52.0

