Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499D13FF8
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 306AF73122
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:07 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E6FFC73145
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/9] service: Add gateway parameter to DNS host route deletion paths.
Date: Sat, 16 Dec 2023 00:27:57 -0800
Message-ID: <20231216082805.2221938-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231216082805.2221938-1-gerickson@nuovations.com>
References: <20231216082805.2221938-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a gateway address parameter to domain name service (DNS)
server host route deletion paths.

Routing table manipulation, host routes among them, should be
fundamentally symmetric. The routing table entry parameters used to
add a route should be identical to those used to delete the same
route.

The following interfaces were missing the gateway address parameter
and now have it:

    * __connman_service_nameserver_del_routes
    * nameserver_del_routes

to match:

    * __connman_service_nameserver_add_routes
    * nameserver_add_routes

which had such a parameter.
---
 src/connman.h |  1 +
 src/gateway.c | 16 ++++++++++++----
 src/service.c | 25 +++++++++++++++++--------
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 90d5a34b8c58..622a778590b1 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -808,6 +808,7 @@ void __connman_service_nameserver_clear(struct connman_service *service);
 void __connman_service_nameserver_add_routes(const struct connman_service *service,
 						const char *gw);
 void __connman_service_nameserver_del_routes(const struct connman_service *service,
+					const char *gw,
 					enum connman_ipconfig_type type);
 void __connman_service_set_timeservers(struct connman_service *service,
 						char **timeservers);
diff --git a/src/gateway.c b/src/gateway.c
index 61f3226a6771..b97abe0dd991 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -3765,10 +3765,6 @@ void __connman_gateway_remove(struct connman_service *service,
 	else
 		return;
 
-    /* Delete any routes associated with this service's nameservers. */
-
-	__connman_service_nameserver_del_routes(service, type);
-
 	/*
 	 * If there is no hash table / map entry for this service, then
 	 * there are no gateways associated with it; simply return.
@@ -3779,6 +3775,18 @@ void __connman_gateway_remove(struct connman_service *service,
 
 	GATEWAY_DATA_DBG("service_data", data);
 
+	/* Delete any routes associated with this service's nameservers. */
+
+	if (do_ipv4 && data->ipv4_config)
+		__connman_service_nameserver_del_routes(service,
+			data->ipv4_config->gateway,
+			type);
+
+	if (do_ipv6 && data->ipv6_config)
+		__connman_service_nameserver_del_routes(service,
+			data->ipv6_config->gateway,
+			type);
+
 	if (do_ipv4 && data->ipv4_config)
 		is_vpn4 = is_gateway_config_vpn(data->ipv4_config);
 
diff --git a/src/service.c b/src/service.c
index 54c12532e9ca..21b83e51e788 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1407,22 +1407,28 @@ static void nameserver_add_routes(int index, char **nameservers,
 }
 
 static void nameserver_del_routes(int index, char **nameservers,
+				const char *gw,
 				enum connman_ipconfig_type type)
 {
-	int i, ns_family;
+	int i, ns_family, gw_family;
+
+	gw_family = connman_inet_check_ipaddress(gw);
+	if (gw_family < 0)
+		return;
 
 	for (i = 0; nameservers[i]; i++) {
 		ns_family = connman_inet_check_ipaddress(nameservers[i]);
-		if (ns_family < 0)
+		if (ns_family < 0 || ns_family != gw_family)
 			continue;
 
 		del_nameserver_route(ns_family, index, nameservers[i],
-			NULL, type);
+			gw, type);
 	}
 }
 
-void __connman_service_nameserver_add_routes(const struct connman_service *service,
-						const char *gw)
+void __connman_service_nameserver_add_routes(
+					const struct connman_service *service,
+					const char *gw)
 {
 	int index;
 
@@ -1449,7 +1455,9 @@ void __connman_service_nameserver_add_routes(const struct connman_service *servi
 	}
 }
 
-void __connman_service_nameserver_del_routes(const struct connman_service *service,
+void __connman_service_nameserver_del_routes(
+					const struct connman_service *service,
+					const char *gw,
 					enum connman_ipconfig_type type)
 {
 	int index;
@@ -1461,9 +1469,9 @@ void __connman_service_nameserver_del_routes(const struct connman_service *servi
 
 	if (service->nameservers_config)
 		nameserver_del_routes(index, service->nameservers_config,
-					type);
+					gw, type);
 	else if (service->nameservers)
-		nameserver_del_routes(index, service->nameservers, type);
+		nameserver_del_routes(index, service->nameservers, gw, type);
 }
 
 /**
@@ -4483,6 +4491,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 		if (gw && strlen(gw))
 			__connman_service_nameserver_del_routes(service,
+						gw,
 						CONNMAN_IPCONFIG_TYPE_ALL);
 
 		dbus_message_iter_recurse(&value, &entry);
-- 
2.42.0

