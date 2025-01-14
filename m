Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.78.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B952500BD
	for <connman@lists.linux.dev>; Tue, 14 Jan 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736845009; cv=none; b=DqMiNXeOWO2Vt1fnYLXif0YxswEPNzTuT7t5S4r6J8xHzHAxPr4LiXjEmXYLIWB0ZwpcDCeL3tNxUkeYmG+wlLqgFP6zyUZ3rlAdj7kpifNBJvTuPgzuAXG10qqh0JV94V1YYIIAbF1dnSKrvy/nEaHD95/avycYgcpG4PZqOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736845009; c=relaxed/simple;
	bh=XFoiKNE/gPDwtNTO9kLaF+R5Kw+gXvaMGZS/UcZmVdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlN/VPLtTHnTUAMjbYhsCWjREzwsVLo2jC/GTuoNj+ieCd6jFzS598dWHcNBTwOmhya73cvzx84rdvgQNut4YRA11TbDHkpGy2c51hT7HAQcHa4O8P/XBiTKJwEORyCEe0ssfMU3YcMzXYvLBv5Mx1BZ7135mf/cyIstR2sZ0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b=Bd2twgem; arc=none smtp.client-ip=77.75.78.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailprofi.seznam.cz header.i=@emailprofi.seznam.cz header.b="Bd2twgem"
Received: from email.seznam.cz
	by smtpc-mxd-9dd5ff85d-ghlh2
	(smtpc-mxd-9dd5ff85d-ghlh2 [2a02:598:64:8a00::1000:a01])
	id 1b9fc961e545cf031bb723f6;
	Tue, 14 Jan 2025 09:56:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=emailprofi.seznam.cz; s=szn20221014; t=1736845003;
	bh=rZ+zO5KfMr5Yd/fMioMCcaz9JhZWtt+Bi5EpDIRwCPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=Bd2twgemq2EArkZuXvbVTcBuWRX5Ed1QTONA7cmks28yO/jB/pitY+A6qu/rGUDsl
	 xOzWix3jo/vbScw2Yft0K8P3tuMc1+M3XkTmoJSHvTLHNW63/iuKOVwp899I6VyuNS
	 yy5u6S9TT9BYvxBr3wwZUYsaUyoWVbmqRFotzd+p8GU7/Pu4w1ZCez1SdF8OtVXxL7
	 BigkrWMssYd5kWfVlVmslK+cdQ9Ol0sFTHBVrQ34lZBkIL4OnfneVAamrGBZpqEOc4
	 JpX14ldX5ms8OQ0ZGrrlgYkGZ9iChbNEmDUpkKFXi2vSElJ2XWn2RfmArZl3H/kd0O
	 wUDMiipJWEH8A==
Received: from smrz ([93.90.163.238])
	by smtpd-relay-7666f97df9-g2fkx (szn-email-smtpd/2.0.27) with ESMTPA
	id f6584095-3558-4d58-9f5d-ea4297b65932;
	Tue, 14 Jan 2025 09:55:23 +0100
From: =?UTF-8?q?Roman=20Smr=C5=BE?= <roman@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: michael@amarulasolutions.com,
	=?UTF-8?q?Roman=20Smr=C5=BE?= <roman@amarulasolutions.com>
Subject: [PATCH] technology: Tethering address configuration
Date: Tue, 14 Jan 2025 09:49:18 +0100
Message-ID: <20250114085457.26934-2-roman@amarulasolutions.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250114085457.26934-1-roman@amarulasolutions.com>
References: <CAOf5uwnN7R-3znm80TzhAPF=GgokUuBg2Zy+C0sqCETRNJy_RQ@mail.gmail.com>
 <20250114085457.26934-1-roman@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new TetheringAddress property to the Technology API, which, when
set, configures the used router address of the tethering interface, and
makes the addresses assigned to the clients come from that IP network.
---
 doc/technology-api.txt | 11 ++++++++++
 src/connman.h          |  2 ++
 src/ippool.c           | 12 ++++++++---
 src/peer.c             |  2 +-
 src/technology.c       | 49 ++++++++++++++++++++++++++++++++++++++++++
 src/tethering.c        | 15 +++++++++++--
 unit/test-ippool.c     | 20 ++++++++---------
 7 files changed, 95 insertions(+), 16 deletions(-)

diff --git a/doc/technology-api.txt b/doc/technology-api.txt
index cdf30396..9740b649 100644
--- a/doc/technology-api.txt
+++ b/doc/technology-api.txt
@@ -107,3 +107,14 @@ Properties	boolean Powered [readwrite]
 
 			This property is only valid for the WiFi technology and it's
 			optional. Default frequency is 2412 Mhz.
+
+		string TetheringAddress [readwrite]
+
+			The tethering interface (bridge) address.
+
+			Configures the IP address used by the tethering
+			interface. Client addresses will be allocated from
+			the same network.
+
+			If this property is not set, the tethering address is
+			selected automatically.
diff --git a/src/connman.h b/src/connman.h
index 32ba5591..74ea84b4 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -680,6 +680,7 @@ int __connman_tethering_init(void);
 void __connman_tethering_cleanup(void);
 
 const char *__connman_tethering_get_bridge(void);
+int __connman_tethering_set_ip(uint32_t);
 int __connman_tethering_set_enabled(void);
 void __connman_tethering_set_disabled(void);
 void __connman_tethering_list_clients(DBusMessageIter *array);
@@ -1039,6 +1040,7 @@ void __connman_ippool_cleanup(void);
 void __connman_ippool_free(struct connman_ippool *pool);
 
 struct connman_ippool *__connman_ippool_create(int index,
+					uint32_t block_req,
 					unsigned int start,
 					unsigned int range,
 					ippool_collision_cb_t collision_cb,
diff --git a/src/ippool.c b/src/ippool.c
index f2e9b000..18a6e023 100644
--- a/src/ippool.c
+++ b/src/ippool.c
@@ -322,6 +322,7 @@ void __connman_ippool_deladdr(int index, const char *address,
 }
 
 struct connman_ippool *__connman_ippool_create(int index,
+					uint32_t block_req,
 					unsigned int start,
 					unsigned int range,
 					ippool_collision_cb_t collision_cb,
@@ -342,7 +343,11 @@ struct connman_ippool *__connman_ippool_create(int index,
 		return NULL;
 	}
 
-	block = get_free_block(start + range);
+	if (block_req)
+		block = block_req;
+	else
+		block = get_free_block(start + range);
+
 	if (block == 0) {
 		connman_warn("Could not find a free IP block");
 		return NULL;
@@ -358,7 +363,8 @@ struct connman_ippool *__connman_ippool_create(int index,
 		return NULL;
 	}
 
-	last_block = block;
+	if (!block_req)
+		last_block = block;
 
 	info->index = index;
 	info->start = block;
@@ -373,7 +379,7 @@ struct connman_ippool *__connman_ippool_create(int index,
 	if (range == 0)
 		range = 1;
 
-	pool->gateway = get_ip(info->start + 1);
+	pool->gateway = get_ip(info->start + (start > 1 ? start - 1 : 1));
 	pool->broadcast = get_ip(info->start + 255);
 	pool->subnet_mask = get_ip(subnet_mask_24);
 	pool->start_ip = get_ip(block + start);
diff --git a/src/peer.c b/src/peer.c
index bad5c841..f9b18ee3 100644
--- a/src/peer.c
+++ b/src/peer.c
@@ -140,7 +140,7 @@ static int start_dhcp_server(struct connman_peer *peer)
 	else
 		index = connman_device_get_index(peer->device);
 
-	peer->ip_pool = __connman_ippool_create(index, 2, 1, NULL, NULL);
+	peer->ip_pool = __connman_ippool_create(index, 0, 2, 1, NULL, NULL);
 	if (!peer->ip_pool)
 		goto error;
 
diff --git a/src/technology.c b/src/technology.c
index 270d83d0..19f95c3a 100644
--- a/src/technology.c
+++ b/src/technology.c
@@ -69,6 +69,7 @@ struct connman_technology {
 	char *tethering_ident;
 	char *tethering_passphrase;
 	int tethering_freq;
+	struct connman_ipaddress *tethering_address;
 
 	bool enable_persistent; /* Save the tech state */
 
@@ -202,6 +203,11 @@ static void technology_save(struct connman_technology *technology)
 				"Tethering.Freq",
 				technology->tethering_freq);
 
+	if (technology->tethering_address)
+		g_key_file_set_string(keyfile, identifier,
+				"Tethering.Address",
+				technology->tethering_address->local);
+
 done:
 	g_free(identifier);
 
@@ -232,6 +238,10 @@ int connman_technology_tethering_notify(struct connman_technology *technology,
 		return -EALREADY;
 
 	if (enabled) {
+		if (technology->tethering_address && technology->tethering_address->local)
+			__connman_tethering_set_ip(ntohl(inet_addr(technology->tethering_address->local)));
+		else
+			__connman_tethering_set_ip(0);
 		err = __connman_tethering_set_enabled();
 		if (err < 0)
 			return err;
@@ -487,6 +497,16 @@ static void technology_load(struct connman_technology *technology)
 	technology->tethering_freq = g_key_file_get_integer(keyfile,
 				identifier, "Tethering.Freq", NULL);
 
+	enc = g_key_file_get_string(keyfile,
+				identifier, "Tethering.Address", NULL);
+	if (enc) {
+		if (!technology->tethering_address)
+			technology->tethering_address = connman_ipaddress_alloc(AF_INET);
+
+		connman_ipaddress_set_ipv4(technology->tethering_address,
+				enc, "255.255.255.0", NULL);
+	}
+
 done:
 	g_free(identifier);
 
@@ -602,6 +622,11 @@ static void append_properties(DBusMessageIter *iter,
 				DBUS_TYPE_INT32,
 				&technology->tethering_freq);
 
+	if (technology->tethering_address)
+		connman_dbus_dict_append_basic(&dict, "TetheringAddress",
+					DBUS_TYPE_STRING,
+					&technology->tethering_address->local);
+
 	connman_dbus_dict_close(iter, &dict);
 }
 
@@ -1037,6 +1062,29 @@ static DBusMessage *set_property(DBusConnection *conn,
 					DBUS_TYPE_INT32,
 					&technology->tethering_freq);
 		}
+	} else if (g_str_equal(name, "TetheringAddress")) {
+		const char *address;
+
+		if (type != DBUS_TYPE_STRING)
+			return __connman_error_invalid_arguments(msg);
+
+		if (technology->type != CONNMAN_SERVICE_TYPE_WIFI)
+			return __connman_error_not_supported(msg);
+
+		dbus_message_iter_get_basic(&value, &address);
+
+		if (g_str_equal(address, "")) {
+			if (technology->tethering_address) {
+				connman_ipaddress_free(technology->tethering_address);
+				technology->tethering_address = NULL;
+			}
+		} else {
+			if (!technology->tethering_address)
+				technology->tethering_address = connman_ipaddress_alloc(AF_INET);
+
+			connman_ipaddress_set_ipv4(technology->tethering_address,
+					address, "255.255.255.0", NULL);
+		}
 	} else if (g_str_equal(name, "Powered")) {
 		dbus_bool_t enable;
 
@@ -1257,6 +1305,7 @@ static void technology_put(struct connman_technology *technology)
 	g_free(technology->regdom);
 	g_free(technology->tethering_ident);
 	g_free(technology->tethering_passphrase);
+	connman_ipaddress_free(technology->tethering_address);
 	g_free(technology);
 }
 
diff --git a/src/tethering.c b/src/tethering.c
index f930a26b..e0e16038 100644
--- a/src/tethering.c
+++ b/src/tethering.c
@@ -56,6 +56,7 @@ static char *private_network_primary_dns = NULL;
 static char *private_network_secondary_dns = NULL;
 
 static volatile int tethering_enabled;
+static uint32_t tethering_ip_address;
 static GDHCPServer *tethering_dhcp_server = NULL;
 static struct connman_ippool *dhcp_ippool = NULL;
 static DBusConnection *connection;
@@ -200,6 +201,14 @@ static void unregister_all_clients(void)
 	g_hash_table_foreach(clients_table, unregister_client, NULL);
 }
 
+int __connman_tethering_set_ip(uint32_t ip)
+{
+	tethering_ip_address = ip;
+	if ((tethering_ip_address & 0xff) == 0)
+		tethering_ip_address |= 1;
+	return 0;
+}
+
 int __connman_tethering_set_enabled(void)
 {
 	int index;
@@ -225,7 +234,9 @@ int __connman_tethering_set_enabled(void)
 	}
 
 	index = connman_inet_ifindex(BRIDGE_NAME);
-	dhcp_ippool = __connman_ippool_create(index, 2, 252,
+	dhcp_ippool = __connman_ippool_create(index, tethering_ip_address & ~0xff,
+						1 + (tethering_ip_address & 0xff),
+						253 - (tethering_ip_address & 0xff),
 						tethering_restart, NULL);
 	if (!dhcp_ippool) {
 		connman_error("Fail to create IP pool");
@@ -592,7 +603,7 @@ int __connman_private_network_request(DBusMessage *msg, const char *owner)
 	pn->fd = fd;
 	pn->interface = iface;
 	pn->index = index;
-	pn->pool = __connman_ippool_create(pn->index, 1, 1, ippool_disconnect, pn);
+	pn->pool = __connman_ippool_create(pn->index, 0, 1, 1, ippool_disconnect, pn);
 	if (!pn->pool) {
 		errno = -ENOMEM;
 		goto error;
diff --git a/unit/test-ippool.c b/unit/test-ippool.c
index a6cae652..8e02d6b1 100644
--- a/unit/test-ippool.c
+++ b/unit/test-ippool.c
@@ -46,11 +46,11 @@ static void test_case_1(void)
 
 	__connman_ippool_init();
 
-	pool = __connman_ippool_create(23, 1, 500, NULL, NULL);
+	pool = __connman_ippool_create(23, 0, 1, 500, NULL, NULL);
 	g_assert(!pool);
 
 	for (i = 0; i < 100000; i++) {
-		pool = __connman_ippool_create(23, 1, 20, NULL, NULL);
+		pool = __connman_ippool_create(23, 0, 1, 20, NULL, NULL);
 		g_assert(pool);
 
 		__connman_ippool_free(pool);
@@ -73,7 +73,7 @@ static void test_case_2(void)
 
 	/* Test the IP range */
 	for (i = 1; i < 254; i++) {
-		pool = __connman_ippool_create(23, 1, i, NULL, NULL);
+		pool = __connman_ippool_create(23, 0, 1, i, NULL, NULL);
 		g_assert(pool);
 
 		gateway = __connman_ippool_get_gateway(pool);
@@ -130,7 +130,7 @@ static void test_case_3(void)
 	__connman_ippool_newaddr(46, "172.16.0.1", 11);
 
 	while (TRUE) {
-		pool = __connman_ippool_create(23, 1, 100, NULL, NULL);
+		pool = __connman_ippool_create(23, 0, 1, 100, NULL, NULL);
 		if (!pool)
 			break;
 		i += 1;
@@ -192,7 +192,7 @@ static void test_case_4(void)
 	/* Test the IP range collision */
 
 	flag = 0;
-	pool = __connman_ippool_create(23, 1, 100, collision_cb, &flag);
+	pool = __connman_ippool_create(23, 0, 1, 100, collision_cb, &flag);
 	g_assert(pool);
 
 	gateway = __connman_ippool_get_gateway(pool);
@@ -223,7 +223,7 @@ static void test_case_4(void)
 
 	flag = 0;
 
-	pool = __connman_ippool_create(23, 1, 100, collision_cb, &flag);
+	pool = __connman_ippool_create(23, 0, 1, 100, collision_cb, &flag);
 	g_assert(pool);
 
 	gateway = __connman_ippool_get_gateway(pool);
@@ -271,7 +271,7 @@ static void test_case_5(void)
 	g_assert(flag == 0);
 
 	/* pool should return 192.168.0.1 now */
-	pool1 = __connman_ippool_create(26, 1, 100, collision_cb, &flag);
+	pool1 = __connman_ippool_create(26, 0, 1, 100, collision_cb, &flag);
 	g_assert(pool1);
 
 	gateway = __connman_ippool_get_gateway(pool1);
@@ -303,7 +303,7 @@ static void test_case_5(void)
 
 	/* pool should return 192.168.2.1 now */
 	flag = 0;
-	pool2 = __connman_ippool_create(23, 1, 100, collision_cb, &flag);
+	pool2 = __connman_ippool_create(23, 0, 1, 100, collision_cb, &flag);
 	g_assert(pool2);
 
 	gateway = __connman_ippool_get_gateway(pool2);
@@ -361,7 +361,7 @@ static void test_case_6(void)
 	g_assert(flag == 0);
 
 	/* pool should return 192.168.2.1 now */
-	pool1 = __connman_ippool_create(26, 1, 100, collision_cb, &flag);
+	pool1 = __connman_ippool_create(26, 0, 1, 100, collision_cb, &flag);
 	g_assert(pool1);
 
 	gateway = __connman_ippool_get_gateway(pool1);
@@ -393,7 +393,7 @@ static void test_case_6(void)
 
 	/* pool should return 192.168.3.1 now */
 	flag = 0;
-	pool2 = __connman_ippool_create(23, 1, 100, collision_cb, &flag);
+	pool2 = __connman_ippool_create(23, 0, 1, 100, collision_cb, &flag);
 	g_assert(pool2);
 
 	gateway = __connman_ippool_get_gateway(pool2);
-- 
2.45.2

