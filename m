Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA60328D0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D340273146
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:10 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 961427314B
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:10 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 32/90] connection: Document 'mutate_default_gateway_route_cb_t'.
Date: Wed,  6 Dec 2023 15:49:55 -0800
Message-ID: <20231206235056.322578-33-gerickson@nuovations.com>
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

This adds documentation to the 'mutate_default_gateway_route_cb_t'
typedef.
---
 src/connection.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 1bcf16dee616..53563d057ab3 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -203,6 +203,23 @@ struct mutate_default_gateway_ops {
 				struct gateway_config *config);
 };
 
+/**
+ *  Prototype for a function callback to mutate (that is, add/set or
+ *  clear/delete/remove) a default route for a gateway using a function
+ *  utilizing a SIOCADDRT / SIOCDELRT socket ioctl or a RTM_NEWROUTE /
+ *  RTM_DELROUTE Linux Routing Netlink (rtnl) command to modify the Linux
+ *  routing table.
+ *
+ *  @param[in,out]  data    A pointer to the mutable gateway data to
+ *                          use to mutate the default route.
+ *  @param[in,out]  config  A pointer to the mutable gateway
+ *                          configuration to use to mutate the
+ *                          default route.
+ *
+ *  @returns
+ *    0 if successful; otherwise, < 0 on error.
+ *
+ */
 typedef int (*mutate_default_gateway_route_cb_t)(struct gateway_data *data,
 				struct gateway_config *config);
 
-- 
2.42.0

