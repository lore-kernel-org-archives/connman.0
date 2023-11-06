Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABAA33CF
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 59DAB7310E
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 16:11:07 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 271C773177
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 16:11:07 -0500 (EST)
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
Subject: [PATCH] Terminate all online check handling in one function.
Message-Id: <C0F0B144-2996-4453-B7CF-CF4E87A81FB1@nuovations.com>
Date: Mon, 6 Nov 2023 13:11:06 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This modifies 'portal_manage_status' by moving the unconditional
transition of the service to the 'online' state for which a HTTP-
based reachability check was successfully completed to the callback
provided to '__connman_wispr_start', specifically,
'complete_online_check'. This places all handling, both failure and
success, of HTTP-based reachability checks in a single, auditable
location in a single function in a single source file.
---
 src/service.c |  9 ++++++++-
 src/wispr.c   | 10 +---------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/src/service.c b/src/service.c
index 03e23618..dc9fa3ac 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1845,7 +1845,14 @@ static void complete_online_check(struct =
connman_service *service,
 		redo_func =3D redo_wispr_ipv6;
 	}
=20
-	if(!enable_online_to_ready_transition)
+	if (success) {
+		__connman_service_ipconfig_indicate_state(service,
+			CONNMAN_SERVICE_STATE_ONLINE,
+			type);
+
+		if (!enable_online_to_ready_transition)
+			return;
+	} else if (!enable_online_to_ready_transition)
 		goto redo_func;
=20
 	if (success) {
diff --git a/src/wispr.c b/src/wispr.c
index 0004ff57..64c94a4d 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -97,7 +97,6 @@ static GHashTable *wispr_portal_hash =3D NULL;
=20
 static char *online_check_ipv4_url =3D NULL;
 static char *online_check_ipv6_url =3D NULL;
-static bool enable_online_to_ready_transition =3D false;
=20
 #define wispr_portal_context_ref(wp_context) \
 	wispr_portal_context_ref_debug(wp_context, __FILE__, __LINE__, =
__func__)
@@ -480,11 +479,7 @@ static void portal_manage_status(GWebResult =
*result,
 				&str))
 		connman_info("Client-Timezone: %s", str);
=20
-	__connman_service_ipconfig_indicate_state(service,
-					CONNMAN_SERVICE_STATE_ONLINE, =
type);
-
-	if (enable_online_to_ready_transition)
-		wp_context->cb(service, type, true);
+	wp_context->cb(service, type, true);
 }
=20
 static bool wispr_route_request(const char *address, int ai_family,
@@ -1128,9 +1123,6 @@ int __connman_wispr_init(void)
 	online_check_ipv6_url =3D
 		connman_setting_get_string("OnlineCheckIPv6URL");
=20
-	enable_online_to_ready_transition =3D
-		=
connman_setting_get_bool("EnableOnlineToReadyTransition");
-
 	return 0;
 }
=20
--=20
2.42.0


