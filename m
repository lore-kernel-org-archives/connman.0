Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AF374
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0EB7373100
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 19:48:01 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BB4A573128
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 19:48:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/4] connection: Colocate search functions.
Date: Tue, 28 Nov 2023 16:47:55 -0800
Message-ID: <20231129004759.1240786-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129004759.1240786-1-gerickson@nuovations.com>
References: <20231129004759.1240786-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This relocates 'find_active_gateway' and 'find_default_gateway' such
that they are colocated with other service/gateway map search
functions.
---
 src/connection.c | 70 ++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 499e8e46a5a5..7b73b48ab1ea 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -241,6 +241,41 @@ static struct gateway_data *lookup_gateway_data(struct gateway_config *config)
 	return NULL;
 }
 
+static struct gateway_data *find_active_gateway(void)
+{
+	GHashTableIter iter;
+	gpointer value, key;
+
+	DBG("");
+
+	g_hash_table_iter_init(&iter, gateway_hash);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		struct gateway_data *data = value;
+
+		if (data->ipv4_config &&
+				data->ipv4_config->active)
+			return data;
+
+		if (data->ipv6_config &&
+				data->ipv6_config->active)
+			return data;
+	}
+
+	return NULL;
+}
+
+static struct gateway_data *find_default_gateway(void)
+{
+	struct connman_service *service;
+
+	service = connman_service_get_default();
+	if (!service)
+		return NULL;
+
+	return g_hash_table_lookup(gateway_hash, service);
+}
+
 static struct gateway_data *find_vpn_gateway(int index, const char *gateway)
 {
 	GHashTableIter iter;
@@ -717,17 +752,6 @@ static void unset_default_gateway(struct gateway_data *data,
 						data->ipv4_config->gateway);
 }
 
-static struct gateway_data *find_default_gateway(void)
-{
-	struct connman_service *service;
-
-	service = connman_service_get_default();
-	if (!service)
-		return NULL;
-
-	return g_hash_table_lookup(gateway_hash, service);
-}
-
 static bool choose_default_gateway(struct gateway_data *data,
 					struct gateway_data *candidate)
 {
@@ -968,30 +992,6 @@ static struct connman_rtnl connection_rtnl = {
 	.delgateway	= connection_delgateway,
 };
 
-static struct gateway_data *find_active_gateway(void)
-{
-	GHashTableIter iter;
-	gpointer value, key;
-
-	DBG("");
-
-	g_hash_table_iter_init(&iter, gateway_hash);
-
-	while (g_hash_table_iter_next(&iter, &key, &value)) {
-		struct gateway_data *data = value;
-
-		if (data->ipv4_config &&
-				data->ipv4_config->active)
-			return data;
-
-		if (data->ipv6_config &&
-				data->ipv6_config->active)
-			return data;
-	}
-
-	return NULL;
-}
-
 static void add_host_route(int family, int index, const char *gateway,
 			enum connman_service_type service_type)
 {
-- 
2.42.0

