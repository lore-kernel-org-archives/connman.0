Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DC36A
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D4E657312B
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:36 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 97BA973147
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:36 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 8/8] inet: Document IPv{4,6} host/network route functions with metric/priority.
Date: Thu, 14 Dec 2023 16:10:31 -0800
Message-ID: <20231215001032.2127527-9-gerickson@nuovations.com>
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

This adds documentation to the
'connman_inet_{add,del}_{,ipv6_}{host,network}_route_with_metric'
functions.
---
 src/inet.c | 338 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 338 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index 863d733078f6..2abd55ef75e9 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -1309,6 +1309,44 @@ static int inet_modify_ipv6_host_route(int cmd,
 				metric);
 }
 
+/**
+ *  @brief
+ *    Add an IPv4 host route with a route metric/priority.
+ *
+ *  This attempts to add an IPv4 host route to the kernel using a
+ *  Linux Route Netlink (rtnl) socket and protocol with the specified
+ *  attributes and route metric/priority.
+ *
+ *  @param[in]  index            The network interface index associated
+ *                               with the output network device for
+ *                               the route.
+ *  @param[in]  host             A pointer to an immutable null-
+ *                               terminated C string containing the
+ *                               IPv4 address, in text form, of the
+ *                               route host destination address.
+ *  @param[in]  gateway          An optional pointer to an immutable
+ *                               null-terminated C string containing
+ *                               the IPv4 address, in text form, of
+ *                               the route next hop gateway address.
+ *  @param[in]  metric           The routing priority metric for the
+ *                               route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a host is null; if @a index is invalid; if
+ *                    @a host or @a gateway, if present, do not
+ *                    contain a character string representing a valid
+ *                    network address in the AF_INET family; or if the
+ *                    routing information to be added was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    added was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to add routes.
+ *  @retval  -EEXIST  A request was made to add an existing routing
+ *                    entry.
+ *
+ *  @sa inet_modify_ipv4_host_route
+ *
+ */
 int connman_inet_add_host_route_with_metric(int index,
 				const char *host,
 				const char *gateway,
@@ -1325,6 +1363,44 @@ int connman_inet_add_host_route_with_metric(int index,
 				metric);
 }
 
+/**
+ *  @brief
+ *    Remove an IPv4 host route with a route metric/priority.
+ *
+ *  This attempts to remove an IPv4 host route from the kernel using a
+ *  Linux Route Netlink (rtnl) socket and protocol with the specified
+ *  attributes and route metric/priority.
+ *
+ *  @param[in]  index            The network interface index associated
+ *                               with the output network device for
+ *                               the route.
+ *  @param[in]  host             A pointer to an immutable null-
+ *                               terminated C string containing the
+ *                               IPv4 address, in text form, of the
+ *                               route host destination address.
+ *  @param[in]  gateway          An optional pointer to an immutable
+ *                               null-terminated C string containing
+ *                               the IPv4 address, in text form, of
+ *                               the route next hop gateway address.
+ *  @param[in]  metric           The routing priority metric for the
+ *                               route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a host is null; if @a index is invalid; if
+ *                    @a host or @a gateway, if present, do not
+ *                    contain a character string representing a valid
+ *                    network address in the AF_INET family; or if the
+ *                    routing information to be deleted was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    deleted was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to delete routes.
+ *  @retval  -ESRCH   A request was made to delete a non-existing
+ *                    routing entry.
+ *
+ *  @sa inet_modify_ipv4_host_route
+ *
+ */
 int connman_inet_del_host_route_with_metric(int index,
 				const char *host,
 				const char *gateway,
@@ -1341,6 +1417,52 @@ int connman_inet_del_host_route_with_metric(int index,
 				metric);
 }
 
+/**
+ *  @brief
+ *    Add an IPv4 network route with a route metric/priority.
+ *
+ *  This attempts to add an IPv4 network route to the kernel using a
+ *  Linux Route Netlink (rtnl) socket and protocol with the specified
+ *  attributes and route metric/priority.
+ *
+ *  @note
+ *    The caller may provide the IPv4 @a network address in masked
+ *    (that is, 169.254.0.0/16) or unmasked (169.254.75.191/16)
+ *    form. The function will mask the address, based on the prefix
+ *    length, before modifying the route with it.
+ *
+ *  @param[in]  index            The network interface index associated
+ *                               with the output network device for
+ *                               the route.
+ *  @param[in]  network          A pointer to an immutable null-
+ *                               terminated C string containing the
+ *                               IPv4 address, in text form, of the
+ *                               route network destination address.
+ *  @param[in]  gateway          An optional pointer to an immutable
+ *                               null-terminated C string containing
+ *                               the IPv4 address, in text form, of
+ *                               the route next hop gateway address.
+ *  @param[in]  prefixlen        The destination prefix length of the
+ *                               route.
+ *  @param[in]  metric           The routing priority metric for the
+ *                               route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a network is null; if @a index is invalid;
+ *                    if @a network or @a gateway, if present, do not
+ *                    contain a character string representing a valid
+ *                    network address in the AF_INET family; or if the
+ *                    routing information to be added was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    added was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to add routes.
+ *  @retval  -EEXIST  A request was made to add an existing routing
+ *                    entry.
+ *
+ *  @sa inet_modify_ipv4_network_route
+ *
+ */
 int connman_inet_add_network_route_with_metric(int index,
 				const char *network,
 				const char *gateway,
@@ -1359,6 +1481,52 @@ int connman_inet_add_network_route_with_metric(int index,
 				metric);
 }
 
+/**
+ *  @brief
+ *    Remove an IPv4 network route with a route metric/priority.
+ *
+ *  This attempts to add an IPv4 network route from the kernel using a
+ *  Linux Route Netlink (rtnl) socket and protocol with the specified
+ *  attributes and route metric/priority.
+ *
+ *  @note
+ *    The caller may provide the IPv4 @a network address in masked
+ *    (that is, 169.254.0.0/16) or unmasked (169.254.75.191/16)
+ *    form. The function will mask the address, based on the prefix
+ *    length, before modifying the route with it.
+ *
+ *  @param[in]  index            The network interface index associated
+ *                               with the output network device for
+ *                               the route.
+ *  @param[in]  network          A pointer to an immutable null-
+ *                               terminated C string containing the
+ *                               IPv4 address, in text form, of the
+ *                               route network destination address.
+ *  @param[in]  gateway          An optional pointer to an immutable
+ *                               null-terminated C string containing
+ *                               the IPv4 address, in text form, of
+ *                               the route next hop gateway address.
+ *  @param[in]  prefixlen        The destination prefix length of the
+ *                               route.
+ *  @param[in]  metric           The routing priority metric for the
+ *                               route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a network is null; if @a index is invalid;
+ *                    if @a network or @a gateway, if present, do not
+ *                    contain a character string representing a valid
+ *                    network address in the AF_INET family; or if the
+ *                    routing information to be deleted was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    deleted was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to add routes.
+ *  @retval  -ESRCH   A request was made to delete a non-existing
+ *                    routing entry.
+ *
+ *  @sa inet_modify_ipv4_network_route
+ *
+ */
 int connman_inet_del_network_route_with_metric(int index,
 				const char *network,
 				const char *gateway,
@@ -1530,6 +1698,44 @@ out:
 	return err;
 }
 
+/**
+ *  @brief
+ *    Add an IPv6 host route with a route metric/priority.
+ *
+ *  This attempts to add an IPv6 host route to the kernel using a
+ *  Linux Route Netlink (rtnl) socket and protocol with the specified
+ *  attributes and route metric/priority.
+ *
+ *  @param[in]  index            The network interface index associated
+ *                               with the output network device for
+ *                               the route.
+ *  @param[in]  host             A pointer to an immutable null-
+ *                               terminated C string containing the
+ *                               IPv6 address, in text form, of the
+ *                               route host destination address.
+ *  @param[in]  gateway          An optional pointer to an immutable
+ *                               null-terminated C string containing
+ *                               the IPv6 address, in text form, of
+ *                               the route next hop gateway address.
+ *  @param[in]  metric           The routing priority metric for the
+ *                               route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a host is null; if @a index is invalid; if
+ *                    @a host or @a gateway, if present, do not
+ *                    contain a character string representing a valid
+ *                    network address in the AF_INET family; or if the
+ *                    routing information to be added was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    added was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to add routes.
+ *  @retval  -EEXIST  A request was made to add an existing routing
+ *                    entry.
+ *
+ *  @sa inet_modify_ipv6_host_route
+ *
+ */
 int connman_inet_add_ipv6_host_route_with_metric(int index,
 				const char *host,
 				const char *gateway,
@@ -1546,6 +1752,44 @@ int connman_inet_add_ipv6_host_route_with_metric(int index,
 				metric);
 }
 
+/**
+ *  @brief
+ *    Remove an IPv6 host route with a route metric/priority.
+ *
+ *  This attempts to remove an IPv6 host route from the kernel using a
+ *  Linux Route Netlink (rtnl) socket and protocol with the specified
+ *  attributes and route metric/priority.
+ *
+ *  @param[in]  index            The network interface index associated
+ *                               with the output network device for
+ *                               the route.
+ *  @param[in]  host             A pointer to an immutable null-
+ *                               terminated C string containing the
+ *                               IPv6 address, in text form, of the
+ *                               route host destination address.
+ *  @param[in]  gateway          An optional pointer to an immutable
+ *                               null-terminated C string containing
+ *                               the IPv6 address, in text form, of
+ *                               the route next hop gateway address.
+ *  @param[in]  metric           The routing priority metric for the
+ *                               route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a host is null; if @a index is invalid; if
+ *                    @a host or @a gateway, if present, do not
+ *                    contain a character string representing a valid
+ *                    network address in the AF_INET family; or if the
+ *                    routing information to be deleted was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    deleted was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to delete routes.
+ *  @retval  -ESRCH   A request was made to delete a non-existing
+ *                    routing entry.
+ *
+ *  @sa inet_modify_ipv6_host_route
+ *
+ */
 int connman_inet_del_ipv6_host_route_with_metric(int index,
 				const char *host,
 				const char *gateway,
@@ -1562,6 +1806,53 @@ int connman_inet_del_ipv6_host_route_with_metric(int index,
 				metric);
 }
 
+/**
+ *  @brief
+ *    Add an IPv6 network route with a route metric/priority.
+ *
+ *  This attempts to add an IPv6 network route to the kernel using a
+ *  Linux Route Netlink (rtnl) socket and protocol with the specified
+ *  attributes and route metric/priority.
+ *
+ *  @note
+ *    The caller may provide the IPv6 @a network address in masked
+ *    (that is, 2601:647:5a00:1500::/56) or unmasked
+ *    (2601:647:5a00:15c1:230d:b2c9:c388:f96b/56) form. The function
+ *    will mask the address, based on the prefix length, before
+ *    modifying the route with it.
+ *
+ *  @param[in]  index            The network interface index associated
+ *                               with the output network device for
+ *                               the route.
+ *  @param[in]  network          A pointer to an immutable null-
+ *                               terminated C string containing the
+ *                               IPv6 address, in text form, of the
+ *                               route network destination address.
+ *  @param[in]  gateway          An optional pointer to an immutable
+ *                               null-terminated C string containing
+ *                               the IPv6 address, in text form, of
+ *                               the route next hop gateway address.
+ *  @param[in]  prefixlen        The destination prefix length of the
+ *                               route.
+ *  @param[in]  metric           The routing priority metric for the
+ *                               route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a network is null; if @a index is invalid;
+ *                    if @a network or @a gateway, if present, do not
+ *                    contain a character string representing a valid
+ *                    network address in the AF_INET family; or if the
+ *                    routing information to be added was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    added was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to add routes.
+ *  @retval  -EEXIST  A request was made to add an existing routing
+ *                    entry.
+ *
+ *  @sa inet_modify_ipv6_network_route
+ *
+ */
 int connman_inet_add_ipv6_network_route_with_metric(int index,
 				const char *network,
 				const char *gateway,
@@ -1580,6 +1871,53 @@ int connman_inet_add_ipv6_network_route_with_metric(int index,
 				metric);
 }
 
+/**
+ *  @brief
+ *    Remove an IPv6 network route with a route metric/priority.
+ *
+ *  This attempts to add an IPv6 network route from the kernel using a
+ *  Linux Route Netlink (rtnl) socket and protocol with the specified
+ *  attributes and route metric/priority.
+ *
+ *  @note
+ *    The caller may provide the IPv6 @a network address in masked
+ *    (that is, 2601:647:5a00:1500::/56) or unmasked
+ *    (2601:647:5a00:15c1:230d:b2c9:c388:f96b/56) form. The function
+ *    will mask the address, based on the prefix length, before
+ *    modifying the route with it.
+ *
+ *  @param[in]  index            The network interface index associated
+ *                               with the output network device for
+ *                               the route.
+ *  @param[in]  network          A pointer to an immutable null-
+ *                               terminated C string containing the
+ *                               IPv6 address, in text form, of the
+ *                               route network destination address.
+ *  @param[in]  gateway          An optional pointer to an immutable
+ *                               null-terminated C string containing
+ *                               the IPv6 address, in text form, of
+ *                               the route next hop gateway address.
+ *  @param[in]  prefixlen        The destination prefix length of the
+ *                               route.
+ *  @param[in]  metric           The routing priority metric for the
+ *                               route.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a network is null; if @a index is invalid;
+ *                    if @a network or @a gateway, if present, do not
+ *                    contain a character string representing a valid
+ *                    network address in the AF_INET family; or if the
+ *                    routing information to be deleted was invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    deleted was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to add routes.
+ *  @retval  -ESRCH   A request was made to delete a non-existing
+ *                    routing entry.
+ *
+ *  @sa inet_modify_ipv4_network_route
+ *
+ */
 int connman_inet_del_ipv6_network_route_with_metric(int index,
 				const char *network,
 				const char *gateway,
-- 
2.42.0

