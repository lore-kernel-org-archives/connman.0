Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083C14001
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id EEE927311A
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:07 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B05B273144
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/9] inet: Document 'connman_inet_{add,del}_{,ipv6_}host_route'.
Date: Sat, 16 Dec 2023 00:27:59 -0800
Message-ID: <20231216082805.2221938-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231216082805.2221938-1-gerickson@nuovations.com>
References: <20231216082805.2221938-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the
'connman_inet_{add,del}_{,ipv6_}host_route' functions.
---
 src/inet.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index 55684dc2fd65..e0f927a12dcb 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -1545,6 +1545,42 @@ int connman_inet_del_network_route_with_metric(int index,
 				metric);
 }
 
+/**
+ *  @brief
+ *    Add an IPv4 host route.
+ *
+ *  This attempts to add an IPv4 host route to the kernel with the
+ *  specified attributes.
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
+ *  @sa connman_inet_del_host_route
+ *  @sa connman_inet_add_ipv6_host_route
+ *
+ */
 int connman_inet_add_host_route(int index,
 				const char *host,
 				const char *gateway)
@@ -1552,6 +1588,42 @@ int connman_inet_add_host_route(int index,
 	return connman_inet_add_network_route(index, host, gateway, NULL);
 }
 
+/**
+ *  @brief
+ *    Delete an IPv4 host route.
+ *
+ *  This attempts to delete an IPv4 host route to the kernel with the
+ *  specified attributes.
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
+ *  @sa connman_inet_add_host_route
+ *  @sa connman_inet_del_ipv6_host_route
+ *
+ */
 int connman_inet_del_host_route(int index,
 				const char *host,
 				const char *gateway)
@@ -1951,6 +2023,42 @@ int connman_inet_del_ipv6_network_route_with_metric(int index,
 				metric);
 }
 
+/**
+ *  @brief
+ *    Add an IPv6 host route.
+ *
+ *  This attempts to add an IPv6 host route to the kernel with the
+ *  specified attributes.
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
+ *  @sa connman_inet_add_host_route
+ *  @sa connman_inet_del_ipv6_host_route
+ *
+ */
 int connman_inet_add_ipv6_host_route(int index,
 				const char *host,
 				const char *gateway)
@@ -1958,6 +2066,42 @@ int connman_inet_add_ipv6_host_route(int index,
 	return connman_inet_add_ipv6_network_route(index, host, gateway, 128);
 }
 
+/**
+ *  @brief
+ *    Delete an IPv6 host route.
+ *
+ *  This attempts to delete an IPv6 host route to the kernel with the
+ *  specified attributes.
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
+ *  @sa connman_inet_add_ipv6_host_route
+ *  @sa connman_inet_del_host_route
+ *
+ */
 int connman_inet_del_ipv6_host_route(int index,
 				const char *host,
 				const char *gateway)
-- 
2.42.0

