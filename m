Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21640328DA
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6634473120
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:07 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 293177312C
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 23/90] connection: Introduce and leverage 'mutate_default_gateway'.
Date: Wed,  6 Dec 2023 15:49:46 -0800
Message-ID: <20231206235056.322578-24-gerickson@nuovations.com>
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

The bodies of '{un,}set_default_gateway' are nearly identical, aside
from the functions they call.

Factor out the common implementation into a new function,
'mutate_default_gateway' and pass in the functions they call via a new
structure, 'mutate_default_gateway_ops'.
---
 src/connection.c | 142 +++++++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 59 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index f07974aee938..0136754128d5 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -144,6 +144,13 @@ struct gateway_data {
 	bool default_checked;
 };
 
+struct mutate_default_gateway_ops {
+	int (*mutate_ipv4)(struct gateway_data *data,
+				struct gateway_config *config);
+	int (*mutate_ipv6)(struct gateway_data *data,
+				struct gateway_config *config);
+};
+
 /*
  * These are declared as 'const char *const' to effect an immutable
  * pointer to an immutable null-terminated character string such that
@@ -1126,7 +1133,48 @@ static int add_gateway(struct connman_service *service,
 	return err;
 }
 
-static int set_ipv4_default_gateway(struct gateway_data *data,
+static int mutate_default_gateway(struct gateway_data *data,
+				enum connman_ipconfig_type type,
+				const struct mutate_default_gateway_ops *ops,
+				const char *function)
+{
+	int status4 = 0, status6 = 0;
+	bool do_ipv4 = false, do_ipv6 = false;
+
+	DBG("data %p type %d (%s) ops %p from %s()", data,
+		type, __connman_ipconfig_type2string(type),
+		ops,
+		function);
+
+	if (!data || !ops || !function)
+		return -EINVAL;
+
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+		do_ipv4 = true;
+	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
+		do_ipv6 = true;
+	else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
+		do_ipv4 = do_ipv6 = true;
+	else
+		return -EINVAL;
+
+	GATEWAY_DATA_DBG("data", data);
+
+	if (do_ipv4 && ops->mutate_ipv4 && data->ipv4_config)
+		status4 = ops->mutate_ipv4(data, data->ipv4_config);
+
+	if (do_ipv6 && ops->mutate_ipv6 && data->ipv6_config)
+		status6 = ops->mutate_ipv6(data, data->ipv6_config);
+
+	DBG("status4 %d (%s) status6 %d (%s)",
+		status4, strerror(-status4),
+		status6, strerror(-status6));
+
+	return (status4 < 0 ? status4 : status6);
+}
+
+static int set_ipv4_high_priority_default_gateway(
+				struct gateway_data *data,
 				struct gateway_config *config)
 {
 	int err = 0;
@@ -1170,7 +1218,8 @@ done:
 	return err;
 }
 
-static int set_ipv6_default_gateway(struct gateway_data *data,
+static int set_ipv6_high_priority_default_gateway(
+				struct gateway_data *data,
 				struct gateway_config *config)
 {
 	int err = 0;
@@ -1241,53 +1290,36 @@ done:
  *                            which the call to this function should
  *                            be attributed.
  *
- *  @sa __connman_inet_add_default_to_table
- *  @sa __connman_service_indicate_default
- *  @sa connman_inet_set_gateway_interface
- *  @sa connman_inet_set_ipv6_gateway_interface
+ *  @sa mutate_default_gateway
+ *  @sa set_ipv4_high_priority_default_gateway
+ *  @sa set_ipv6_high_priority_default_gateway
  *
  */
 static void set_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type,
 				const char *function)
 {
-	int status4 = 0, status6 = 0;
-	bool do_ipv4 = false, do_ipv6 = false;
-
-	DBG("data %p type %d (%s) from %s()", data,
-		type, __connman_ipconfig_type2string(type),
-		function);
+	static const struct mutate_default_gateway_ops ops = {
+		set_ipv4_high_priority_default_gateway,
+		set_ipv6_high_priority_default_gateway
+	};
+	int status = 0;
 
-	GATEWAY_DATA_DBG("data", data);
+	DBG("from %s()", function);
 
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
-		do_ipv4 = true;
-	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
-		do_ipv6 = true;
-	else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
-		do_ipv4 = do_ipv6 = true;
-	else
-		return;
-
-	if (do_ipv4 && data->ipv4_config)
-		status4 = set_ipv4_default_gateway(data, data->ipv4_config);
-
-	if (do_ipv6 && data->ipv6_config)
-		status6 = set_ipv6_default_gateway(data, data->ipv6_config);
-
-	DBG("status4 %d (%s) status6 %d (%s)",
-		status4, strerror(-status4),
-		status6, strerror(-status6));
-
-	if (status4 < 0 || status6 < 0)
+	status = mutate_default_gateway(data, type, &ops, __func__);
+	if (status < 0)
 		return;
 
 	__connman_service_indicate_default(data->service);
 }
 
-static void unset_ipv4_default_gateway(struct gateway_data *data,
+static int unset_ipv4_high_priority_default_gateway(
+				struct gateway_data *data,
 				struct gateway_config *config)
 {
+	int err = 0;
+
 	if (is_gateway_config_vpn(config)) {
 		connman_inet_clear_gateway_interface(data->index);
 
@@ -1313,11 +1345,16 @@ static void unset_ipv4_default_gateway(struct gateway_data *data,
 		DBG("unset %p index %d gateway %s",
 			data, data->index, config->gateway);
 	}
+
+	return err;
 }
 
-static void unset_ipv6_default_gateway(struct gateway_data *data,
+static int unset_ipv6_high_priority_default_gateway(
+				struct gateway_data *data,
 				struct gateway_config *config)
 {
+	int err = 0;
+
 	if (is_gateway_config_vpn(config)) {
 		connman_inet_clear_ipv6_gateway_interface(data->index);
 
@@ -1343,6 +1380,8 @@ static void unset_ipv6_default_gateway(struct gateway_data *data,
 		DBG("unset %p index %d gateway %s",
 			data, data->index, config->gateway);
 	}
+
+	return err;
 }
 
 /**
@@ -1371,38 +1410,23 @@ static void unset_ipv6_default_gateway(struct gateway_data *data,
  *                            be attributed.
  *
  *
- *  @sa connman_inet_clear_gateway_address
- *  @sa connman_inet_clear_gateway_interface
- *  @sa connman_inet_clear_ipv6_gateway_address
- *  @sa connman_inet_clear_ipv6_gateway_interface
+ *  @sa mutate_default_gateway
+ *  @sa unset_ipv4_default_gateway
+ *  @sa unset_ipv6_default_gateway
  *
  */
 static void unset_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type,
 				const char *function)
 {
-	bool do_ipv4 = false, do_ipv6 = false;
+	static const struct mutate_default_gateway_ops ops = {
+		unset_ipv4_high_priority_default_gateway,
+		unset_ipv6_high_priority_default_gateway
+	};
 
-	DBG("data %p type %d (%s) from %s()", data,
-		type, __connman_ipconfig_type2string(type),
-		function);
-
-	GATEWAY_DATA_DBG("data", data);
+	DBG("from %s()", function);
 
-	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
-		do_ipv4 = true;
-	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
-		do_ipv6 = true;
-	else if (type == CONNMAN_IPCONFIG_TYPE_ALL)
-		do_ipv4 = do_ipv6 = true;
-	else
-		return;
-
-	if (do_ipv4 && data->ipv4_config)
-		unset_ipv4_default_gateway(data, data->ipv4_config);
-
-	if (do_ipv6 && data->ipv6_config)
-		unset_ipv6_default_gateway(data, data->ipv6_config);
+	mutate_default_gateway(data, type, &ops, __func__);
 }
 
 /**
-- 
2.42.0

