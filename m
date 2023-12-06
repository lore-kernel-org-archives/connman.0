Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F12182C4
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A3E4F73147
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:00 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 221F07315A
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 06/90] connection: Document gateway configuration flags.
Date: Wed,  6 Dec 2023 15:49:29 -0800
Message-ID: <20231206235056.322578-7-gerickson@nuovations.com>
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

This adds documentation to the 'gateway_config_flags' enumeration.
---
 src/connection.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index b13403c4a673..17d3805cd5fd 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -38,8 +38,18 @@
 #define GATEWAY_DATA_DBG(description, data) \
 	gateway_data_debug(__func__, description, data)
 
+/**
+ *  Flags governing the state and use of a gateway configuration.
+ */
 enum gateway_config_flags {
+	/**
+	 *	Indicates there are no gateway configuration flags asserted.
+	 */
 	CONNMAN_GATEWAY_CONFIG_FLAG_NONE = 0,
+
+	/**
+	 *	Indicates whether the gateway configuration is part of a VPN.
+	 */
 	CONNMAN_GATEWAY_CONFIG_FLAG_VPN	 = 1U << 0
 };
 
@@ -72,6 +82,10 @@ enum gateway_config_state {
 };
 
 struct gateway_config {
+	/**
+	 *	A 32-bit flag bitfield governing the state and use of the
+	 *	configuration. See #gateway_config_flags.
+	 */
 	uint32_t flags;
 
 	/**
-- 
2.42.0

