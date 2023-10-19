Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD48F54
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CB6C97328B
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:53:53 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7C45D73378
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:53:53 -0400 (EDT)
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
Subject: [PATCH] Add a callback parameter to '__connman_wispr_start'.
Message-Id: <CF970CC5-5AF5-4680-81C1-EB58F8FF44CC@nuovations.com>
Date: Thu, 19 Oct 2023 14:53:52 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

The addition of this callback provides two benefits.

The first is making static the implementation of the WISPr closure
function defined in service.c.

The second is that it will make easier closing several failure path
"holes" that currently do not properly "bookend" requests to
'__connman_wispr_start' by making the closure of those holes
independent of the function providing the closure.

---
 src/connman.h | 10 ++++++----
 src/service.c |  9 ++++++---
 src/wispr.c   | 16 +++++++++-------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index b955d98b..6c5e071f 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -523,10 +523,15 @@ void __connman_wpad_cleanup(void);
 int __connman_wpad_start(struct connman_service *service);
 void __connman_wpad_stop(struct connman_service *service);
=20
+typedef void (*__connman_wispr_cb_t) (struct connman_service *service,
+				enum connman_ipconfig_type type,
+				bool success);
+
 int __connman_wispr_init(void);
 void __connman_wispr_cleanup(void);
 int __connman_wispr_start(struct connman_service *service,
-					enum connman_ipconfig_type =
type);
+					enum connman_ipconfig_type type,
+					__connman_wispr_cb_t callback);
 void __connman_wispr_stop(struct connman_service *service);
=20
 #include <connman/technology.h>
@@ -734,9 +739,6 @@ int __connman_service_set_mdns(struct =
connman_service *service,
=20
 void __connman_service_set_string(struct connman_service *service,
 					const char *key, const char =
*value);
-void __connman_service_online_check(struct connman_service *service,
-					enum connman_ipconfig_type type,
-					bool success);
 int __connman_service_ipconfig_indicate_state(struct connman_service =
*service,
 					enum connman_service_state =
new_state,
 					enum connman_ipconfig_type =
type);
diff --git a/src/service.c b/src/service.c
index 06d02322..60437a5a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -157,6 +157,9 @@ static struct connman_ipconfig =
*create_ip6config(struct connman_service *service
 static void dns_changed(struct connman_service *service);
 static void vpn_auto_connect(void);
 static void trigger_autoconnect(struct connman_service *service);
+static void complete_online_check(struct connman_service *service,
+					enum connman_ipconfig_type type,
+					bool success);
=20
 struct find_data {
 	const char *path;
@@ -3621,7 +3624,7 @@ void __connman_service_wispr_start(struct =
connman_service *service,
 		service->online_check_interval_ipv6 =3D
 					online_check_initial_interval;
=20
-	__connman_wispr_start(service, type);
+	__connman_wispr_start(service, type, complete_online_check);
 }
=20
 static DBusMessage *set_property(DBusConnection *conn,
@@ -6347,7 +6350,7 @@ static void redo_wispr(struct connman_service =
*service,
 		__connman_ipconfig_type2string(type),
 		service, service->name);
=20
-	__connman_wispr_start(service, type);
+	__connman_wispr_start(service, type, complete_online_check);
 	connman_service_unref(service);
 }
=20
@@ -6373,7 +6376,7 @@ static gboolean redo_wispr_ipv6(gpointer =
user_data)
 	return FALSE;
 }
=20
-void __connman_service_online_check(struct connman_service *service,
+static void complete_online_check(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					bool success)
 {
diff --git a/src/wispr.c b/src/wispr.c
index a4372018..18d2560d 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -59,6 +59,7 @@ struct connman_wispr_portal_context {
 	int refcount;
 	struct connman_service *service;
 	enum connman_ipconfig_type type;
+	__connman_wispr_cb_t cb;
 	struct connman_wispr_portal *wispr_portal;
=20
 	/* Portal/WISPr common */
@@ -483,7 +484,7 @@ static void portal_manage_status(GWebResult *result,
 					CONNMAN_SERVICE_STATE_ONLINE, =
type);
=20
 	if (enable_online_to_ready_transition)
-		__connman_service_online_check(service, type, true);
+		wp_context->cb(service, type, true);
 }
=20
 static bool wispr_route_request(const char *address, int ai_family,
@@ -821,8 +822,7 @@ static bool wispr_portal_web_result(GWebResult =
*result, gpointer user_data)
 		goto done;
 	case 400:
 	case 404:
-		__connman_service_online_check(wp_context->service,
-						wp_context->type, =
false);
+		wp_context->cb(wp_context->service, wp_context->type, =
false);
=20
 		break;
 	case 505:
@@ -989,16 +989,17 @@ done:
 }
=20
 int __connman_wispr_start(struct connman_service *service,
-					enum connman_ipconfig_type type)
+					enum connman_ipconfig_type type,
+					__connman_wispr_cb_t callback)
 {
 	struct connman_wispr_portal_context *wp_context =3D NULL;
 	struct connman_wispr_portal *wispr_portal =3D NULL;
 	int index, err;
=20
-	DBG("service %p %s", service,
-		__connman_ipconfig_type2string(type));
+	DBG("service %p %s callback %p", service,
+		__connman_ipconfig_type2string(type), callback);
=20
-	if (!wispr_portal_hash)
+	if (!wispr_portal_hash || !callback)
 		return -EINVAL;
=20
 	switch (connman_service_get_type(service)) {
@@ -1048,6 +1049,7 @@ int __connman_wispr_start(struct connman_service =
*service,
=20
 	wp_context->service =3D service;
 	wp_context->type =3D type;
+	wp_context->cb =3D callback;
 	wp_context->wispr_portal =3D wispr_portal;
=20
 	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4)
--=20
2.32.0


