Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E481328C0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 96A1C73146
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:50:59 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 59AE673150
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:50:59 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 04/90] connection: Document gateway configuration state.
Date: Wed,  6 Dec 2023 15:49:27 -0800
Message-ID: <20231206235056.322578-5-gerickson@nuovations.com>
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

This adds documentation to the 'gateway_config_state' enumeration.
---
 src/connection.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 6c735f761a54..63c22be0cf83 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -38,12 +38,40 @@
 #define GATEWAY_DATA_DBG(description, data) \
 	gateway_data_debug(__func__, description, data)
 
+/**
+ *	@brief
+ *    Indicates the current lifecycle state of the gateway
+ *    configuration.
+ *
+ *  Gateway lifecycle is generally top-down, from user space to
+ *  kernel. That is, Connection Manager manages and adds/sets or
+ *  gateway routes and then uses notifications from the kernel Routing
+ *  Netlink (rtnl) to confirm and "activate" those routes. Likewise,
+ *  Connection Manager removes/clears/deletes gateway routes an then
+ *  uses notifications from the kernel Routing Netlink (rtnl) to
+ *  confirm and "inactivate" those routes.
+ *
+ */
 enum gateway_config_state {
+	/**
+	 *	Indicates whether the gateway, or default router, is inactive.
+	 */
 	CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE = 0,
+
+	/**
+	 *	Indicates whether the gateway, or default router, is added and
+	 *	acknowledged by the kernel through a Routing Netlink (rtnl)
+	 *	notification and, consequently, is active (that is, in use).
+	 */
 	CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE	  = 1
 };
 
 struct gateway_config {
+
+	/**
+	 *	Indicates the current state of the gateway configuration. See
+	 *	#gateway_config_state.
+	 */
 	enum gateway_config_state state;
 	char *gateway;
 
-- 
2.42.0

