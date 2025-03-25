Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169071F0E48
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878782; cv=none; b=MB0qUjCF7zUqV3G9ZNvD/vW5IqzqOOqfnYbhQ6YY9gf6lCiF38+1s8p6B82bsY95xweFqL8xduRKCyA9iwA0U7fLh13wrp6+kKaxEqFARaaJPmCRXO+vOofW1WxM7B5hTm1tck9vNewkGCOvUSaSBZdQ4Opqs5acO84YxDP1GRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878782; c=relaxed/simple;
	bh=1AgjP2YA9Uoa38Tm6zas58vc2iTl354URDjbomzK6oI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnhiMXwiba1XRsqdZ7dPlaUZ/G3ZbK0Err3B98XnhPmhl3kYajck0s9DRJ/BMObyS4jiD+qvZfBtp4fDrZaHIsZ7FeWQO66sagk7wkbWZXyfzmL+KFKQZEkMxxplZtEfZR4d1bXOHEdfSivv2HnquENT6QXzFncSFRwe/ocRRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=MyWX7utm; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="MyWX7utm"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id BDEF1164AAB
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:31 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 70ED2125166
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:31 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v4 5/9] wispr: Refactor 'wispr_portal_web_result' to leverage 'GError'.
Date: Mon, 24 Mar 2025 21:59:23 -0700
Message-ID: <90cf71d0585440245fc9f788fbbb460a0c210f56.1742878567.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=M9uQSoBBsHxxXBRLlcAOtg8Du/xs6ED2Mka9+VtDn1w=; b=MyWX7utmEYdA37KglaukGtSS4JSQNIIPIUuo1go0zYzHzw0eUJi/eMjwqMcQ+AXJFzu65pIy4GjsTIyoqYgh0iL05f5A4zEoyBjctwOhdib7o6+HDcMYWCpgBZOxixogSBa7zaVF15bbQJ4Ly93rRFy+qmZcLhmT0EJ4KPPQ6WDsyf7295SCisMiivoHjaafLw7LXaENpkREjXOxCO2Tx3iyUF+sEfkY6a0v5zcTaLHZ+Ps+S4H4DTKAHRUPpAtpBXj472T6YNzY1FKCyOOHjqRhZYX/enlpMi8cf5mOX6FlwiNfYtIyiD9VLNuKEVSknl9MdvRNJTCZ/FuoaTaoPQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Leverages the newly-added GError parameter to the 'GWebResultFunc' to
refactor 'wispr_portal_web_result' into
'wispr_portal_web_result_failure' and
'wispr_portal_web_result_success' with the former handling
non-successful cases and the latter handling successful HTTP status
code cases.

Prior to the introduction of an optional, immutable 'GError' parameter
to 'GWebResultFunc' and this refactor, there existed a "hole" in the
finalization of WISPr IPv4 and IPv6 "online" HTTP-based Internet
reachability checks web request sessions that both could and did leave
such checks "dangling" and non-renewing such that an expected active,
default network service failover does not occur when it should.

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

With this change, the second, failure EOF case will now return a
GError instance pointer synthesized from 'ECONNRESET' and will be
handled as a failure by 'wispr_portal_web_result_failure',
"bookending" the original "online" HTTP-based Internet reachability
check.

All of the prior HTTP status code cases are handled by
'wispr_portal_web_result_success'.
---
 src/wispr.c | 105 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 34 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index c3d8b13a9610..3f42e131608f 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -652,6 +652,9 @@ static void wispr_portal_error(struct connman_wispr_portal_context *wp_context)
  *                              associated with the unsuccessful
  *                              "online" HTTP-based Internet
  *                              reachability check.
+ *  @param[in]      message     A pointer to an immutable null-
+ *                              terminated C string describing the
+ *                              reason for the online check failure.
  *
  *  @sa portal_manage_success_status
  *  @sa wispr_portal_web_result_no_err
@@ -663,7 +666,8 @@ static void wispr_portal_error(struct connman_wispr_portal_context *wp_context)
  */
 static void portal_manage_failure_status(
 			struct connman_wispr_portal_context *wp_context,
-			int err)
+			int err,
+			const char *message)
 {
 	struct connman_service *service = wp_context->service;
 	enum connman_ipconfig_type type = wp_context->type;
@@ -810,8 +814,10 @@ static void wispr_portal_request_portal(
 					wispr_route_request,
 					wp_context, &err);
 
+	DBG("wp_context->request_id %d err %d", wp_context->request_id, err);
+
 	if (wp_context->request_id == 0) {
-		portal_manage_failure_status(wp_context, err);
+		portal_manage_failure_status(wp_context, -err, strerror(-err));
 		wispr_portal_error(wp_context);
 		wispr_portal_context_unref(wp_context);
 	}
@@ -1001,35 +1007,22 @@ static bool wispr_manage_message(GWebResult *result,
 	return false;
 }
 
-static bool wispr_portal_web_result(const GError *error, GWebResult *result,
-		gpointer user_data)
+static void wispr_portal_web_result_failure(const GError *error,
+		GWebResult *result,
+		struct connman_wispr_portal_context *wp_context)
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
+	portal_manage_failure_status(wp_context, 0, error->message);
 
-		g_web_parser_end_data(wp_context->wispr_parser);
+	free_wispr_routes(wp_context);
+	wp_context->request_id = 0;
+}
 
-		if (wp_context->wispr_msg.message_type >= 0) {
-			if (wispr_manage_message(result, wp_context))
-				goto done;
-		}
-	}
+static void wispr_portal_web_result_success(GWebResult *result,
+		struct connman_wispr_portal_context *wp_context)
+{
+	guint16 status;
+	const char *str = NULL;
+	const char *redirect = NULL;
 
 	status = g_web_result_get_status(result);
 
@@ -1085,15 +1078,15 @@ static bool wispr_portal_web_result(const GError *error, GWebResult *result,
 
 		goto done;
 	case GWEB_HTTP_STATUS_CODE_BAD_REQUEST:
-		portal_manage_failure_status(wp_context, -EINVAL);
+		portal_manage_failure_status(wp_context, 0, "bad request");
 		break;
 
 	case GWEB_HTTP_STATUS_CODE_NOT_FOUND:
-		portal_manage_failure_status(wp_context, -ENOENT);
+		portal_manage_failure_status(wp_context, 0, "resource not found");
 		break;
 
 	case GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT:
-		portal_manage_failure_status(wp_context, -ETIMEDOUT);
+		portal_manage_failure_status(wp_context, 0, "request timeout");
 		break;
 
 	case GWEB_HTTP_STATUS_CODE_HTTP_VERSION_NOT_SUPPORTED:
@@ -1102,12 +1095,55 @@ static bool wispr_portal_web_result(const GError *error, GWebResult *result,
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
+static bool wispr_portal_web_result(const GError *error, GWebResult *result,
+		gpointer user_data)
+{
+	struct connman_wispr_portal_context *wp_context = user_data;
+	const guint8 *chunk = NULL;
+	gsize length;
+
+	DBG("error %p result %p user_data %p wispr_result %d",
+		error, result, user_data, wp_context->wispr_result);
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
+	if (error)
+		wispr_portal_web_result_failure(error, result, wp_context);
+	else
+		wispr_portal_web_result_success(result, wp_context);
+
 done:
 	wp_context->wispr_msg.message_type = -1;
 
@@ -1117,6 +1153,7 @@ done:
 	 * maintaining a weak reference to it.
 	 */
 	wispr_portal_context_unref(wp_context);
+
 	return false;
 }
 
@@ -1196,7 +1233,7 @@ static void proxy_callback(const char *proxy, void *user_data)
 	if (!proxy) {
 		wispr_log_proxy_failure(wp_context, "No valid proxy");
 
-		portal_manage_failure_status(wp_context, -EINVAL);
+		portal_manage_failure_status(wp_context, 0, "no valid proxy");
 
 		return;
 	}
@@ -1543,7 +1580,7 @@ int __connman_wispr_start(struct connman_service *service,
 free_wp:
 	DBG("err %d wp_context %p", err, wp_context);
 
-	portal_manage_failure_status(wp_context, err);
+	portal_manage_failure_status(wp_context, -err, strerror(-err));
 
 	g_hash_table_remove(wispr_portal_hash, GINT_TO_POINTER(index));
 	return err;
@@ -1629,7 +1666,7 @@ int __connman_wispr_cancel(struct connman_service *service,
 
 	cancel_connman_wispr_portal_context(wp_context);
 
-	portal_manage_failure_status(wp_context, -ECANCELED);
+	portal_manage_failure_status(wp_context, -ECANCELED, strerror(-ECANCELED));
 
 	wispr_portal_context_unref(wp_context);
 
-- 
2.45.0

