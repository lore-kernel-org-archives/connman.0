Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF04191F7E
	for <connman@lists.linux.dev>; Thu, 26 Jun 2025 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922932; cv=none; b=Y/ZsF1u7ITW2R1XwprGcMWtw6ge6xN0sTDdDHjKV65YGEHUb2r6zNG7KGVYqhABN4jvNyXkyWnZzmUAKjzt5KjmnBhLi30SN21LmxvIFX64jRtsXV4gG+Z/WAiIA0Swy5jgbpzqGnrWFAslyq1uOAyEfkg4cDIGIKVCPwP9w16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922932; c=relaxed/simple;
	bh=MLL9G1xIjdnJw3r9dBGAVodG4P4+FCnVKaRUbbGEEiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3v7bB8tNYO2fUSvdHI1nvwh0P+AauXQAUJhwp/bCxzhBmQXQeqwTjSG+uloHwZa2PwZxWfswkX6sRcYDqv//03HhQbbUWru53stteXCXzYLPdgL7hIbrF17lomtGp7WVeSoPk4qyb0zHjF3fQzr39tlq6jpbD/4rJ7ihAyfuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=gad+frbv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gad+frbv"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so348408f8f.0
        for <connman@lists.linux.dev>; Thu, 26 Jun 2025 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1750922928; x=1751527728; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuKHCB7g5LApWEIkYH5rFoDZlIdqyMmXIUqVdfiUvbs=;
        b=gad+frbvCicu+S9HbN6odEoiJJe4RyflsbkBpsqR4EVwX5XuJLLBkK7DyiklMXKeMJ
         2L3ya1QI/jl6LAwKKEIkffhiusKpVT/rWVNqimLmxmwKrYioKTAS4zh3x/nJ18JxrcK3
         5egf4e5lMbhFMG9GfJ7EMv8/j6Qx14MV6g0CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750922928; x=1751527728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuKHCB7g5LApWEIkYH5rFoDZlIdqyMmXIUqVdfiUvbs=;
        b=heWFNPcflIC2haGongHYJTsa9KtiE5cCWhAshQrsCVNUmt8/z4EjmcKbTPBUovuPRg
         sC90I0UGB06KVgKfcLSqfOU2yKs7D8+JOpH0uFglo9bgW5JEkuoN6aW1yXTceO2rBrIl
         6RiC8+yXGRzmIeyjpx2XiOVm6xBsjbPDncqvo9oypr6mBOnADwGw6NMXe5aH+n4toZZM
         8hlK+N9Yj/Sc6yTjWgYATQrViwed5yX9y18Jp9PmRc+0bmqvWgv3WMcxTHCSvNasdSLb
         YCbtlkoAywfjYu8aftlfa+cYpipT2wsqJKPaGcdXrFARt1d1gw8gvngAfZZw1zNk2ALh
         55EA==
X-Gm-Message-State: AOJu0YyyQHo1O9A/+h+8ViVhhhI7tPl2+O7jR+AY/Hp2Lfx9Ghzkf68z
	n3A8JE2GsbAG4lA9bi5kF4X7hjuicTRMrSfrIAIzGwPUfXZ6kpF21It3PByKYJAeVdb+lzjvnWK
	VKllBvAY=
X-Gm-Gg: ASbGncuSFp0wobEUb2xINNk4EfHBa00DWA7R6ewQm9RB9GirEnoCI5W4vxJQK79Ut1h
	q78xOzAhKrjuxGGp7yXP3xG4/WdGd+C/S+GbASYIDcE9AhMfA+J/RM9OQRUHM/RsJaOcNMYley3
	t6U3AcybTW3dF1fkIDb7g/m7LAcvgS/F4yaqc5yXAnBkWa/7bU2Z0NiKjVX8WMZUJl9Ledi3D8f
	0eN8bRbkixfo1pvWUFqQOG5sjypDtxcD4skGRR2HmsCGaW6zN2kHX2J2vX/VOrRSzq1/9sPj7/T
	1pp1gOm2yLnW2DRkRvrUqzQ6Drg+7i3vQ6PfVDmhiSbhx3uSyQ9P5gbXvlmKfxU9eYhGqewGRrl
	jmuYx+OT+OfxCuXVLnohD7ct96F6zOCwyacOVRhBRVwM=
X-Google-Smtp-Source: AGHT+IFiI3dJ0RQ8OAiTjklvnqVQzP/Ov/tdZWMx2kVD9kdQyr/7oEczCOWh1aneUWCpk+puyZ0Gaw==
X-Received: by 2002:a05:6000:230c:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3a6ed604835mr4096996f8f.19.1750922928373;
        Thu, 26 Jun 2025 00:28:48 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-8382-0206-0000-0000-0000-05fa.ipv6.o2.cz. [2a00:1028:8382:206::5fa])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a6e805d21fsm6410736f8f.23.2025.06.26.00.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 00:28:47 -0700 (PDT)
From: =?UTF-8?q?Roman=20Smr=C5=BE?= <roman@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v3 1/3] Add GetKnownServices api to connaman
Date: Thu, 26 Jun 2025 09:27:44 +0200
Message-ID: <20250626072822.1941-2-roman@amarulasolutions.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626072822.1941-1-roman@amarulasolutions.com>
References: <20250626072822.1941-1-roman@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Trimarchi <michael@amarulasolutions.com>

Add a way to retrieve all the networks that were configured
using connman and not all the ones visible
---
 client/commands.c    | 14 ++++++++++++
 doc/manager-api.txt  | 11 +++++++++
 src/connman.h        |  1 +
 src/manager.c        | 23 +++++++++++++++++++
 src/service.c        | 54 ++++++++++++++++++++++++++++++++++++++++++++
 tools/manager-api.c  | 30 ++++++++++++++++++++++++
 tools/session-test.h |  1 +
 7 files changed, 134 insertions(+)

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
index 6eaa0a38..f36ff813 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -39,6 +39,17 @@ Methods		dict GetProperties()
 
 			Possible Errors: [service].Error.InvalidArguments
 
+		array{object,dict} GetKnownServices()
+
+			Returns a sorted list of tuples with dictionary of service
+			properties. Those are all the services, including the ones
+			that are registered, but not visible or not in use.
+
+			This list will not contain sensitive information
+			like passphrases etc.
+
+			Possible Errors: [service].Error.InvalidArguments
+
 		array{object,dict} GetPeers() [experimental]
 
 			Returns a sorted list of tuples with peer object path
diff --git a/src/connman.h b/src/connman.h
index 7ebda7af..a4e7e4f1 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -721,6 +721,7 @@ int __connman_service_move(struct connman_service *service,
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
index f73f42eb..bcda5076 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5441,6 +5441,60 @@ static void append_struct(gpointer value, gpointer user_data)
 	append_struct_service(iter, append_dict_properties, service);
 }
 
+void __connman_known_service_list_struct(DBusMessageIter *iter)
+{
+	struct connman_service *service;
+	char **srv_id_parts;
+	char **services;
+	unsigned int i;
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
+		service->path = g_strdup_printf("%s/service/%s", CONNMAN_PATH,
+						service->identifier);
+		srv_id_parts = g_strsplit(services[i], "_", -1);
+
+		service->type = __connman_service_string2type(srv_id_parts[0]);
+		if (service->type == CONNMAN_SERVICE_TYPE_WIFI) {
+			char *id = srv_id_parts[g_strv_length(srv_id_parts) - 1];
+			service->security = __connman_service_string2security(id);
+		}
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
2.49.0

