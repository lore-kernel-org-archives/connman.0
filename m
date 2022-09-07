Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796912F42
	for <connman@lists.linux.dev>; Wed,  7 Sep 2022 18:52:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 163C85E0C2;
	Wed,  7 Sep 2022 20:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1662576746; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=zA1Qmyz9tlIjM1Uq172i9qY7dfn8Vw4zevLccLa5SF4=;
	b=X0vlfWit24C3JBsfNloc/pMM3pAMHwEMwQBdsCyLGm8CLiS0is2gdOCNfM7sVhQFYuhzTP
	JPAFFIvGw5DbWF44HoO38y6/ZMrGgoVEAUJf19fIOs9kDPsBP+AioDFeaSGTnE+4Vi/oZs
	o8ddXYf/9Bz49C8p+x/hhbDtC6MJFhrqwAc3EeiAC7cHbsVwSjSQJhaivx5+GPKy4JLX1f
	qndXJ4saTfsXVIsV/MKnMiN/87WjgRodm01eXxgvz8oK4hADbEyFh8NN0LXKnEtjPxs2RO
	DJ268tpDQkJJLPkmhVGgjkDQ9uTdbPAUgSHi91jThBlc36zJvFqtsfB310PiVg==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 2/3] wispr: Fix context refcounting in wispr_portal_request_portal()
Date: Wed,  7 Sep 2022 20:52:20 +0200
Message-Id: <20220907185221.2981-3-wagi@monom.org>
In-Reply-To: <20220907185221.2981-1-wagi@monom.org>
References: <20220907185221.2981-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The wispr_portal_request_portal() function is expected to read until
there is no data. Hence, the wp_context refcount is supposed to be
hold on while reading.

Furthermore, we should not return early when we read the
X-ConnMan-Status header. Instead we are supposed to go through the
normal return path so that we cleanup any added routing entries. Thus,
we also don't need to update the refcount in this code path as we
handle it at the main return path.

Fixes: 416bfaff9888 ("wispr: Update portal context references")
---
 src/wispr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 9b27af5fff55..a7562e8462f3 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -537,7 +537,8 @@ static bool wispr_route_request(const char *address, int ai_family,
 static void wispr_portal_request_portal(
 		struct connman_wispr_portal_context *wp_context)
 {
-	DBG("");
+	DBG("wp_context %p %s", wp_context,
+		__connman_ipconfig_type2string(wp_context->type));
 
 	wispr_portal_context_ref(wp_context);
 	wp_context->request_id = g_web_request_get(wp_context->web,
@@ -753,7 +754,7 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 		if (length > 0) {
 			g_web_parser_feed_data(wp_context->wispr_parser,
 								chunk, length);
-			wispr_portal_context_unref(wp_context);
+			/* read more data */
 			return true;
 		}
 
@@ -783,8 +784,6 @@ static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 		if (g_web_result_get_header(result, "X-ConnMan-Status",
 						&str)) {
 			portal_manage_status(result, wp_context);
-			wispr_portal_context_unref(wp_context);
-			return false;
 		} else {
 			wispr_portal_context_ref(wp_context);
 			__connman_agent_request_browser(wp_context->service,
@@ -996,7 +995,8 @@ int __connman_wispr_start(struct connman_service *service,
 	struct connman_wispr_portal *wispr_portal = NULL;
 	int index, err;
 
-	DBG("service %p", service);
+	DBG("service %p %s", service,
+		__connman_ipconfig_type2string(type));
 
 	if (!wispr_portal_hash)
 		return -EINVAL;
-- 
2.37.2

