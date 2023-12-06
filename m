Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAC32C61
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 75AF173144
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:10 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 387987315A
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:10 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 31/90] connection: Fan out route manipulation into callbacks.
Date: Wed,  6 Dec 2023 15:49:54 -0800
Message-ID: <20231206235056.322578-32-gerickson@nuovations.com>
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

There is an appreciable amount of boilerplate copied-and-pasted among
the four set/unset IPv4/IPv6 gateway default route mutation functions.

This introduces two new functions to handle that common boilerplate:
'set_default_gateway_route_common' and
'unset_default_gateway_route_common' and introduces a new function
pointer, 'mutate_default_gateway_route_cb_t' that they take as a
parameter.

The four remaining set/unset IPv4/IPv6 gateway default route mutation
functions are then solely responsible only for making additions or
deletions to the routing table(s).
---
 src/connection.c | 101 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 10 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 2a21e476bc53..1bcf16dee616 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -203,6 +203,9 @@ struct mutate_default_gateway_ops {
 				struct gateway_config *config);
 };
 
+typedef int (*mutate_default_gateway_route_cb_t)(struct gateway_data *data,
+				struct gateway_config *config);
+
 static int unset_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type,
 				const char *function);
@@ -1254,7 +1257,45 @@ static int mutate_default_gateway(struct gateway_data *data,
 	return (status4 < 0 ? status4 : status6);
 }
 
-static int set_ipv4_high_priority_default_gateway(
+static int set_default_gateway_route_common(struct gateway_data *data,
+				struct gateway_config *config,
+				enum gateway_config_type type,
+				mutate_default_gateway_route_cb_t cb)
+{
+	int err = 0;
+
+	if (!data || !config || !cb)
+		return -EINVAL;
+
+	err = cb(data, config);
+	if (err < 0)
+		goto done;
+
+	gateway_config_type_set(config, type);
+
+done:
+	return err;
+}
+
+static int unset_default_gateway_route_common(struct gateway_data *data,
+				struct gateway_config *config,
+				enum gateway_config_type type,
+				mutate_default_gateway_route_cb_t cb)
+{
+	int err = 0;
+
+	if (!data || !config || !cb)
+		return -EINVAL;
+
+	err = cb(data, config);
+	if (err < 0)
+		goto done;
+
+done:
+	return err;
+}
+
+static int set_ipv4_high_priority_default_gateway_route_cb(
 				struct gateway_data *data,
 				struct gateway_config *config)
 {
@@ -1292,14 +1333,11 @@ static int set_ipv4_high_priority_default_gateway(
 			data, data->index, config->gateway);
 	}
 
-	gateway_config_type_set(config,
-		CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT);
-
 done:
 	return err;
 }
 
-static int set_ipv6_high_priority_default_gateway(
+static int set_ipv6_high_priority_default_gateway_route_cb(
 				struct gateway_data *data,
 				struct gateway_config *config)
 {
@@ -1337,13 +1375,32 @@ static int set_ipv6_high_priority_default_gateway(
 			data, data->index, config->gateway);
 	}
 
-	gateway_config_type_set(config,
-		CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT);
-
 done:
 	return err;
 }
 
+static int set_ipv4_high_priority_default_gateway(struct gateway_data *data,
+				struct gateway_config *config)
+{
+	static const enum gateway_config_type type =
+			CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT;
+	static const mutate_default_gateway_route_cb_t cb =
+			set_ipv4_high_priority_default_gateway_route_cb;
+
+	return set_default_gateway_route_common(data, config, type, cb);
+}
+
+static int set_ipv6_high_priority_default_gateway(struct gateway_data *data,
+				struct gateway_config *config)
+{
+	static const enum gateway_config_type type =
+			CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT;
+	static const mutate_default_gateway_route_cb_t cb =
+			set_ipv6_high_priority_default_gateway_route_cb;
+
+	return set_default_gateway_route_common(data, config, type, cb);
+}
+
 /**
  *  @brief
  *    Set, or assign, the gateway, or default route, for the specified
@@ -1401,7 +1458,7 @@ done:
 	return status;
 }
 
-static int unset_ipv4_high_priority_default_gateway(
+static int unset_ipv4_high_priority_default_gateway_route_cb(
 				struct gateway_data *data,
 				struct gateway_config *config)
 {
@@ -1436,7 +1493,7 @@ static int unset_ipv4_high_priority_default_gateway(
 	return err;
 }
 
-static int unset_ipv6_high_priority_default_gateway(
+static int unset_ipv6_high_priority_default_gateway_route_cb(
 				struct gateway_data *data,
 				struct gateway_config *config)
 {
@@ -1471,6 +1528,30 @@ static int unset_ipv6_high_priority_default_gateway(
 	return err;
 }
 
+static int unset_ipv4_high_priority_default_gateway(
+				struct gateway_data *data,
+				struct gateway_config *config)
+{
+	static const enum gateway_config_type type =
+			CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT;
+	static const mutate_default_gateway_route_cb_t cb =
+			unset_ipv4_high_priority_default_gateway_route_cb;
+
+	return unset_default_gateway_route_common(data, config, type, cb);
+}
+
+static int unset_ipv6_high_priority_default_gateway(
+				struct gateway_data *data,
+				struct gateway_config *config)
+{
+	static const enum gateway_config_type type =
+			CONNMAN_GATEWAY_CONFIG_TYPE_HIGH_PRIORITY_DEFAULT;
+	static const mutate_default_gateway_route_cb_t cb =
+			unset_ipv6_high_priority_default_gateway_route_cb;
+
+	return unset_default_gateway_route_common(data, config, type, cb);
+}
+
 /**
  *  @brief
  *    Unset the gateway, or default route, for the specified IP
-- 
2.42.0

