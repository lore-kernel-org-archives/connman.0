Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DBC328C1
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A0B86730F9
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:06 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 60CC87311A
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 21/90] connection: Add 'gateway_config_free'.
Date: Wed,  6 Dec 2023 15:49:44 -0800
Message-ID: <20231206235056.322578-22-gerickson@nuovations.com>
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

Since there are two identical instances of gateway configuration in
gateway data, introduce a function, 'gateway_config_free' to free
those instances rather than copying-and-pasting the logic to free them
twice in 'remove_gateway'.
---
 src/connection.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 72a82dd87f76..5b0f18627f40 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1698,27 +1698,27 @@ static void connection_newgateway(int index, const char *gateway)
 	check_default_gateway(data);
 }
 
+static void gateway_config_free(struct gateway_config *config)
+{
+	DBG("config %p", config);
+
+	if (config) {
+		g_free(config->gateway);
+		g_free(config->vpn_ip);
+		g_free(config->vpn_phy_ip);
+		g_free(config);
+	}
+}
+
 static void remove_gateway(gpointer user_data)
 {
 	struct gateway_data *data = user_data;
 
-	DBG("data %p", data);
-
 	GATEWAY_DATA_DBG("data", data);
 
-	if (data->ipv4_config) {
-		g_free(data->ipv4_config->gateway);
-		g_free(data->ipv4_config->vpn_ip);
-		g_free(data->ipv4_config->vpn_phy_ip);
-		g_free(data->ipv4_config);
-	}
+	gateway_config_free(data->ipv4_config);
 
-	if (data->ipv6_config) {
-		g_free(data->ipv6_config->gateway);
-		g_free(data->ipv6_config->vpn_ip);
-		g_free(data->ipv6_config->vpn_phy_ip);
-		g_free(data->ipv6_config);
-	}
+	gateway_config_free(data->ipv6_config);
 
 	connman_service_unref(data->service);
 
-- 
2.42.0

