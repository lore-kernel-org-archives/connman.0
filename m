Received: from mx1.kistler.com (mx1.kistler.com [91.223.79.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4625323C
	for <connman@lists.linux.dev>; Tue,  8 Nov 2022 07:20:03 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.96,147,1665439200"; 
   d="scan'208";a="53599282"
Received: from sl-win-seppm-1.int.kistler.com ([192.168.52.67])
  by mx1.kistler.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 07:56:07 +0100
Received: from mx1.kistler.com (kihagciip01.int.kistler.com [192.168.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sl-win-seppm-1.int.kistler.com (Postfix) with ESMTPS
	for <connman@lists.linux.dev>; Tue,  8 Nov 2022 08:18:52 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.96,147,1665439200"; 
   d="scan'208";a="53599281"
Received: from sw-win-exch-2.int.kistler.com ([192.168.100.96])
  by mx1.kistler.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 07:56:06 +0100
Received: from SW-WIN-EXCH-1.int.kistler.com (192.168.100.95) by
 SW-WIN-EXCH-2.int.kistler.com (192.168.100.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Nov 2022 08:18:51 +0100
Received: from VL-BTS-Cvo-1.int.kistler.com (192.168.100.116) by
 SW-WIN-EXCH-1.int.kistler.com (192.168.100.95) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 8 Nov 2022 08:18:51 +0100
From: Miroslav Cuvar <miroslav.cuvar@kistler.com>
To: <connman@lists.linux.dev>
CC: Miroslav Cuvar <miroslav.cuvar@kistler.com>
Subject: [PATCH 1/1] Added support for setting preferred IP for WiFi tethering
Date: Tue, 8 Nov 2022 08:18:20 +0100
Message-ID: <20221108071820.14101-1-miroslav.cuvar@kistler.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-C2ProcessedOrg: 78a97207-3cfa-406d-a777-069c09c1300a
Content-Transfer-Encoding: quoted-printable
X-SM-outgoing: yes

Hello,

This patch is to enable the user to set a preferred IP when enabling WiFi t=
ethering, if the preferred IP is not available, the closest next available =
IP will be used.
The preferred IP is set using DBus and it works by explicitly setting the s=
tarting block in static uint32_t get_free_block(unsigned int);
Would a feature like this benefit the connman project?

Signed-off-by: Miroslav Cuvar <miroslav.cuvar@kistler.com>
---
 doc/technology-api.txt |  8 ++++++++
 src/connman.h          |  6 +++++-
 src/ippool.c           | 19 +++++++++++-------
 src/peer.c             |  2 +-
 src/technology.c       | 45 ++++++++++++++++++++++++++++++++++++++++++
 src/tethering.c        | 11 +++++++++--
 unit/test-ippool.c     | 20 +++++++++----------
 7 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/doc/technology-api.txt b/doc/technology-api.txt
index cdf30396..4492a7f6 100644
--- a/doc/technology-api.txt
+++ b/doc/technology-api.txt
@@ -107,3 +107,11 @@ Properties	boolean Powered [readwrite]
=20
 			This property is only valid for the WiFi technology and it's
 			optional. Default frequency is 2412 Mhz.
+
+		int TetheringPreferredIP [readwrite]
+
+			Preferred start IP for WiFi tethering IP pool. If the IP is not
+			free, closest next free IP will be chosen.
+
+			This property is only valid for the WiFi technology and it's
+			optional. Default value is 0, which means no preference for IP.=20
diff --git a/src/connman.h b/src/connman.h
index b955d98b..d4aaf7a0 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -649,6 +649,7 @@ const char *__connman_tethering_get_bridge(void);
 int __connman_tethering_set_enabled(void);
 void __connman_tethering_set_disabled(void);
 void __connman_tethering_list_clients(DBusMessageIter *array);
+void __connman_tethering_set_preferred_ip(uint32_t preferred_ip);
=20
 int __connman_private_network_request(DBusMessage *msg, const char *owner)=
;
 int __connman_private_network_release(const char *path);
@@ -1007,7 +1008,8 @@ struct connman_ippool *__connman_ippool_create(int in=
dex,
 					unsigned int start,
 					unsigned int range,
 					ippool_collision_cb_t collision_cb,
-					void *user_data);
+					void *user_data,
+					uint32_t preferred_ip);
=20
 const char *__connman_ippool_get_gateway(struct connman_ippool *pool);
 const char *__connman_ippool_get_broadcast(struct connman_ippool *pool);
@@ -1020,6 +1022,8 @@ void __connman_ippool_newaddr(int index, const char *=
address,
 void __connman_ippool_deladdr(int index, const char *address,
 				unsigned char prefixlen);
=20
+bool __connman_ippool_is_private_address(uint32_t address);
+
 int __connman_bridge_create(const char *name);
 int __connman_bridge_remove(const char *name);
 int __connman_bridge_enable(const char *name, const char *ip_address,
diff --git a/src/ippool.c b/src/ippool.c
index f2e9b000..3be47d95 100644
--- a/src/ippool.c
+++ b/src/ippool.c
@@ -152,7 +152,7 @@ static uint32_t next_block(uint32_t block)
 	return (block & 0xffff0000) | ((next << 8) & 0x0000ff00);
 }
=20
-static uint32_t get_free_block(unsigned int size)
+static uint32_t get_free_block(unsigned int size, uint32_t preferred_ip)
 {
 	struct address_info *info;
 	uint32_t block;
@@ -160,6 +160,8 @@ static uint32_t get_free_block(unsigned int size)
 	bool collision;
=20
 	/*
+	 * If the preferred_ip is specified we try to use that IP or the
+	 * closest next free IP.
 	 * Instead starting always from the 16 bit block, we start
 	 * from the last assigned block. This is a simple optimimazion
 	 * for the case where a lot of blocks have been assigned, e.g.
@@ -169,7 +171,9 @@ static uint32_t get_free_block(unsigned int size)
 	 * To only thing we have to make sure is that we terminated if
 	 * there is no block left.
 	 */
-	if (last_block)
+	if (preferred_ip !=3D 0)
+       		block =3D preferred_ip;
+    	else if (last_block)
 		block =3D last_block;
 	else
 		block =3D block_16_bits;
@@ -208,7 +212,7 @@ static struct address_info *lookup_info(int index, uint=
32_t start)
 	return NULL;
 }
=20
-static bool is_private_address(uint32_t address)
+bool __connman_ippool_is_private_address(uint32_t address)
 {
 	unsigned int a, b;
=20
@@ -234,7 +238,7 @@ void __connman_ippool_newaddr(int index, const char *ad=
dress,
 		return;
=20
 	start =3D ntohl(inp.s_addr);
-	if (!is_private_address(start))
+	if (!__connman_ippool_is_private_address(start))
 		return;
=20
 	if (prefixlen >=3D 32)
@@ -297,7 +301,7 @@ void __connman_ippool_deladdr(int index, const char *ad=
dress,
 		return;
=20
 	start =3D ntohl(inp.s_addr);
-	if (!is_private_address(start))
+	if (!__connman_ippool_is_private_address(start))
 		return;
=20
 	mask =3D ~(0xffffffff >> prefixlen);
@@ -325,7 +329,8 @@ struct connman_ippool *__connman_ippool_create(int inde=
x,
 					unsigned int start,
 					unsigned int range,
 					ippool_collision_cb_t collision_cb,
-					void *user_data)
+					void *user_data,
+					uint32_t preferred_ip)
 {
 	struct connman_ippool *pool;
 	struct address_info *info;
@@ -342,7 +347,7 @@ struct connman_ippool *__connman_ippool_create(int inde=
x,
 		return NULL;
 	}
=20
-	block =3D get_free_block(start + range);
+	block =3D get_free_block(start + range, preferred_ip);
 	if (block =3D=3D 0) {
 		connman_warn("Could not find a free IP block");
 		return NULL;
diff --git a/src/peer.c b/src/peer.c
index bad5c841..5406da37 100644
--- a/src/peer.c
+++ b/src/peer.c
@@ -140,7 +140,7 @@ static int start_dhcp_server(struct connman_peer *peer)
 	else
 		index =3D connman_device_get_index(peer->device);
=20
-	peer->ip_pool =3D __connman_ippool_create(index, 2, 1, NULL, NULL);
+	peer->ip_pool =3D __connman_ippool_create(index, 2, 1, NULL, NULL, 0);
 	if (!peer->ip_pool)
 		goto error;
=20
diff --git a/src/technology.c b/src/technology.c
index 5c469111..ff085ec2 100644
--- a/src/technology.c
+++ b/src/technology.c
@@ -67,6 +67,10 @@ struct connman_technology {
 	char *tethering_ident;
 	char *tethering_passphrase;
 	int tethering_freq;
+	char *tethering_preferred_ip; /* WIFI specific, used as first IP
+				       * when searching for free block when
+				       * starting tethering.
+				       */
=20
 	bool enable_persistent; /* Save the tech state */
=20
@@ -175,6 +179,12 @@ static void technology_save(struct connman_technology =
*technology)
 	if (!identifier)
 		goto done;
=20
+	if (technology->tethering_preferred_ip){
+		g_key_file_set_string(keyfile, identifier,
+		"Tethering.PreferredIP",
+		technology->tethering_preferred_ip);
+	}
+
 	g_key_file_set_boolean(keyfile, identifier, "Enable",
 				technology->enable_persistent);
=20
@@ -229,6 +239,9 @@ int connman_technology_tethering_notify(struct connman_=
technology *technology,
 	if (technology->tethering =3D=3D enabled)
 		return -EALREADY;
=20
+	if (technology->type =3D=3D CONNMAN_SERVICE_TYPE_WIFI && technology->teth=
ering_preferred_ip !=3D NULL)
+		__connman_tethering_set_preferred_ip(ntohl(inet_addr(technology->tetheri=
ng_preferred_ip)));
+
 	if (enabled) {
 		err =3D __connman_tethering_set_enabled();
 		if (err < 0)
@@ -461,6 +474,9 @@ static void technology_load(struct connman_technology *=
technology)
 	technology->tethering_freq =3D g_key_file_get_integer(keyfile,
 				identifier, "Tethering.Freq", NULL);
=20
+	technology->tethering_preferred_ip =3D g_key_file_get_string(keyfile,
+			identifier, "Tethering.PreferredIP", NULL);
+
 done:
 	g_free(identifier);
=20
@@ -576,6 +592,11 @@ static void append_properties(DBusMessageIter *iter,
 				DBUS_TYPE_INT32,
 				&technology->tethering_freq);
=20
+	if (technology->tethering_preferred_ip)
+		connman_dbus_dict_append_basic(&dict, "TetheringPreferredIP",
+		DBUS_TYPE_STRING,
+		&technology->tethering_preferred_ip);
+
 	connman_dbus_dict_close(iter, &dict);
 }
=20
@@ -1011,6 +1032,29 @@ static DBusMessage *set_property(DBusConnection *con=
n,
 					DBUS_TYPE_INT32,
 					&technology->tethering_freq);
 		}
+	} else if (g_str_equal(name, "TetheringPreferredIP")) {
+		const char *str;
+
+		dbus_message_iter_get_basic(&value, &str);
+		if (technology->type !=3D CONNMAN_SERVICE_TYPE_WIFI)
+			return __connman_error_not_supported(msg);
+
+		uint32_t preferred_ip	=3D ntohl(inet_addr(str));
+		if (preferred_ip !=3D 0 && !__connman_ippool_is_private_address(preferre=
d_ip)) {
+			return __connman_error_invalid_arguments(msg);
+		}
+=20
+		if (g_strcmp0(technology->tethering_preferred_ip, str) !=3D 0) {
+			g_free(technology->tethering_preferred_ip);
+			technology->tethering_preferred_ip =3D g_strdup(str);
+			technology_save(technology);
+
+			connman_dbus_property_changed_basic(technology->path,
+				CONNMAN_TECHNOLOGY_INTERFACE,
+				"TetheringPreferredIP",
+				DBUS_TYPE_STRING,
+				&technology->tethering_preferred_ip);
+		}
 	} else if (g_str_equal(name, "Powered")) {
 		dbus_bool_t enable;
=20
@@ -1231,6 +1275,7 @@ static void technology_put(struct connman_technology =
*technology)
 	g_free(technology->regdom);
 	g_free(technology->tethering_ident);
 	g_free(technology->tethering_passphrase);
+	g_free(technology->tethering_preferred_ip);
 	g_free(technology);
 }
=20
diff --git a/src/tethering.c b/src/tethering.c
index f930a26b..05958ddd 100644
--- a/src/tethering.c
+++ b/src/tethering.c
@@ -63,6 +63,8 @@ static GHashTable *pn_hash;
=20
 static GHashTable *clients_table;
=20
+static uint32_t tethering_preferred_ip =3D 0;
+
 struct _clients_notify {
 	int id;
 	GHashTable *remove;
@@ -226,7 +228,7 @@ int __connman_tethering_set_enabled(void)
=20
 	index =3D connman_inet_ifindex(BRIDGE_NAME);
 	dhcp_ippool =3D __connman_ippool_create(index, 2, 252,
-						tethering_restart, NULL);
+						tethering_restart, NULL, tethering_preferred_ip);
 	if (!dhcp_ippool) {
 		connman_error("Fail to create IP pool");
 		__connman_bridge_remove(BRIDGE_NAME);
@@ -592,7 +594,7 @@ int __connman_private_network_request(DBusMessage *msg,=
 const char *owner)
 	pn->fd =3D fd;
 	pn->interface =3D iface;
 	pn->index =3D index;
-	pn->pool =3D __connman_ippool_create(pn->index, 1, 1, ippool_disconnect, =
pn);
+	pn->pool =3D __connman_ippool_create(pn->index, 1, 1, ippool_disconnect, =
pn, 0);
 	if (!pn->pool) {
 		errno =3D -ENOMEM;
 		goto error;
@@ -691,3 +693,8 @@ void __connman_tethering_cleanup(void)
=20
 	dbus_connection_unref(connection);
 }
+
+void __connman_tethering_set_preferred_ip(uint32_t preferred_ip){
+    DBG("Setting prefered IP: %d", preferred_ip);
+    tethering_preferred_ip =3D preferred_ip;
+}
diff --git a/unit/test-ippool.c b/unit/test-ippool.c
index a6cae652..ec4727c2 100644
--- a/unit/test-ippool.c
+++ b/unit/test-ippool.c
@@ -46,11 +46,11 @@ static void test_case_1(void)
=20
 	__connman_ippool_init();
=20
-	pool =3D __connman_ippool_create(23, 1, 500, NULL, NULL);
+	pool =3D __connman_ippool_create(23, 1, 500, NULL, NULL, 0);
 	g_assert(!pool);
=20
 	for (i =3D 0; i < 100000; i++) {
-		pool =3D __connman_ippool_create(23, 1, 20, NULL, NULL);
+		pool =3D __connman_ippool_create(23, 1, 20, NULL, NULL, 0);
 		g_assert(pool);
=20
 		__connman_ippool_free(pool);
@@ -73,7 +73,7 @@ static void test_case_2(void)
=20
 	/* Test the IP range */
 	for (i =3D 1; i < 254; i++) {
-		pool =3D __connman_ippool_create(23, 1, i, NULL, NULL);
+		pool =3D __connman_ippool_create(23, 1, i, NULL, NULL, 0);
 		g_assert(pool);
=20
 		gateway =3D __connman_ippool_get_gateway(pool);
@@ -130,7 +130,7 @@ static void test_case_3(void)
 	__connman_ippool_newaddr(46, "172.16.0.1", 11);
=20
 	while (TRUE) {
-		pool =3D __connman_ippool_create(23, 1, 100, NULL, NULL);
+		pool =3D __connman_ippool_create(23, 1, 100, NULL, NULL, 0);
 		if (!pool)
 			break;
 		i +=3D 1;
@@ -192,7 +192,7 @@ static void test_case_4(void)
 	/* Test the IP range collision */
=20
 	flag =3D 0;
-	pool =3D __connman_ippool_create(23, 1, 100, collision_cb, &flag);
+	pool =3D __connman_ippool_create(23, 1, 100, collision_cb, &flag, 0);
 	g_assert(pool);
=20
 	gateway =3D __connman_ippool_get_gateway(pool);
@@ -223,7 +223,7 @@ static void test_case_4(void)
=20
 	flag =3D 0;
=20
-	pool =3D __connman_ippool_create(23, 1, 100, collision_cb, &flag);
+	pool =3D __connman_ippool_create(23, 1, 100, collision_cb, &flag, 0);
 	g_assert(pool);
=20
 	gateway =3D __connman_ippool_get_gateway(pool);
@@ -271,7 +271,7 @@ static void test_case_5(void)
 	g_assert(flag =3D=3D 0);
=20
 	/* pool should return 192.168.0.1 now */
-	pool1 =3D __connman_ippool_create(26, 1, 100, collision_cb, &flag);
+	pool1 =3D __connman_ippool_create(26, 1, 100, collision_cb, &flag, 0);
 	g_assert(pool1);
=20
 	gateway =3D __connman_ippool_get_gateway(pool1);
@@ -303,7 +303,7 @@ static void test_case_5(void)
=20
 	/* pool should return 192.168.2.1 now */
 	flag =3D 0;
-	pool2 =3D __connman_ippool_create(23, 1, 100, collision_cb, &flag);
+	pool2 =3D __connman_ippool_create(23, 1, 100, collision_cb, &flag, 0);
 	g_assert(pool2);
=20
 	gateway =3D __connman_ippool_get_gateway(pool2);
@@ -361,7 +361,7 @@ static void test_case_6(void)
 	g_assert(flag =3D=3D 0);
=20
 	/* pool should return 192.168.2.1 now */
-	pool1 =3D __connman_ippool_create(26, 1, 100, collision_cb, &flag);
+	pool1 =3D __connman_ippool_create(26, 1, 100, collision_cb, &flag, 0);
 	g_assert(pool1);
=20
 	gateway =3D __connman_ippool_get_gateway(pool1);
@@ -393,7 +393,7 @@ static void test_case_6(void)
=20
 	/* pool should return 192.168.3.1 now */
 	flag =3D 0;
-	pool2 =3D __connman_ippool_create(23, 1, 100, collision_cb, &flag);
+	pool2 =3D __connman_ippool_create(23, 1, 100, collision_cb, &flag, 0);
 	g_assert(pool2);
=20
 	gateway =3D __connman_ippool_get_gateway(pool2);
--=20
2.17.1


Confidentiality Notice: This e-mail is privileged and confidential and for =
the use of the addressee only. Should you have received this e-mail in erro=
r please notify us by replying directly to the sender or by sending a messa=
ge to info@kistler.com. Unauthorised dissemination, disclosure or copying o=
f the contents of this e-mail, or any similar action, is prohibited. =0A=
