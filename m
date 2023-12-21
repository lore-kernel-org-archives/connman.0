Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC76B664
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 38AE4731FC
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:42 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id EE6657321A
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:41 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 15/60] session: Add service identifier to 'DBG' in four functions.
Date: Wed, 20 Dec 2023 22:16:38 -0800
Message-ID: <20231221061734.2344286-16-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221061734.2344286-1-gerickson@nuovations.com>
References: <20231221061734.2344286-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds the service identifier to the 'DBG' statements in:

  *  'service_save'
  * '__connman_service_nameserver_append'
  * 'service_schedule_added'
  * 'service_route_changed'

to aid debugging in a multi-technology environment with
"EnableOnlineToReadyTransition" asserted and for consistency with
other 'DBG' statements in this and other modules.
---
 src/service.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/src/service.c b/src/service.c
index 0e25d4879d77..fb901ef16c9b 100644
--- a/src/service.c
+++ b/src/service.c
@@ -705,7 +705,9 @@ static int service_save(struct connman_service *service)
 	const char *cst_str = NULL;
 	int err = 0;
 
-	DBG("service %p new %d", service, service->new_service);
+	DBG("service %p (%s) new %d",
+		service, connman_service_get_identifier(service),
+		service->new_service);
 
 	if (service->new_service)
 		return -ESRCH;
@@ -1231,7 +1233,9 @@ int __connman_service_nameserver_append(struct connman_service *service,
 	char **nameservers;
 	int len, i;
 
-	DBG("service %p nameserver %s auto %d",	service, nameserver, is_auto);
+	DBG("service %p (%s) nameserver %s auto %d",
+		service, connman_service_get_identifier(service),
+		nameserver, is_auto);
 
 	if (!nameserver)
 		return -EINVAL;
@@ -6415,7 +6419,8 @@ static DBusMessage *reset_counters(DBusConnection *conn,
 
 static void service_schedule_added(struct connman_service *service)
 {
-	DBG("service %p", service);
+	DBG("service %p (%s)",
+		service, connman_service_get_identifier(service));
 
 	g_hash_table_remove(services_notify->remove, service->path);
 	g_hash_table_replace(services_notify->add, service->path, service);
@@ -8643,8 +8648,10 @@ static void service_ip_bound(struct connman_ipconfig *ipconfig,
 	type = __connman_ipconfig_get_config_type(ipconfig);
 	method = __connman_ipconfig_get_method(ipconfig);
 
-	DBG("service %p ipconfig %p type %d method %d", service, ipconfig,
-							type, method);
+	DBG("service %p (%s) type %d (%s) ipconfig %p method %d (%s)",
+		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		ipconfig, method, __connman_ipconfig_method2string(method));
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
 			method == CONNMAN_IPCONFIG_METHOD_AUTO)
@@ -8691,7 +8698,10 @@ static void service_route_changed(struct connman_ipconfig *ipconfig,
 {
 	struct connman_service *service = __connman_ipconfig_get_data(ipconfig);
 
-	DBG("%s route changed", ifname);
+	DBG("service %p (%s) ipconfig %p ifname %s route changed",
+		service, connman_service_get_identifier(service),
+		ipconfig,
+		ifname);
 
 	settings_changed(service, ipconfig);
 }
-- 
2.42.0

