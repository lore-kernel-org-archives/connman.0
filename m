Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCF328B6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id F131773219
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:30 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AD15573202
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:30 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 81/90] connection: Document 'unset_ipv4_low_priority_default_gateway_route_cb'.
Date: Wed,  6 Dec 2023 15:50:47 -0800
Message-ID: <20231206235056.322578-85-gerickson@nuovations.com>
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
'unset_ipv4_low_priority_default_gateway_route_cb' function.
---
 src/connection.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 5740e4522d1a..0a7d9c919452 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2490,6 +2490,41 @@ static int set_low_priority_default_gateway(struct gateway_data *data,
 	return mutate_default_gateway(data, type, &ops, __func__);
 }
 
+/**
+ *  @brief
+ *    Unset, or remove, the IPv4 low-priority default route for the
+ *    specified gateway data and configuration using a function
+ *    utilizing a SIOCDELRT socket ioctl or a RTM_DELROUTE Linux
+ *    Routing Netlink (rtnl) command.
+ *
+ *  This attempts to unset, or remove, the IPv4 low-priority (that
+ *  is, metric > 0) default route for the specified gateway data and
+ *  configuration using a function utilizing a SIOCDELRT socket ioctl
+ *  or a RTM_DELROUTE Linux Routing Netlink (rtnl) command to modify
+ *  the Linux routing table.
+ *
+ *  @param[in,out]  data    A pointer to the mutable gateway data to
+ *                          use to unset, or remove, the IPv4
+ *                          low-priority default route.
+ *  @param[in,out]  config  A pointer to the mutable gateway
+ *                          configuration to use to unset, or remove,
+ *                          the IPv4 low-priority default route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a data or @a config are null; or if
+ *                    the routing information to be set, or
+ *                    added, was invalid.
+ *  @retval  -EFAULT  If the address to the routing information
+ *                    to be set, or added, was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to set, or
+ *                    add, routes.
+ *  @retval  -ESRCH   A request was made to delete a non-existing
+ *                    routing entry.
+ *
+ *  @sa __connman_inet_del_default_from_table_with_metric;
+ *
+ */
 static int unset_ipv4_low_priority_default_gateway_route_cb(
 				struct gateway_data *data,
 				struct gateway_config *config)
-- 
2.42.0

