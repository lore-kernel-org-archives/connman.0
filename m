Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE392328C7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 83B997314B
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:01 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 451117315D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:01 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 08/90] connection: Document 'gateway_config_type'.
Date: Wed,  6 Dec 2023 15:49:31 -0800
Message-ID: <20231206235056.322578-9-gerickson@nuovations.com>
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

This adds documentation to the 'gateway_config_type' enumeration.
---
 src/connection.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index bcecd886b85b..1f5997786c13 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -81,8 +81,20 @@ enum gateway_config_state {
 	CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE	  = 1
 };
 
+/**
+ *	Indicates the current type or use of the gateway configuration.
+ */
 enum gateway_config_type {
+	/**
+	 *	Indicates the gateway, or default router, is not used for any
+	 *	route.
+	 */
 	CONNMAN_GATEWAY_CONFIG_TYPE_NONE				  = 0,
+
+	/**
+	 *	Indicates the gateway, or default router, is a high-priority
+	 *	(that is, metric 0) default route.
+	 */
 	CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT = 1
 };
 
@@ -98,6 +110,11 @@ struct gateway_config {
 	 *	#gateway_config_state.
 	 */
 	enum gateway_config_state state;
+
+	/**
+	 *	Indicates the current type or use of the gateway configuration.
+	 *	See #gateway_config_type.
+	 */
 	enum gateway_config_type type;
 	char *gateway;
 
-- 
2.42.0

