Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946C328C0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 67CD973218
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:29 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 298A873207
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:29 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 77/90] connection: Document 'unset_ipv6_high_priority_default_gateway'.
Date: Wed,  6 Dec 2023 15:50:43 -0800
Message-ID: <20231206235056.322578-81-gerickson@nuovations.com>
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
'unset_ipv6_high_priority_default_gateway' function.
---
 src/connection.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index df5c4d158dad..62e9f3bc07f6 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2190,6 +2190,38 @@ static int unset_ipv4_high_priority_default_gateway(
 	return unset_default_gateway_route_common(data, config, type, cb);
 }
 
+/**
+ *  @brief
+ *    Unset, or clear, the IPv6 high-priority default route for the
+ *    specified gateway data and configuration.
+ *
+ *  This attempts to unset, or clear, the IPv6 high-priority (that is,
+ *  metric 0) default route from the provided gateway data and
+ *  configuration.
+ *
+ *  @param[in,out]  data    A pointer to the mutable gateway data to
+ *                          use to unset, or remove, the IPv6
+ *                          high-priority default route.
+ *  @param[in,out]  config  A pointer to the mutable gateway
+ *                          configuration to use to unset, or remove,
+ *                          the IPv6 high-priority default route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a data or @a config are null; or if
+ *                    the routing information to be unset, or
+ *                    removed, was invalid.
+ *  @retval  -EFAULT  If the address to the routing information
+ *                    to be unset, or cleared, was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to unset, or
+ *                    clear, routes.
+ *  @retval  -ESRCH   A request was made to unset, or clear a
+ *                    non-existing routing entry.
+ *
+ *  @sa unset_default_gateway_route_common
+ *  @sa unset_ipv6_high_priority_default_gateway_route_cb
+ *
+ */
 static int unset_ipv6_high_priority_default_gateway(
 				struct gateway_data *data,
 				struct gateway_config *config)
-- 
2.42.0

