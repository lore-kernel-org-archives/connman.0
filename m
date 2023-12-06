Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505D328C2
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5743D73206
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:26 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1AA2D73226
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:26 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 69/90] connection: Document 'promote_default_gateway'.
Date: Wed,  6 Dec 2023 15:50:35 -0800
Message-ID: <20231206235056.322578-73-gerickson@nuovations.com>
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

This adds documentation to the 'promote_default_gateway' function.
---
 src/connection.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 17aa4e7a7562..4fa2218def11 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2200,6 +2200,56 @@ static int demote_default_gateway(struct gateway_data *data,
 	return (unset_status == 0 ? unset_status : set_status);
 }
 
+/**
+ *  @brief
+ *    Promote, from low- to high-priority, the default route
+ *    associated with the specified gateway data and IP configuration
+ *    type.
+ *
+ *  This attempts to promote, from low- (that is, metric > 0) to high-
+ *  (that is, metric 0) priority, the default route associated with
+ *  the specified gateway data and IP configuration type.
+ *
+ *  @param[in,out]  data      The gateway data associated with the
+ *                            default route for which the priority is
+ *                            to be promoted.
+ *  @param[in]      type      The IP configuration type for which
+ *                            the gateway, or default router, is to be
+ *                            promoted.
+ *  @param[in]      function  A pointer to an immutable null-terminated
+ *                            C string containing the function name to
+ *                            which the call to this function should be
+ *                            attributed.
+ *
+ *  @retval  0              If successful.
+ *  @retval  -EINVAL        If @a data is null, if @a type is
+ *                          #CONNMAN_IPCONFIG_TYPE_UNKNOWN, if the
+ *                          gateway configuration type is invalid; or
+ *                          if the routing information to be added or
+ *                          deleted was invalid.
+ *  @retval  -EINPROGRESS   If the state of the gateway configuration
+ *                          for @a data is already
+ *                          #CONNMAN_GATEWAY_CONFIG_STATE_ADDED or
+ *                          #CONNMAN_GATEWAY_CONFIG_STATE_REMOVED.
+ *  @retval  -EALREADY      If the state of the gateway configuration
+ *                          for @a data is already
+ *                          #CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE or
+ *                          #CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE.
+ *  @retval  -EFAULT        If the address to the routing information
+ *                          to be added or deleted was invalid.
+ *  @retval  -EPERM         If the current process does not have the
+ *                          credentials or capabilities to add or
+ *                          delete routes.
+ *  @retval  -EEXIST        A request was made to add an existing
+ *                          routing entry.
+ *  @retval  -ESRCH         A request was made to delete a non-
+ *                          existing routing entry.
+ *
+ *  @sa set_default_gateway
+ *  @sa unset_low_priority_default_gateway
+ *  @sa demote_default_gateway
+ *
+ */
 static int promote_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type,
 				const char *function)
-- 
2.42.0

