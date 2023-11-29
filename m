Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8721FB4
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8C52B73122
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 20:52:56 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 44EEE73156
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 20:52:56 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/3] connection: Introduce and leverage 'is_ipv[46]_addr_any_str' functions.
Date: Tue, 28 Nov 2023 17:52:52 -0800
Message-ID: <20231129015253.1254116-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129015253.1254116-1-gerickson@nuovations.com>
References: <20231129015253.1254116-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Comparisons against the IPv4 and IPv6 any / unspecified address string
constants, "0.0.0.0" and "::" respectively, appear often enough
throughout the code where they warrant introducing and leveraging
introspection functions to encapsulate the comparison patterns.

This introduces and leverages 'is_ipv[46]_addr_any_str' introspection
functions to encapsulate these comparison patterns.
---
 src/connection.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 66a3bd656db0..9fb2298dde61 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -192,6 +192,16 @@ static void gateway_data_debug(const char *function,
 	}
 }
 
+static bool is_ipv4_addr_any_str(const char *address)
+{
+	return g_strcmp0(ipv4_addr_any_str, address) == 0;
+}
+
+static bool is_ipv6_addr_any_str(const char *address)
+{
+	return g_strcmp0(ipv6_addr_any_str, address) == 0;
+}
+
 /**
  *  @brief
  *    Find the gateway, or default router, configuration associated
@@ -488,8 +498,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 
 		DBG("active gw %s", active_gateway->ipv4_config->gateway);
 
-		if (g_strcmp0(active_gateway->ipv4_config->gateway,
-							ipv4_addr_any_str) != 0)
+		if (!is_ipv4_addr_any_str(active_gateway->ipv4_config->gateway))
 			dest = active_gateway->ipv4_config->gateway;
 		else
 			dest = NULL;
@@ -508,8 +517,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 
 		DBG("active gw %s", active_gateway->ipv6_config->gateway);
 
-		if (g_strcmp0(active_gateway->ipv6_config->gateway,
-					ipv6_addr_any_str) != 0)
+		if (!is_ipv6_addr_any_str(active_gateway->ipv6_config->gateway))
 			dest = active_gateway->ipv6_config->gateway;
 		else
 			dest = NULL;
@@ -540,8 +548,7 @@ static int del_routes(struct gateway_data *data,
 						data->index,
 						data->ipv4_config->vpn_ip);
 
-		} else if (g_strcmp0(data->ipv4_config->gateway,
-						ipv4_addr_any_str) == 0) {
+		} else if (is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
 			status4 = connman_inet_clear_gateway_interface(
 								data->index);
 		} else {
@@ -559,8 +566,7 @@ static int del_routes(struct gateway_data *data,
 						data->index,
 						data->ipv6_config->vpn_ip);
 
-		} else if (g_strcmp0(data->ipv6_config->gateway,
-						ipv6_addr_any_str) == 0) {
+		} else if (is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
 			status6 = connman_inet_clear_ipv6_gateway_interface(
 								data->index);
 		} else {
@@ -719,8 +725,7 @@ static void set_default_gateway(struct gateway_data *data,
 	index = __connman_service_get_index(data->service);
 
 	if (do_ipv4 && data->ipv4_config &&
-			g_strcmp0(data->ipv4_config->gateway,
-					ipv4_addr_any_str) == 0) {
+			is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
 		if (connman_inet_set_gateway_interface(index) < 0)
 			return;
 		data->ipv4_config->active = true;
@@ -728,8 +733,7 @@ static void set_default_gateway(struct gateway_data *data,
 	}
 
 	if (do_ipv6 && data->ipv6_config &&
-			g_strcmp0(data->ipv6_config->gateway,
-					ipv6_addr_any_str) == 0) {
+			is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
 		if (connman_inet_set_ipv6_gateway_interface(index) < 0)
 			return;
 		data->ipv6_config->active = true;
@@ -801,16 +805,14 @@ static void unset_default_gateway(struct gateway_data *data,
 	index = __connman_service_get_index(data->service);
 
 	if (do_ipv4 && data->ipv4_config &&
-			g_strcmp0(data->ipv4_config->gateway,
-					ipv4_addr_any_str) == 0) {
+			is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
 		connman_inet_clear_gateway_interface(index);
 		data->ipv4_config->active = false;
 		return;
 	}
 
 	if (do_ipv6 && data->ipv6_config &&
-			g_strcmp0(data->ipv6_config->gateway,
-					ipv6_addr_any_str) == 0) {
+			is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
 		connman_inet_clear_ipv6_gateway_interface(index);
 		data->ipv6_config->active = false;
 		return;
@@ -1070,7 +1072,7 @@ static void add_host_route(int family, int index, const char *gateway,
 {
 	switch (family) {
 	case AF_INET:
-		if (g_strcmp0(gateway, ipv4_addr_any_str) != 0) {
+		if (!is_ipv4_addr_any_str(gateway)) {
 			/*
 			 * We must not set route to the phy dev gateway in
 			 * VPN link. The packets to VPN link might be routed
@@ -1095,7 +1097,7 @@ static void add_host_route(int family, int index, const char *gateway,
 		break;
 
 	case AF_INET6:
-		if (g_strcmp0(gateway, ipv6_addr_any_str) != 0) {
+		if (!is_ipv6_addr_any_str(gateway)) {
 			if (service_type != CONNMAN_SERVICE_TYPE_VPN)
 				connman_inet_add_ipv6_host_route(index,
 								gateway, NULL);
-- 
2.42.0

