Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8651EB9FA
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059596; cv=none; b=RQT/EEQJIMAfc3kdZDtr4IJL9EbG8jIRT8H7jZcFmkmCHtayL+5Iu3IyxJWmj/fTzkaZp5l0zpnHcrl07yd09QIHUQGvqgy9nqA4wWxpn4ao7idPFc8I2wkkttrksj6j2LRaenZk7ZWFpUe8PhCc8z9t4/ywj1vSFbaSG8grWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059596; c=relaxed/simple;
	bh=FSwX5EZ5k8H4zfcktaMNseSF2kfuy+uOeewo74HihyI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFFQJzVh/m7gjRinIkWNP5YbWK1KeYN1Oz86P5c+9yGnlkMXMNi51U3qm0RhHlz+LLAR3eTP/qwjdx8upb/4+bklXXuLmWCz4TRd8bg2xvKRsLPCKxbbpgtFdGNj/29zUrbWiw9j71ssYYNxGIZ7z0DI8cAQuY95YZLODrGsSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=XcSgTOb+; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="XcSgTOb+"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 8D6FC164B43
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:53 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 436D6126386
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:53 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 16/22] wispr: Refactor 'wispr_portal_web_result' to leverage 'g_web_result_get_err'.
Date: Mon,  3 Mar 2025 19:39:38 -0800
Message-ID: <9a810fc16ec4f7b16bd6055fad40a9fc87182759.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=XIQGR4AGmJ7AWgrbLCkTL5beVz5QBL75r9xBJJEGwko=; b=XcSgTOb+Tu2kTKeDsixC9z+OAIRnnZ0wfh5Wd+2n0EMdVh6dTIf5NdDKBt443GkuxQiqWchBCZpRz9Quxdtu5F4mXAJUnzW9Ygw0S4z3+wmqiUgtGcDt6L/4CnJhXLUxX8H8Be/hGh2eH95K8Qd214vvIhA1/EWyObmNG8MKfflGg5K4ITpLHXT33h2EdQbUSp2Rh2N2rDrujX1mtaGc6WGNKyOaR6TlbeT7okKrgxI4V6SRArK9SdkoweYkOB8FWJhdNQQBCYoBJK0A6aWNJpS8Ht0WTkhbxVgpGOACZbkXTZbL/2Tj04wp0Gpec96AcssXrYXgSjqXy3+taLxE2g==
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
 src/wispr.c | 93 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 68 insertions(+), 25 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index fc49778fa607..3116edef0d4b 100644
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
@@ -973,34 +975,22 @@ static bool wispr_manage_message(GWebResult *result,
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

