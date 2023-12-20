Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A301D69C
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8E39273145
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:16 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5217E73150
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:16 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/5] gateway: Address unhandled gateway lifecycle events/transitions.
Date: Tue, 19 Dec 2023 21:56:11 -0800
Message-ID: <20231220055613.2287074-4-gerickson@nuovations.com>
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

There were a number of "escapes" or unhandled events and transitions
that did not adhere to the documented gateway configuration lifecycle
/ state machine. This handles those events and transitions.

Failure to handle these was resulting in duplicate default routes, no
default routes, and incorrect default route priorities for some
services and their underlying network interfaces.
---
 src/gateway.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/src/gateway.c b/src/gateway.c
index db8636eb20ef..b5a1e2ddbf19 100644
--- a/src/gateway.c
+++ b/src/gateway.c
@@ -787,12 +787,6 @@ static bool is_gateway_config_type(const struct gateway_config *config,
 	return config->type == type;
 }
 
-static bool is_gateway_config_type_none(const struct gateway_config *config)
-{
-	return is_gateway_config_type(config,
-				CONNMAN_GATEWAY_CONFIG_TYPE_NONE);
-}
-
 /**
  *  @brief
  *    Conditionally log the specified gateway configuration.
@@ -1809,7 +1803,8 @@ static int set_default_gateway_route_common(struct gateway_data *data,
 	if (!data || !config || !cb)
 		return -EINVAL;
 
-	if (!is_gateway_config_type_none(config) &&
+	if ((is_gateway_config_state_added(config) ||
+		is_gateway_config_state_active(config)) &&
 		!is_gateway_config_type(config, type))
 		return -EINVAL;
 
@@ -1886,7 +1881,8 @@ static int unset_default_gateway_route_common(struct gateway_data *data,
 	if (!data || !config || !cb)
 		return -EINVAL;
 
-	if (!is_gateway_config_type(config, type))
+	if (!is_gateway_config_state_inactive(config) &&
+		!is_gateway_config_type(config, type))
 		return -EINVAL;
 
 	if (is_gateway_config_state_removed(config))
@@ -3359,6 +3355,12 @@ static void gateway_rtnl_new(int index, const char *gateway)
 		return;
 	}
 
+	if (is_gateway_config_state_inactive(config)) {
+		DBG("ignoring inactive gateway activation");
+
+		return;
+	}
+
 	/*
 	 * Otherwise, this is a gateway default route we added, or set,
 	 * and it is now acknowledged by the kernel. Consequently, mark it
@@ -3469,11 +3471,18 @@ static void gateway_rtnl_del(int index, const char *gateway)
 	if (config) {
 		GATEWAY_CONFIG_DBG("config", config);
 
-		gateway_config_state_set(config,
-			CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
+		if (is_gateway_config_state_removed(config)) {
+			gateway_config_state_set(config,
+				CONNMAN_GATEWAY_CONFIG_STATE_INACTIVE);
 
-		gateway_config_type_set(config,
-			CONNMAN_GATEWAY_CONFIG_TYPE_NONE);
+			gateway_config_type_set(config,
+				CONNMAN_GATEWAY_CONFIG_TYPE_NONE);
+		} else {
+			DBG("ignoring gateway stale removed activation; "
+			"probably added before removed activation completed");
+
+			return;
+		}
 	} else
 		DBG("no matching gateway config");
 
-- 
2.42.0

