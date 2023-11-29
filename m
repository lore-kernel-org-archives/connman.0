Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28B523B
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A921173174
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:53:36 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B8C47731A8
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:53:34 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/3] connection: Change the function signature of 'add_gateway'.
Date: Tue, 28 Nov 2023 20:53:15 -0800
Message-ID: <20231129045321.1263302-3-gerickson@nuovations.com>
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

This changes the function signature of 'add_gateway' by migrating the
return type to a double-pointer parameter and changing the return type
to an 'int' for error status.

This allows passing the full range of failure errors to the caller and
allows the caller to pass those errors directly along as their own
return status.
---
 src/connection.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index c51eecde1f97..f137c1b037d0 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -645,34 +645,36 @@ static int disable_gateway(struct gateway_data *data,
 	return 0;
 }
 
-static struct gateway_data *add_gateway(struct connman_service *service,
+static int add_gateway(struct connman_service *service,
 					int index, const char *gateway,
-					enum connman_ipconfig_type type)
+					enum connman_ipconfig_type type,
+					struct gateway_data **data)
 {
 	g_autofree struct gateway_data *temp_data = NULL;
 	struct gateway_config *config = NULL;
 	struct gateway_data *old;
+	int err = 0;
 
-	if (!service || index < 0 || !gateway || strlen(gateway) == 0)
-		return NULL;
+	if (!service || index < 0 || !gateway || strlen(gateway) == 0 || !data)
+		return -EINVAL;
 
 	switch (type) {
 	case CONNMAN_IPCONFIG_TYPE_IPV4:
 	case CONNMAN_IPCONFIG_TYPE_IPV6:
 		break;
 	default:
-		return NULL;
+		return -EINVAL;
 	}
 
 	temp_data = g_try_new0(struct gateway_data, 1);
 	if (!temp_data)
-		return NULL;
+		return -ENOMEM;
 
 	temp_data->index = index;
 
 	config = g_try_new0(struct gateway_config, 1);
 	if (!config)
-		return NULL;
+		return -ENOMEM;
 
 	config->gateway = g_strdup(gateway);
 	config->vpn_ip = NULL;
@@ -711,7 +713,9 @@ static struct gateway_data *add_gateway(struct connman_service *service,
 	connman_service_ref(temp_data->service);
 	g_hash_table_replace(gateway_hash, service, temp_data);
 
-	return g_steal_pointer(&temp_data);
+	*data = g_steal_pointer(&temp_data);
+
+	return err;
 }
 
 static void set_default_gateway(struct gateway_data *data,
@@ -1204,6 +1208,7 @@ int __connman_connection_gateway_add(struct connman_service *service,
 					connman_service_get_type(service);
 	int index;
 	g_autofree char *interface = NULL;
+	int err = 0;
 
 	DBG("service %p (%s) gateway %p (%s) type %d (%s) peer %p (%s)",
 		service, maybe_null(connman_service_get_identifier(service)),
@@ -1231,9 +1236,9 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	DBG("service %p index %d gateway %s vpn ip %s type %d",
 		service, index, gateway, peer, type);
 
-	new_gateway = add_gateway(service, index, gateway, type);
-	if (!new_gateway)
-		return -EINVAL;
+	err = add_gateway(service, index, gateway, type, &new_gateway);
+	if (err < 0)
+		return err;
 
 	GATEWAY_DATA_DBG("new_gateway", new_gateway);
 
@@ -1308,7 +1313,8 @@ done:
 		__connman_service_ipconfig_indicate_state(service,
 						CONNMAN_SERVICE_STATE_READY,
 						CONNMAN_IPCONFIG_TYPE_IPV6);
-	return 0;
+
+	return err;
 }
 
 /**
-- 
2.42.0

