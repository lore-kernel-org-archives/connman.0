Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D8182C4
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C53007310E
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:07 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 87FB173150
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 24/90] connection: Document 'mutate_default_gateway_ops'.
Date: Wed,  6 Dec 2023 15:49:47 -0800
Message-ID: <20231206235056.322578-25-gerickson@nuovations.com>
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

This adds documentation to the 'mutate_default_gateway_ops' structure.
---
 src/connection.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 0136754128d5..d78b3f0400a9 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -144,9 +144,43 @@ struct gateway_data {
 	bool default_checked;
 };
 
+/**
+ *	Function pointers to mutating (including, but not limited to,
+ *	adding/setting or clearing/deleting/removing routes) IPv4 and/or
+ *	IPv6 default gateways.
+ */
 struct mutate_default_gateway_ops {
+	/**
+	 *  An optional pointer to a function for mutating (including, but
+	 *  not limited to, adding/setting or clearing/deleting/removing
+	 *  routes) an IPv4 default gateway.
+	 *
+	 *  @param[in,out]  data    A pointer to the mutable IPv4 gateway
+	 *                          data to mutate.
+	 *  @param[in,out]  config  A pointer to the mutable IPv4 gateway
+	 *                          configuration to mutate.
+	 *
+	 *  @returns
+	 *    0 if successful; otherwise, < 0 on error.
+	 *
+	 */
 	int (*mutate_ipv4)(struct gateway_data *data,
 				struct gateway_config *config);
+
+	/**
+	 *  An optional pointer to a function for mutating (including, but
+	 *  not limited to, adding/setting or clearing/deleting/removing
+	 *  routes) an IPv6 default gateway.
+	 *
+	 *  @param[in,out]  data    A pointer to the mutable IPv6 gateway
+	 *                          data to mutate.
+	 *  @param[in,out]  config  A pointer to the mutable IPv6 gateway
+	 *                          configuration to mutate.
+	 *
+	 *  @returns
+	 *    0 if successful; otherwise, < 0 on error.
+	 *
+	 */
 	int (*mutate_ipv6)(struct gateway_data *data,
 				struct gateway_config *config);
 };
-- 
2.42.0

