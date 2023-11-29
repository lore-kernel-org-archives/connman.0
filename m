Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43743DF47
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 06:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4E14073122
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:21:12 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 0188973150
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:21:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/3] connection: Document 'del_gateway_routes{,_if_active}'.
Date: Tue, 28 Nov 2023 22:21:09 -0800
Message-ID: <20231129062109.1270106-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129062109.1270106-1-gerickson@nuovations.com>
References: <20231129062109.1270106-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'del_gateway_routes{,_if_active}'
functions.
---
 src/connection.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 23adf570120a..ce38f35d68c7 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -567,6 +567,46 @@ static void set_vpn_routes(struct gateway_data *new_gateway,
 	}
 }
 
+/**
+ *  @brief
+ *    Delete all gateway, or default router, default or host routes
+ *    for the gateway data.
+ *
+ *  This attempts to delete, or remove, all gateway, or default
+ *  router, default or host routes associated with the specified
+ *  gateway data.
+ *
+ *  @note
+ *    Deletions or removals are restricted to the network * interface
+ *    associated with the network interface index specified by * the
+ *    @a data @a index field.
+ *
+ *  @param[in]  data  A pointer to the mutable gateway data for which
+ *                    to delete or remove all gateway, or default
+ *                    router, default or host routes.
+ *  @param[in]  type  The IP configuration type for which the gateway,
+ *                    or default router, default or host routes are to
+ *                    be deleted or removed.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to delete routes.
+ *  @retval  -EINVAL  If the routing information to be deleted was
+ *                    invalid.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    deleted was invalid.
+ *  @retval  -ESRCH   A request was made to delete a non-existing
+ *                    routing entry.
+ *
+ *  @sa connman_inet_clear_gateway_address
+ *  @sa connman_inet_clear_gateway_interface
+ *  @sa connman_inet_clear_ipv6_gateway_address
+ *  @sa connman_inet_clear_ipv6_gateway_interface
+ *  @sa connman_inet_del_host_route
+ *  @sa connman_inet_del_ipv6_host_route
+ *  @sa del_gateway_routes_if_active
+ *
+ */
 static int del_gateway_routes(struct gateway_data *data,
 			enum connman_ipconfig_type type)
 {
@@ -621,6 +661,43 @@ static int del_gateway_routes(struct gateway_data *data,
 	return (status4 < 0 ? status4 : status6);
 }
 
+/**
+ *  @brief
+ *    Delete all gateway, or default router, default or host routes
+ *    for the gateway data, if they are active.
+ *
+ *  This attempts to delete, or remove, all gateway, or default
+ *  router, default or host routes associated with the specified
+ *  gateway data, if the corresponding gateway configuration for the
+ *  specified type, @a type, is marked as active.
+ *
+ *  @note
+ *    Deletions or removals are restricted to the network interface
+ *    associated with the network interface index specified by the
+ *    @a data @a index field.
+ *
+ *  @param[in]  data  A pointer to the mutable gateway data for which
+ *                    to delete or remove all gateway, or default
+ *                    router, default or host routes, if they are
+ *                    active.
+ *  @param[in]  type  The IP configuration type for which the gateway,
+ *                    or default router, default or host routes are to
+ *                    be deleted or removed.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If data is null, if type is
+ *                    #CONNMAN_IPCONFIG_TYPE_UNKNOWN, if the routing
+ *                    information to be deleted was invalid.
+ *  @retval  -EPERM   If the current process does not have the
+ *                    credentials or capabilities to delete routes.
+ *  @retval  -EFAULT  If the address to the routing information to be
+ *                    deleted was invalid.
+ *  @retval  -ESRCH   A request was made to delete a non-existing
+ *                    routing entry.
+ *
+ *  @sa del_gateway_routes
+ *
+ */
 static int del_gateway_routes_if_active(struct gateway_data *data,
 			enum connman_ipconfig_type type)
 {
-- 
2.42.0

