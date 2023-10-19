Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E360DC140
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E8C2973248
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:34:25 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8696473326
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 17:34:25 -0400 (EDT)
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
Subject: [PATCH] Const-qualify service leaf getter functions.
Message-Id: <F972A4C7-98B0-4667-B919-41A692B22C22@nuovations.com>
Date: Thu, 19 Oct 2023 14:34:24 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the network service arguments in service leaf getter
and introspection functions to make it clear to the compiler, static
analyzers, and human readers that the function is strictly a getter
or introspection function with no network service mutation side
effects.

---
 include/service.h | 18 +++++++++---------
 src/connman.h     | 24 ++++++++++++------------
 src/service.c     | 42 +++++++++++++++++++++---------------------
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/include/service.h b/include/service.h
index 8f6b36b4..e3cf3d36 100644
--- a/include/service.h
+++ b/include/service.h
@@ -114,24 +114,24 @@ connman_service_ref_debug(struct connman_service =
*service,
 void connman_service_unref_debug(struct connman_service *service,
 			const char *file, int line, const char *caller);
=20
-enum connman_service_type connman_service_get_type(struct =
connman_service *service);
-enum connman_service_state connman_service_get_state(struct =
connman_service *service);
+enum connman_service_type connman_service_get_type(const struct =
connman_service *service);
+enum connman_service_state connman_service_get_state(const struct =
connman_service *service);
 char *connman_service_get_interface(struct connman_service *service);
=20
-const char *connman_service_get_identifier(struct connman_service =
*service);
-const char *connman_service_get_domainname(struct connman_service =
*service);
-const char *connman_service_get_dbuspath(struct connman_service =
*service);
+const char *connman_service_get_identifier(const struct connman_service =
*service);
+const char *connman_service_get_domainname(const struct connman_service =
*service);
+const char *connman_service_get_dbuspath(const struct connman_service =
*service);
 char **connman_service_get_nameservers(struct connman_service =
*service);
 char **connman_service_get_timeservers_config(struct connman_service =
*service);
 char **connman_service_get_timeservers(struct connman_service =
*service);
 void connman_service_set_proxy_method(struct connman_service *service, =
enum connman_service_proxy_method method);
-enum connman_service_proxy_method =
connman_service_get_proxy_method(struct connman_service *service);
+enum connman_service_proxy_method =
connman_service_get_proxy_method(const struct connman_service *service);
 char **connman_service_get_proxy_servers(struct connman_service =
*service);
 char **connman_service_get_proxy_excludes(struct connman_service =
*service);
-const char *connman_service_get_proxy_url(struct connman_service =
*service);
+const char *connman_service_get_proxy_url(const struct connman_service =
*service);
 const char *connman_service_get_proxy_autoconfig(struct connman_service =
*service);
-bool connman_service_get_favorite(struct connman_service *service);
-bool connman_service_get_autoconnect(struct connman_service *service);
+bool connman_service_get_favorite(const struct connman_service =
*service);
+bool connman_service_get_autoconnect(const struct connman_service =
*service);
 bool connman_service_set_autoconnect(struct connman_service *service,
 							bool =
autoconnect);
=20
diff --git a/src/connman.h b/src/connman.h
index b955d98b..c5d33c12 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -710,14 +710,14 @@ void __connman_service_notify_ipv4_configuration(
 				struct connman_service *service);
 void __connman_service_wispr_start(struct connman_service *service,
                                 enum connman_ipconfig_type type);
-bool __connman_service_is_connected_state(struct connman_service =
*service,
+bool __connman_service_is_connected_state(const struct connman_service =
*service,
 					enum connman_ipconfig_type =
type);
-const char *__connman_service_get_path(struct connman_service =
*service);
-const char *__connman_service_get_name(struct connman_service =
*service);
+const char *__connman_service_get_path(const struct connman_service =
*service);
+const char *__connman_service_get_name(const struct connman_service =
*service);
 struct connman_network *__connman_service_get_network(struct =
connman_service *service);
-enum connman_service_security __connman_service_get_security(struct =
connman_service *service);
-const char *__connman_service_get_phase2(struct connman_service =
*service);
-bool __connman_service_wps_enabled(struct connman_service *service);
+enum connman_service_security __connman_service_get_security(const =
struct connman_service *service);
+const char *__connman_service_get_phase2(const struct connman_service =
*service);
+bool __connman_service_wps_enabled(const struct connman_service =
*service);
 int __connman_service_set_favorite(struct connman_service *service,
 						bool favorite);
 int __connman_service_set_favorite_delayed(struct connman_service =
*service,
@@ -755,7 +755,7 @@ int __connman_service_disconnect(struct =
connman_service *service);
 void __connman_service_set_active_session(bool enable, GSList *list);
 void __connman_service_auto_connect(enum connman_service_connect_reason =
reason);
 bool __connman_service_remove(struct connman_service *service);
-bool __connman_service_is_provider_pending(struct connman_service =
*service);
+bool __connman_service_is_provider_pending(const struct connman_service =
*service);
 void __connman_service_set_provider_pending(struct connman_service =
*service,
 							DBusMessage =
*msg);
 void __connman_service_set_hidden_data(struct connman_service *service,
@@ -790,17 +790,17 @@ void __connman_service_timeserver_changed(struct =
connman_service *service,
 		GSList *ts_list);
 void __connman_service_set_pac(struct connman_service *service,
 					const char *pac);
-bool __connman_service_is_hidden(struct connman_service *service);
-bool __connman_service_is_split_routing(struct connman_service =
*service);
+bool __connman_service_is_hidden(const struct connman_service =
*service);
+bool __connman_service_is_split_routing(const struct connman_service =
*service);
 bool __connman_service_index_is_split_routing(int index);
 void __connman_service_set_split_routing(struct connman_service =
*service,
 						bool split_routing);
 void __connman_service_split_routing_changed(struct connman_service =
*service);
-int __connman_service_get_index(struct connman_service *service);
+int __connman_service_get_index(const struct connman_service *service);
 void __connman_service_set_hidden(struct connman_service *service);
 void __connman_service_set_hostname(struct connman_service *service,
 						const char *hostname);
-const char *__connman_service_get_hostname(struct connman_service =
*service);
+const char *__connman_service_get_hostname(const struct connman_service =
*service);
 void __connman_service_set_domainname(struct connman_service *service,
 						const char *domainname);
 const char *__connman_service_get_nameserver(struct connman_service =
*service);
@@ -823,7 +823,7 @@ void __connman_service_set_agent_identity(struct =
connman_service *service,
 						const char =
*agent_identity);
 int __connman_service_set_passphrase(struct connman_service *service,
 					const char *passphrase);
-const char *__connman_service_get_passphrase(struct connman_service =
*service);
+const char *__connman_service_get_passphrase(const struct =
connman_service *service);
 int __connman_service_check_passphrase(enum connman_service_security =
security,
 					const char *passphrase);
 int __connman_service_reset_ipconfig(struct connman_service *service,
diff --git a/src/service.c b/src/service.c
index 06d02322..91d17e32 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2717,13 +2717,13 @@ void =
__connman_service_list_struct(DBusMessageIter *iter)
 	g_list_foreach(service_list, append_struct, iter);
 }
=20
-bool __connman_service_is_hidden(struct connman_service *service)
+bool __connman_service_is_hidden(const struct connman_service *service)
 {
 	return service->hidden;
 }
=20
 bool
-__connman_service_is_split_routing(struct connman_service *service)
+__connman_service_is_split_routing(const struct connman_service =
*service)
 {
 	return service->do_split_routing;
 }
@@ -2742,7 +2742,7 @@ bool __connman_service_index_is_split_routing(int =
index)
 	return __connman_service_is_split_routing(service);
 }
=20
-int __connman_service_get_index(struct connman_service *service)
+int __connman_service_get_index(const struct connman_service *service)
 {
 	if (!service)
 		return -1;
@@ -2776,7 +2776,7 @@ void __connman_service_set_hostname(struct =
connman_service *service,
 		service->hostname =3D g_strdup(hostname);
 }
=20
-const char *__connman_service_get_hostname(struct connman_service =
*service)
+const char *__connman_service_get_hostname(const struct connman_service =
*service)
 {
 	if (!service)
 		return NULL;
@@ -2799,7 +2799,7 @@ void __connman_service_set_domainname(struct =
connman_service *service,
 	domain_changed(service);
 }
=20
-const char *connman_service_get_domainname(struct connman_service =
*service)
+const char *connman_service_get_domainname(const struct connman_service =
*service)
 {
 	if (!service)
 		return NULL;
@@ -2810,7 +2810,7 @@ const char *connman_service_get_domainname(struct =
connman_service *service)
 		return service->domainname;
 }
=20
-const char *connman_service_get_dbuspath(struct connman_service =
*service)
+const char *connman_service_get_dbuspath(const struct connman_service =
*service)
 {
 	if (!service)
 		return NULL;
@@ -2883,7 +2883,7 @@ void connman_service_set_proxy_method(struct =
connman_service *service,
 }
=20
 enum connman_service_proxy_method connman_service_get_proxy_method(
-					struct connman_service *service)
+					const struct connman_service =
*service)
 {
 	if (!service)
 		return CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN;
@@ -2909,7 +2909,7 @@ char **connman_service_get_proxy_excludes(struct =
connman_service *service)
 	return g_strdupv(service->excludes);
 }
=20
-const char *connman_service_get_proxy_url(struct connman_service =
*service)
+const char *connman_service_get_proxy_url(const struct connman_service =
*service)
 {
 	if (!service)
 		return NULL;
@@ -3275,7 +3275,7 @@ int __connman_service_set_passphrase(struct =
connman_service *service,
 	return 0;
 }
=20
-const char *__connman_service_get_passphrase(struct connman_service =
*service)
+const char *__connman_service_get_passphrase(const struct =
connman_service *service)
 {
 	if (!service)
 		return NULL;
@@ -4463,7 +4463,7 @@ static void vpn_auto_connect(void)
 }
=20
 bool
-__connman_service_is_provider_pending(struct connman_service *service)
+__connman_service_is_provider_pending(const struct connman_service =
*service)
 {
 	if (!service)
 		return false;
@@ -5487,7 +5487,7 @@ int __connman_service_compare(const struct =
connman_service *a,
  *
  * Get the type of service
  */
-enum connman_service_type connman_service_get_type(struct =
connman_service *service)
+enum connman_service_type connman_service_get_type(const struct =
connman_service *service)
 {
 	if (!service)
 		return CONNMAN_SERVICE_TYPE_UNKNOWN;
@@ -5558,7 +5558,7 @@ __connman_service_get_ipconfig(struct =
connman_service *service, int family)
=20
 }
=20
-bool __connman_service_is_connected_state(struct connman_service =
*service,
+bool __connman_service_is_connected_state(const struct connman_service =
*service,
 					enum connman_ipconfig_type type)
 {
 	if (!service)
@@ -5579,7 +5579,7 @@ bool __connman_service_is_connected_state(struct =
connman_service *service,
 	return false;
 }
 enum connman_service_security __connman_service_get_security(
-				struct connman_service *service)
+				const struct connman_service *service)
 {
 	if (!service)
 		return CONNMAN_SERVICE_SECURITY_UNKNOWN;
@@ -5587,7 +5587,7 @@ enum connman_service_security =
__connman_service_get_security(
 	return service->security;
 }
=20
-const char *__connman_service_get_phase2(struct connman_service =
*service)
+const char *__connman_service_get_phase2(const struct connman_service =
*service)
 {
 	if (!service)
 		return NULL;
@@ -5595,7 +5595,7 @@ const char *__connman_service_get_phase2(struct =
connman_service *service)
 	return service->phase2;
 }
=20
-bool __connman_service_wps_enabled(struct connman_service *service)
+bool __connman_service_wps_enabled(const struct connman_service =
*service)
 {
 	if (!service)
 		return false;
@@ -5657,12 +5657,12 @@ int __connman_service_set_favorite(struct =
connman_service *service,
 							false);
 }
=20
-bool connman_service_get_favorite(struct connman_service *service)
+bool connman_service_get_favorite(const struct connman_service =
*service)
 {
 	return service->favorite;
 }
=20
-bool connman_service_get_autoconnect(struct connman_service *service)
+bool connman_service_get_autoconnect(const struct connman_service =
*service)
 {
 	return service->autoconnect;
 }
@@ -7294,22 +7294,22 @@ struct connman_service =
*__connman_service_lookup_from_index(int index)
 	return NULL;
 }
=20
-const char *connman_service_get_identifier(struct connman_service =
*service)
+const char *connman_service_get_identifier(const struct connman_service =
*service)
 {
 	return service ? service->identifier : NULL;
 }
=20
-const char *__connman_service_get_path(struct connman_service *service)
+const char *__connman_service_get_path(const struct connman_service =
*service)
 {
 	return service->path;
 }
=20
-const char *__connman_service_get_name(struct connman_service *service)
+const char *__connman_service_get_name(const struct connman_service =
*service)
 {
 	return service->name;
 }
=20
-enum connman_service_state connman_service_get_state(struct =
connman_service *service)
+enum connman_service_state connman_service_get_state(const struct =
connman_service *service)
 {
 	return service ? service->state : CONNMAN_SERVICE_STATE_UNKNOWN;
 }
--=20
2.32.0

