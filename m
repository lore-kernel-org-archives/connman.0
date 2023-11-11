Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676E1B28C
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1C2FC730FE
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 14:00:26 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D9ADD73122
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 14:00:25 -0500 (EST)
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
Subject: [PATCH 6/8] Leverage GWeb connect timeout and
 'OnlineCheckConnectTimeout'.
Date: Sat, 11 Nov 2023 11:00:25 -0800
References: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
Message-Id: <B2491372-B5AC-4292-9333-8C786CC6FC81@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages both the GWeb TCP connect timeout setter and the newly-
added 'OnlineCheckConnectTimeout' setting to support TCP connect
timeouts different from the underlying operating system and network
stack when so configured.
---
 src/connman.h |  1 +
 src/service.c | 10 ++++++++--
 src/wispr.c   | 14 ++++++++++----
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index d3f2d0139f91..143a087701d8 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -531,6 +531,7 @@ int __connman_wispr_init(void);
 void __connman_wispr_cleanup(void);
 int __connman_wispr_start(struct connman_service *service,
 					enum connman_ipconfig_type type,
+					guint connect_timeout_ms,
 					__connman_wispr_cb_t callback);
 void __connman_wispr_stop(struct connman_service *service);
=20
diff --git a/src/service.c b/src/service.c
index 81a1bebdc14b..075f3fba5abe 100644
--- a/src/service.c
+++ b/src/service.c
@@ -58,6 +58,7 @@ static unsigned int vpn_autoconnect_id =3D 0;
 static struct connman_service *current_default =3D NULL;
 static bool services_dirty =3D false;
 static bool enable_online_to_ready_transition =3D false;
+static unsigned int online_check_connect_timeout_ms =3D 0;
 static unsigned int online_check_initial_interval =3D 0;
 static unsigned int online_check_max_interval =3D 0;
 static const char *online_check_timeout_interval_style =3D NULL;
@@ -1700,7 +1701,8 @@ static void redo_wispr(struct connman_service =
*service,
 		service, connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type));
=20
-	__connman_wispr_start(service, type, complete_online_check);
+	__connman_wispr_start(service, type,
+			online_check_connect_timeout_ms, =
complete_online_check);
=20
 	// Release the reference to the service taken when
 	// g_timeout_add_seconds was invoked with the callback
@@ -2011,7 +2013,8 @@ void __connman_service_wispr_start(struct =
connman_service *service,
 		service->online_check_interval_ipv6 =3D
 					online_check_initial_interval;
=20
-	__connman_wispr_start(service, type, complete_online_check);
+	__connman_wispr_start(service, type,
+			online_check_connect_timeout_ms, =
complete_online_check);
 }
=20
 static void address_updated(struct connman_service *service,
@@ -8496,6 +8499,9 @@ int __connman_service_init(void)
 	else
 		online_check_timeout_compute_func =3D =
online_check_timeout_compute_geometric;
=20
+	online_check_connect_timeout_ms =3D
+		connman_setting_get_uint("OnlineCheckConnectTimeout");
+
 	online_check_initial_interval =3D
 		connman_setting_get_uint("OnlineCheckInitialInterval");
 	online_check_max_interval =3D
diff --git a/src/wispr.c b/src/wispr.c
index 8a5bbdcfe3d8..8618b5158b04 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -861,6 +861,7 @@ static bool wispr_portal_web_result(GWebResult =
*result, gpointer user_data)
 		goto done;
 	case GWEB_HTTP_STATUS_CODE_BAD_REQUEST:
 	case GWEB_HTTP_STATUS_CODE_NOT_FOUND:
+	case GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT:
 		wp_context->cb(wp_context->service, wp_context->type, =
false);
=20
 		break;
@@ -967,7 +968,8 @@ static gboolean no_proxy_callback(gpointer =
user_data)
 	return FALSE;
 }
=20
-static int wispr_portal_detect(struct connman_wispr_portal_context =
*wp_context)
+static int wispr_portal_detect(struct connman_wispr_portal_context =
*wp_context,
+						guint =
connect_timeout_ms)
 {
 	enum connman_service_proxy_method proxy_method;
 	char *interface =3D NULL;
@@ -1012,6 +1014,8 @@ static int wispr_portal_detect(struct =
connman_wispr_portal_context *wp_context)
 	if (getenv("CONNMAN_WEB_DEBUG"))
 		g_web_set_debug(wp_context->web, web_debug, "WEB");
=20
+	g_web_set_connect_timeout(wp_context->web, connect_timeout_ms);
+
 	if (wp_context->type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4) {
 		g_web_set_address_family(wp_context->web, AF_INET);
 		wp_context->status_url =3D online_check_ipv4_url;
@@ -1069,15 +1073,17 @@ done:
=20
 int __connman_wispr_start(struct connman_service *service,
 					enum connman_ipconfig_type type,
+					guint connect_timeout_ms,
 					__connman_wispr_cb_t callback)
 {
 	struct connman_wispr_portal_context *wp_context =3D NULL;
 	struct connman_wispr_portal *wispr_portal =3D NULL;
 	int index, err;
=20
-	DBG("service %p (%s) type %d (%s) callback %p",
+	DBG("service %p (%s) type %d (%s) connect_timeout %ums callback =
%p",
 		service, connman_service_get_identifier(service),
-		type, __connman_ipconfig_type2string(type), callback);
+		type, __connman_ipconfig_type2string(type),
+		connect_timeout_ms, callback);
=20
 	if (!wispr_portal_hash || !callback)
 		return -EINVAL;
@@ -1137,7 +1143,7 @@ int __connman_wispr_start(struct connman_service =
*service,
 	else
 		wispr_portal->ipv6_context =3D wp_context;
=20
-	err =3D wispr_portal_detect(wp_context);
+	err =3D wispr_portal_detect(wp_context, connect_timeout_ms);
 	if (err)
 		goto free_wp;
 	return 0;
--=20
2.42.0

