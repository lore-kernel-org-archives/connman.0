Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58E328C1
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id AEE8973214
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:21 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 719C77321D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 57/90] connection: Add 'DBG' else clauses to 'connection_delgateway'.
Date: Wed,  6 Dec 2023 15:50:23 -0800
Message-ID: <20231206235056.322578-61-gerickson@nuovations.com>
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

This adds 'DBG' else clauses to 'connection_delgateway' to aid in
debugging cases that otherwise "skip out" of 'connection_delgateway'.
---
 src/connection.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 771f9eaccc28..68c919049f20 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2421,7 +2421,8 @@ static void connection_delgateway(int index, const char *gateway)
 
 		gateway_config_type_set(config,
 			CONNMAN_GATEWAY_CONFIG_TYPE_NONE);
-	}
+	} else
+		DBG("no matching gateway config");
 
 	/*
 	 * Due to the newly-removed gateway route, there may have been a
@@ -2434,7 +2435,8 @@ static void connection_delgateway(int index, const char *gateway)
 		GATEWAY_DATA_DBG("data", data);
 
 		PROMOTE_DEFAULT_GATEWAY(data, CONNMAN_IPCONFIG_TYPE_ALL);
-	}
+	} else
+		DBG("no default gateway data");
 }
 
 static struct connman_rtnl connection_rtnl = {
-- 
2.42.0

