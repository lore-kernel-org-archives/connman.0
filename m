Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4C92FE0D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3BC0773147
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:11 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id F2C037315D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:10 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 33/90] connection: Document 'set_default_gateway_route_common'.
Date: Wed,  6 Dec 2023 15:49:56 -0800
Message-ID: <20231206235056.322578-34-gerickson@nuovations.com>
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

This adds documentation to the 'set_default_gateway_route_common'
function.
---
 src/connection.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 53563d057ab3..6dcb93f887ca 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1274,6 +1274,51 @@ static int mutate_default_gateway(struct gateway_data *data,
 	return (status4 < 0 ? status4 : status6);
 }
 
+/**
+ *  @brief
+ *    Set, or add, the default route, for the specified gateway data
+ *    and configuration using the provided gateway configuration type
+ *    and callback function.
+ *
+ *  This attempts to set, or add, the default route for the specified
+ *  gateway data and configuration using the provided gateway
+ *  configuration type and callback function.
+ *
+ *  On success, the gateway configuration type will be set to @a type
+ *  and its state to #CONNMAN_GATEWAY_CONFIG_STATE_ADDED.
+ *
+ *  @param[in,out]  data    A pointer to the mutable gateway data to
+ *                          set, or add, as the default route.
+ *  @param[in,out]  config  A pointer to the mutable gateway
+ *                          configuration to set, or add, as the
+ *                          default route.
+ *  @param[in]      type    The gateway configuration type that will
+ *                          be assigned to @a config on success.
+ *  @param[in]      cb      The callback function used to set, or
+ *                          add, the default route.
+ *
+ *  @retval  0              If successful.
+ *  @retval  -EINVAL        If @a data, @a config, or @a cb are
+ *                          null; if the gateway configuration type is
+ *                          not #CONNMAN_GATEWAY_CONFIG_TYPE_NONE or
+ *                          @a type; or if the routing information to
+ *                          be set, or added, was invalid.
+ *  @retval  -EINPROGRESS   If the state of @a config is
+ *                          #CONNMAN_GATEWAY_CONFIG_STATE_ADDED.
+ *  @retval  -EALREADY      If the state of @a config is
+ *                          #CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE.
+ *  @retval  -EFAULT        If the address to the routing information
+ *                          to be set, or added, was invalid.
+ *  @retval  -EPERM         If the current process does not have the
+ *                          credentials or capabilities to set, or
+ *                          add, routes.
+ *  @retval  -EEXIST        A request was made to add an existing
+ *                          routing entry.
+ *
+ *  @sa gateway_config_type_set
+ *  @sa unset_default_gateway_route_common
+ *
+ */
 static int set_default_gateway_route_common(struct gateway_data *data,
 				struct gateway_config *config,
 				enum gateway_config_type type,
-- 
2.42.0

