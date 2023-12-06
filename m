Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44AD328C7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3E5217321D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:23 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id F0B2873226
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:22 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 61/90] connection: Document 'gateway_data'.
Date: Wed,  6 Dec 2023 15:50:27 -0800
Message-ID: <20231206235056.322578-65-gerickson@nuovations.com>
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

This adds documentation to the 'gateway_data' structure.
---
 src/connection.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 04a336e0b619..d575e514e101 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -243,11 +243,43 @@ struct gateway_config {
 	char *vpn_phy_ip;
 };
 
+/**
+ *	The key data structure used to associate a network service with a
+ *	gateway, or default router.
+ */
 struct gateway_data {
+	/**
+	 *	The network interface index associated with the underlying
+	 *	network interface for the assigned @a service field.
+	 */
 	int index;
+
+	/**
+	 *	A strong (that is, uses #connman_service_{ref,unref})
+	 *	reference to the network service associated with this gateway.
+	 */
 	struct connman_service *service;
+
+	/**
+	 *	An optional weak reference to dynamically-allocated storage
+	 *	for the gateway-specific configuration, if the gateway is IPv4.
+	 */
 	struct gateway_config *ipv4_config;
+
+	/**
+	 *	An optional weak reference to dynamically-allocated storage
+	 *	for the gateway-specific configuration, if the gateway is IPv6.
+	 */
 	struct gateway_config *ipv6_config;
+
+	/**
+	 *	A Boolean indicating whether this gateway / network interface
+	 *	index tuple has been handled by the #connman_rtnl @a
+	 *	newgateway Linux Routing Netlink (rtnl) new gateway listener
+	 *	method and, specifically, whether that method has checked a
+	 *	new, incoming gateway against the current gateway / default
+	 *	router.
+	 */
 	bool default_checked;
 };
 
-- 
2.42.0

