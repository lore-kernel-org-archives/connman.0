Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFDF328CF
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8B13B73208
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:20 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4DCF373225
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 54/90] connection: Add 'is_addr_any_str'.
Date: Wed,  6 Dec 2023 15:50:20 -0800
Message-ID: <20231206235056.322578-58-gerickson@nuovations.com>
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

This adds 'is_addr_any_str' which can successfully determine whether a
specified text-formatted IP address is the "any" or "unspecified"
address for either an IPv4 or an IPv6 address.

Application of 'is_addr_any_str' helps neutralize any/unspecified
address string comparisons and moves IPv4- and IPv6-specific blocks of
code closer to unification.
---
 src/connection.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 1f8152e7a7e4..cfae70f2055c 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -620,6 +620,15 @@ static bool is_ipv6_addr_any_str(const char *address)
 	return g_strcmp0(ipv6_addr_any_str, address) == 0;
 }
 
+static bool is_addr_any_str(const char *address)
+{
+	if (!address)
+		return false;
+
+	return (!strchr(address, ':') && is_ipv4_addr_any_str(address)) ||
+				is_ipv6_addr_any_str(address);
+}
+
 /**
  *  @brief
  *    Find the gateway, or default router, configuration associated
@@ -934,7 +943,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 
 		DBG("active gw %s", active_gateway->ipv4_config->gateway);
 
-		if (!is_ipv4_addr_any_str(active_gateway->ipv4_config->gateway))
+		if (!is_addr_any_str(active_gateway->ipv4_config->gateway))
 			dest = active_gateway->ipv4_config->gateway;
 		else
 			dest = NULL;
@@ -953,7 +962,7 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 
 		DBG("active gw %s", active_gateway->ipv6_config->gateway);
 
-		if (!is_ipv6_addr_any_str(active_gateway->ipv6_config->gateway))
+		if (!is_addr_any_str(active_gateway->ipv6_config->gateway))
 			dest = active_gateway->ipv6_config->gateway;
 		else
 			dest = NULL;
@@ -1489,7 +1498,7 @@ static int set_ipv4_high_priority_default_gateway_route_cb(
 			data, data->index, config->vpn_ip,
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
-	} else if (is_ipv4_addr_any_str(config->gateway)) {
+	} else if (is_addr_any_str(config->gateway)) {
 		err = connman_inet_set_gateway_interface(
 					data->index);
 		if (err < 0)
@@ -1528,7 +1537,7 @@ static int set_ipv6_high_priority_default_gateway_route_cb(
 			data, data->index, config->vpn_ip,
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
-	} else if (is_ipv6_addr_any_str(config->gateway)) {
+	} else if (is_addr_any_str(config->gateway)) {
 		err = connman_inet_set_ipv6_gateway_interface(
 					data->index);
 		if (err < 0)
@@ -1646,7 +1655,7 @@ static int unset_ipv4_high_priority_default_gateway_route_cb(
 			data, data->index, config->vpn_ip,
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
-	} else if (is_ipv4_addr_any_str(config->gateway)) {
+	} else if (is_addr_any_str(config->gateway)) {
 		err = connman_inet_clear_gateway_interface(data->index);
 		if (err < 0)
 			goto done;
@@ -1682,7 +1691,7 @@ static int unset_ipv6_high_priority_default_gateway_route_cb(
 			data, data->index, config->vpn_ip,
 			config->vpn_phy_index,
 			config->vpn_phy_ip);
-	} else if (is_ipv6_addr_any_str(config->gateway)) {
+	} else if (is_addr_any_str(config->gateway)) {
 		err = connman_inet_clear_ipv6_gateway_interface(data->index);
 		if (err < 0)
 			goto done;
@@ -2336,7 +2345,7 @@ static void add_host_route(int family, int index, const char *gateway,
 {
 	switch (family) {
 	case AF_INET:
-		if (!is_ipv4_addr_any_str(gateway)) {
+		if (!is_addr_any_str(gateway)) {
 			/*
 			 * We must not set route to the phy dev gateway in
 			 * VPN link. The packets to VPN link might be routed
@@ -2361,7 +2370,7 @@ static void add_host_route(int family, int index, const char *gateway,
 		break;
 
 	case AF_INET6:
-		if (!is_ipv6_addr_any_str(gateway)) {
+		if (!is_addr_any_str(gateway)) {
 			if (service_type != CONNMAN_SERVICE_TYPE_VPN)
 				connman_inet_add_ipv6_host_route(index,
 								gateway, NULL);
-- 
2.42.0

