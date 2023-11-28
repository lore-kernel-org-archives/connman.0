Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66558AB2
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D59FF7314B
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 18:08:50 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8EE887315D
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 18:08:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 5/8] connection: Expand, Enhance, and Refactor 'DBG'.
Date: Tue, 28 Nov 2023 15:08:43 -0800
Message-ID: <20231128230847.1224497-6-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128230847.1224497-1-gerickson@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This expands, exhances, and refactors 'DBG' statements throughout the
module to improve symmetry in content, aid in debugging, and to
reflect the newly-leveraged 'GATEWAY_CONFIG_DBG' and
'GATEWAY_DATA_DBG' macros.
---
 src/connection.c | 52 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/src/connection.c b/src/connection.c
index 1227c9cdea77..90cc33106ca7 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -566,6 +566,9 @@ static void set_default_gateway(struct gateway_data *data,
 	int status4 = 0, status6 = 0;
 	bool do_ipv4 = false, do_ipv6 = false;
 
+	DBG("data %p type %d (%s)", data,
+		type, __connman_ipconfig_type2string(type));
+
 	GATEWAY_DATA_DBG("data", data);
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
@@ -575,9 +578,6 @@ static void set_default_gateway(struct gateway_data *data,
 	else
 		do_ipv4 = do_ipv6 = true;
 
-	DBG("type %d gateway ipv4 %p ipv6 %p", type, data->ipv4_gateway,
-						data->ipv6_gateway);
-
 	if (do_ipv4 && data->ipv4_gateway &&
 					data->ipv4_gateway->vpn) {
 		connman_inet_set_gateway_interface(data->index);
@@ -649,6 +649,9 @@ static void unset_default_gateway(struct gateway_data *data,
 	int index;
 	bool do_ipv4 = false, do_ipv6 = false;
 
+	DBG("data %p type %d (%s)", data,
+		type, __connman_ipconfig_type2string(type));
+
 	GATEWAY_DATA_DBG("data", data);
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
@@ -776,13 +779,17 @@ static bool choose_default_gateway(struct gateway_data *data,
 
 static void connection_newgateway(int index, const char *gateway)
 {
+	g_autofree char *interface = NULL;
 	struct gateway_config *config;
 	struct gateway_data *data;
 	GHashTableIter iter;
 	gpointer value, key;
 	bool found = false;
 
-	DBG("index %d gateway %s", index, gateway);
+	interface = connman_inet_ifname(index);
+
+	DBG("index %d (%s) gateway %s", index, maybe_null(interface),
+		gateway);
 
 	config = find_gateway(index, gateway);
 	if (!config)
@@ -839,7 +846,7 @@ static void remove_gateway(gpointer user_data)
 {
 	struct gateway_data *data = user_data;
 
-	DBG("gateway ipv4 %p ipv6 %p", data->ipv4_gateway, data->ipv6_gateway);
+	DBG("data %p", data);
 
 	GATEWAY_DATA_DBG("data", data);
 
@@ -864,10 +871,14 @@ static void remove_gateway(gpointer user_data)
 
 static void connection_delgateway(int index, const char *gateway)
 {
+	g_autofree char *interface = NULL;
 	struct gateway_config *config;
 	struct gateway_data *data;
 
-	DBG("index %d gateway %s", index, gateway);
+	interface = connman_inet_ifname(index);
+
+	DBG("index %d (%s) gateway %s", index, maybe_null(interface),
+		gateway);
 
 	config = find_gateway(index, gateway);
 	if (config) {
@@ -974,9 +985,20 @@ int __connman_connection_gateway_add(struct connman_service *service,
 	enum connman_service_type service_type =
 					connman_service_get_type(service);
 	int index;
+	g_autofree char *interface = NULL;
+
+	DBG("service %p (%s) gateway %p (%s) type %d (%s) peer %p (%s)",
+		service, maybe_null(connman_service_get_identifier(service)),
+		gateway, maybe_null(gateway),
+		type, __connman_ipconfig_type2string(type),
+		peer, maybe_null(peer));
 
 	index = __connman_service_get_index(service);
 
+	interface = connman_inet_ifname(index);
+
+	DBG("index %d (%s)", index, maybe_null(interface));
+
 	/*
 	 * If gateway is NULL, it's a point to point link and the default
 	 * gateway for ipv4 is 0.0.0.0 and for ipv6 is ::, meaning the
@@ -1077,9 +1099,21 @@ void __connman_connection_gateway_remove(struct connman_service *service,
 	struct gateway_data *data = NULL;
 	bool set_default4 = false, set_default6 = false;
         bool do_ipv4 = false, do_ipv6 = false;
+	int index;
+	g_autofree char *interface = NULL;
 	int err;
 
-	DBG("service %p type %d", service, type);
+	DBG("service %p (%s) type %d (%s)",
+		service, maybe_null(connman_service_get_identifier(service)),
+		type, __connman_ipconfig_type2string(type));
+
+	index = __connman_service_get_index(service);
+	if (index < 0)
+		return;
+
+	interface = connman_inet_ifname(index);
+
+	DBG("index %d (%s)", index, maybe_null(interface));
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		do_ipv4 = true;
@@ -1157,12 +1191,14 @@ bool __connman_connection_update_gateway(void)
 	GHashTableIter iter;
 	gpointer value, key;
 
+	DBG("");
+
 	if (!gateway_hash)
 		return updated;
 
 	default_gateway = find_default_gateway();
 
-	DBG("default %p", default_gateway);
+	DBG("default_gateway %p", default_gateway);
 
 	GATEWAY_DATA_DBG("default_gateway", default_gateway);
 
-- 
2.42.0

