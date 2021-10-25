Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FBF2C9F
	for <connman@lists.linux.dev>; Mon, 25 Oct 2021 13:28:01 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id n1so16691740edd.0
        for <connman@lists.linux.dev>; Mon, 25 Oct 2021 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Cbbs1QpbGP1hChX8tqcFz7SEgXHtL+Hcg3R2TyS/WY=;
        b=Ae6zybcGZgDvpWL82bGYMvYJi4j+Ngbxsq4a7T67dvB4oC+/4OAseHlbUJFhEIsKbU
         o9SjRZxiNAX+09PQ5qR2HlSwXCX6Usb/B8+MUzzJ4fJnnxKZc2uNQQ5CH6d2b2O5qyIi
         O61HA4gNGqsynWKXV4boti9twyq73NSaUJZnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Cbbs1QpbGP1hChX8tqcFz7SEgXHtL+Hcg3R2TyS/WY=;
        b=5LVoLzxTlf3yUtirOum+G/qoYJSaE22kvnXRpb3KMiT3htpPjLxsVlc2umBNMOJ4jf
         PbCOFetzyYs1cCbu6BlS6ITp/H4zlSDhVkR7M2KMvmNH2ZMg0+D+NsBfM4ogT/Cuolw0
         7wcjqjZhZxbhBjD8xJoNfwzfoNqHGPQ/zju5QXFG+K9jEywkLL24RXVPaACudIPetXqA
         jortpmxgEc7shp0bovDv4+DDT8/qmQgXndzcn1MhbfO2w+9MqA8A+IcQgdAPaAmYrifG
         8wIIEac6tt7P9Vp7tax9vRMyDrFx9zCH2tYkQQoTzkHYwSn/iQbTivpusd7oD+L8W11c
         y0Sg==
X-Gm-Message-State: AOAM531jZNHSvVVb94TMQqCaoe+AVbhLbqsGU3j1m3vVmNyqg3zyoSzz
	4MgTnrLoqiw8fr7CVKQ2nO14iexw+bVU+Ft2
X-Google-Smtp-Source: ABdhPJy11RmMw8VOoWuhAvijanWm3jX+W/mT7JiW6DYFLzDt6BMDPyzNU+fbf3TmClWZP3JWU6ggew==
X-Received: by 2002:a17:907:3da7:: with SMTP id he39mr22573325ejc.554.1635168405538;
        Mon, 25 Oct 2021 06:26:45 -0700 (PDT)
Received: from bsh.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id x26sm7426424ejf.103.2021.10.25.06.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 06:26:44 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: Jan.Ryll@bshg.com,
	Simon.Holesch@bshg.com
Subject: [PATCH] Add GetKnownServices api to connaman
Date: Mon, 25 Oct 2021 13:26:43 +0000
Message-Id: <20211025132643.4485-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a way to retrieve all the networks that were configured
using connman and not all the ones visible

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 client/commands.c    | 14 ++++++++++
 src/connman.h        |  1 +
 src/manager.c        | 23 +++++++++++++++++
 src/service.c        | 61 ++++++++++++++++++++++++++++++++++++++++++++
 tools/manager-api.c  | 33 ++++++++++++++++++++++++
 tools/session-test.h |  1 +
 6 files changed, 133 insertions(+)

diff --git a/client/commands.c b/client/commands.c
index 53cc14c8..f4366e8c 100644
--- a/client/commands.c
+++ b/client/commands.c
@@ -420,6 +420,18 @@ static int cmd_services(char *args[], int num, struct connman_option *options)
 			object_properties, path, NULL, NULL);
 }
 
+static int cmd_known_services(char *args[], int num, struct connman_option *options)
+{
+	if (num > 1)
+		return -E2BIG;
+
+	return __connmanctl_dbus_method_call(connection,
+			 CONNMAN_SERVICE, CONNMAN_PATH,
+			 "net.connman.Manager",
+			 "GetKnownServices",
+			 services_list, NULL, NULL, NULL);
+}
+
 static int cmd_peers(char *args[], int num, struct connman_option *options)
 {
 	char *peer_name = NULL;
@@ -2808,6 +2820,8 @@ static const struct {
 	  "Display tethering clients", NULL },
 	{ "services",     "[<service>]",  service_options, cmd_services,
 	  "Display services", lookup_service_arg },
+	{ "known-services", NULL,  NULL, cmd_known_services,
+	  "Display known services", NULL },
 	{ "peers",        "[peer]",       NULL,            cmd_peers,
 	  "Display peers", lookup_peer_arg },
 	{ "scan",         "<technology>", NULL,            cmd_scan,
diff --git a/src/connman.h b/src/connman.h
index 68176086..cdc88532 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -682,6 +682,7 @@ int __connman_service_move(struct connman_service *service,
 				struct connman_service *target, bool before);
 int __connman_service_load_modifiable(struct connman_service *service);
 
+void __connman_known_service_list_struct(DBusMessageIter *iter);
 void __connman_service_list_struct(DBusMessageIter *iter);
 
 int __connman_service_compare(const struct connman_service *a,
diff --git a/src/manager.c b/src/manager.c
index 892d3a42..b196109a 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -175,6 +175,11 @@ static const struct connman_notifier technology_notifier = {
 	.idle_state	= idle_state,
 };
 
+static void append_known_service_structs(DBusMessageIter *iter, void *user_data)
+{
+	__connman_known_service_list_struct(iter);
+}
+
 static void append_service_structs(DBusMessageIter *iter, void *user_data)
 {
 	__connman_service_list_struct(iter);
@@ -195,6 +200,21 @@ static DBusMessage *get_services(DBusConnection *conn,
 	return reply;
 }
 
+static DBusMessage *get_known_services(DBusConnection *conn,
+				   DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	__connman_dbus_append_objpath_dict_array(reply,
+				 append_known_service_structs, NULL);
+
+	return reply;
+}
+
 static void append_peer_structs(DBusMessageIter *iter, void *user_data)
 {
 	__connman_peer_list_struct(iter);
@@ -534,6 +554,9 @@ static const GDBusMethodTable manager_methods[] = {
 	{ GDBUS_DEPRECATED_METHOD("RemoveProvider",
 			GDBUS_ARGS({ "provider", "o" }), NULL,
 			remove_provider) },
+	{ GDBUS_METHOD("GetKnownServices",
+			NULL, GDBUS_ARGS({"knownServices", "a(oa{sv})" }),
+			get_known_services) },
 	{ GDBUS_METHOD("GetServices",
 			NULL, GDBUS_ARGS({ "services", "a(oa{sv})" }),
 			get_services) },
diff --git a/src/service.c b/src/service.c
index 8d3c75a5..52f64005 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2705,6 +2705,67 @@ static void append_struct(gpointer value, gpointer user_data)
 	append_struct_service(iter, append_dict_properties, service);
 }
 
+void __connman_known_service_list_struct(DBusMessageIter *iter)
+{
+	gchar **services = NULL;
+	gchar **service_id_parts = NULL;
+	guint i = 0;
+	struct connman_service *service = NULL;
+
+	DBG("listing known services");
+
+	services = connman_storage_get_services();
+	if (services == NULL)
+		return;
+
+	for (i = 0; i < g_strv_length(services); i++) {
+		service = connman_service_create();
+		if (service == NULL) {
+			connman_error("connman_service_create() allocation failed");
+			return;
+		}
+
+		service->identifier = g_strdup(services[i]);
+		service_id_parts = g_strsplit(services[i], "_", -1);
+
+		if (service_id_parts == NULL) {
+			g_free(service);
+			continue;
+		}
+
+		service->type = __connman_service_string2type(service_id_parts[0]);
+		service->path = g_strdup_printf("%s/service/%s", CONNMAN_PATH, service->identifier);
+		if (service->type == CONNMAN_SERVICE_TYPE_WIFI)
+		service->security = __connman_service_string2security(service_id_parts[g_strv_length(service_id_parts) - 1]);
+
+		if (service->path == NULL) {
+			g_strfreev(service_id_parts);
+			continue;
+		}
+
+		if (find_service(service->path) != NULL)
+			service->state = (find_service(service->path))->state;
+
+		if (service->type == CONNMAN_SERVICE_TYPE_ETHERNET &&
+		    find_service(service->path) != NULL)
+			service->name = (find_service(service->path))->name;
+
+		if (0 != service_load(service)) {
+			connman_error("service_load() returned error");
+			g_free(service);
+			g_strfreev(service_id_parts);
+			g_strfreev(services);
+			return;
+		}
+
+		append_struct_service(iter, append_dict_properties, service);
+		g_strfreev(service_id_parts);
+		g_free(service);
+	}
+
+	g_strfreev(services);
+}
+
 void __connman_service_list_struct(DBusMessageIter *iter)
 {
 	g_list_foreach(service_list, append_struct, iter);
diff --git a/tools/manager-api.c b/tools/manager-api.c
index e082962d..99035988 100644
--- a/tools/manager-api.c
+++ b/tools/manager-api.c
@@ -64,6 +64,39 @@ static DBusMessage *set_property(DBusConnection *connection,
 	return reply;
 }
 
+DBusMessage *manager_get_known_services(DBusConnection *connection)
+{
+	DBusMessage *message, *reply;
+	DBusError error;
+
+	message = dbus_message_new_method_call(CONNMAN_SERVICE,
+				   CONNMAN_MANAGER_PATH,
+				   CONNMAN_MANAGER_INTERFACE,
+				   "GetKnownServices");
+
+	if (!message)
+		return NULL;
+
+	dbus_error_init(&error);
+
+	reply = dbus_connection_send_with_reply_and_block(connection,
+				  message, -1, &error);
+	if (!reply) {
+		if (dbus_error_is_set(&error)) {
+			LOG("%s", error.message);
+			dbus_error_free(&error);
+		} else {
+			LOG("Failed to get known services");
+		}
+		dbus_message_unref(message);
+		return NULL;
+	}
+
+	dbus_message_unref(message);
+
+	return reply;
+}
+
 DBusMessage *manager_get_services(DBusConnection *connection)
 {
 	DBusMessage *message, *reply;
diff --git a/tools/session-test.h b/tools/session-test.h
index 2c068bd7..ab89f8c5 100644
--- a/tools/session-test.h
+++ b/tools/session-test.h
@@ -114,6 +114,7 @@ DBusMessage *session_disconnect(DBusConnection *connection,
 					struct test_session *session);
 
 /* manager-api.c */
+DBusMessage *manager_get_known_services(DBusConnection *connection);
 DBusMessage *manager_get_services(DBusConnection *connection);
 DBusMessage *manager_get_properties(DBusConnection *connection);
 DBusMessage *manager_create_session(DBusConnection *connection,
-- 
2.25.1

