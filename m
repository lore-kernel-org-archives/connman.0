Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352915484
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CCC6D7324C
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 14:47:19 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 96197732BF
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 14:47:19 -0400 (EDT)
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
Subject: [PATCH v2] Expand DBG content in WISPr 'wispr_portal_request_portal'.
Date: Thu, 2 Nov 2023 11:47:18 -0700
References: <98B224A1-A428-4C45-BB8C-4C2679C65706@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <98B224A1-A428-4C45-BB8C-4C2679C65706@nuovations.com>
Message-Id: <D8647202-2777-4F06-A248-6CD97629D3E1@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

As the functionality for "EnableOnlineToReadyTransition" is further
developed and there are multiple online checks in flight for multiple
services and IP configuration types thereof, the expanded content in
this DBG statement becomes critical to successfully tracking these
unique online check operations.
---
 src/wispr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 5f4eb477..0004ff57 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -538,8 +538,11 @@ static bool wispr_route_request(const char =
*address, int ai_family,
 static void wispr_portal_request_portal(
 		struct connman_wispr_portal_context *wp_context)
 {
-	DBG("wp_context %p %s", wp_context,
-		__connman_ipconfig_type2string(wp_context->type));
+	DBG("wispr/portal context %p service %p (%s) type %d (%s)",
+		wp_context,
+		wp_context->service,
+		connman_service_get_identifier(wp_context->service),
+		wp_context->type, =
__connman_ipconfig_type2string(wp_context->type));
=20
 	wispr_portal_context_ref(wp_context);
 	wp_context->request_id =3D g_web_request_get(wp_context->web,
--=20
2.42.0

