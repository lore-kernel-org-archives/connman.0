Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980AE14000
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8E9617312C
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:07 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5151173147
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/9] inet: Add gateway parameter to 'connman_inet_del_{,ipv6_}host_route'.
Date: Sat, 16 Dec 2023 00:27:58 -0800
Message-ID: <20231216082805.2221938-4-gerickson@nuovations.com>
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

This adds a gateway address parameter to the
'connman_inet_del_{,ipv6_}host_route' functions.

Routing table manipulation, host routes among them, should be
fundamentally symmetric. The routing table entry parameters used to
add a route should be identical to those used to delete the same
route. Otherwise, an ESRCH error may occur which, at present, are
suppressed due to commit e03a01d3182d ("inet: Fix error handling when
adding/removing routes") that is masking route deletion errors where
this gateway parameter asymmetry is occurring.

In addition, call sites to 'connman_inet_del_{,ipv6_}host_route' are
updated to pass the gateway parameter.
---
 include/inet.h | 17 ++++++++++++-----
 src/gateway.c  | 17 +++++++++++------
 src/inet.c     | 40 +++++++++++++++++++++++++++++++++++-----
 src/service.c  | 25 +++++++++++++++++++------
 4 files changed, 77 insertions(+), 22 deletions(-)

diff --git a/include/inet.h b/include/inet.h
index c7488165720c..5b2015eda76a 100644
--- a/include/inet.h
+++ b/include/inet.h
@@ -50,8 +50,12 @@ int connman_inet_del_host_route_with_metric(int index,
 					const char *host,
 					const char *gateway,
 					uint32_t metric);
-int connman_inet_add_host_route(int index, const char *host, const char *gateway);
-int connman_inet_del_host_route(int index, const char *host);
+int connman_inet_add_host_route(int index,
+					const char *host,
+					const char *gateway);
+int connman_inet_del_host_route(int index,
+					const char *host,
+					const char *gateway);
 int connman_inet_add_network_route_with_metric(int index,
 					const char *host,
 					const char *gateway,
@@ -82,9 +86,12 @@ int connman_inet_del_ipv6_host_route_with_metric(int index,
 					const char *host,
 					const char *gateway,
 					uint32_t metric);
-int connman_inet_add_ipv6_host_route(int index, const char *host,
-						const char *gateway);
-int connman_inet_del_ipv6_host_route(int index, const char *host);
+int connman_inet_add_ipv6_host_route(int index,
+					const char *host,
+					const char *gateway);
+int connman_inet_del_ipv6_host_route(int index,
+					const char *host,
+					const char *gateway);
 int connman_inet_del_ipv6_network_route_with_metric(int index,
 					const char *host,
 					const char *gateway,
diff --git a/src/gateway.c b/src/gateway.c
index b97abe0dd991..29115250d243 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -401,9 +401,10 @@ struct gateway_config_ops {
 		uint32_t metric);
 
 	int (*add_host_route)(int index,
-		const char *gateway,
-		const char *host);
+		const char *host,
+		const char *gateway);
 	int (*del_host_route)(int index,
+		const char *host,
 		const char *gateway);
 };
 
@@ -1445,7 +1446,8 @@ static int del_gateway_routes(struct gateway_data *data,
 		} else {
 			data->ipv4_config->ops->del_host_route(
 						data->index,
-						data->ipv4_config->gateway);
+						data->ipv4_config->gateway,
+						NULL);
 
 			status4 = UNSET_DEFAULT_GATEWAY(data, type);
 
@@ -1462,7 +1464,8 @@ static int del_gateway_routes(struct gateway_data *data,
 		} else {
 			data->ipv6_config->ops->del_host_route(
 						data->index,
-						data->ipv6_config->gateway);
+						data->ipv6_config->gateway,
+						NULL);
 
 			status6 = UNSET_DEFAULT_GATEWAY(data, type);
 
@@ -3803,12 +3806,14 @@ void __connman_gateway_remove(struct connman_service *service,
 	if (is_vpn4 && data->index >= 0)
 		data->ipv4_config->ops->del_host_route(
 					data->ipv4_config->vpn_phy_index,
-					data->ipv4_config->gateway);
+					data->ipv4_config->gateway,
+					NULL);
 
 	if (is_vpn6 && data->index >= 0)
 		data->ipv6_config->ops->del_host_route(
 					data->ipv6_config->vpn_phy_index,
-					data->ipv6_config->gateway);
+					data->ipv6_config->gateway,
+					NULL);
 
 	/* Remove all active routes associated with this gateway data. */
 
diff --git a/src/inet.c b/src/inet.c
index 371b3328175f..55684dc2fd65 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -1545,14 +1545,29 @@ int connman_inet_del_network_route_with_metric(int index,
 				metric);
 }
 
-int connman_inet_add_host_route(int index, const char *host,
+int connman_inet_add_host_route(int index,
+				const char *host,
 				const char *gateway)
 {
 	return connman_inet_add_network_route(index, host, gateway, NULL);
 }
 
-int connman_inet_del_host_route(int index, const char *host)
+int connman_inet_del_host_route(int index,
+				const char *host,
+				const char *gateway)
 {
+	/*
+	 * NOTE: The 'connman_inet_del_network_route' is deficient in that
+	 * it is missing the requisite 'gateway' parameter making it
+	 * symmetric with 'connman_inet_add_host_route' and
+	 * 'connman_inet_add_network_route'. Consequently, host route
+	 * deletion may fail.
+	 *
+	 * This, 'connman_inet_add_host_route', and
+	 * 'connman_inet_del_network_route' should probably be migrated to
+	 * the same RTNL-based call stack as
+	 * 'connman_inet_del_host_route_with_metric'.
+	 */
 	return connman_inet_del_network_route(index, host);
 }
 
@@ -1936,14 +1951,29 @@ int connman_inet_del_ipv6_network_route_with_metric(int index,
 				metric);
 }
 
-int connman_inet_add_ipv6_host_route(int index, const char *host,
-					const char *gateway)
+int connman_inet_add_ipv6_host_route(int index,
+				const char *host,
+				const char *gateway)
 {
 	return connman_inet_add_ipv6_network_route(index, host, gateway, 128);
 }
 
-int connman_inet_del_ipv6_host_route(int index, const char *host)
+int connman_inet_del_ipv6_host_route(int index,
+				const char *host,
+				const char *gateway)
 {
+	/*
+	 * NOTE: The 'connman_inet_del_ipv6_network_route' is deficient in
+	 * that it is missing the requisite 'gateway' parameter making it
+	 * symmetric with 'connman_inet_add_ipv6_host_route' and
+	 * 'connman_inet_add_ipv6_network_route'. Consequently, host route
+	 * deletion may fail.
+	 *
+	 * This, 'connman_inet_add_ipv6_host_route', and
+	 * 'connman_inet_del_ipv6_network_route' should probably be
+	 * migrated to the same RTNL-based call stack as
+	 * 'connman_inet_del_ipv6_host_route_with_metric'.
+	 */
 	return connman_inet_del_ipv6_network_route(index, host, 128);
 }
 
diff --git a/src/service.c b/src/service.c
index 21b83e51e788..1f227a2e0125 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1376,14 +1376,27 @@ static void del_nameserver_route(int family, int index, const char *nameserver,
 
 	switch (family) {
 	case AF_INET:
-		if (type != CONNMAN_IPCONFIG_TYPE_IPV6)
-			connman_inet_del_host_route(index,
-						nameserver);
+		if (type != CONNMAN_IPCONFIG_TYPE_IPV4 &&
+			type != CONNMAN_IPCONFIG_TYPE_ALL)
+			break;
+
+		if (connman_inet_compare_subnet(index, nameserver))
+			break;
+
+		if (connman_inet_del_host_route(index, nameserver, gw) < 0)
+			/* For P-t-P link the above route del will fail */
+			connman_inet_del_host_route(index, nameserver, NULL);
 		break;
+
 	case AF_INET6:
-		if (type != CONNMAN_IPCONFIG_TYPE_IPV4)
-			connman_inet_del_ipv6_host_route(index,
-						nameserver);
+		if (type != CONNMAN_IPCONFIG_TYPE_IPV6 &&
+			type != CONNMAN_IPCONFIG_TYPE_ALL)
+			break;
+
+		if (connman_inet_del_ipv6_host_route(index, nameserver,
+								gw) < 0)
+			connman_inet_del_ipv6_host_route(index, nameserver,
+							NULL);
 		break;
 	}
 }
-- 
2.42.0

