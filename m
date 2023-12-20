Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F51D6A2
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id EA80773144
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:16 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AE14C7315A
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:16 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/5] gateway: Add and leveage 'gateway_config_set_{,in}active'.
Date: Tue, 19 Dec 2023 21:56:12 -0800
Message-ID: <20231220055613.2287074-5-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220055613.2287074-1-gerickson@nuovations.com>
References: <20231220055613.2287074-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This encapsulates and makes symmetric the actions at the "terminal
ends" of the gateway configuration lifecycle / state machine by adding
and leveraging 'gateway_config_set_{,in}active' to set the gateway
configuration state and type appropriately.
---
 src/gateway.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/src/gateway.c b/src/gateway.c
index b5a1e2ddbf19..42a8da72642c 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -787,6 +787,20 @@ static bool is_gateway_config_type(const struct gateway_config *config,
 	return config->type == type;
 }
 
+static void gateway_config_set_active(struct gateway_config *config)
+{
+	gateway_config_state_set(config, CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+}
+
+static void gateway_config_set_inactive(struct gateway_config *config)
+{
+	gateway_config_state_set(config,
+		CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
+
+	gateway_config_type_set(config,
+		CONNMAN_GATEWAY_CONFIG_TYPE_NONE);
+}
+
 /**
  *  @brief
  *    Conditionally log the specified gateway configuration.
@@ -3366,8 +3380,7 @@ static void gateway_rtnl_new(int index, const char *gateway)
 	 * and it is now acknowledged by the kernel. Consequently, mark it
 	 * as active.
 	 */
-	gateway_config_state_set(config,
-		CONNMAN_GATEWAY_CONFIG_STATE_ACTIVE);
+	gateway_config_set_active(config);
 
 	/*
 	 * It is possible that we have two default routes atm
@@ -3471,13 +3484,9 @@ static void gateway_rtnl_del(int index, const char *gateway)
 	if (config) {
 		GATEWAY_CONFIG_DBG("config", config);
 
-		if (is_gateway_config_state_removed(config)) {
-			gateway_config_state_set(config,
-				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
-
-			gateway_config_type_set(config,
-				CONNMAN_GATEWAY_CONFIG_TYPE_NONE);
-		} else {
+		if (is_gateway_config_state_removed(config))
+			gateway_config_set_inactive(config);
+		else {
 			DBG("ignoring gateway stale removed activation; "
 			"probably added before removed activation completed");
 
-- 
2.42.0

