Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457555;
	b=a3QsSS5wy0QLG3fJVvU2jcn1NoRTIaDqkDtm14u8BuMIaNrFPwVJwgCQR0kqwB0EegAX
	 k7utlQf78HZEsWoKGlbj2AgqhuRrQmJgdj8pFZM2ppTQjAsVj3P/dIiaAsSGHZBBD0L45
	 nbrgdxJ/WHJoVdlIXDgh6R9Sw7QcRJ/MtBJITbMyba0eX0JAYQfE3TlNPwVYuA83KJIkw
	 KHPBhNwrO2Zwazzcx6M5yHP+Wy6Kd/8Wf9OKm34p+SzuovtQrGnvgzogG71RQKoJc8z6H
	 8jNwFegND7W+uLVOlcrL6cdEZLvpV0lYWAJcyteXQ+bMetB35MUN+i3RPNit95ORnBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457555;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=3gfSbo059YK9okP1X4cYt7SBdFfS1lIyQVLxcv2d71M=;
	b=nYNDEQ0YGnILD9PB/uwB/hWypjjhBJkEroCuNu7NkS6BFy+iiMbFnCjJ7TyEx5cBidxf
	 TnYGYg7sdOt3qXQxoatC41aZQCBe9W5DW5tBL5Dsv77TMzioIK+yeYgh/+F5AYwgQGRJT
	 c0Zx810wxx24MDr0cHse2nm3s+0+AKDqBktDSKLMjvOJAAPOqIrvovppanxUAWKhy3dwv
	 kRLaEhMumE2PGachl6iWaldxLWBhWuxz8VbIeroEWSqKYzaywFbFpvdp2COMXcRHkgo2W
	 GV1klBV9RPC9qYo95+EIZEvV6eo2lrKks8M3mbv+ih475dUZYzePbi4EJg0/wxW4R4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=LNBiZ3tk;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F3606A323
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 04:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E7F3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=LNBiZ3tk
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 881501602B1;
	Wed, 11 Nov 2026 23:25:54 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 1EAC2124BF7;
	Wed, 11 Nov 2026 23:25:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Cc: giuseppe.eletto98@gmail.com
Subject: [PATCH 3/5] wispr: Fail checks before requesting a browser
Date: Wed, 11 Nov 2026 20:25:49 -0800
Message-ID: <20261112042551.1613107-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261112042551.1613107-3-gerickson@nuovations.com>
References: <20261112042551.1613107-1-gerickson@nuovations.com>
 <20261112042551.1613107-2-gerickson@nuovations.com>
 <20261112042551.1613107-3-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=3gfSbo059YK9okP1X4cYt7SBdFfS1lIyQVLxcv2d71M=; b=LNBiZ3tkn46iApl7MyXrQJeV+JUHfs2DZxjzBMVhuxbxNgMsSvM/VsCuWE6AbPKmSq4+b0ewNElBoq4hMWFVpz5ryVsyMzdhws+KwElt9jTzU1OH44yIv29SzXcWvyZKSEDIbcLl58DZimkejBTkSjIDiSqKt+0dncHk05osBEkuKdC+OnsvOAWgA3qIld83FWckpaU0vLFi6z8pwnZh5D0CvlQosdkMpdk8OLO56HPk5b3+bPmxYbxsptZjXwDRt0i6JdhJhYR7Lvk7eXOBlIP/7IDfXBYLR3j6C5swpMxMmHXvlLqXEGQNKINZTlpwx4Vt9j0XrEU1SjYmqduVEQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

When an online check response suggests a captive portal, namely a
200 without the "X-ConnMan-Status" header, a redirect that cannot be
followed, a 505, or no status at all, wispr asks the agent to open a
browser and leaves the check waiting on the agent. None of the
outcomes completes the check:

  * With no agent registered, __connman_agent_request_browser
    returns -ESRCH. The return value is ignored and the reference
    taken for the request leaks.

  * If the agent replies with an error or the request times out,
    wispr_portal_browser_reply_cb releases the context without
    reporting a result.

  * If the agent replies with success, the reply callback restarts
    the check with __connman_service_wispr_start, which returns
    -EALREADY because the stalled check is still active.

So, as with an unhandled status, the check never completes and, in
continuous mode, no further check is scheduled. On a headless device
without an agent, any router block page that answers 200 without the
header, or redirects, leaves the service "ready" or "online"
indefinitely.

Factor these branches into wispr_portal_request_browser, which
requests the browser and then completes the check as a failure, with
a message naming the reason, so that the check is logged and counted
and its successor scheduled whether or not, or whenever, the agent
answers. Release the request reference if the request cannot be made.

Because checks now continue past a portal, request the browser at
most once per network interface until a check on it succeeds or the
interface's WISPr state is torn down. This keeps the agent-visible
behavior as it was, one browser request per portal encounter, rather
than one per rescheduled check. If the user completes the portal
login, either the reply callback's restart or the next scheduled
check observes the success.
---
 src/wispr.c | 112 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 96 insertions(+), 16 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 47eb57f1880e..013afe241054 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -131,6 +131,7 @@ struct connman_wispr_portal_context {
 struct connman_wispr_portal {
 	struct connman_wispr_portal_context *ipv4_context;
 	struct connman_wispr_portal_context *ipv6_context;
+	bool browser_requested;
 };
 
 static bool wispr_portal_web_result(const GError *error, GWebResult *result, gpointer user_data);
@@ -724,6 +725,13 @@ static void portal_manage_success_status(GWebResult *result,
 				&str))
 		connman_info("Client-Timezone: %s", str);
 
+	/*
+	 * The network is reachable, so allow a browser request again
+	 * should a later check on this interface find a portal.
+	 */
+	if (wp_context->wispr_portal)
+		wp_context->wispr_portal->browser_requested = false;
+
 	wp_context->cb(service, type, true, 0, NULL);
 }
 
@@ -897,6 +905,77 @@ static void wispr_portal_browser_reply_cb(struct connman_service *service,
 	wispr_portal_context_unref(wp_context);
 }
 
+/**
+ *  @brief
+ *    Complete an "online" HTTP-based Internet reachability check as a
+ *    failure and request that the agent open a browser.
+ *
+ *  This handles a reachability check response that suggests a
+ *  captive portal requiring user interaction, such as a 200 "OK"
+ *  status without the "X-ConnMan-Status" header or a redirect that
+ *  cannot be followed.
+ *
+ *  If no browser has yet been requested for the network interface
+ *  associated with @a wp_context since its last successful check,
+ *  the agent, if any, is asked to open one at @a url. Regardless,
+ *  the check is then completed as a failure with @a message, so that
+ *  it is logged and counted and, in continuous mode, the next check
+ *  is scheduled whether or not, or whenever, the agent answers.
+ *
+ *  Requesting the browser at most once per interface until a check
+ *  succeeds preserves the behavior from before checks continued
+ *  past a portal: one request per portal encounter, not one per
+ *  rescheduled check.
+ *
+ *  @param[in,out]  wp_context  A pointer to the mutable WISPr portal
+ *                              detection context associated with the
+ *                              "online" HTTP-based Internet
+ *                              reachability check this is
+ *                              completing.
+ *  @param[in]      url         An optional pointer to an immutable
+ *                              null-terminated C string of the URL
+ *                              for the agent to open.
+ *  @param[in]      message     A pointer to an immutable
+ *                              null-terminated C string describing
+ *                              why the check failed.
+ *
+ *  @sa portal_manage_failure_status
+ *  @sa wispr_portal_browser_reply_cb
+ *  @sa wispr_portal_web_result_success
+ *
+ *  @private
+ *
+ */
+static void wispr_portal_request_browser(
+			struct connman_wispr_portal_context *wp_context,
+			const char *url,
+			const char *message)
+{
+	struct connman_wispr_portal *wispr_portal = wp_context->wispr_portal;
+	int err;
+
+	if (wispr_portal && !wispr_portal->browser_requested) {
+		/*
+		 * Retain a reference to the WISPr/portal context for the
+		 * browser request. It is released by the reply callback
+		 * or, if the request could not be made, here.
+		 */
+		wispr_portal_context_ref(wp_context);
+
+		err = __connman_agent_request_browser(wp_context->service,
+				wispr_portal_browser_reply_cb,
+				url, wp_context);
+		if (err == -EINPROGRESS)
+			wispr_portal->browser_requested = true;
+		else {
+			DBG("browser request failed: %d", err);
+			wispr_portal_context_unref(wp_context);
+		}
+	}
+
+	portal_manage_failure_status(wp_context, 0, message);
+}
+
 static void wispr_portal_request_wispr_login(struct connman_service *service,
 				bool success,
 				const char *ssid, int ssid_len,
@@ -1073,10 +1152,9 @@ static void wispr_portal_web_result_success(GWebResult *result,
 
 	switch (status) {
 	case GWEB_HTTP_STATUS_CODE_UNKNOWN:
-		wispr_portal_context_ref(wp_context);
-		__connman_agent_request_browser(wp_context->service,
-				wispr_portal_browser_reply_cb,
-				wp_context->status_url, wp_context);
+		wispr_portal_request_browser(wp_context,
+				wp_context->status_url,
+				"no HTTP status");
 		break;
 	case GWEB_HTTP_STATUS_CODE_OK:
 		/*
@@ -1108,10 +1186,9 @@ static void wispr_portal_web_result_success(GWebResult *result,
 						&str)) {
 			portal_manage_success_status(result, wp_context);
 		} else {
-			wispr_portal_context_ref(wp_context);
-			__connman_agent_request_browser(wp_context->service,
-					wispr_portal_browser_reply_cb,
-					wp_context->redirect_url, wp_context);
+			wispr_portal_request_browser(wp_context,
+					wp_context->redirect_url,
+					"missing X-ConnMan-Status header");
 		}
 
 		break;
@@ -1124,11 +1201,15 @@ static void wispr_portal_web_result_success(GWebResult *result,
 		if (!g_web_supports_tls() ||
 			!g_web_result_get_header(result, "Location",
 							&redirect)) {
+			message = g_strdup_printf("HTTP status %03u redirect "
+					"not followed (%s)", status,
+					!g_web_supports_tls() ?
+						"no TLS support" :
+						"no Location header");
 
-			wispr_portal_context_ref(wp_context);
-			__connman_agent_request_browser(wp_context->service,
-					wispr_portal_browser_reply_cb,
-					wp_context->status_url, wp_context);
+			wispr_portal_request_browser(wp_context,
+					wp_context->status_url,
+					message);
 			break;
 		}
 
@@ -1167,10 +1248,9 @@ static void wispr_portal_web_result_success(GWebResult *result,
 		break;
 
 	case GWEB_HTTP_STATUS_CODE_HTTP_VERSION_NOT_SUPPORTED:
-		wispr_portal_context_ref(wp_context);
-		__connman_agent_request_browser(wp_context->service,
-				wispr_portal_browser_reply_cb,
-				wp_context->status_url, wp_context);
+		wispr_portal_request_browser(wp_context,
+				wp_context->status_url,
+				"HTTP version not supported");
 		break;
 	default:
 		/*
-- 
2.52.0

