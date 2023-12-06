Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17838328B6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 71B267311A
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:50:58 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3532D7312B
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:50:58 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 01/90] connection: Rename 'find_active_gateway_data'.
Date: Wed,  6 Dec 2023 15:49:24 -0800
Message-ID: <20231206235056.322578-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206235056.322578-1-gerickson@nuovations.com>
References: <20231206235056.322578-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

From: Grant Erickson <erick205@umn.edu>

This module has a map that maps services to their gateway data and IP
type-specific configuration. That configuration includes a state
variable indicating whether the configuration is actively contributing
to route that has been confirmed (or "activated") by a Routing Netlink
(rtnl) notification from the kernel.

In a multi-technology and -service environment, there are potentially
at least as many gateways as there are technologies and connected
services. Consequently, the function name 'find_active_gateway_data'
is ambiguous in that "which activate gateway data?" is
unspecified. While the purpose of this function remains unclear, the
name is being updated to accurately reflect what it does, which is to
return any active gateway data.
---
 src/connection.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 94b2f90f515b..f0da0c3c442c 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -352,7 +352,7 @@ static struct gateway_data *find_gateway_data(
 	return NULL;
 }
 
-static struct gateway_data *find_active_gateway_data(void)
+static struct gateway_data *find_any_active_gateway_data(void)
 {
 	GHashTableIter iter;
 	gpointer value, key;
@@ -390,7 +390,7 @@ static struct gateway_data *find_active_gateway_data(void)
  *    with the default network service (that is, has the default
  *    route) on success; otherwise, null.
  *
- *  @sa find_active_gateway_data
+ *  @sa find_any_active_gateway_data
  *  @sa find_gateway_data
  *
  */
@@ -1518,7 +1518,7 @@ int __connman_connection_gateway_add(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					const char *peer)
 {
-	struct gateway_data *active_gateway = NULL;
+	struct gateway_data *any_active_gateway = NULL;
 	struct gateway_data *new_gateway = NULL;
 	enum connman_ipconfig_type type4 = CONNMAN_IPCONFIG_TYPE_UNKNOWN,
 		type6 = CONNMAN_IPCONFIG_TYPE_UNKNOWN;
@@ -1560,12 +1560,9 @@ int __connman_connection_gateway_add(struct connman_service *service,
 
 	GATEWAY_DATA_DBG("new_gateway", new_gateway);
 
-	active_gateway = find_active_gateway_data();
+	any_active_gateway = find_any_active_gateway_data();
 
-	DBG("active %p index %d new %p", active_gateway,
-		active_gateway ? active_gateway->index : -1, new_gateway);
-
-	GATEWAY_DATA_DBG("active_gateway", active_gateway);
+	GATEWAY_DATA_DBG("any_active_gateway", any_active_gateway);
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
 				new_gateway->ipv4_config) {
@@ -1586,7 +1583,7 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	if (service_type == CONNMAN_SERVICE_TYPE_VPN) {
 
 		set_vpn_routes(new_gateway, service, gateway, type, peer,
-							active_gateway);
+							any_active_gateway);
 
 	} else {
 		if (type == CONNMAN_IPCONFIG_TYPE_IPV4 &&
@@ -1598,7 +1595,7 @@ int __connman_connection_gateway_add(struct connman_service *service,
 			new_gateway->ipv6_config->vpn = false;
 	}
 
-	if (!active_gateway) {
+	if (!any_active_gateway) {
 		set_default_gateway(new_gateway, type);
 		goto done;
 	}
@@ -1608,8 +1605,8 @@ int __connman_connection_gateway_add(struct connman_service *service,
 				new_gateway->ipv4_config->vpn) {
 		if (!__connman_service_is_split_routing(new_gateway->service))
 			connman_inet_clear_gateway_address(
-					active_gateway->index,
-					active_gateway->ipv4_config->gateway);
+				any_active_gateway->index,
+				any_active_gateway->ipv4_config->gateway);
 	}
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 &&
@@ -1617,8 +1614,8 @@ int __connman_connection_gateway_add(struct connman_service *service,
 				new_gateway->ipv6_config->vpn) {
 		if (!__connman_service_is_split_routing(new_gateway->service))
 			connman_inet_clear_ipv6_gateway_address(
-					active_gateway->index,
-					active_gateway->ipv6_config->gateway);
+				any_active_gateway->index,
+				any_active_gateway->ipv6_config->gateway);
 	}
 
 done:
-- 
2.42.0

