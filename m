Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D2842909
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 222927315A
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 18:13:06 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id DE48C73172
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 18:13:05 -0400 (EDT)
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
Subject: [PATCH] Expand DBG content in WISPr functions.
Message-Id: <98B224A1-A428-4C45-BB8C-4C2679C65706@nuovations.com>
Date: Thu, 19 Oct 2023 15:13:04 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

As the functionality for "EnableOnlineToReadyTransition" is further
developecd and there are multiple online checks in flight for multiple
services and IP configuration types thereof, the expanded content in
these DBG statements becomes critical to successfully tracking these
unique online check operations.
---
 src/wispr.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 2ed4d440..f9413371 100644
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
@@ -932,8 +935,11 @@ static int wispr_portal_detect(struct =
connman_wispr_portal_context *wp_context)
 	int err =3D 0;
 	int i;
=20
-	DBG("wispr/portal context %p service %p", wp_context,
-		wp_context->service);
+	DBG("wispr/portal context %p service %p (%s) type %d (%s)",
+		wp_context,
+		wp_context->service,
+		connman_service_get_identifier(wp_context->service),
+		wp_context->type, =
__connman_ipconfig_type2string(wp_context->type));
=20
 	interface =3D =
connman_service_get_interface(wp_context->service);
 	if (!interface)
@@ -1009,8 +1015,10 @@ int __connman_wispr_start(struct connman_service =
*service,
 	struct connman_wispr_portal *wispr_portal =3D NULL;
 	int index, err;
=20
-	DBG("service %p %s callback %p", service,
-		__connman_ipconfig_type2string(type), callback);
+	DBG("service %p (%s) type %d (%s) callback %p",
+		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		callback);
=20
 	if (!wispr_portal_hash || !callback)
 		return -EINVAL;
@@ -1087,7 +1095,7 @@ void __connman_wispr_stop(struct connman_service =
*service)
 	struct connman_wispr_portal *wispr_portal;
 	int index;
=20
-	DBG("service %p", service);
+	DBG("service %p (%s)", service, =
connman_service_get_identifier(service));
=20
 	if (!wispr_portal_hash)
 		return;
--=20
2.32.0


