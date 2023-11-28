Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8E46B93
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3A18E73140
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 14:23:06 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E61C873146
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 14:23:05 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] ipconfig: Expand and harmonize 'DBG' in '__connman_ipconfig_gateway_{add,remove}'
Date: Tue, 28 Nov 2023 11:23:03 -0800
Message-ID: <20231128192304.1179479-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128192304.1179479-1-gerickson@nuovations.com>
References: <20231128192304.1179479-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This expands and aligns the initial 'DBG' statements in
'__connman_ipconfig_gateway_{add,remove}' to aid debugging in a
multi-technology environment with "EnableOnlineToReadyTransition"
asserted.
---
 src/ipconfig.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 25e86bca292b..7c3418d51982 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -103,6 +103,11 @@ static GHashTable *ipdevice_hash = NULL;
 static GList *ipconfig_list = NULL;
 static bool is_ipv6_supported = false;
 
+static const char *maybe_null(const void *pointer)
+{
+	return pointer ? pointer : "<null>";
+}
+
 static void store_set_str(struct ipconfig_store *store,
 			const char *key, const char *val)
 
@@ -1324,8 +1329,13 @@ void __connman_ipconfig_set_gateway(struct connman_ipconfig *ipconfig,
 int __connman_ipconfig_gateway_add(const struct connman_ipconfig *ipconfig)
 {
 	struct connman_service *service;
+	g_autofree char *interface = NULL;
 
-	DBG("");
+	interface = connman_inet_ifname(ipconfig->index);
+
+	DBG("ipconfig %p type %d (%s) index %d (%s)", ipconfig,
+		ipconfig->type, __connman_ipconfig_type2string(ipconfig->type),
+		ipconfig->index, maybe_null(interface));
 
 	if (!ipconfig->address)
 		return -EINVAL;
@@ -1334,7 +1344,7 @@ int __connman_ipconfig_gateway_add(const struct connman_ipconfig *ipconfig)
 	if (!service)
 		return -EINVAL;
 
-	DBG("type %d gw %s peer %s", ipconfig->type,
+	DBG("gw %s peer %s",
 		ipconfig->address->gateway, ipconfig->address->peer);
 
 	if (ipconfig->type == CONNMAN_IPCONFIG_TYPE_IPV6 ||
@@ -1350,8 +1360,13 @@ int __connman_ipconfig_gateway_add(const struct connman_ipconfig *ipconfig)
 void __connman_ipconfig_gateway_remove(const struct connman_ipconfig *ipconfig)
 {
 	struct connman_service *service;
+	g_autofree char *interface = NULL;
 
-	DBG("");
+	interface = connman_inet_ifname(ipconfig->index);
+
+	DBG("ipconfig %p type %d (%s) index %d (%s)", ipconfig,
+		ipconfig->type, __connman_ipconfig_type2string(ipconfig->type),
+		ipconfig->index, maybe_null(interface));
 
 	service = __connman_service_lookup_from_index(ipconfig->index);
 	if (service)
-- 
2.42.0

