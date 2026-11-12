Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457555;
	b=mbibfGbjgGRVV8PTNM+mNV1+JPGmduCPf5TGANEGOrCd9Gc9mkx+Nivpj5qjshShrg4M
	 vC/O2MWUS52IrKnhAvwccF6PMDkbcJWcllMqPybZHzvxvxh5M5xXV2846QId7xJkKILyK
	 4V8TSSMoqfbDYwEkXk9UYeGinqCxnpMyLCs1eMnp/6N97QiQw4PnNjNR6PeCIjB7arGhT
	 k7NQ5GK94uknYPVY/LBqskovCqHGQaatn1Ghflb9nm0bQlxdC2MMqU3ms79lWTxUAFbzw
	 zn3Hmdy2QwES/aGlZX2MYeEabnaFI76+O1llyu3r5JeAhcHtoo/cldu+6/lyhV7v4Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457555;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:DKIM-Signature:X-Scanned-By;
	bh=0tNhQrFVKCN0+3I1v5cFNDfVgGE9ZERdn0TbkcUbQac=;
	b=daSYndGAu4UDUJtMKpG4ZVhN7L3BMPFFeVnN0dEMZe5jCzRpZFDgkK1G8wP+WMu3ym6P
	 Rx3ptr8rRN6+XCu67m2pfdYydqm+W7DFCVrUMWkIkocxVfhBNowgjaSgVHnsiox1PaU7c
	 cwPWw6XhyJTNbLtTM33pm/i9hwkpXpOVKDuFxZTuV6P7AvMsD3V0ajH5xVrvFcfuiCUGN
	 atLZu1ax7JC6Q3ZQCt5ZlBeH6sJ7EWeHBS5H7Dcan5ZSsMeFwCBOFeVSL9fT9HGP4NxSb
	 CQXnx9jwew+JdmFTD0a/0D43fd3H0TAMFe0NjvacyPnafaHmwD/XUl9WGaYeTWt5oxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=m81vHYMt;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C5C606A327
	for <connman@lists.linux.dev>; Thu, 12 Nov 2026 04:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74C5C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=m81vHYMt
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id F0D6E160294;
	Wed, 11 Nov 2026 23:25:53 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8773F124BF7;
	Wed, 11 Nov 2026 23:25:53 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Cc: giuseppe.eletto98@gmail.com
Subject: [PATCH 2/5] wispr: Fail checks ending in an unhandled response
Date: Wed, 11 Nov 2026 20:25:48 -0800
Message-ID: <20261112042551.1613107-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261112042551.1613107-2-gerickson@nuovations.com>
References: <20261112042551.1613107-1-gerickson@nuovations.com>
 <20261112042551.1613107-2-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=0tNhQrFVKCN0+3I1v5cFNDfVgGE9ZERdn0TbkcUbQac=; b=m81vHYMts/lILospYeePQIcjlb3ZpgFjR1UJgJVORuLGxmyU0hI/6rtpnBbPLwzqepLgbBzZOJRuNv/4q/IjjyEogDuzNbxFBIYpu5eoqUUGLBVVlM3y40aWFg1N7BG/siI94/LqNNWdFW4WMqFzYnX6DNjCYsj9UGeHGUMsXbjO7i6szuSg5zEy+61AFS26QTTkAAQ3Sv7NvaP9SIspIfo5s5otAp/tyxlrU1tOg3ul32a4rXZYtDMNiCo2+Za1muKfrxP4ewz7rlUa7FnEx6DqKaraqU0uNbncbpQVAOnfExcvpMJcMmmQngjbISuiaKstQyqob+jb8uFR2ZZEcg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

An online check completes only through its callback, which reports
success or failure to the service. Several outcomes of
wispr_portal_web_result_success never invoke it:

  * Any HTTP status that the switch does not name, such as 204, 403,
    5xx, or 511, falls to the default case, which does nothing.

  * A 200 carrying a WISPr message that wispr_manage_message did not
    act on breaks out of the switch without completing.

  * A redirect whose follow-on request cannot be started leaves
    request_id at zero with no result callback to come. Builds
    without TLS support never follow redirects, so this arises only
    with TLS support.

In each case, the check never completes. Because the check is still
active, later attempts to start one return -EALREADY. In continuous
mode, no further check is scheduled until the default service, the
link, or an address changes. A service that is "ready" stays "ready"
and one that is "online" stays "online", regardless of whether the
online check endpoint becomes reachable, or stops being reachable.

This happens in practice: a home router that pauses or blocks a
device commonly answers the online check URL itself with a block
page or an error status.

Complete each of these as a failure, with a message that names the
reason (for example, "unexpected HTTP status 403"), so that the
failure is logged and counted, and continuous mode reschedules the
next check with its configured backoff.
---
 src/wispr.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/src/wispr.c b/src/wispr.c
index a40cf353b54e..47eb57f1880e 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1065,6 +1065,7 @@ static void wispr_portal_web_result_success(GWebResult *result,
 	guint16 status;
 	const char *str = NULL;
 	const char *redirect = NULL;
+	g_autofree char *message = NULL;
 
 	status = g_web_result_get_status(result);
 
@@ -1078,8 +1079,30 @@ static void wispr_portal_web_result_success(GWebResult *result,
 				wp_context->status_url, wp_context);
 		break;
 	case GWEB_HTTP_STATUS_CODE_OK:
-		if (wp_context->wispr_msg.message_type >= 0)
+		/*
+		 * A WISPr message type of zero or greater means the
+		 * response body carried a WISPr XML message. The type
+		 * starts at -1 (connman_wispr_message_init), is set only
+		 * when the body is parsed, and is reset to -1 after each
+		 * result, so here it describes this response alone.
+		 *
+		 * wispr_portal_web_result hands such a message to
+		 * wispr_manage_message first and skips this handler if
+		 * that acted on it: by requesting login credentials from
+		 * the agent (type 100), or by re-checking after a
+		 * successful login (type 120 or 140 with response code
+		 * 50). Reaching here with a type of zero or greater
+		 * therefore means it did not act: the type is one it does
+		 * not handle, the login request could not be made (for
+		 * example, with no agent registered), or the login was
+		 * rejected. Nothing else will complete this check, so
+		 * complete it as a failure.
+		 */
+		if (wp_context->wispr_msg.message_type >= 0) {
+			portal_manage_failure_status(wp_context, 0,
+				"unhandled WISPr message");
 			break;
+		}
 
 		if (g_web_result_get_header(result, "X-ConnMan-Status",
 						&str)) {
@@ -1118,6 +1141,18 @@ static void wispr_portal_web_result_success(GWebResult *result,
 				redirect, wispr_portal_web_result,
 				wispr_route_request, wp_context, NULL);
 
+		/*
+		 * If the redirect request could not even be started, there
+		 * will be no result callback to complete this check, so
+		 * complete it here as a failure.
+		 */
+		if (wp_context->request_id == 0) {
+			portal_manage_failure_status(wp_context, 0,
+				"could not follow redirect");
+			wispr_portal_context_unref(wp_context);
+			break;
+		}
+
 		return;
 	case GWEB_HTTP_STATUS_CODE_BAD_REQUEST:
 		portal_manage_failure_status(wp_context, 0, "bad request");
@@ -1138,6 +1173,17 @@ static void wispr_portal_web_result_success(GWebResult *result,
 				wp_context->status_url, wp_context);
 		break;
 	default:
+		/*
+		 * Any other status (for example, 204, 403, 5xx, or 511 from
+		 * a router or a block page answering on behalf of the
+		 * online check endpoint) cannot indicate success. Complete
+		 * the check as a failure; otherwise, it would never
+		 * complete and, in continuous mode, no further check would
+		 * be scheduled.
+		 */
+		message = g_strdup_printf("unexpected HTTP status %03u",
+					status);
+		portal_manage_failure_status(wp_context, 0, message);
 		break;
 	}
 
-- 
2.52.0

