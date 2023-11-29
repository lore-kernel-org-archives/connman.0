Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7BA1FB2
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1E29C7312B
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 20:52:56 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CAEB07314B
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 20:52:55 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/3] connection: Introduce and leverage 'ipv[46]_addr_any_str' constants.
Date: Tue, 28 Nov 2023 17:52:51 -0800
Message-ID: <20231129015253.1254116-2-gerickson@nuovations.com>
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

The IPv4 and IPv6 any / unspecified address string literals, "0.0.0.0"
and "::" respectively, appear often enough throughout the code where
they warrant referencing through file-scoped constants.
---
 src/connection.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 3749d3a59196..66a3bd656db0 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -57,6 +57,9 @@ struct gateway_data {
 	bool default_checked;
 };
 
+static const char *const ipv4_addr_any_str = "0.0.0.0";
+static const char *const ipv6_addr_any_str = "::";
+
 static GHashTable *gateway_hash = NULL;
 
 /**
@@ -486,7 +489,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 		DBG("active gw %s", active_gateway->ipv4_config->gateway);
 
 		if (g_strcmp0(active_gateway->ipv4_config->gateway,
-							"0.0.0.0") != 0)
+							ipv4_addr_any_str) != 0)
 			dest = active_gateway->ipv4_config->gateway;
 		else
 			dest = NULL;
@@ -506,7 +509,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 		DBG("active gw %s", active_gateway->ipv6_config->gateway);
 
 		if (g_strcmp0(active_gateway->ipv6_config->gateway,
-								"::") != 0)
+					ipv6_addr_any_str) != 0)
 			dest = active_gateway->ipv6_config->gateway;
 		else
 			dest = NULL;
@@ -538,7 +541,7 @@ static int del_routes(struct gateway_data *data,
 						data->ipv4_config->vpn_ip);
 
 		} else if (g_strcmp0(data->ipv4_config->gateway,
-							"0.0.0.0") == 0) {
+						ipv4_addr_any_str) == 0) {
 			status4 = connman_inet_clear_gateway_interface(
 								data->index);
 		} else {
@@ -556,7 +559,8 @@ static int del_routes(struct gateway_data *data,
 						data->index,
 						data->ipv6_config->vpn_ip);
 
-		} else if (g_strcmp0(data->ipv6_config->gateway, "::") == 0) {
+		} else if (g_strcmp0(data->ipv6_config->gateway,
+						ipv6_addr_any_str) == 0) {
 			status6 = connman_inet_clear_ipv6_gateway_interface(
 								data->index);
 		} else {
@@ -716,7 +720,7 @@ static void set_default_gateway(struct gateway_data *data,
 
 	if (do_ipv4 && data->ipv4_config &&
 			g_strcmp0(data->ipv4_config->gateway,
-							"0.0.0.0") == 0) {
+					ipv4_addr_any_str) == 0) {
 		if (connman_inet_set_gateway_interface(index) < 0)
 			return;
 		data->ipv4_config->active = true;
@@ -725,7 +729,7 @@ static void set_default_gateway(struct gateway_data *data,
 
 	if (do_ipv6 && data->ipv6_config &&
 			g_strcmp0(data->ipv6_config->gateway,
-							"::") == 0) {
+					ipv6_addr_any_str) == 0) {
 		if (connman_inet_set_ipv6_gateway_interface(index) < 0)
 			return;
 		data->ipv6_config->active = true;
@@ -798,7 +802,7 @@ static void unset_default_gateway(struct gateway_data *data,
 
 	if (do_ipv4 && data->ipv4_config &&
 			g_strcmp0(data->ipv4_config->gateway,
-							"0.0.0.0") == 0) {
+					ipv4_addr_any_str) == 0) {
 		connman_inet_clear_gateway_interface(index);
 		data->ipv4_config->active = false;
 		return;
@@ -806,7 +810,7 @@ static void unset_default_gateway(struct gateway_data *data,
 
 	if (do_ipv6 && data->ipv6_config &&
 			g_strcmp0(data->ipv6_config->gateway,
-							"::") == 0) {
+					ipv6_addr_any_str) == 0) {
 		connman_inet_clear_ipv6_gateway_interface(index);
 		data->ipv6_config->active = false;
 		return;
@@ -1066,7 +1070,7 @@ static void add_host_route(int family, int index, const char *gateway,
 {
 	switch (family) {
 	case AF_INET:
-		if (g_strcmp0(gateway, "0.0.0.0") != 0) {
+		if (g_strcmp0(gateway, ipv4_addr_any_str) != 0) {
 			/*
 			 * We must not set route to the phy dev gateway in
 			 * VPN link. The packets to VPN link might be routed
@@ -1091,7 +1095,7 @@ static void add_host_route(int family, int index, const char *gateway,
 		break;
 
 	case AF_INET6:
-		if (g_strcmp0(gateway, "::") != 0) {
+		if (g_strcmp0(gateway, ipv6_addr_any_str) != 0) {
 			if (service_type != CONNMAN_SERVICE_TYPE_VPN)
 				connman_inet_add_ipv6_host_route(index,
 								gateway, NULL);
@@ -1176,10 +1180,10 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	 * interface
 	 */
 	if (!gateway && type == CONNMAN_IPCONFIG_TYPE_IPV4)
-		gateway = "0.0.0.0";
+		gateway = ipv4_addr_any_str;
 
 	if (!gateway && type == CONNMAN_IPCONFIG_TYPE_IPV6)
-		gateway = "::";
+		gateway = ipv6_addr_any_str;
 
 	DBG("service %p index %d gateway %s vpn ip %s type %d",
 		service, index, gateway, peer, type);
-- 
2.42.0

