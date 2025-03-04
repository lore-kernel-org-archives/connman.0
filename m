Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338AC3BBC9
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050690; cv=none; b=GnGlXUJw7a9ZV1ylLbxR4nN9YfS1KTnBAAyxoMOoSC3ntUfZ7AbR6iDIOjCA1409966gK67SrY5K5WesaxpdycVlYQ5FLlb2R5oe196cZjmZjpoZQc5h2/fqf6POzSgp7HPE6ghAFIFJoVK401skSz/+yA3A0LxVd+o3OnyZ0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050690; c=relaxed/simple;
	bh=m5qc72d+E5U/nlVvK1iWbWX8jce6UQPp+Woq5ug82Ug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1bjyE0aWU1N4FliKf+ZOiZm8dHlSvYDZCNZ4SehxKY296QSAT6DmB/rZSk0YRzFdUFx7Pk4DywGMZf7Kinw3ejIri+CxlXaixepMLiwFCkf7wNOphFtd+v/tT6GgGi0cWlMLyZ8ou1vcNIS3yAPRYSg5lGpTgF2/bi9uEMtiQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=AEFFrK6J; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="AEFFrK6J"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id A5790164B5A
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:22 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 5D0481260D5
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:22 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 16/22] wispr: Refactor 'wispr_portal_web_result' to leverage 'g_web_result_get_err'.
Date: Mon,  3 Mar 2025 17:11:07 -0800
Message-ID: <dd652b9b5c89b0b8b528de641ec16bd5f49f6659.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Jf7mqV8g1VpJ7Y6ZpUGNOHiXlN41k9Qv2NfoXBIElio=; b=AEFFrK6J9abnolIWcAy33oNyIApIU44JRDYPcysnOB5Zmh/2o/Cwjq/HfNQMfN5YRpn+SJdFEw3Y/7T0WFzmgSOThMYvSf0STAHcKmZo8MK1ZLOC4rQcFfqfo6mdre1Nb3MHiV7ols55jXd4lg5l7ifWEggMkdDou+gKl/ih8QCxj3F8P3RJWbJu08OCc0oJZx+FYSXBCx+SNtZuymN2/On/MVIBtQWqb+sF2mPKF+2U+GXdX/bXvNEURvB+exiTygdKdNFodWwiWeze5VJsJh3DFiDCRX1kBRoDnR0e9lDqG/6Brx1Vodize/DeXIjpAeDT7Z2ZymwvGmmVPlYWBQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Leverages the newly-added GWeb 'g_web_result_get_err' interface to
refactor 'wispr_portal_web_result' into 'wispr_portal_web_result_err'
and 'wispr_portal_web_result_no_err' with the former handling
non-successful POSIX error domain cases and the latter handling
successful HTTP status code cases.

Prior to the introduction of 'g_web_result_get_err' and this refactor,
there existed a "hole" in the finalization of WISPr IPv4 and IPv6
"online" HTTP-based Internet reachability checks web request sessions
that both could and did leave such checks "dangling" and non-renewing
such that an expected active, default network service failover does
not occur when it should.

The "hole" involves an end-of-file (EOF) condition. In the normal
case, there are a series of one or more data receipts for the web
request as headers of the request response are fulfilled. When there
is no further data to send, the final receive completes a normal EOF
that leads to the successful closure of the web request, typically
with HTTP 200 "OK" in the nominal success case.

However, there is a second EOF case that appears to happen with a
random distribution in the nginx server backing the default "online"
HTTP-based Internet reachability check URLs,
'ipv[46].connman.net/online/status.html'. In that case, the nginx
server appears to periodically do an unexpected and spontaneous remote
connection close after the initial connection but before any data has
been received. Prior to this change, all such failures hit the same
WISPr error-handling block which effectively maps such a failure to the
effective 'GWebResult' "null" GWEB_HTTP_STATUS_CODE_UNKNOWN status
value. Unfortunately, WISPr historically had no way to distinguish
this as an actual failure or success and so it lands on the case:

        case GWEB_HTTP_STATUS_CODE_UNKNOWN:
                wispr_portal_context_ref(wp_context);
                __connman_agent_request_browser(wp_context->service,
                                wispr_portal_browser_reply_cb,
                                wp_context->status_url, wp_context);

which does not "bookend" the original, initiating WISPr web request
and leaves the original request "dangling" and non-renewed, eventually
leading to the aforementioned "hole".

With this change, the second, failure EOF case will now return
'-ECONNRESET' from 'g_web_result_get_err' and will be handled as a
failure by 'wispr_portal_web_result_err', "bookending" the original
"online" HTTP-based Internet reachability check.

All of the prior HTTP status code cases are handled by
'wispr_portal_web_result_no_err'.
---
 src/wispr.c | 95 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 26 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index fc49778fa607..d1d49704e5bf 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -782,6 +782,8 @@ static void wispr_portal_request_portal(
 					wispr_route_request,
 					wp_context, &err);
 
+	DBG("wp_context->request_id %d err %d", wp_context->request_id, err);
+
 	if (wp_context->request_id == 0) {
 		portal_manage_failure_status(wp_context, err);
 		wispr_portal_error(wp_context);
@@ -973,38 +975,26 @@ static bool wispr_manage_message(GWebResult *result,
 	return false;
 }
 
-static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
+static void wispr_portal_web_result_err(GWebResult *result,
+		struct connman_wispr_portal_context *wp_context,
+		int err)
 {
-	struct connman_wispr_portal_context *wp_context = user_data;
-	const char *redirect = NULL;
-	const guint8 *chunk = NULL;
-	const char *str = NULL;
-	guint16 status;
-	gsize length;
-
-	DBG("");
-
-	if (wp_context->wispr_result != CONNMAN_WISPR_RESULT_ONLINE) {
-		g_web_result_get_chunk(result, &chunk, &length);
-
-		if (length > 0) {
-			g_web_parser_feed_data(wp_context->wispr_parser,
-								chunk, length);
-			/* read more data */
-			return true;
-		}
+	portal_manage_failure_status(wp_context, err);
 
-		g_web_parser_end_data(wp_context->wispr_parser);
+	free_wispr_routes(wp_context);
+	wp_context->request_id = 0;
+}
 
-		if (wp_context->wispr_msg.message_type >= 0) {
-			if (wispr_manage_message(result, wp_context))
-				goto done;
-		}
-	}
+static void wispr_portal_web_result_no_err(GWebResult *result,
+		struct connman_wispr_portal_context *wp_context)
+{
+	guint16 status;
+	const char *str = NULL;
+	const char *redirect = NULL;
 
 	status = g_web_result_get_status(result);
 
-	DBG("status: %03u", status);
+	connman_info("status: %03u", status);
 
 	switch (status) {
 	case GWEB_HTTP_STATUS_CODE_UNKNOWN:
@@ -1073,12 +1063,64 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 				wispr_portal_browser_reply_cb,
 				wp_context->status_url, wp_context);
 		break;
+
 	default:
 		break;
 	}
 
 	free_wispr_routes(wp_context);
 	wp_context->request_id = 0;
+
+done:
+	return;
+}
+
+static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
+{
+	struct connman_wispr_portal_context *wp_context = user_data;
+	const guint8 *chunk = NULL;
+	int err;
+	gsize length;
+
+	DBG("result %p user_data %p wispr_result %d",
+		result, user_data, wp_context->wispr_result);
+
+	if (wp_context->wispr_result != CONNMAN_WISPR_RESULT_ONLINE) {
+		g_web_result_get_chunk(result, &chunk, &length);
+
+		DBG("length %zu", length);
+
+		if (length > 0) {
+			g_web_parser_feed_data(wp_context->wispr_parser,
+								chunk, length);
+			/* read more data */
+			return true;
+		}
+
+		g_web_parser_end_data(wp_context->wispr_parser);
+
+		DBG("wp_context->wispr_msg.message_type %d", wp_context->wispr_msg.message_type);
+
+		if (wp_context->wispr_msg.message_type >= 0) {
+			if (wispr_manage_message(result, wp_context))
+				goto done;
+		}
+	}
+
+	/* Check whether there was an operating system error while
+	 * processing the web request associated with the "online"
+	 * HTTP-based Internet reachability check.
+	 */
+
+	err = g_web_result_get_err(result);
+
+	DBG("err %d", err);
+
+	if (err < 0)
+		wispr_portal_web_result_err(result, wp_context, err);
+	else
+		wispr_portal_web_result_no_err(result, wp_context);
+
 done:
 	wp_context->wispr_msg.message_type = -1;
 
@@ -1088,6 +1130,7 @@ done:
 	 * maintaining a weak reference to it.
 	 */
 	wispr_portal_context_unref(wp_context);
+
 	return false;
 }
 
-- 
2.45.0

