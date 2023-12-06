Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB1328D2
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 997F87314E
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:11 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5B44073171
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 34/90] connection: Document 'unset_default_gateway_route_common'.
Date: Wed,  6 Dec 2023 15:49:57 -0800
Message-ID: <20231206235056.322578-35-gerickson@nuovations.com>
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

This adds documentation to the 'unset_default_gateway_route_common'
function.
---
 src/connection.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 6dcb93f887ca..f29f42870cdf 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1339,6 +1339,49 @@ done:
 	return err;
 }
 
+/**
+ *  @brief
+ *    Unset, or remove, the default route, for the specified gateway
+ *    data and configuration using the provided gateway configuration
+ *    type and callback function.
+ *
+ *  This attempts to unset, or remove, the default route for the
+ *  specified gateway data and configuration using the provided
+ *  gateway configuration type and callback function.
+ *
+ *  On success, the gateway configuration state will be set to
+ *  #CONNMAN_GATEWAY_CONFIG_STATE_REMOVED.
+ *
+ *  @param[in,out]  data    A pointer to the mutable gateway data to
+ *                          unset, or remove, as the default route.
+ *  @param[in,out]  config  A pointer to the mutable gateway
+ *                          configuration to unset, or remove, as the
+ *                          default route.
+ *  @param[in]      type    The gateway configuration type that @a
+ *                          config is expected to be.
+ *  @param[in]      cb      The callback function used to unset, or
+ *                          remove, the default route.
+ *
+ *  @retval  0              If successful.
+ *  @retval  -EINVAL        If @a data, @a config, or @a cb are
+ *                          null; if the gateway configuration type is
+ *                          not @a type; or if the routing information
+ *                          to be unset, or cleared, was invalid.
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
+ *  @sa set_default_gateway_route_common
+ *
+ */
 static int unset_default_gateway_route_common(struct gateway_data *data,
 				struct gateway_config *config,
 				enum gateway_config_type type,
-- 
2.42.0

