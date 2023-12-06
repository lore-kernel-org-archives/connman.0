Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067FE328CA
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8BFF373128
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:08 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4E10673144
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:08 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 26/90] connection: Add gateway config ADDED/REMOVED states.
Date: Wed,  6 Dec 2023 15:49:49 -0800
Message-ID: <20231206235056.322578-27-gerickson@nuovations.com>
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

This adds two new gateway configuration lifecycle states: ADDED and
REMOVED.

ADDED indicates whether the gateway has been added, or set, to the
kernel but not acknowledged round-trip via a Routing Netlink (rtnl)
notification.

REMOVED indicates whether the gateway has been removed, or cleared,
from the kernel but not acknowledged round-trip via a Routing Netlink
(rtnl) notification.
---
 src/connection.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/connection.c b/src/connection.c
index 532b8f06713c..18ab007f0893 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -85,12 +85,24 @@ enum gateway_config_state {
 	 */
 	CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE = 0,
 
+	/**
+	 *	Indicates whether the gateway has been added, or set, to the
+	 *	kernel but not acknowledged round-trip.
+	 */
+	CONNMAN_GATEWAY_CONFIG_STATE_ADDED	  = 1,
+
 	/**
 	 *	Indicates whether the gateway, or default router, is added and
 	 *	acknowledged by the kernel through a Routing Netlink (rtnl)
 	 *	notification and, consequently, is active (that is, in use).
 	 */
-	CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE	  = 1
+	CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE	  = 2,
+
+	/**
+	 *	Indicates whether the gateway has been removed, or cleared,
+	 *	from the kernel but not acknowledged round-trip.
+	 */
+	CONNMAN_GATEWAY_CONFIG_STATE_REMOVED  = 3
 };
 
 /**
@@ -262,8 +274,12 @@ static const char *gateway_config_state2string(enum gateway_config_state state)
 	switch (state) {
 	case CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE:
 		return "inactive";
+	case CONNMAN_GATEWAY_CONFIG_STATE_ADDED:
+		return "added";
 	case CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE:
 		return "active";
+	case CONNMAN_GATEWAY_CONFIG_STATE_REMOVED:
+		return "removed";
 	}
 
 	return NULL;
-- 
2.42.0

