Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F4182C4
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D9CFE73204
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:27 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9D05173224
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:27 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 73/90] connection: Document 'set_ipv6_high_priority_default_gateway'.
Date: Wed,  6 Dec 2023 15:50:39 -0800
Message-ID: <20231206235056.322578-77-gerickson@nuovations.com>
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

This adds documentation to the
'set_ipv6_high_priority_default_gateway' function.
---
 src/connection.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 1d31a42ce334..74f63faf7320 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1887,6 +1887,49 @@ static int set_ipv4_high_priority_default_gateway(struct gateway_data *data,
 	return set_default_gateway_route_common(data, config, type, cb);
 }
 
+/**
+ *  @brief
+ *    Set, or add, the IPv6 high-priority default route for the
+ *    specified gateway data and configuration.
+ *
+ *  This attempts to set, or add, the IPv6 high-priority (that is,
+ *  metric 0) default route for the specified gateway data and
+ *  configuration.
+ *
+ *  On success, the gateway configuration type will be set to
+ *  #CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT and its state
+ *  to #CONNMAN_GATEWAY_CONFIG_STATE_ADDED.
+ *
+ *  @param[in,out]  data    A pointer to the mutable gateway data to
+ *                          assign as the IPv6 high-priority default
+ *                          route.
+ *  @param[in,out]  config  A pointer to the mutable gateway
+ *                          configuration to assign as the IPv6
+ *                          high-priority default route.
+ *
+ *  @retval  0              If successful.
+ *  @retval  -EINVAL        If @a data or @a config are
+ *                          null; if the gateway configuration type is
+ *                          not #CONNMAN_GATEWAY_CONFIG_TYPE_NONE or
+ *                          #CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT;
+ *                          or if the routing information to be set,
+ *                          or added, was invalid.
+ *  @retval  -EINPROGRESS   If the state of @a config is
+ *                          #CONNMAN_GATEWAY_CONFIG_STATE_ADDED.
+ *  @retval  -EALREADY      If the state of @a config is
+ *                          #CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE.
+ *  @retval  -EFAULT        If the address to the routing information
+ *                          to be added was invalid.
+ *  @retval  -EPERM         If the current process does not have the
+ *                          credentials or capabilities to add, or
+ *                          set, routes.
+ *  @retval  -EEXIST        A request was made to add an existing
+ *                          routing entry.
+ *
+ *  @sa set_default_gateway_route_common
+ *  @sa set_ipv6_high_priority_default_gateway_route_cb
+ *
+ */
 static int set_ipv6_high_priority_default_gateway(struct gateway_data *data,
 				struct gateway_config *config)
 {
-- 
2.42.0

