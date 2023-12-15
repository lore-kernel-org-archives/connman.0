Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B086B363
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1AB877310B
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:36 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CFFFA7312C
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:35 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 6/8] connection: Document 'inet_modify_host_or_network_route'.
Date: Thu, 14 Dec 2023 16:10:29 -0800
Message-ID: <20231215001032.2127527-7-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215001032.2127527-1-gerickson@nuovations.com>
References: <20231215001032.2127527-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'inet_modify_host_or_network_route'
function.
---
 src/inet.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index ca999fa31633..873da5f73396 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -703,6 +703,67 @@ static int inet_mask_addr_data(size_t addr_len,
 	return 0;
 }
 
+/**
+ *  @brief
+ *    Add or remove a host or network route.
+ *
+ *  This attempts to add or remove a host or network route to or from
+ *  the kernel using a Linux Route Netlink (rtnl) socket and protocol
+ *  with the specified attributes.
+ *
+ *  @note
+ *    The caller may provide the IPv4 or IPv6 @a host_or_network
+ *    address in masked (that is, 169.254.0.0/16) or unmasked
+ *    (169.254.75.191/16) form. The function will mask the address,
+ *    based on the prefix length, before modifying the route with it.
+ *
+ *  @param[in]  cmd              The Linux Route Netlink command to
+ *                               send. This is expected to be either
+ *                               RTM_NEWROUTE (add new route) or
+ *                               RTM_DELROUTE (delete existing route).
+ *  @param[in]  family           The address family associated with @a
+ *                               host_or_network and @a gateway, if
+ *                               present.
+ *  @param[in]  index            The network interface index associated
+ *                               with the output network device for
+ *                               the route.
+ *  @param[in]  host_or_network  A pointer to an immutable null-
+ *                               terminated C string containing the
+ *                               IPv4 or IPv6 address, in text form,
+ *                               of the route host or network
+ *                               destination address.
+ *  @param[in]  gateway          An optional pointer to an immutable
+ *                               null-terminated C string containing
+ *                               the IPv4 or IPv6 address, in text
+ *                               form, of the route next hop gateway
+ *                               address.
+ *  @param[in]  prefixlen        The destination prefix length of the
+ *                               route.
+ *  @param[in]  table_id         The table to add/delete this route
+ *                               to/from.
+ *  @param[in]  metric           The routing priority metric for the
+ *                               route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a host_or_network is null; if @a index is
+ *                    invalid; if the address family of @a family was
+ *                    not AF_INET (IPv4) or AF_INET6 (IPv6); if @a
+ *                    host_or_network or @a gateway, if present, do
+ *                    not contain a character string representing a
+ *                    valid network address in either the AF_INET or
+ *                    AF_INET6 family; or if the routing information
+ *                    to be added or deleted was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    added or deleted was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to add or delete
+ *                    routes.
+ *  @retval  -EEXIST  A request was made to add an existing routing
+ *                    entry.
+ *  @retval  -ESRCH   A request was made to delete a non-existing
+ *                    routing entry.
+ *
+ */
 static int inet_modify_host_or_network_route(int cmd,
 					int family,
 					int index,
-- 
2.42.0

