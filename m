Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314D328CD
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2B89E73203
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:25 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E274673219
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:24 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 66/90] connection: Document 'add_host_route'.
Date: Wed,  6 Dec 2023 15:50:32 -0800
Message-ID: <20231206235056.322578-70-gerickson@nuovations.com>
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

This adds documentation to the 'add_host_route' function.
---
 src/connection.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index b2b5f01867b9..90e6f9f9d6be 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2591,6 +2591,29 @@ static struct connman_rtnl connection_rtnl = {
 	.delgateway	= connection_delgateway,
 };
 
+/**
+ *  @brief
+ *    Add, or set, a host route for the specified IP configuration
+ *    type for the provided gateway data.
+ *
+ *  This attempts to add, or set, a host route (that is, the RTF_HOST
+ *  flag is asserted on the route) for the specified IP configuration
+ *  type for the provided gateway data.
+ *
+ *  @param[in]  data           A pointer to the mutable gateway data
+ *                             for which to add a host route.
+ *  @param[in]  ipconfig_type  The IP configuration type for which the
+ *                             gateway host route(s) are to be added.
+ *  @param[in]  service_type   The service type for the network service
+ *                             associated with @a index for which the
+ *                             host route is being added.
+ *
+ *  @sa connman_inet_add_host_route
+ *  @sa connman_inet_add_ipv6_host_route
+ *  @sa connman_inet_get_dest_addr
+ *  @sa connman_inet_ipv6_get_dest_addr
+ *
+ */
 static void add_host_route(struct gateway_data *data,
 			enum connman_ipconfig_type ipconfig_type,
 			enum connman_service_type service_type)
-- 
2.42.0

