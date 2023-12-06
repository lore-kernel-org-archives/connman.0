Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC072328C1
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5A92E73203
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:19 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1897D7321E
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:19 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 51/90] inet: Document '__connman_inet_{add,del}_default_{to,from}_table_with_metric'.
Date: Wed,  6 Dec 2023 15:50:17 -0800
Message-ID: <20231206235056.322578-55-gerickson@nuovations.com>
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

From: Grant Erickson <erick205@umn.edu>

This adds documentation to the
'__connman_inet_{add,del}_default_{to,from}_table_with_metric' functions.
---
 src/inet.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index 3270a854eb6b..31596a76a140 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -3382,6 +3382,39 @@ int __connman_inet_add_default_to_table(uint32_t table_id, int ifindex,
 		gateway, prefixlen);
 }
 
+/**
+ *  @brief
+ *    Add a gateway default route with metric/priority.
+ *
+ *  This attempts to add a gateway default route to the kernel routing
+ *  table, @a table_id, using a Linux Route Netlink (rtnl) socket and
+ *  protocol with the specified attributes, including an explicit
+ *  metric/prioity from the range [0, UINT32_MAX].
+ *
+ *  @param[in]  table_id   The table to add this route to.
+ *  @param[in]  ifindex    The network interface index associated with
+ *                         the output network device for the route.
+ *  @param[in]  gateway    A pointer to an immutable null-terminated C
+ *                         string containing the IPv4 or IPv6 address,
+ *                         in text form, of the route destination or
+ *                         next hop gateway address.
+ *  @param[in]  metric     The routing priority metric for the route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If the address family of @a gateway was not AF_INET
+ *                    (IPv4) or AF_INET6 (IPv6), if @a gateway does not
+ *                    contain a character string representing a valid
+ *                    network address in either the AF_INET or
+ *                    AF_INET6 family, or if the routing information
+ *                    to be deleted was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    deleted was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to delete routes.
+ *  @retval  -EEXIST  A request was made to add an existing routing
+ *                    entry.
+ *
+ */
 int __connman_inet_add_default_to_table_with_metric(uint32_t table_id,
 						int ifindex,
 						const char *gateway,
@@ -3453,6 +3486,39 @@ int __connman_inet_del_default_from_table(uint32_t table_id, int ifindex,
 		gateway, prefixlen);
 }
 
+/**
+ *  @brief
+ *    Delete a gateway default route with metric/priority.
+ *
+ *  This attempts to delete a gateway default route from the kernel
+ *  routing table, @a table_id, using a Linux Route Netlink (rtnl)
+ *  socket and protocol with the specified attributes, including an
+ *  explicit metric/prioity from the range [0, UINT32_MAX].
+ *
+ *  @param[in]  table_id   The table to delete this route from.
+ *  @param[in]  ifindex    The network interface index associated with
+ *                         the output network device for the route.
+ *  @param[in]  gateway    A pointer to an immutable null-terminated C
+ *                         string containing the IPv4 or IPv6 address,
+ *                         in text form, of the route destination or
+ *                         next hop gateway address.
+ *  @param[in]  metric     The routing priority metric for the route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If the address family of @a gateway was not AF_INET
+ *                    (IPv4) or AF_INET6 (IPv6), if @a gateway does not
+ *                    contain a character string representing a valid
+ *                    network address in either the AF_INET or
+ *                    AF_INET6 family, or if the routing information
+ *                    to be deleted was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    deleted was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to delete routes.
+ *  @retval  -ESRCH   A request was made to delete a non-existing
+ *                    routing entry.
+ *
+ */
 int __connman_inet_del_default_from_table_with_metric(uint32_t table_id,
 						int ifindex,
 						const char *gateway,
-- 
2.42.0

