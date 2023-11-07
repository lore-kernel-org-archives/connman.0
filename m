Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C32D02E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id F385673203
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 13:52:51 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C028973238
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 13:52:51 -0500 (EST)
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
Subject: [PATCH v2] Close three '__connman_wisp_start' failure closure holes.
Date: Tue, 7 Nov 2023 10:52:50 -0800
References: <6669EDB7-4146-4974-8354-27A259DDF2CB@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <6669EDB7-4146-4974-8354-27A259DDF2CB@nuovations.com>
Message-Id: <5B470B03-18A6-494A-B6F6-B2CE614A1A7E@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

There are currently three failure holes in which a request to
'__connman_wispr_start' is not properly closed.

  1. If 'g_web_request_get' fails to generate a successful gweb request
     and returns a request identifier of zero (0) in
     'wispr_portal_request_portal'.

  2. If the service proxy is set to =
CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN.
     This can happen in 'proxy_callback' if WISPr is started and the
     service proxy method is set latently or is never set at all.

  3. If 'wispr_portal_detect' returns non-zero error status in
     '__connman_wispr_start'.
---
 src/wispr.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index f767b68e..0004ff57 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -552,6 +552,7 @@ static void wispr_portal_request_portal(
 					wp_context);
=20
 	if (wp_context->request_id =3D=3D 0) {
+		wp_context->cb(wp_context->service, wp_context->type, =
false);
 		wispr_portal_error(wp_context);
 		wispr_portal_context_unref(wp_context);
 	}
@@ -876,11 +877,21 @@ static void proxy_callback(const char *proxy, void =
*user_data)
 	struct connman_wispr_portal_context *wp_context =3D user_data;
 	char *proxy_server;
=20
-	DBG("proxy %s", proxy);
+	DBG("wp_context %p proxy %p", wp_context, proxy);
=20
-	if (!wp_context || !proxy)
+	if (!wp_context)
 		return;
=20
+	if (!proxy) {
+		DBG("no valid proxy");
+
+		wp_context->cb(wp_context->service, wp_context->type, =
false);
+
+		return;
+	}
+
+	DBG("proxy %s", proxy);
+
 	wp_context->token =3D 0;
=20
 	proxy_server =3D parse_proxy(proxy);
@@ -973,6 +984,8 @@ static int wispr_portal_detect(struct =
connman_wispr_portal_context *wp_context)
=20
 	proxy_method =3D =
connman_service_get_proxy_method(wp_context->service);
=20
+	DBG("proxy_method %d", proxy_method);
+
 	if (proxy_method !=3D CONNMAN_SERVICE_PROXY_METHOD_DIRECT) {
 		wp_context->token =3D connman_proxy_lookup(interface,
 						wp_context->status_url,
@@ -1070,6 +1083,8 @@ int __connman_wispr_start(struct connman_service =
*service,
 	return 0;
=20
 free_wp:
+	wp_context->cb(wp_context->service, wp_context->type, false);
+
 	g_hash_table_remove(wispr_portal_hash, GINT_TO_POINTER(index));
 	return err;
 }
--=20
2.42.0

