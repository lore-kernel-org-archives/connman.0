Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393EE182C4
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 29BC07315D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:03 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id DCF4D731A4
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:02 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 12/90] connection: Add 'DBG' to 'del_gateway_routes'.
Date: Wed,  6 Dec 2023 15:49:35 -0800
Message-ID: <20231206235056.322578-13-gerickson@nuovations.com>
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

To aid in debugging gateway route handling in multi-technology and
-service configurations, particularly during online check-driven
failover, add additional 'DBG' statements to 'del_gateway_routes'.
---
 src/connection.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 2c4c716560fe..d81ed8648175 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -833,6 +833,9 @@ static int del_gateway_routes(struct gateway_data *data,
 	int status4 = 0, status6 = 0;
 	bool do_ipv4 = false, do_ipv6 = false;
 
+	DBG("data %p type %d (%s)", data,
+		type, __connman_ipconfig_type2string(type));
+
 	GATEWAY_DATA_DBG("data", data);
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
@@ -880,6 +883,10 @@ static int del_gateway_routes(struct gateway_data *data,
 		}
 	}
 
+	DBG("status4 %d (%s) status6 %d (%s)",
+		status4, strerror(-status4),
+		status6, strerror(-status6));
+
 	return (status4 < 0 ? status4 : status6);
 }
 
-- 
2.42.0

