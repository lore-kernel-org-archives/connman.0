Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DC328C6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 54D5973214
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:31 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1725173225
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:31 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 82/90] connection: Document 'unset_ipv4_low_priority_default_gateway'.
Date: Wed,  6 Dec 2023 15:50:48 -0800
Message-ID: <20231206235056.322578-86-gerickson@nuovations.com>
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
'unset_ipv4_low_priority_default_gateway' function.
---
 src/connection.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 0a7d9c919452..1f250a62f24c 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2540,6 +2540,50 @@ static int unset_ipv4_low_priority_default_gateway_route_cb(
 				metric);
 }
 
+/**
+ *  @brief
+ *    Unset the IPv4 low-priority default route for the specified IP
+ *    configuration type from the provided gateway data.
+ *
+ *  This attempts to unset, or clear, the IPv4 low-priority (that is,
+ *  metric > 0) default route for the specified IP configuration type
+ *  from the provided gateway data. The network interface and, by
+ *  extension, the network service with which the gateway is
+ *  associated is determined by the @a index field of @a data.
+ *
+ *  On success, the gateway configuration state will be set to
+ *  #CONNMAN_GATEWAY_CONFIG_STATE_REMOVED.
+ *
+ *  @param[in,out]  data  A pointer to the mutable gateway data to
+ *                        clear as the IPv4 low-priority default
+ *                        route.
+ *  @param[in]      type  The IP configuration type for which the
+ *                        gateway, or default router, configuration
+ *                        will be selected from @a data and used to
+ *                        unset the IPv4 low-priority default route.
+ *
+ *  @retval  0              If successful.
+ *  @retval  -EINVAL        If @a data or @a config are null, if the
+ *                          gateway configuration type is not
+ *                          #CONNMAN_GATEWAY_CONFIG_TYPE_LOW_PRIORITY_DEFAULT,
+ *                          or if the routing information to be unset,
+ *                          or cleared, was invalid.
+ *  @retval  -EINPROGRESS   If the state of @a config is
+ *                          #CONNMAN_GATEWAY_CONFIG_STATE_REMOVED.
+ *  @retval  -EALREADY      If the state of @a config is
+ *                          #CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE.
+ *  @retval  -EFAULT        If the address to the routing information
+ *                          to be unset, or cleared, was invalid.
+ *  @retval  -EPERM         If the current process does not have the
+ *                          credentials or capabilities to unset, or
+ *                          clear, routes.
+ *  @retval  -ESRCH         A request was made to unset, or clear a
+ *                          non-existing routing entry.
+ *
+ *  @sa unset_default_gateway_route_common
+ *  @sa unset_ipv4_low_priority_default_gateway_route_cb
+ *
+ */
 static int unset_ipv4_low_priority_default_gateway(struct gateway_data *data,
 				struct gateway_config *config)
 {
-- 
2.42.0

