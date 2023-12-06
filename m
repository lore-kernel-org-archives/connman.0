Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73766328C0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8325473174
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:03 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 45BFE731FD
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:03 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 13/90] connection: Rename 'active_gateway' local.
Date: Wed,  6 Dec 2023 15:49:36 -0800
Message-ID: <20231206235056.322578-14-gerickson@nuovations.com>
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

In '__connman_connection_update_gateway' there is a local variable
inside a loop control block, 'active_gateway'. This renames this local
varable to 'current_gateway' to avoid any confusion with the term
"active" which has implications for the 'ACTIVE' gateway configuration
state, which is definitely not the case for this local.
---
 src/connection.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index d81ed8648175..e80443c02a5a 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2102,27 +2102,27 @@ bool __connman_connection_update_gateway(void)
 	g_hash_table_iter_init(&iter, gateway_hash);
 
 	while (g_hash_table_iter_next(&iter, &key, &value)) {
-		struct gateway_data *active_gateway = value;
+		struct gateway_data *current_gateway = value;
 
-		GATEWAY_DATA_DBG("active_gateway", active_gateway);
+		GATEWAY_DATA_DBG("current_gateway", current_gateway);
 
-		if (active_gateway == default_gateway)
+		if (current_gateway == default_gateway)
 			continue;
 
-		if (active_gateway->ipv4_config &&
+		if (current_gateway->ipv4_config &&
 				is_gateway_config_state_active(
-					active_gateway->ipv4_config)) {
+					current_gateway->ipv4_config)) {
 
-			UNSET_DEFAULT_GATEWAY(active_gateway,
+			UNSET_DEFAULT_GATEWAY(current_gateway,
 						CONNMAN_IPCONFIG_TYPE_IPV4);
 			updated = true;
 		}
 
-		if (active_gateway->ipv6_config &&
+		if (current_gateway->ipv6_config &&
 				is_gateway_config_state_active(
-					active_gateway->ipv6_config)) {
+					current_gateway->ipv6_config)) {
 
-			UNSET_DEFAULT_GATEWAY(active_gateway,
+			UNSET_DEFAULT_GATEWAY(current_gateway,
 						CONNMAN_IPCONFIG_TYPE_IPV6);
 			updated = true;
 		}
-- 
2.42.0

