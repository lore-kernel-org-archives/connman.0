Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8431EE036
	for <connman@lists.linux.dev>; Tue,  7 Jan 2025 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254609; cv=none; b=GznewpzUys3K02Ywi5LnkAAo7ZtVxjeMTPFs8Z5wTSh1BSICuCNWigdwRpmytS2xXsirl/7J16xOR+cBiVqzV4d0vsgBwDQ0F4U1/+ccQXw4VdnsdD7EKfs7lPqyyNEs7cKFLBGgsma0f7k7zYJbieHja7hE8ceuPhKmnzXga/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254609; c=relaxed/simple;
	bh=EhROavvxTx5AX70VrX5fvycz+nxoJZ/BkpLQGcHWk58=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BhItEub+Ye9LpOCDvNCm4lEzwVcfUB1LHcYyjVAu18P4vofl6sumT5EmZvqJqEYoS7cvuxc8mnxGxWZ0lScvLQ5lg6yPgapQRrOxIMFuLp8ifhvq9JmGJMAUp4rjSLetpfsVw+ZkGo8EvHNniRo6Yn9NUTIh/wrHK1xZvli8RYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=CmzMz/al; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CmzMz/al"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43622267b2eso161912695e9.0
        for <connman@lists.linux.dev>; Tue, 07 Jan 2025 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1736254603; x=1736859403; darn=lists.linux.dev;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SI4Jf1w6pwub6Z3tTsmDdXIeLkxb4UcI+ezrR/EuWTI=;
        b=CmzMz/all1WmbE+gFQQS9e2/BLQsy9Bqw1eiJv/y2SQxE+dahTAl3qEPNvdcvxWedm
         T+CeGons59TWGazhyId4itnrDIhwd7DEFghMvwL8hrvU67Xr98wD1ndNwYM1lRKiTwvD
         c7GQy6twhTOWkMN1fJ0c7bJHunwWChGWUmo7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254603; x=1736859403;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI4Jf1w6pwub6Z3tTsmDdXIeLkxb4UcI+ezrR/EuWTI=;
        b=cRIvh7OybNtPNh8RlkgSXFRkDGOaqN6FZa7p2axI7Pr38pK0Zo9WGQAzROHBh3HAgZ
         J10d9q6sK408hS2GluXE0m/SpmsNcUn9ECM4JWAr+WT1YlOQjRKUG11DHxrZDJy+BA4n
         mW1PjsHDPEAl2/TQD8xsi3Vfk6EQT81kStf3R2bzC6SLvBvk3X2Oy1UDqtkrd2NKfedJ
         SIe7lZI4rc7nlZO4TPjIjdPlqhXIDcWLoEt16zVcEpxyEXaHc7zNadOGf6hu73bUZa8N
         MTLiuhENU0kDrHePrv5drkt3sjcjhwhVOo5TpQCqVkGki/o6cdGTrVPttORruByGqyj8
         59+w==
X-Gm-Message-State: AOJu0Yx8BGDu18ixq3XCmhf4ULEFRSjj0oS58iTqCger4BKJEfQe3ECt
	OjTQoKHQfr9YrIhL6jh8TSiWrXr7fWMgefGVMQW3hEWxEoJvropeJKP2gWP4SmzlFJ7upNzVi/t
	tVn0=
X-Gm-Gg: ASbGncvzVaH1DpORx4P4avlheitVyHXzi9L2g8N5wcgcs4Ioa15YHHRSzEGK3wx+pNn
	QUOmk1d4/ogCvivaTJ5D+kaERSNZNacggpvucYgHZqcEmfMYEXilfvej6slWP79dkfkXZR6qJUo
	P+PF59VLAhh3SmkkxlsL3eHI4AARkVH0tUO2ufvSiGePuo/MjwAfQ1rtuhwhT0EZuc15XizDJI9
	HdJcP0zQi8g8cYCz4sbc3FgyWZG2XmCkefQR0xSgELAtDLkYAcypc0=
X-Google-Smtp-Source: AGHT+IGSoQtd3XZNL/YSduAjdXhL4Tq61iWsNlzkreo7/jmiv6HhSM82IpmUdUiAZ6Tx+Z0/3AyJZA==
X-Received: by 2002:a05:600c:3110:b0:434:ffb2:f9df with SMTP id 5b1f17b1804b1-43668646bb5mr563926955e9.17.1736254603357;
        Tue, 07 Jan 2025 04:56:43 -0800 (PST)
Received: from smrz ([93.90.163.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b441bbsm627979125e9.40.2025.01.07.04.56.42
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:56:42 -0800 (PST)
Date: Tue, 7 Jan 2025 13:56:41 +0100
From: Roman =?utf-8?B?U21yxb4=?= <roman@amarulasolutions.com>
To: connman@lists.linux.dev
Subject: Manual configuration of tethering IP address
Message-ID: <Z30kiZZrfMQw8yI0@smrz>
Mail-Followup-To: connman@lists.linux.dev
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3+SeYEJ7FQvUmGHd"
Content-Disposition: inline


--3+SeYEJ7FQvUmGHd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

we have a use case where we need to manually configure the IP address
and network used by connman for the tethering interface. For that, I've
added TetheringAddress property to the Technology interface.

I am attaching the patch as we have it now. If this functionality and
approach makes sense to you and you have some comments, I'll update the
patch as necessary so it could be merged upstream.

Best Regards
	Roman

--3+SeYEJ7FQvUmGHd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-technology-Tethering-address-configuration.patch"

From 38767f65169d063d7b87a06fe7692bd6a841c128 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Roman=20Smr=C5=BE?= <roman@amarulasolutions.com>
Date: Thu, 28 Nov 2024 16:35:26 +0100
Subject: [PATCH] technology: Tethering address configuration

Add a new TetheringAddress property to the Technology API, which, when
set, configures the used router address of the tethering interface, and
makes the addresses assigned to the clients come from that IP network.
---
 doc/technology-api.txt | 11 ++++++++++
 src/connman.h          |  2 ++
 src/ippool.c           |  7 +++---
 src/peer.c             |  2 +-
 src/technology.c       | 49 ++++++++++++++++++++++++++++++++++++++++++
 src/tethering.c        | 15 +++++++++++--
 unit/test-ippool.c     | 20 ++++++++---------
 7 files changed, 90 insertions(+), 16 deletions(-)

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
index 32ba5591..3d7952b7 100644
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
+					uint32_t block,
 					unsigned int start,
 					unsigned int range,
 					ippool_collision_cb_t collision_cb,
diff --git a/src/ippool.c b/src/ippool.c
index f2e9b000..84c4a8d4 100644
--- a/src/ippool.c
+++ b/src/ippool.c
@@ -322,6 +322,7 @@ void __connman_ippool_deladdr(int index, const char *address,
 }
 
 struct connman_ippool *__connman_ippool_create(int index,
+					uint32_t block,
 					unsigned int start,
 					unsigned int range,
 					ippool_collision_cb_t collision_cb,
@@ -329,7 +330,6 @@ struct connman_ippool *__connman_ippool_create(int index,
 {
 	struct connman_ippool *pool;
 	struct address_info *info;
-	uint32_t block;
 
 	DBG("");
 
@@ -342,7 +342,8 @@ struct connman_ippool *__connman_ippool_create(int index,
 		return NULL;
 	}
 
-	block = get_free_block(start + range);
+	if (block == 0)
+		block = get_free_block(start + range);
 	if (block == 0) {
 		connman_warn("Could not find a free IP block");
 		return NULL;
@@ -373,7 +374,7 @@ struct connman_ippool *__connman_ippool_create(int index,
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


--3+SeYEJ7FQvUmGHd--
