Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42410A10
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CE3C573150
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 02:39:48 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9132673159
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 02:39:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/4] connection: Refactor 'connection_newgateway'.
Date: Tue, 28 Nov 2023 23:39:43 -0800
Message-ID: <20231129073947.1280705-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129073947.1280705-1-gerickson@nuovations.com>
References: <20231129073947.1280705-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This refactors the body tail of 'connection_newgateway' into a
separate function, 'check_default_gateway', shortening the length of
the former and making the latter an individually auditable and
comprehensible function.
---
 src/connection.c | 86 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 31 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index ce38f35d68c7..747b744a295e 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1051,6 +1051,57 @@ static bool choose_default_gateway(struct gateway_data *data,
 	return downgraded;
 }
 
+static void check_default_gateway(struct gateway_data *activated)
+{
+	GHashTableIter iter;
+	gpointer value, key;
+	bool found = false;
+
+	DBG("activated %p", activated);
+
+	GATEWAY_DATA_DBG("activated", activated);
+
+	/*
+	 * If we have already handled a Routing Netlink (rtnl)
+	 * notification and checked the newly-activated gateway against
+	 * the existing gateway / default routers, simply return.
+	 *
+	 * Otherwise, failure to use this 'default_checked' sentinel could
+	 * lead into an infinite Routing Netlink (rntl) loop as changing
+	 * the default gateway pushes a new route into the kernel and ends
+	 * up back here again (via the .newgateway method).
+	 */
+	if (activated->default_checked)
+		return;
+
+	g_hash_table_iter_init(&iter, gateway_hash);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		struct gateway_data *existing = value;
+
+		if (existing == activated)
+			continue;
+
+		found = choose_default_gateway(activated, existing);
+		if (found)
+			break;
+	}
+
+	DBG("found %u", found);
+
+	if (!found) {
+		if (activated->ipv4_config)
+			set_default_gateway(activated,
+				CONNMAN_IPCONFIG_TYPE_IPV4);
+
+		if (activated->ipv6_config)
+			set_default_gateway(activated,
+				CONNMAN_IPCONFIG_TYPE_IPV6);
+	}
+
+	activated->default_checked = true;
+}
+
 /**
  *  @brief
  *    Handler for gateway, or default route, -specific routes newly
@@ -1070,6 +1121,7 @@ static bool choose_default_gateway(struct gateway_data *data,
  *                       formatted address of the gateway, or default
  *                       router, that was added.
  *
+ *  @sa check_default_gateway
  *  @sa set_default_gateway
  *  @sa connection_delgateway
  *
@@ -1079,9 +1131,6 @@ static void connection_newgateway(int index, const char *gateway)
 	g_autofree char *interface = NULL;
 	struct gateway_config *config;
 	struct gateway_data *data;
-	GHashTableIter iter;
-	gpointer value, key;
-	bool found = false;
 
 	interface = connman_inet_ifname(index);
 
@@ -1118,36 +1167,11 @@ static void connection_newgateway(int index, const char *gateway)
 
 	GATEWAY_DATA_DBG("data", data);
 
-	if (data->default_checked)
-		return;
-
 	/*
-	 * The next checks are only done once, otherwise setting
-	 * the default gateway could lead into rtnl forever loop.
+	 * Check whether this newly-activated gateway should yield or
+	 * become the default.
 	 */
-
-	g_hash_table_iter_init(&iter, gateway_hash);
-
-	while (g_hash_table_iter_next(&iter, &key, &value)) {
-		struct gateway_data *candidate = value;
-
-		if (candidate == data)
-			continue;
-
-		found = choose_default_gateway(data, candidate);
-		if (found)
-			break;
-	}
-
-	if (!found) {
-		if (data->ipv4_config)
-			set_default_gateway(data, CONNMAN_IPCONFIG_TYPE_IPV4);
-
-		if (data->ipv6_config)
-			set_default_gateway(data, CONNMAN_IPCONFIG_TYPE_IPV6);
-	}
-
-	data->default_checked = true;
+	check_default_gateway(data);
 }
 
 static void remove_gateway(gpointer user_data)
-- 
2.42.0

