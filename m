Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B5374E0
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7220D7312B
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 18:47:47 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3D704731B2
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 18:47:47 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 3/3] wispr: Leverage GWebStatusCode mnemonics.
Date: Thu, 9 Nov 2023 15:47:47 -0800
References: <F9A20319-A6BC-47C5-8D71-884B705AAF3F@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <F9A20319-A6BC-47C5-8D71-884B705AAF3F@nuovations.com>
Message-Id: <FEE0F97A-C19A-4919-980C-BCA510E61B64@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages the 'GWEB_HTTP_STATUS_CODE_*' GWebStatusCode mnemonics
from gweb.h for improved code self-documentation.
---
 src/wispr.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 57e74a83..0c9bdb69 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -794,13 +794,13 @@ static bool wispr_portal_web_result(GWebResult =
*result, gpointer user_data)
 	DBG("status: %03u", status);
=20
 	switch (status) {
-	case 000:
+	case GWEB_HTTP_STATUS_CODE_UNKNOWN:
 		wispr_portal_context_ref(wp_context);
 		__connman_agent_request_browser(wp_context->service,
 				wispr_portal_browser_reply_cb,
 				wp_context->status_url, wp_context);
 		break;
-	case 200:
+	case GWEB_HTTP_STATUS_CODE_OK:
 		if (wp_context->wispr_msg.message_type >=3D 0)
 			break;
=20
@@ -815,12 +815,12 @@ static bool wispr_portal_web_result(GWebResult =
*result, gpointer user_data)
 		}
=20
 		break;
-	case 300:
-	case 301:
-	case 302:
-	case 303:
-	case 307:
-	case 308:
+	case GWEB_HTTP_STATUS_CODE_MULTIPLE_CHOICES:
+	case GWEB_HTTP_STATUS_CODE_MOVED_PERMANENTLY:
+	case GWEB_HTTP_STATUS_CODE_FOUND:
+	case GWEB_HTTP_STATUS_CODE_SEE_OTHER:
+	case GWEB_HTTP_STATUS_CODE_TEMPORARY_REDIRECT:
+	case GWEB_HTTP_STATUS_CODE_PERMANENT_REDIRECT:
 		if (!g_web_supports_tls() ||
 			!g_web_result_get_header(result, "Location",
 							&redirect)) {
@@ -842,12 +842,12 @@ static bool wispr_portal_web_result(GWebResult =
*result, gpointer user_data)
 				wispr_route_request, wp_context);
=20
 		goto done;
-	case 400:
-	case 404:
+	case GWEB_HTTP_STATUS_CODE_BAD_REQUEST:
+	case GWEB_HTTP_STATUS_CODE_NOT_FOUND:
 		wp_context->cb(wp_context->service, wp_context->type, =
false);
=20
 		break;
-	case 505:
+	case GWEB_HTTP_STATUS_CODE_HTTP_VERSION_NOT_SUPPORTED:
 		wispr_portal_context_ref(wp_context);
 		__connman_agent_request_browser(wp_context->service,
 				wispr_portal_browser_reply_cb,
--=20
2.42.0

