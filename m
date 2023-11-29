Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B67473
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 60CE873118
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:21:11 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 19DC973144
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:21:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/3] connection: Rename 'disable_gateway'.
Date: Tue, 28 Nov 2023 22:21:07 -0800
Message-ID: <20231129062109.1270106-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129062109.1270106-1-gerickson@nuovations.com>
References: <20231129062109.1270106-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames 'disable_gateway' as 'del_gateway_routes_if_active'. The
former is a bit of a misnomer since it is not possible to actually
"disable" a gateway and its associated routes. The latter, revised
name more accurately reflect its purpose and conditional action.
---
 src/connection.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index c39b861708fb..547a47cf8b6f 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -621,7 +621,7 @@ static int del_routes(struct gateway_data *data,
 	return (status4 < 0 ? status4 : status6);
 }
 
-static int disable_gateway(struct gateway_data *data,
+static int del_gateway_routes_if_active(struct gateway_data *data,
 			enum connman_ipconfig_type type)
 {
 	bool active = false;
@@ -695,7 +695,7 @@ static int disable_gateway(struct gateway_data *data,
  *                    #gateway_config.
  *
  *  @sa __connman_connection_gateway_add
- *  @sa disable_gateway
+ *  @sa del_gateway_routes_if_active
  *
  */
 static int add_gateway(struct connman_service *service,
@@ -753,7 +753,7 @@ static int add_gateway(struct connman_service *service,
 	if (old) {
 		DBG("Replacing gw %p ipv4 %p ipv6 %p", old,
 			old->ipv4_config, old->ipv6_config);
-		disable_gateway(old, type);
+		del_gateway_routes_if_active(old, type);
 		if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 			temp_data->ipv6_config = old->ipv6_config;
 			old->ipv6_config = NULL;
@@ -1463,7 +1463,7 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 
 	/* Remove all active routes associated with this gateway data. */
 
-	err = disable_gateway(data, type);
+	err = del_gateway_routes_if_active(data, type);
 
 	/*
 	 * We remove the service from the service/gateway map only if ALL
@@ -1660,7 +1660,7 @@ void __connman_connection_cleanup(void)
 	while (g_hash_table_iter_next(&iter, &key, &value)) {
 		struct gateway_data *data = value;
 
-		disable_gateway(data, CONNMAN_IPCONFIG_TYPE_ALL);
+		del_gateway_routes_if_active(data, CONNMAN_IPCONFIG_TYPE_ALL);
 	}
 
 	g_hash_table_destroy(gateway_hash);
-- 
2.42.0

