Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF023328B6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4E25773204
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:33 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 117B573227
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:33 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 87/90] connection: Update '{un,}set_default_gateway' documentation.
Date: Wed,  6 Dec 2023 15:50:53 -0800
Message-ID: <20231206235056.322578-91-gerickson@nuovations.com>
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

This updates the '{un,}set_default_gateway' function documentation to
reflect changes due to adding support for both high- and low-priority
default gateway routes.
---
 src/connection.c | 92 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 28 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index a7b2777f53f4..8f745a4387bb 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1949,33 +1949,52 @@ static int set_ipv6_high_priority_default_gateway(struct gateway_data *data,
 
 /**
  *  @brief
- *    Set, or assign, the gateway, or default route, for the specified
- *    IP configuration type from the provided gateway data.
+ *    Set, or add, the gateway high-priority default route for the
+ *    specified IP configuration type from the provided gateway data.
  *
- *  This attempts to set, or assign, the gateway, or default, route
- *  for the specified IP configuration type from the provided gateway
- *  data. The network interface and, by extension, the network service
- *  with which the gateway is associated is determined by the @a index
- *  field of @a data.
+ *  This attempts to set, or add, the high-priority (that is,
+ *  metric 0) default route for the specified IP configuration type
+ *  from the provided gateway data. The network interface and, by
+ *  extension, the network service with which the gateway is
+ *  associated is determined by the @a index field of @a data.
  *
- *  On success, the gateway configuration specific to @a type will
- *  have its @a active field set to true and the gateway data network
- *  service @a service will be signaled as the default via
- *  #__connman_service_indicate_default.
+ *  On success, the gateway configuration state and type specific to
+ *  @a type will be set to #CONNMAN_GATEWAY_CONFIG_STATE_ADDED and
+ *  #CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT, respectively,
+ *  and the gateway data network service @a service will be signaled
+ *  as the default via #__connman_service_indicate_default.
  *
  *  @param[in,out]  data      A pointer to the mutable gateway data
- *                            to assign as the default route.
+ *                            to assign as the high-priority default
+ *                            route.
  *  @param[in]      type      The IP configuration type for which the
  *                            gateway, or default router,
  *                            configuration will be selected from @a
- *                            data and used to set the default route.
+ *                            data and used to set the high-priority
+ *                            default route.
  *  @param[in]      function  A pointer to an immutable null-terminated
  *                            C string containing the function name to
  *                            which the call to this function should
  *                            be attributed.
  *
- * @returns
- *   0 if successful; otherwise, < 0 on error.
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
  *
  *  @sa mutate_default_gateway
  *  @sa set_ipv4_high_priority_default_gateway
@@ -2242,32 +2261,49 @@ static int unset_ipv6_high_priority_default_gateway(
 
 /**
  *  @brief
- *    Unset the gateway, or default route, for the specified IP
+ *    Unset the high-priority default route for the specified IP
  *    configuration type from the provided gateway data.
  *
- *  This attempts to unset, or clear, the gateway, or default, route
- *  for the specified IP configuration type from the provided gateway
- *  data. The network interface and, by extension, the network service
- *  with which the gateway is associated is determined by the @a index
- *  field of @a data.
+ *  This attempts to unset, or clear, the high-priority (that is,
+ *  metric 0) default route for the specified IP configuration type
+ *  from the provided gateway data. The network interface and, by
+ *  extension, the network service with which the gateway is
+ *  associated is determined by the @a index field of @a data.
  *
- *  On success, the gateway configuration specific to @a type will
- *  have its @a active field set to false.
+ *  On success, the gateway configuration state specific to @a type
+ *  will be set to #CONNMAN_GATEWAY_CONFIG_STATE_REMOVED.
  *
  *  @param[in,out]  data      A pointer to the mutable gateway data
- *                            to clear as the default route.
+ *                            to clear as the high-priority default
+ *                            route.
  *  @param[in]      type      The IP configuration type for which
  *                            the gateway, or default router,
  *                            configuration will be selected from @a
- *                            data and used to unset the default route.
+ *                            data and used to unset the high-priority
+ *                            default route.
  *  @param[in]      function  A pointer to an immutable null-terminated
  *                            C string containing the function name to
  *                            which the call to this function should
  *                            be attributed.
  *
- *
- * @returns
- *   0 if successful; otherwise, < 0 on error.
+ *  @retval  0              If successful.
+ *  @retval  -EINVAL        If @a data is null, if @a type is invalid,
+ *                          if the gateway configuration type is not
+ *                          type
+ *                          #CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT,
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
  *
  *  @sa mutate_default_gateway
  *  @sa unset_ipv4_default_gateway
-- 
2.42.0

