Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD075DF3D
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id AC8E073232
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:21:11 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 643957324A
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:21:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 8/8] connection: Document '__connman_connection_update_gateway'.
Date: Wed, 29 Nov 2023 11:21:06 -0800
Message-ID: <20231129192106.1295868-9-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129192106.1295868-1-gerickson@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
 <20231129192106.1295868-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the '__connman_connection_update_gateway'
function.
---
 src/connection.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 58abf2ae1925..7c65b0951243 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1320,6 +1320,24 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	}
 }
 
+/**
+ *  @brief
+ *    Handle a potential change in gateways.
+ *
+ *  This may be invoked by other modules in the event of service and
+ *  technology changes to reexamine and, if necessary, update active
+ *  network interface gateways and their associated routing table
+ *  entries.
+ *
+ *  @returns
+ *    True if an active gateway was updated; otherwise, false.
+ *
+ *  @sa __connman_connection_gateway_add
+ *  @sa __connman_connection_gateway_remove
+ *  @sa set_default_gateway
+ *  @sa unset_default_gateway
+ *
+ */
 bool __connman_connection_update_gateway(void)
 {
 	struct gateway_data *default_gateway;
@@ -1329,6 +1347,10 @@ bool __connman_connection_update_gateway(void)
 
 	DBG("");
 
+	/*
+	 * If there is no service-to-gateway data hash, then there is
+	 * nothing to update and do; simply return.
+	 */
 	if (!gateway_hash)
 		return updated;
 
-- 
2.42.0

