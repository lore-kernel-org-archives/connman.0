Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63B537FF
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050688; cv=none; b=XjkXJnG/mhSgCdpxgcdduRlcNokopNd7nBJuGbyzkJwNiLewfcDCsxggsTigF6xxlD3GOyJhs3hm+BgqUAJwDE0+vLw9DxCvplUkq0wE1pJgJlMXh0zyQqiu0oRioTAhQwJbsN4ICN7r+NzMxY1yZlueW4Kdp+cnJumYVxZiANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050688; c=relaxed/simple;
	bh=K2+y9qG9UIUWL2crGm/QZ1ZKQ9St4gs65NdBxqQ8jE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3ctYUo4usnlixQon9ofDPCAyHtgrpvMaud9Fv2s2kWbtl8IZOppqEyUrCJqxatOrqEfrjIhGYCJuL4QfXsDedFkTO8zjqsOWkWS7wuKf4ajZ8zU1t5BWv9jEh7wzRUIcWDGirCBHsjF0fmME1gcTBLEJxIUaenJVms6cKRMAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=O4vol6G2; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="O4vol6G2"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 6D36D164B56
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:20 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 24B901262B0
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 11/22] gweb: Close web request session finalization 'hole'.
Date: Mon,  3 Mar 2025 17:11:02 -0800
Message-ID: <3e35d3f610c54761f9f3b54514d92272215230cc.1741050622.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
References: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=ojYdfHzkhPpbTHzEcUutPyG7cA8mELrsffy7npJvxgY=; b=O4vol6G28OJQjvSy25y5mtIZyTQz2LNjmKGAKmf3p/WzDltAx/OgzfrmN2qZ6dRVSbXfKJKqYyKeYAg/lIevc77E4hGwSkmwHial4DMiN2/f72t9Y/PB7KxRrBA+4LhFOJW8eK1IWqK8dMcqeOrBqUhZYBaztt+ZXC5Eqnt0gpDBfgVkQYI1IzkcAnJcLC3FZAfhDUJBkOX9Bdi1v/5eP5i4sFql1hSvElXvORvdlANlLZsY472MgfdbgCwPFcDG8mJ+lmja3LPeqvW4yEwYttUcsy0fh5+r7MIUYc6LlYNvZCBbZa9BPVdn2FCIMj/apawnhkkP8AnFeXpPEhms1A==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

There exist two "holes" in the finalization of web request sessions
that can, for example in a client such as WISPr leave one or both of
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

To handle this failure EOF case, if GWeb asked for a non-zero amount of
data from 'g_io_channel_read_chars' but received none and have
accumulated no headers thus far upon receiving the status
'G_IO_STATUS_EOF', then GWeb assumes that the remote peer server
unexpectedly closed the connection, and synthesize the error
'-ECONNRESET' with the same HTTP status "null" value of
'GWEB_HTTP_STATUS_CODE_UNKNOWN'. With the addition of the new
'g_web_result_get_err' interface, clients such as WISPr can now
distinguish between a low-level operating system error in which no
HTTP data was received and an operating system success in which HTTP
data was received and the status can be disguished by the HTTP status
code.

The second of the two failure "holes" involves the case where
'g_io_channel_read_chars' returns 'G_IO_STATUS_ERROR' status. Prior to
this change, this funneled to the same "hole" as the 'G_IO_STATUS_ERROR'
failure with the same consequence to clients such as WISPr.

To handle this error case, GWeb now passes a glib GError pointer to
'g_io_channel_read_chars'. If it is set, GWeb maps the resulting error
domain/code pairs to negated POSIX domain errors, and default to
'-EIO' if no suitable mapping can be made. As with the failure EOF
case, this allows clients to distinguish and handle such failures and
to successfully "bookend" their initial web request.
---
 gweb/gweb.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 106 insertions(+), 7 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 78d4fb0517ff..4a402ccfc346 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1130,8 +1130,67 @@ static void add_header_field(struct web_session *session)
 	}
 }
 
-static void received_data_finalize(struct web_session *session)
+static int map_gerror(const GError *error)
 {
+	int err;
+
+	if (error->domain == G_CONVERT_ERROR) {
+		switch (error->code) {
+		case G_CONVERT_ERROR_NO_MEMORY:
+			err = -ENOMEM;
+			break;
+		case G_CONVERT_ERROR_ILLEGAL_SEQUENCE:
+			err = -EILSEQ;
+			break;
+		case G_CONVERT_ERROR_PARTIAL_INPUT:
+			err = -EBADMSG;
+			break;
+		default:
+			err = -EIO;
+			break;
+		}
+	} else if (error->domain == G_IO_CHANNEL_ERROR) {
+		switch (error->code) {
+		case G_IO_CHANNEL_ERROR_INVAL:
+			err = -EINVAL;
+			break;
+		case G_IO_CHANNEL_ERROR_FBIG:
+			err = -EFBIG;
+			break;
+		case G_IO_CHANNEL_ERROR_IO:
+			err = -EIO;
+			break;
+		case G_IO_CHANNEL_ERROR_ISDIR:
+			err = -EISDIR;
+			break;
+		case G_IO_CHANNEL_ERROR_NOSPC:
+			err = -ENOSPC;
+			break;
+		case G_IO_CHANNEL_ERROR_NXIO:
+			err = -ENXIO;
+			break;
+		case G_IO_CHANNEL_ERROR_OVERFLOW:
+			err = -EOVERFLOW;
+			break;
+		case G_IO_CHANNEL_ERROR_PIPE:
+			err = -EPIPE;
+			break;
+		default:
+			err = -EIO;
+			break;
+		}
+	} else {
+		err = -EIO;
+	}
+
+	return err;
+}
+
+static void received_data_finalize(struct web_session *session,
+				GIOStatus status, gsize bytes_available,
+				gsize bytes_read, const GError *error)
+{
+	int err = 0;
 	const guint16 code = GWEB_HTTP_STATUS_CODE_UNKNOWN;
 
 	session->transport_watch = 0;
@@ -1139,7 +1198,41 @@ static void received_data_finalize(struct web_session *session)
 	session->result.buffer = NULL;
 	session->result.length = 0;
 
-	call_result_func(session, 0, code);
+	/* Handle post-channel read errors, which could be either
+	 * G_IO_STATUS_ERROR or G_IO_STATUS_EOF.
+	 *
+	 * For G_IO_STATUS_ERROR, simply attempt to map the error from
+	 * GError, if available.
+	 *
+	 * For G_IO_STATUS_EOF, this could occur at the end of a nominal,
+	 * successful get. That is, some number of headers, with or
+	 * without a body, termiated by an expected end-of-file (EOF)
+	 * condition. However, G_IO_STATUS_EOF can also happen as a result
+	 * of the remote peer server unexpectedly terminating the
+	 * connection without transferring any data at all. The only
+	 * reasonable recovery for this case it to fail the request,
+	 * synthesizing -ECONNRESET as the error, and to let the client
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
+			err = map_gerror(error);
+		else
+			err = -EIO;
+	} else if (status == G_IO_STATUS_EOF) {
+		if (bytes_available > 0 &&
+				bytes_read == 0 &&
+				!g_web_result_has_headers(&session->result, NULL))
+			err = -ECONNRESET;
+	}
+
+	call_result_func(session, err, code);
 }
 
 static bool received_data_continue(struct web_session *session,
@@ -1260,8 +1353,10 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
 	struct web_session *session = user_data;
+	const gsize bytes_available = session->receive_space - 1;
 	gsize bytes_read;
 	GIOStatus status;
+	GError *error = NULL;
 
 	/* We received some data or condition, cancel the connect timeout. */
 
@@ -1277,7 +1372,7 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 		session->result.buffer = NULL;
 		session->result.length = 0;
 
-		call_result_func(session, -EIO, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
+		call_result_func(session, -EIO, GWEB_HTTP_STATUS_CODE_UNKNOWN);
 
 		return FALSE;
 	}
@@ -1286,16 +1381,20 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 
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
+
+		if (error != NULL)
+			g_clear_error(&error);
 
 		return FALSE;
 	}
-- 
2.45.0

