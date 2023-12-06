Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD5328B6
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9ED8673214
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:28 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 61E247322E
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:28 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 75/90] connection: Document 'unset_ipv6_high_priority_default_gateway_route_cb'.
Date: Wed,  6 Dec 2023 15:50:41 -0800
Message-ID: <20231206235056.322578-79-gerickson@nuovations.com>
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
'unset_ipv6_high_priority_default_gateway_route_cb' function.
---
 src/connection.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index e890877f21b0..4aaffbf7e5c3 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2072,6 +2072,42 @@ done:
 	return err;
 }
 
+/**
+ *  @brief
+ *    Unset, or remove, the IPv6 high-priority default route for the
+ *    specified gateway data and configuration using a function
+ *    utilizing a SIOCDELRT socket ioctl or a RTM_DELROUTE Linux
+ *    Routing Netlink (rtnl) command.
+ *
+ *  This attempts to unset, or remove, the IPv6 high-priority (that
+ *  is, metric 0) default route for the specified gateway data and
+ *  configuration using a function utilizing a SIOCDELRT socket ioctl
+ *  or a RTM_DELROUTE Linux Routing Netlink (rtnl) command to modify
+ *  the Linux routing table.
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
+ *                    to be set, or added, was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to set, or
+ *                    add, routes.
+ *  @retval  -ESRCH   A request was made to delete a non-existing
+ *                    routing entry.
+ *
+ *  @sa connman_inet_clear_ipv6_gateway_interface
+ *  @sa connman_inet_clear_ipv6_gateway_address
+ *
+ */
 static int unset_ipv6_high_priority_default_gateway_route_cb(
 				struct gateway_data *data,
 				struct gateway_config *config)
-- 
2.42.0

