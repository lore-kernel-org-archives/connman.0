Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D25C3DB
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id ED39273154
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 15:41:58 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A155C7321A
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 15:41:58 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 2/3] connection: Introduce and leverage 'is_ipv[46]_addr_any_str' functions.
Date: Wed, 29 Nov 2023 12:41:55 -0800
Message-ID: <20231129204156.1298225-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129204156.1298225-1-gerickson@nuovations.com>
References: <20231129015253.1254116-1-gerickson@nuovations.com>
 <20231129204156.1298225-1-gerickson@nuovations.com>
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
index 77ca28934cf2..f7b5ca008d8a 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -200,6 +200,16 @@ static void gateway_data_debug(const char *function,
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
@@ -496,8 +506,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 
 		DBG("active gw %s", active_gateway->ipv4_config->gateway);
 
-		if (g_strcmp0(active_gateway->ipv4_config->gateway,
-							ipv4_addr_any_str) != 0)
+		if (!is_ipv4_addr_any_str(active_gateway->ipv4_config->gateway))
 			dest = active_gateway->ipv4_config->gateway;
 		else
 			dest = NULL;
@@ -516,8 +525,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 
 		DBG("active gw %s", active_gateway->ipv6_config->gateway);
 
-		if (g_strcmp0(active_gateway->ipv6_config->gateway,
-					ipv6_addr_any_str) != 0)
+		if (!is_ipv6_addr_any_str(active_gateway->ipv6_config->gateway))
 			dest = active_gateway->ipv6_config->gateway;
 		else
 			dest = NULL;
@@ -548,8 +556,7 @@ static int del_routes(struct gateway_data *data,
 						data->index,
 						data->ipv4_config->vpn_ip);
 
-		} else if (g_strcmp0(data->ipv4_config->gateway,
-						ipv4_addr_any_str) == 0) {
+		} else if (is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
 			status4 = connman_inet_clear_gateway_interface(
 								data->index);
 		} else {
@@ -567,8 +574,7 @@ static int del_routes(struct gateway_data *data,
 						data->index,
 						data->ipv6_config->vpn_ip);
 
-		} else if (g_strcmp0(data->ipv6_config->gateway,
-						ipv6_addr_any_str) == 0) {
+		} else if (is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
 			status6 = connman_inet_clear_ipv6_gateway_interface(
 								data->index);
 		} else {
@@ -727,8 +733,7 @@ static void set_default_gateway(struct gateway_data *data,
 	index = __connman_service_get_index(data->service);
 
 	if (do_ipv4 && data->ipv4_config &&
-			g_strcmp0(data->ipv4_config->gateway,
-					ipv4_addr_any_str) == 0) {
+			is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
 		if (connman_inet_set_gateway_interface(index) < 0)
 			return;
 		data->ipv4_config->active = true;
@@ -736,8 +741,7 @@ static void set_default_gateway(struct gateway_data *data,
 	}
 
 	if (do_ipv6 && data->ipv6_config &&
-			g_strcmp0(data->ipv6_config->gateway,
-					ipv6_addr_any_str) == 0) {
+			is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
 		if (connman_inet_set_ipv6_gateway_interface(index) < 0)
 			return;
 		data->ipv6_config->active = true;
@@ -809,16 +813,14 @@ static void unset_default_gateway(struct gateway_data *data,
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
@@ -1078,7 +1080,7 @@ static void add_host_route(int family, int index, const char *gateway,
 {
 	switch (family) {
 	case AF_INET:
-		if (g_strcmp0(gateway, ipv4_addr_any_str) != 0) {
+		if (!is_ipv4_addr_any_str(gateway)) {
 			/*
 			 * We must not set route to the phy dev gateway in
 			 * VPN link. The packets to VPN link might be routed
@@ -1103,7 +1105,7 @@ static void add_host_route(int family, int index, const char *gateway,
 		break;
 
 	case AF_INET6:
-		if (g_strcmp0(gateway, ipv6_addr_any_str) != 0) {
+		if (!is_ipv6_addr_any_str(gateway)) {
 			if (service_type != CONNMAN_SERVICE_TYPE_VPN)
 				connman_inet_add_ipv6_host_route(index,
 								gateway, NULL);
-- 
2.42.0

