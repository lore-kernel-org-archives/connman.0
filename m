Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FA2C81
	for <connman@lists.linux.dev>; Wed, 27 Oct 2021 14:01:57 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 5so10942449edw.7
        for <connman@lists.linux.dev>; Wed, 27 Oct 2021 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cjbgz3ij9mvZ1TBuymRLF7ENJZV6jMPUYYLnTF3GVuM=;
        b=m8luXUS3KL+ZexZbJ0GmCoXDndDdzP12SZCFwCr2zzrB7FcbtlBy3F8+shz8SzzlcB
         RE0zBt/tw6jzm/GMXl3m7zl0oT5KquLAjqj2V8q9qv6hEfjs5rf//D2OUK9A+7Tg3pjL
         nLHa8O0EjxN1wceogBxZ9dFzCKTV1zkNAwBPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cjbgz3ij9mvZ1TBuymRLF7ENJZV6jMPUYYLnTF3GVuM=;
        b=dwui2lfISAki4tu/Ks76FWeJtoF4DTDn/cX3Aa6QiGJUVceHnHpWf5rmHdgy5Byn47
         CFhufchIJWDTI8aGJM5i++d+NDdJB+YXC7uBpAIgQlAwsQSmQiSS7FC4VYzpCK6ydnmv
         j4huHp5BCehwf8iomJM1Avz/68oDbtoSoBTTkIMGx2URVAyvDv+Ao0FXvbJjFIr4TSwB
         6bEpMagZMOBhTcQB2c7EQw3XRyx3Dqt4PNuPHqga5WPGt0vaVUSAoXI7rlrWkE+b5Z88
         G9XNUUo0PlH9rkie2YWZzeUE+wOLGnpTj5cDub85TC1gnidyV9qvf+rKGpuslJVKR131
         kblQ==
X-Gm-Message-State: AOAM533b+ukwTszxLNmy30eqkLBi3fFa95Nkflnq54QIxt1w2vJrgMwc
	NzSdXaxCFiO0JsIg5it4TbhfH8LOV4EZ6zZU
X-Google-Smtp-Source: ABdhPJxOLhllMj9ZMHJ2yAJyZyMJxkHUd1t5StUxugrizg/6ZWklSquH4frFRHHrUwXkAYl1hdL4Tw==
X-Received: by 2002:a17:907:1caa:: with SMTP id nb42mr26553754ejc.333.1635343302523;
        Wed, 27 Oct 2021 07:01:42 -0700 (PDT)
Received: from localhost.localdomain (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id hp13sm9357490ejc.66.2021.10.27.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:01:42 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev,
	Daniel Wagner <wagi@monom.org>
Cc: Jan.Ryll@bshg.com,
	Simon.Holesch@bshg.com
Subject: [PATCH V2] Add GetKnownServices api to connaman
Date: Wed, 27 Oct 2021 14:01:41 +0000
Message-Id: <20211027140141.9267-1-michael@amarulasolutions.com>
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

---
Changes V1->V2:
	- remove SoB
	- Add documentation
	- remove LOG print
	- Avoid check null on functions that assert
	- adjust the function the look for service
	- clean up a bit variable name
	- remove initialization of variables that are not needed
---
 client/commands.c    | 14 +++++++++++
 doc/manager-api.txt  | 12 ++++++++++
 src/connman.h        |  1 +
 src/manager.c        | 23 ++++++++++++++++++
 src/service.c        | 55 ++++++++++++++++++++++++++++++++++++++++++++
 tools/manager-api.c  | 30 ++++++++++++++++++++++++
 tools/session-test.h |  1 +
 7 files changed, 136 insertions(+)

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
diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index 6eaa0a38..093b25c1 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -39,6 +39,18 @@ Methods		dict GetProperties()
 
 			Possible Errors: [service].Error.InvalidArguments
 
+		array{object,dict} GetKnownServices()
+
+			Returns a sorted list of tuples with service
+			object path and dictionary of service propertiesa
+			Those are all the services including the one that
+			are registered but not visible or not in use.
+
+			This list will not contain sensitive information
+			like passphrases etc.
+
+			Possible Errors: [service].Error.InvalidArguments
+
 		array{object,dict} GetPeers() [experimental]
 
 			Returns a sorted list of tuples with peer object path
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
index 8d3c75a5..da8304cc 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2705,6 +2705,61 @@ static void append_struct(gpointer value, gpointer user_data)
 	append_struct_service(iter, append_dict_properties, service);
 }
 
+void __connman_known_service_list_struct(DBusMessageIter *iter)
+{
+	gchar **services;
+	gchar **srv_id_parts;
+	guint i;
+	struct connman_service *service;
+
+	services = connman_storage_get_services();
+	if (!services)
+		return;
+
+	for (i = 0; i < g_strv_length(services); i++) {
+		struct connman_service *srv;
+
+		service = connman_service_create();
+		if (!service) {
+			connman_error("connman_service_create() allocation failed");
+			return;
+		}
+
+		service->identifier = g_strdup(services[i]);
+		srv_id_parts = g_strsplit(services[i], "_", -1);
+		if (srv_id_parts == NULL) {
+			g_free(service);
+			continue;
+		}
+
+		service->type = __connman_service_string2type(srv_id_parts[0]);
+		service->path = g_strdup_printf("%s/%s", STORAGEDIR, service->identifier);
+		if (service->type == CONNMAN_SERVICE_TYPE_WIFI)
+			service->security = __connman_service_string2security(srv_id_parts[g_strv_length(srv_id_parts) - 1]);
+
+		srv = find_service(service->path);
+		if (srv)
+			service->state = srv->state;
+
+		if (service->type == CONNMAN_SERVICE_TYPE_ETHERNET && srv)
+			service->name = srv->name;
+
+		if (service_load(service)) {
+			connman_error("service_load() returned error");
+			g_free(service);
+			g_strfreev(srv_id_parts);
+			g_strfreev(services);
+			return;
+		}
+
+		append_struct_service(iter, append_dict_properties, service);
+		g_strfreev(srv_id_parts);
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
index e082962d..8668ca9e 100644
--- a/tools/manager-api.c
+++ b/tools/manager-api.c
@@ -64,6 +64,36 @@ static DBusMessage *set_property(DBusConnection *connection,
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
+		if (dbus_error_is_set(&error))
+			dbus_error_free(&error);
+
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

