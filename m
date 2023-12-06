Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7A328C1
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8FA8473204
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:30 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5047D73226
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:30 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 80/90] connection: Document 'set_low_priority_default_gateway'.
Date: Wed,  6 Dec 2023 15:50:46 -0800
Message-ID: <20231206235056.322578-84-gerickson@nuovations.com>
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

This adds documentation to the 'set_low_priority_default_gateway'
function.
---
 src/connection.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 84b3bb1c80bf..5740e4522d1a 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2444,6 +2444,38 @@ static int set_ipv4_low_priority_default_gateway(
 	return set_default_gateway_route_common(data, config, type, cb);
 }
 
+/**
+ *  @brief
+ *    Set, or add, the gateway low-priority default route for the
+ *    specified IP configuration type from the provided gateway data.
+ *
+ *  This attempts to set, or add, the low-priority (that is, metric
+ *  > 0) default route for the specified IP configuration type from
+ *  the provided gateway data. The network interface and, by
+ *  extension, the network service with which the gateway is
+ *  associated is determined by the @a index field of @a data.
+ *
+ *  On success, the gateway configuration state and type specific to
+ *  @a type will be set to #CONNMAN_GATEWAY_CONFIG_STATE_ADDED and
+ *  #CONNMAN_GATEWAY_CONFIG_TYPE_LOW_PRIORITY_DEFAULT, respectively.
+ *
+ *  @param[in,out]  data      A pointer to the mutable gateway data
+ *                            to assign as the low-priority default
+ *                            route.
+ *  @param[in]      type      The IP configuration type for which the
+ *                            gateway, or default router,
+ *                            configuration will be selected from @a
+ *                            data and used to set the low-priority
+ *                            default route.
+ *  @param[in]      function  A pointer to an immutable null-terminated
+ *                            C string containing the function name to
+ *                            which the call to this function should
+ *                            be attributed.
+ *
+ *  @sa mutate_default_gateway
+ *  @sa set_ipv4_low_priority_default_gateway
+ *
+ */
 static int set_low_priority_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type,
 				const char *function)
-- 
2.42.0

