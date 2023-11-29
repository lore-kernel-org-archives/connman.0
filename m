Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F06FA7
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 968D373150
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:53:33 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 00C2673145
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:53:31 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/3] connection: Simplify exception handling in 'add_gateway'.
Date: Tue, 28 Nov 2023 20:53:14 -0800
Message-ID: <20231129045321.1263302-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129045321.1263302-1-gerickson@nuovations.com>
References: <20231129045321.1263302-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Leverage early parameter checking, the 'g_autofree' pointer
decoration, and 'g_steal_pointer' macro to simplify exception handling
in 'add_gateway'.
---
 src/connection.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index eddfdc721636..c51eecde1f97 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -649,23 +649,30 @@ static struct gateway_data *add_gateway(struct connman_service *service,
 					int index, const char *gateway,
 					enum connman_ipconfig_type type)
 {
-	struct gateway_data *data, *old;
-	struct gateway_config *config;
+	g_autofree struct gateway_data *temp_data = NULL;
+	struct gateway_config *config = NULL;
+	struct gateway_data *old;
 
-	if (!gateway || strlen(gateway) == 0)
+	if (!service || index < 0 || !gateway || strlen(gateway) == 0)
 		return NULL;
 
-	data = g_try_new0(struct gateway_data, 1);
-	if (!data)
+	switch (type) {
+	case CONNMAN_IPCONFIG_TYPE_IPV4:
+	case CONNMAN_IPCONFIG_TYPE_IPV6:
+		break;
+	default:
+		return NULL;
+	}
+
+	temp_data = g_try_new0(struct gateway_data, 1);
+	if (!temp_data)
 		return NULL;
 
-	data->index = index;
+	temp_data->index = index;
 
 	config = g_try_new0(struct gateway_config, 1);
-	if (!config) {
-		g_free(data);
+	if (!config)
 		return NULL;
-	}
 
 	config->gateway = g_strdup(gateway);
 	config->vpn_ip = NULL;
@@ -675,17 +682,11 @@ static struct gateway_data *add_gateway(struct connman_service *service,
 	config->active = false;
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
-		data->ipv4_config = config;
+		temp_data->ipv4_config = config;
 	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
-		data->ipv6_config = config;
-	else {
-		g_free(config->gateway);
-		g_free(config);
-		g_free(data);
-		return NULL;
-	}
+		temp_data->ipv6_config = config;
 
-	data->service = service;
+	temp_data->service = service;
 
 	/*
 	 * If the service is already in the hash, then we
@@ -699,18 +700,18 @@ static struct gateway_data *add_gateway(struct connman_service *service,
 			old->ipv4_config, old->ipv6_config);
 		disable_gateway(old, type);
 		if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
-			data->ipv6_config = old->ipv6_config;
+			temp_data->ipv6_config = old->ipv6_config;
 			old->ipv6_config = NULL;
 		} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
-			data->ipv4_config = old->ipv4_config;
+			temp_data->ipv4_config = old->ipv4_config;
 			old->ipv4_config = NULL;
 		}
 	}
 
-	connman_service_ref(data->service);
-	g_hash_table_replace(gateway_hash, service, data);
+	connman_service_ref(temp_data->service);
+	g_hash_table_replace(gateway_hash, service, temp_data);
 
-	return data;
+	return g_steal_pointer(&temp_data);
 }
 
 static void set_default_gateway(struct gateway_data *data,
-- 
2.42.0

