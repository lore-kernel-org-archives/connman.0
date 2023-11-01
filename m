Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67512B6F
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6715773133
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 19:22:08 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 199E973176
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 19:22:08 -0400 (EDT)
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
Subject: [PATCH v2] Be consistent about debug logging service and IP config
 type.
Date: Wed, 1 Nov 2023 16:22:07 -0700
References: <E8C09CE8-DE8A-46EA-BE67-F9F1B11211D2@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <E8C09CE8-DE8A-46EA-BE67-F9F1B11211D2@nuovations.com>
Message-Id: <1943BE4D-CEA9-4BA2-8815-F0F8D7BD2177@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

In a number of DBG log instances, there are inconsistencies in what and
how a service and its IP configuration type are logged. In some places,
it is just pointers and enumeration values. In other places, it is
pointers, identifiers, and strings without enumerated values.

This makes several such instances consistent, logging the service
pointer, the service instance name, the IP configuration type enumerated
value and its string equivalent.
---
 src/proxy.c   |  4 +++-
 src/service.c | 27 +++++++++++++++++++--------
 src/wispr.c   | 14 +++++++++-----
 src/wpad.c    |  2 +-
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/src/proxy.c b/src/proxy.c
index e1bc420a..9e00469e 100644
--- a/src/proxy.c
+++ b/src/proxy.c
@@ -107,7 +107,9 @@ unsigned int connman_proxy_lookup(const char =
*interface, const char *url,
 {
 	struct proxy_lookup *lookup;
=20
-	DBG("interface %s url %s", interface, url);
+	DBG("interface %s url %s service %p (%s)",
+		interface, url,
+		service, connman_service_get_identifier(service));
=20
 	if (!interface)
 		return 0;
diff --git a/src/service.c b/src/service.c
index 5795026b..464c86e7 100644
--- a/src/service.c
+++ b/src/service.c
@@ -3612,7 +3612,10 @@ int __connman_service_reset_ipconfig(struct =
connman_service *service,
 void __connman_service_wispr_start(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
-	DBG("service %p type %s", service, =
__connman_ipconfig_type2string(type));
+	DBG("service %p (%s) type %d (%s)",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type));
=20
 	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4)
 		service->online_check_interval_ipv4 =3D
@@ -4720,8 +4723,11 @@ static void downgrade_state(struct =
connman_service *service)
 	if (!service)
 		return;
=20
-	DBG("service %p state4 %d state6 %d", service, =
service->state_ipv4,
-						service->state_ipv6);
+	DBG("service %p (%s) state4 %d (%s) state6 %d (%s)",
+		service,
+		connman_service_get_identifier(service),
+		service->state_ipv4, state2string(service->state_ipv4),
+		service->state_ipv6, state2string(service->state_ipv6));
=20
 	if (service->state_ipv4 =3D=3D CONNMAN_SERVICE_STATE_ONLINE)
 		__connman_service_ipconfig_indicate_state(service,
@@ -6005,8 +6011,9 @@ static int service_indicate_state(struct =
connman_service *service)
 	old_state =3D service->state;
 	new_state =3D combine_state(service->state_ipv4, =
service->state_ipv6);
=20
-	DBG("service %p old %s - new %s/%s =3D> %s",
+	DBG("service %p (%s) old %s - new %s/%s =3D> %s",
 					service,
+					=
connman_service_get_identifier(service),
 					state2string(old_state),
 					=
state2string(service->state_ipv4),
 					=
state2string(service->state_ipv6),
@@ -6382,8 +6389,11 @@ void __connman_service_online_check(struct =
connman_service *service,
 	enum connman_service_state current_state;
 	int timeout;
=20
-	DBG("service %p type %s success %d\n",
-		service, __connman_ipconfig_type2string(type), success);
+	DBG("service %p (%s) type %d (%s) success %d\n",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		success);
=20
 	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV4) {
 		interval =3D &service->online_check_interval_ipv4;
@@ -6409,8 +6419,9 @@ void __connman_service_online_check(struct =
connman_service *service,
 	}
=20
 redo_func:
-	DBG("service %p type %s interval %d", service,
-		__connman_ipconfig_type2string(type), *interval);
+	DBG("service %p (%s) type %d (%s) interval %d", service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type), *interval);
=20
 	timeout =3D g_timeout_add_seconds(*interval * *interval,
 				redo_func, =
connman_service_ref(service));
diff --git a/src/wispr.c b/src/wispr.c
index a4372018..4a81cbd5 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -921,8 +921,11 @@ static int wispr_portal_detect(struct =
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
@@ -995,8 +998,9 @@ int __connman_wispr_start(struct connman_service =
*service,
 	struct connman_wispr_portal *wispr_portal =3D NULL;
 	int index, err;
=20
-	DBG("service %p %s", service,
-		__connman_ipconfig_type2string(type));
+	DBG("service %p (%s) type %d (%s)",
+		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type));
=20
 	if (!wispr_portal_hash)
 		return -EINVAL;
@@ -1070,7 +1074,7 @@ void __connman_wispr_stop(struct connman_service =
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
diff --git a/src/wpad.c b/src/wpad.c
index 54084ee8..e1886d2b 100644
--- a/src/wpad.c
+++ b/src/wpad.c
@@ -131,7 +131,7 @@ int __connman_wpad_start(struct connman_service =
*service)
 	int index;
 	int i;
=20
-	DBG("service %p", service);
+	DBG("service %p (%s)", service, =
connman_service_get_identifier(service));
=20
 	if (!wpad_list)
 		return -EINVAL;
--=20
2.42.0

