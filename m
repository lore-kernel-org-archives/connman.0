Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83F846B92
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1C3F773218
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 18:17:09 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C3E9E7321D
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 18:17:08 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] connection: Remove unnecessary '__connman_service_get_index' calls.
Date: Wed, 29 Nov 2023 15:17:06 -0800
Message-ID: <20231129231706.1306676-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129231706.1306676-1-gerickson@nuovations.com>
References: <20231129231706.1306676-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

In both 'set_default_gateway' and 'unset_default_gateway' there are
unnecessary, redundant, and, per the below, circular calls to
'__connman_service_get_index' to get the network interface index from
the 'service' field of the gateway 'data' parameter passed to these
functions.

However, in 'add_gateway', the gateway data 'index' field is assigned
as follows:

    temp_data->index = index;

where 'index' comes from a parameter passed to 'add_gateway', from
'__connman_connection_gateway_add':

    index = __connman_service_get_index(service);

that was sourced from the network service from which a strong
reference was retained when the gateway data was initialized.

Consequently, the network interface index sought may simply be
accessed from the 'index' field of the gateway data as:

    data->index
---
 src/connection.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 5a98b8d57c84..91ce39adc167 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -859,7 +859,6 @@ static int add_gateway(struct connman_service *service,
 static void set_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type)
 {
-	int index;
 	int status4 = 0, status6 = 0;
 	bool do_ipv4 = false, do_ipv6 = false;
 
@@ -905,11 +904,9 @@ static void set_default_gateway(struct gateway_data *data,
 		return;
 	}
 
-	index = __connman_service_get_index(data->service);
-
 	if (do_ipv4 && data->ipv4_config &&
 			is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
-		if (connman_inet_set_gateway_interface(index) < 0)
+		if (connman_inet_set_gateway_interface(data->index) < 0)
 			return;
 		data->ipv4_config->active = true;
 		goto done;
@@ -917,7 +914,7 @@ static void set_default_gateway(struct gateway_data *data,
 
 	if (do_ipv6 && data->ipv6_config &&
 			is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
-		if (connman_inet_set_ipv6_gateway_interface(index) < 0)
+		if (connman_inet_set_ipv6_gateway_interface(data->index) < 0)
 			return;
 		data->ipv6_config->active = true;
 		goto done;
@@ -925,11 +922,11 @@ static void set_default_gateway(struct gateway_data *data,
 
 	if (do_ipv6 && data->ipv6_config)
 		status6 = __connman_inet_add_default_to_table(RT_TABLE_MAIN,
-					index, data->ipv6_config->gateway);
+					data->index, data->ipv6_config->gateway);
 
 	if (do_ipv4 && data->ipv4_config)
 		status4 = __connman_inet_add_default_to_table(RT_TABLE_MAIN,
-					index, data->ipv4_config->gateway);
+					data->index, data->ipv4_config->gateway);
 
 	if (status4 < 0 || status6 < 0)
 		return;
@@ -941,7 +938,6 @@ done:
 static void unset_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type)
 {
-	int index;
 	bool do_ipv4 = false, do_ipv6 = false;
 
 	DBG("data %p type %d (%s)", data,
@@ -985,28 +981,26 @@ static void unset_default_gateway(struct gateway_data *data,
 		return;
 	}
 
-	index = __connman_service_get_index(data->service);
-
 	if (do_ipv4 && data->ipv4_config &&
 			is_ipv4_addr_any_str(data->ipv4_config->gateway)) {
-		connman_inet_clear_gateway_interface(index);
+		connman_inet_clear_gateway_interface(data->index);
 		data->ipv4_config->active = false;
 		return;
 	}
 
 	if (do_ipv6 && data->ipv6_config &&
 			is_ipv6_addr_any_str(data->ipv6_config->gateway)) {
-		connman_inet_clear_ipv6_gateway_interface(index);
+		connman_inet_clear_ipv6_gateway_interface(data->index);
 		data->ipv6_config->active = false;
 		return;
 	}
 
 	if (do_ipv6 && data->ipv6_config)
-		connman_inet_clear_ipv6_gateway_address(index,
+		connman_inet_clear_ipv6_gateway_address(data->index,
 						data->ipv6_config->gateway);
 
 	if (do_ipv4 && data->ipv4_config)
-		connman_inet_clear_gateway_address(index,
+		connman_inet_clear_gateway_address(data->index,
 						data->ipv4_config->gateway);
 }
 
-- 
2.42.0

