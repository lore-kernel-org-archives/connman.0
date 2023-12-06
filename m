Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49B8328B7
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id EFE357312B
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:08 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AACCE73146
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:08 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 27/90] connection: Add low-priority default gateway config type.
Date: Wed,  6 Dec 2023 15:49:50 -0800
Message-ID: <20231206235056.322578-28-gerickson@nuovations.com>
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

This adds a low-priority gateway default route type as a parallel peer
to the existing high-priority type.
---
 src/connection.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/connection.c b/src/connection.c
index 18ab007f0893..5091a229b4d1 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -119,7 +119,13 @@ enum gateway_config_type {
 	 *	Indicates the gateway, or default router, is a high-priority
 	 *	(that is, metric 0) default route.
 	 */
-	CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT = 1
+	CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT = 1,
+
+	/**
+	 *	Indicates the gateway, or default router, is a low-priority
+	 *	(that is, metric > 0) default route.
+	 */
+	CONNMAN_GATEWAY_CONFIG_TYPE_LOW_PRIORITY_DEFAULT  = 2
 };
 
 struct gateway_config {
@@ -292,6 +298,8 @@ static const char *gateway_config_type2string(enum gateway_config_type type)
 		return "none";
 	case CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT:
 		return "high-priority default";
+	case CONNMAN_GATEWAY_CONFIG_TYPE_LOW_PRIORITY_DEFAULT:
+		return "low-priority default";
 	}
 
 	return NULL;
-- 
2.42.0

