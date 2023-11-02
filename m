Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF822305
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 919F47311D
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 18:18:49 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5AB98731EC
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 18:18:49 -0400 (EDT)
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
Subject: [PATCH] service: Introduce and leverage 'is_online'.
Message-Id: <F37E2A4E-0C6D-4C97-B8EE-9BDDB4DB4816@nuovations.com>
Date: Thu, 2 Nov 2023 15:18:48 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This introduces and leverages, where appropriate, the file-scoped
'is_online' service state introspection function as a peer to similar
'is_*' introspection functions.
---
 src/service.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/src/service.c b/src/service.c
index 68d61333..1a674924 100644
--- a/src/service.c
+++ b/src/service.c
@@ -972,6 +972,11 @@ static bool is_connected(enum connman_service_state =
state)
 	return false;
 }
=20
+static bool is_online(enum connman_service_state state)
+{
+	return state =3D=3D CONNMAN_SERVICE_STATE_ONLINE;
+}
+
 static bool is_idle(enum connman_service_state state)
 {
 	switch (state) {
@@ -4821,12 +4826,12 @@ static void downgrade_state(struct =
connman_service *service)
 		service->state_ipv4, state2string(service->state_ipv4),
 		service->state_ipv6, state2string(service->state_ipv6));
=20
-	if (service->state_ipv4 =3D=3D CONNMAN_SERVICE_STATE_ONLINE)
+	if (is_online(service->state_ipv4))
 		__connman_service_ipconfig_indicate_state(service,
 						=
CONNMAN_SERVICE_STATE_READY,
 						=
CONNMAN_IPCONFIG_TYPE_IPV4);
=20
-	if (service->state_ipv6 =3D=3D CONNMAN_SERVICE_STATE_ONLINE)
+	if (is_online(service->state_ipv6))
 		__connman_service_ipconfig_indicate_state(service,
 						=
CONNMAN_SERVICE_STATE_READY,
 						=
CONNMAN_IPCONFIG_TYPE_IPV6);
@@ -4838,7 +4843,7 @@ static void =
apply_relevant_default_downgrade(struct connman_service *service)
=20
 	def_service =3D connman_service_get_default();
 	if (!def_service || def_service !=3D service ||
-		def_service->state !=3D CONNMAN_SERVICE_STATE_ONLINE)
+		!is_online(def_service->state))
 		return;
=20
 	downgrade_state(def_service);
@@ -5496,10 +5501,10 @@ static gint service_compare(gconstpointer a, =
gconstpointer b)
 	if (state_a !=3D state_b) {
 		if (a_connected && b_connected) {
 			/* We prefer online over ready state */
-			if (state_a =3D=3D CONNMAN_SERVICE_STATE_ONLINE)
+			if (is_online(state_a))
 				return -1;
=20
-			if (state_b =3D=3D CONNMAN_SERVICE_STATE_ONLINE)
+			if (is_online(state_b))
 				return 1;
 		}
=20
@@ -6028,7 +6033,7 @@ static void downgrade_connected_services(void)
 		if (!is_connected(up_service->state))
 			continue;
=20
-		if (up_service->state =3D=3D =
CONNMAN_SERVICE_STATE_ONLINE)
+		if (is_online(up_service->state))
 			return;
=20
 		downgrade_state(up_service);
@@ -6116,14 +6121,14 @@ static int service_indicate_state(struct =
connman_service *service)
=20
 	def_service =3D connman_service_get_default();
=20
-	if (new_state =3D=3D CONNMAN_SERVICE_STATE_ONLINE) {
+	if (is_online(new_state)) {
 		result =3D service_update_preferred_order(def_service,
 				service, new_state);
 		if (result =3D=3D -EALREADY)
 			return result;
 	}
=20
-	if (old_state =3D=3D CONNMAN_SERVICE_STATE_ONLINE)
+	if (is_online(old_state))
 		__connman_notifier_leave_online(service->type);
=20
 	if (is_connected(old_state) && !is_connected(new_state))
@@ -6222,7 +6227,7 @@ static int service_indicate_state(struct =
connman_service *service)
 		domain_changed(service);
 		proxy_changed(service);
=20
-		if (old_state !=3D CONNMAN_SERVICE_STATE_ONLINE)
+		if (!is_online(old_state))
 			__connman_notifier_connect(service->type);
=20
 		method =3D =
__connman_ipconfig_get_method(service->ipconfig_ipv6);
@@ -6291,7 +6296,7 @@ notifier:
 		__connman_notifier_disconnect(service->type);
 	}
=20
-	if (new_state =3D=3D CONNMAN_SERVICE_STATE_ONLINE) {
+	if (is_online(new_state)) {
 		__connman_notifier_enter_online(service->type);
 		default_changed();
 	}
--=20
2.42.0
