Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752F5DF3B
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3E6E573230
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:21:11 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id EB86073249
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:21:10 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 7/8] connection: Document '__connman_connection_gateway_{add,remove}'.
Date: Wed, 29 Nov 2023 11:21:05 -0800
Message-ID: <20231129192106.1295868-8-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129192106.1295868-1-gerickson@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
 <20231129192106.1295868-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the
'__connman_connection_gateway_{add,remove}' functions.
---
 src/connection.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index a4610202d0ba..58abf2ae1925 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1040,6 +1040,41 @@ static void add_host_route(int family, int index, const char *gateway,
 	}
 }
 
+/**
+ *  @brief
+ *    Add, or set, the gateway, or default router, for a network
+ *    service.
+ *
+ *  This attempts to add, or set, the gateway, or default router, for
+ *  a network service using the specified IP configuration gateway
+ *  address and network interface index as the lookup key for the
+ *  network service.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to add a gateway, or default
+ *                           router.
+ *  @param[in]      gateway  An optional pointer to an immutable null-
+ *                           terminated C string containing the
+ *                           text-formatted address of the gateway, or
+ *                           default router, to add to or associate
+ *                           with @a service.
+ *  @param[in]      type     The IP configuration type for which
+ *                           gateway, or default router, is to be
+ *                           added.
+ *  @param[in]      peer     An optional pointer to an immutable null-
+ *                           terminated C string containing the
+ *                           text-formatted address of the network
+ *                           peer, for point-to-point links,
+ *                           associated with the gateway.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If service is null or if network interface
+ *                    index associated with @a service is invalid.
+ *
+ *  @sa __connman_connection_gateway_remove
+ *  @sa __connman_connection_update_gateway
+ *
+ */
 int __connman_connection_gateway_add(struct connman_service *service,
 					const char *gateway,
 					enum connman_ipconfig_type type,
@@ -1160,6 +1195,30 @@ done:
 	return 0;
 }
 
+/**
+ *  @brief
+ *    Remove, or clear, the gateway, or default router, for a network
+ *    service.
+ *
+ *  This attempts to remove, or clear, the gateway, or default router,
+ *  for a network service using the specified network service and IP
+ *  configuration type.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to remove, or clear, a gateway,
+ *                           or default router.
+ *  @param[in]      type     The IP configuration type for which
+ *                           gateway, or default router, is to be
+ *                           removed.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If service is null or if network interface
+ *                    index associated with @a service is invalid.
+ *
+ *  @sa __connman_connection_gateway_add
+ *  @sa __connman_connection_update_gateway
+ *
+ */
 void __connman_connection_gateway_remove(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
@@ -1189,8 +1248,14 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	else
 		do_ipv4 = do_ipv6 = true;
 
+    /* Delete any routes associated with this service's nameservers. */
+
 	__connman_service_nameserver_del_routes(service, type);
 
+	/*
+	 * If there is no hash table / map entry for this service, then
+	 * there are no gateways associated with it; simply return.
+	 */
 	data = g_hash_table_lookup(gateway_hash, service);
 	if (!data)
 		return;
@@ -1208,6 +1273,8 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 		data->ipv6_gateway ? data->ipv6_gateway->gateway : "<null>",
 		set_default4, set_default6);
 
+    /* If necessary, delete any VPN-related host routes. */
+
 	if (do_ipv4 && data->ipv4_gateway &&
 			data->ipv4_gateway->vpn && data->index >= 0)
 		connman_inet_del_host_route(data->ipv4_gateway->vpn_phy_index,
@@ -1219,11 +1286,13 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 					data->ipv6_gateway->vpn_phy_index,
 						data->ipv6_gateway->gateway);
 
+	/* Remove all active routes associated with this gateway data. */
+
 	err = disable_gateway(data, type);
 
 	/*
-	 * We remove the service from the hash only if all the gateway
-	 * settings are to be removed.
+	 * We remove the service from the service/gateway map only if ALL
+	 * of the gateway settings are to be removed.
 	 */
 	if (do_ipv4 == do_ipv6 ||
 		(data->ipv4_gateway && !data->ipv6_gateway
-- 
2.42.0

