Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCABC36AF0
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E9B437317E
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 14:38:02 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4] (unknown [IPv6:2601:647:5a00:15c1:3e:a2c6:408d:1da4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A060B731CE
	for <connman@lists.linux.dev>; Tue,  7 Nov 2023 14:38:02 -0500 (EST)
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
Subject: [PATCH v2] Const-qualify 'service' arguments in name and time server 
 getters.
Date: Tue, 7 Nov 2023 11:38:01 -0800
References: <70D6ACF5-703E-48D2-841A-24E63F889D9E@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <70D6ACF5-703E-48D2-841A-24E63F889D9E@nuovations.com>
Message-Id: <D9B864AE-58A6-4384-8FA1-60F2B28B29F0@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Const-qualify the 'service' arguments in name and time server getter
functions to make it clear to the compiler, static analyzers,
and human readers that there are no mutation side effects with
such arguments and that the returned results are immutable and must
be copied if mutation is desired.
---
 include/service.h |  6 +++---
 src/connman.h     |  2 +-
 src/service.c     | 10 +++++-----
 src/timeserver.c  | 14 +++++++-------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/service.h b/include/service.h
index e3cf3d36..e45d7b58 100644
--- a/include/service.h
+++ b/include/service.h
@@ -121,9 +121,9 @@ char *connman_service_get_interface(struct =
connman_service *service);
 const char *connman_service_get_identifier(const struct connman_service =
*service);
 const char *connman_service_get_domainname(const struct connman_service =
*service);
 const char *connman_service_get_dbuspath(const struct connman_service =
*service);
-char **connman_service_get_nameservers(struct connman_service =
*service);
-char **connman_service_get_timeservers_config(struct connman_service =
*service);
-char **connman_service_get_timeservers(struct connman_service =
*service);
+char **connman_service_get_nameservers(const struct connman_service =
*service);
+const char * const *connman_service_get_timeservers_config(const struct =
connman_service *service);
+const char * const *connman_service_get_timeservers(const struct =
connman_service *service);
 void connman_service_set_proxy_method(struct connman_service *service, =
enum connman_service_proxy_method method);
 enum connman_service_proxy_method =
connman_service_get_proxy_method(const struct connman_service *service);
 char **connman_service_get_proxy_servers(struct connman_service =
*service);
diff --git a/src/connman.h b/src/connman.h
index 32adb5f3..d3f2d013 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -450,7 +450,7 @@ char **__connman_timeserver_system_get();
=20
 GSList *__connman_timeserver_add_list(GSList *server_list,
 		const char *timeserver);
-GSList *__connman_timeserver_get_all(struct connman_service *service);
+GSList *__connman_timeserver_get_all(const struct connman_service =
*service);
 void __connman_timeserver_sync(struct connman_service *service,
 				enum connman_timeserver_sync_reason =
reason);
 void __connman_timeserver_conf_update(struct connman_service *service);
diff --git a/src/service.c b/src/service.c
index bf26736e..a84867b9 100644
--- a/src/service.c
+++ b/src/service.c
@@ -3319,7 +3319,7 @@ const char *connman_service_get_dbuspath(const =
struct connman_service *service)
 	return service->path;
 }
=20
-char **connman_service_get_nameservers(struct connman_service *service)
+char **connman_service_get_nameservers(const struct connman_service =
*service)
 {
 	if (!service)
 		return NULL;
@@ -3353,20 +3353,20 @@ char **connman_service_get_nameservers(struct =
connman_service *service)
 	return =
g_strdupv(connman_setting_get_string_list("FallbackNameservers"));
 }
=20
-char **connman_service_get_timeservers_config(struct connman_service =
*service)
+const char * const *connman_service_get_timeservers_config(const struct =
connman_service *service)
 {
 	if (!service)
 		return NULL;
=20
-	return service->timeservers_config;
+	return (const char * const *)service->timeservers_config;
 }
=20
-char **connman_service_get_timeservers(struct connman_service *service)
+const char * const *connman_service_get_timeservers(const struct =
connman_service *service)
 {
 	if (!service)
 		return NULL;
=20
-	return service->timeservers;
+	return (const char * const *)service->timeservers;
 }
=20
 void connman_service_set_proxy_method(struct connman_service *service,
diff --git a/src/timeserver.c b/src/timeserver.c
index 9c0d7aa5..3eb718aa 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -52,7 +52,7 @@ static GResolv *resolv =3D NULL;
 static int resolv_id =3D 0;
=20
 static void sync_next(void);
-static void ts_set_nameservers(struct connman_service *service);
+static void ts_set_nameservers(const struct connman_service *service);
=20
 static void resolv_debug(const char *str, void *data)
 {
@@ -234,13 +234,13 @@ GSList *__connman_timeserver_add_list(GSList =
*server_list,
  * list which will be used to determine NTP server for time =
corrections.
  * The service settings take priority over the global timeservers.
  */
-GSList *__connman_timeserver_get_all(struct connman_service *service)
+GSList *__connman_timeserver_get_all(const struct connman_service =
*service)
 {
 	GSList *list =3D NULL;
-	struct connman_network *network;
+	const struct connman_network *network;
 	char **timeservers;
-	char **service_ts;
-	char **service_ts_config;
+	const char * const *service_ts;
+	const char * const *service_ts_config;
 	const char *service_gw;
 	char **fallback_ts;
 	int index, i;
@@ -267,7 +267,7 @@ GSList *__connman_timeserver_get_all(struct =
connman_service *service)
 	 * configuration option is set to true.
 	 */
 	if (connman_setting_get_bool("UseGatewaysAsTimeservers")) {
-		network =3D __connman_service_get_network(service);
+		network =3D __connman_service_get_network((struct =
connman_service *)service);
 		if (network) {
 			index =3D connman_network_get_index(network);
 			service_gw =3D =
__connman_ipconfig_get_gateway_from_index(index,
@@ -379,7 +379,7 @@ static int ts_setup_resolv(struct connman_service =
*service)
 }
=20
=20
-static void ts_set_nameservers(struct connman_service *service)
+static void ts_set_nameservers(const struct connman_service *service)
 {
 	char **nameservers;
 	int i;
--=20
2.42.0

