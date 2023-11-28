Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423046B92
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B3F177314B
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 14:23:06 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6127073159
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 14:23:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] ipconfig: Document '__connman_ipconfig_gateway_{add,remove}'.
Date: Tue, 28 Nov 2023 11:23:04 -0800
Message-ID: <20231128192304.1179479-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128192304.1179479-1-gerickson@nuovations.com>
References: <20231128192304.1179479-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the
'__connman_ipconfig_gateway_{add,remove}' functions.
---
 src/ipconfig.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 7c3418d51982..2ca4483ce61c 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1326,6 +1326,31 @@ void __connman_ipconfig_set_gateway(struct connman_ipconfig *ipconfig,
 	ipconfig->address->gateway = g_strdup(gateway);
 }
 
+/**
+ *  @brief
+ *    Add, or set, the gateway, or default router, for a network
+ *    service.
+ *
+ *  This attempts to add, or set, the gateway, or default router, for
+ *  a network service using the specified IP configuration.
+ *
+ *  @param[in]  ipconfig  A pointer to the immutable IP configuration
+ *                        containing the network interface index @a
+ *                        index as the lookup key for the network
+ *                        service for which to add, or set, the
+ *                        gateway.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If the @a address field of @a ipconfig is null,
+ *                    if a cooresponding service cannot be found for
+ *                    the network interface index @a index of @a
+ *                    ipconfig, or if the network interface index
+ *                    associated with @a service is invalid.
+ *
+ *  @sa __connman_ipconfig_gateway_remove
+ *  @sa __connman_connection_gateway_add
+ *
+ */
 int __connman_ipconfig_gateway_add(const struct connman_ipconfig *ipconfig)
 {
 	struct connman_service *service;
@@ -1357,6 +1382,24 @@ int __connman_ipconfig_gateway_add(const struct connman_ipconfig *ipconfig)
 	return 0;
 }
 
+/**
+ *  @brief
+ *    Remove, or clear, the gateway, or default router, for a network
+ *    service.
+ *
+ *  This attempts to remove, or clear, the gateway, or default router, for
+ *  a network service using the specified IP configuration.
+ *
+ *  @param[in]  ipconfig  A pointer to the immutable IP configuration
+ *                        containing the network interface index @a
+ *                        index as the lookup key for the network
+ *                        service for which to remove, or clear, the
+ *                        gateway.
+ *
+ *  @sa __connman_ipconfig_gateway_add
+ *  @sa __connman_connection_gateway_remove
+ *
+ */
 void __connman_ipconfig_gateway_remove(const struct connman_ipconfig *ipconfig)
 {
 	struct connman_service *service;
-- 
2.42.0

