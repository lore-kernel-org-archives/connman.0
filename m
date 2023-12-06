Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59C328C5
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D238D73213
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:22 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 93AE373224
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:22 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 60/90] connection: Document 'gateway_config'.
Date: Wed,  6 Dec 2023 15:50:26 -0800
Message-ID: <20231206235056.322578-64-gerickson@nuovations.com>
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

This adds documentation to the 'gateway_config' structure.
---
 src/connection.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 8d2ac801c330..04a336e0b619 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -200,6 +200,11 @@ struct gateway_config_ops {
 		const char *gateway);
 };
 
+/**
+ *	An IP configuration type-specific data structure used to maintain
+ *	gateway-specific configuration information about a gateway, or
+ *	default router, and, for VPNs, the VPN peer.
+ */
 struct gateway_config {
 	/**
 	 *	A 32-bit flag bitfield governing the state and use of the
@@ -224,6 +229,12 @@ struct gateway_config {
 	 *  set/clear/add/delete operations.
 	 */
 	const struct gateway_config_ops *ops;
+
+	/**
+	 *	A pointer to a mutable, dynamically-allocated null-terminated
+	 *	C string containing the text-formatted address of the gateway,
+	 *	or default router.
+	 */
 	char *gateway;
 
 	/* VPN extra data */
-- 
2.42.0

