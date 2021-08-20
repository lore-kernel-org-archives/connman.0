Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597723FC0
	for <connman@lists.linux.dev>; Fri, 20 Aug 2021 13:07:07 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 5b9290b8-01b7-11ec-ae1c-005056bdd08f;
	Fri, 20 Aug 2021 16:05:57 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 1/2] vpn-provider: Implement connmand online state checking
Date: Fri, 20 Aug 2021 16:05:50 +0300
Message-Id: <20210820130550.20167-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
References: <20210817151443.32305-2-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a complete mechanism to track connmand state and query it if
necessary to avoid connecting VPNs when there is either no connmand or
no network to use. This also makes VPNs to disconnect when connmand
loses its online state or disappears.

The connmand state listener uses net.connman.Manager interface to get
the state using GetProperties at startup. PropertyChanged signal is
monitored for state changes to update the state. State is changed and
queried when the D-Bus service listener is notified. Connmand state is
tracked within vpnd with a boolean: "true" = online/ready, "false" =
offline/idle.

Also a feature to support delayed connecting of VPNs is added. It may
happen in a situation where ConnMan status is not queried yet and
a request to connect is received over D-Bus. In this case a timeout
function is added to the main loop that runs with 1s interval. When the
delayed connect function is running it keeps on trying until connmand
state is online/ready. If connection request comes when the state is
queried and it is not online/ready ENOLINK is returned as an error
("NoCarrier" D-Bus msg). The delayed connect function is removed if
connect request comes when the function is waiting to be scheduled and
the VPN in question is connected immediately.
---
Changes since v2:
 * Cleanups and fixes to follow coding style.
 * Refactor run_get_connman_state().
 * Replace g_try_new0() with g_new().
Changes since v3:
 * Remove VPN agent checks as each VPN should do it when agent is needed.
 * Favor immediate connection of VPN if delayed connection func exists.

 vpn/vpn-provider.c | 357 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 356 insertions(+), 1 deletion(-)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index 59c805c5..0ba840d3 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -3,7 +3,7 @@
  *  ConnMan VPN daemon
  *
  *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
- *  Copyright (C) 2019  Jolla Ltd. All rights reserved.
+ *  Copyright (C) 2019-2021  Jolla Ltd. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -24,6 +24,13 @@
 #include <config.h>
 #endif
 
+#define STATE_INTERVAL_DEFAULT		0
+
+#define CONNMAN_STATE_ONLINE 		"online"
+#define CONNMAN_STATE_OFFLINE 		"offline"
+#define CONNMAN_STATE_READY 		"ready"
+#define CONNMAN_STATE_IDLE 		"idle"
+
 #include <errno.h>
 #include <stdio.h>
 #include <string.h>
@@ -89,15 +96,55 @@ struct vpn_provider {
 	struct connman_ipaddress *prev_ipv4_addr;
 	struct connman_ipaddress *prev_ipv6_addr;
 	void *plugin_data;
+	unsigned int do_connect_timeout;
 	unsigned int auth_error_counter;
 	unsigned int conn_error_counter;
 	unsigned int signal_watch;
 };
 
+struct vpn_provider_connect_data {
+	DBusConnection *conn;
+	DBusMessage *msg;
+	struct vpn_provider *provider;
+};
+
+static unsigned int get_connman_state_timeout = 0;
+
+static guint connman_signal_watch;
+static guint connman_service_watch;
+
+static bool connman_online = false;
+static bool state_query_completed = false;
+
 static void append_properties(DBusMessageIter *iter,
 				struct vpn_provider *provider);
 static int vpn_provider_save(struct vpn_provider *provider);
 
+static void get_connman_state();
+
+static void set_state(const char* new_state)
+{
+	if (!new_state || !*new_state)
+		return;
+
+	DBG("old state %s new state %s",
+				connman_online ?
+				CONNMAN_STATE_ONLINE "/" CONNMAN_STATE_READY :
+				CONNMAN_STATE_OFFLINE "/" CONNMAN_STATE_IDLE,
+				new_state);
+
+	/* States "online" and "ready" mean connman is online */
+	if (!g_ascii_strcasecmp(new_state, CONNMAN_STATE_ONLINE) ||
+			!g_ascii_strcasecmp(new_state, CONNMAN_STATE_READY))
+		connman_online = true;
+	/* Everything else means connman is offline */
+	else
+		connman_online = false;
+
+	DBG("set state %s connman_online=%s ", new_state,
+				connman_online ? "true" : "false");
+}
+
 static void free_route(gpointer data)
 {
 	struct vpn_route *route = data;
@@ -740,6 +787,61 @@ static DBusMessage *clear_property(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static gboolean do_connect_timeout_function(gpointer data)
+{
+	struct vpn_provider_connect_data *cdata = data;
+	struct vpn_provider *provider = cdata->provider;
+	int err;
+
+	DBG("");
+
+	/* Keep in main loop if connman is not online. */
+	if (!connman_online)
+		return G_SOURCE_CONTINUE;
+
+	provider->do_connect_timeout = 0;
+	err = __vpn_provider_connect(provider, cdata->msg);
+
+	if (err < 0 && err != -EINPROGRESS) {
+		g_dbus_send_message(cdata->conn,
+				__connman_error_failed(cdata->msg, -err));
+		cdata->msg = NULL;
+	}
+
+	return G_SOURCE_REMOVE;
+}
+
+static void do_connect_timeout_free(gpointer data)
+{
+	struct vpn_provider_connect_data *cdata = data;
+
+	if (cdata->msg)
+		g_dbus_send_message(cdata->conn,
+				__connman_error_operation_aborted(cdata->msg));
+
+	dbus_connection_unref(cdata->conn);
+	g_free(data);
+}
+
+static void do_connect_later(struct vpn_provider *provider,
+					DBusConnection *conn, DBusMessage *msg)
+{
+	struct vpn_provider_connect_data *cdata =
+				g_new0(struct vpn_provider_connect_data, 1);
+
+	cdata->conn = dbus_connection_ref(conn);
+	cdata->msg = dbus_message_ref(msg);
+	cdata->provider = provider;
+
+	if (provider->do_connect_timeout)
+		g_source_remove(provider->do_connect_timeout);
+
+	provider->do_connect_timeout =
+			g_timeout_add_seconds_full(G_PRIORITY_DEFAULT, 1,
+					do_connect_timeout_function, cdata,
+					do_connect_timeout_free);
+}
+
 static DBusMessage *do_connect(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -748,6 +850,27 @@ static DBusMessage *do_connect(DBusConnection *conn, DBusMessage *msg,
 
 	DBG("conn %p provider %p", conn, provider);
 
+	if (!connman_online) {
+		if (state_query_completed) {
+			DBG("Provider %s not started because connman "
+						"not online/ready",
+						provider->identifier);
+			return __connman_error_failed(msg, ENOLINK);
+		} else {
+			DBG("Provider %s start delayed because connman "
+						"state not queried",
+						provider->identifier);
+			do_connect_later(provider, conn, msg);
+			return NULL;
+		}
+	}
+
+	/* Cancel delayed connection if connmand is online. */
+	if (provider->do_connect_timeout) {
+		g_source_remove(provider->do_connect_timeout);
+		provider->do_connect_timeout = 0;
+	}
+
 	err = __vpn_provider_connect(provider, msg);
 	if (err < 0 && err != -EINPROGRESS)
 		return __connman_error_failed(msg, -err);
@@ -1269,6 +1392,9 @@ static void provider_destruct(struct vpn_provider *provider)
 {
 	DBG("provider %p", provider);
 
+	if (provider->do_connect_timeout)
+		g_source_remove(provider->do_connect_timeout);
+
 	if (provider->notify_id != 0)
 		g_source_remove(provider->notify_id);
 
@@ -3214,6 +3340,213 @@ static void remove_unprovisioned_providers(void)
 	g_strfreev(providers);
 }
 
+static gboolean connman_property_changed(DBusConnection *conn,
+				DBusMessage *message,
+				void *user_data)
+{
+	DBusMessageIter iter, value;
+	const char *key;
+	const char *signature = DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING;
+
+	if (!dbus_message_has_signature(message, signature)) {
+		connman_error("vpn connman property signature \"%s\" "
+					"does not match expected \"%s\"",
+					dbus_message_get_signature(message),
+					signature);
+		return TRUE;
+	}
+
+	if (!dbus_message_iter_init(message, &iter))
+		return TRUE;
+
+	dbus_message_iter_get_basic(&iter, &key);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &value);
+
+	DBG("key %s", key);
+
+	if (g_str_equal(key, "State")) {
+		const char *str;
+
+		if (dbus_message_iter_get_arg_type(&value) != DBUS_TYPE_STRING)
+			return TRUE;
+
+		dbus_message_iter_get_basic(&value, &str);
+		set_state(str);
+	}
+
+	return TRUE;
+}
+
+static void get_connman_state_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *reply = NULL;
+	DBusError error;
+	DBusMessageIter iter, array, dict, value;
+
+	const char *signature = DBUS_TYPE_ARRAY_AS_STRING
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING;
+
+	const char *key;
+	const char *str;
+
+	DBG("");
+
+	if (!dbus_pending_call_get_completed(call))
+		goto done;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, reply)) {
+		connman_error("%s", error.message);
+
+		/*
+		 * In case of timeout re-add the state function to main
+		 * event loop.
+		 */
+		if (g_ascii_strcasecmp(error.name, DBUS_ERROR_TIMEOUT) == 0) {
+			DBG("D-Bus timeout, re-add get_connman_state()");
+			get_connman_state();
+		} else {
+			dbus_error_free(&error);
+			goto done;
+		}
+	}
+
+	if (!dbus_message_has_signature(reply, signature)) {
+		connman_error("vpnd signature \"%s\" does not match "
+					"expected \"%s\"",
+					dbus_message_get_signature(reply),
+					signature);
+		goto done;
+	}
+
+	if (!dbus_message_iter_init(reply, &array))
+		goto done;
+
+	dbus_message_iter_recurse(&array, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
+		dbus_message_iter_recurse(&dict, &iter);
+
+		dbus_message_iter_get_basic(&iter, &key);
+
+		dbus_message_iter_next(&iter);
+		dbus_message_iter_recurse(&iter, &value);
+
+		if (g_ascii_strcasecmp(key, "State") == 0 &&
+				dbus_message_iter_get_arg_type(&value) ==
+						DBUS_TYPE_STRING) {
+			dbus_message_iter_get_basic(&value, &str);
+
+			DBG("Got initial state %s", str);
+
+			set_state(str);
+
+			/* No need to process further */
+			break;
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+	state_query_completed = true;
+
+done:
+	if (reply)
+		dbus_message_unref(reply);
+
+	if (call)
+		dbus_pending_call_unref(call);
+}
+
+static gboolean run_get_connman_state(gpointer user_data)
+{
+	const char *path = "/";
+	const char *method = "GetProperties";
+	gboolean rval = FALSE;
+
+	DBusMessage *msg = NULL;
+	DBusPendingCall *call = NULL;
+
+	DBG("");
+
+	msg = dbus_message_new_method_call(CONNMAN_SERVICE, path,
+					CONNMAN_MANAGER_INTERFACE, method);
+	if (!msg)
+		goto out;
+
+	rval = g_dbus_send_message_with_reply(connection, msg, &call, -1);
+	if (!rval) {
+		connman_error("Cannot call %s on %s", method,
+						CONNMAN_MANAGER_INTERFACE);
+		goto out;
+	}
+
+	if (!call) {
+		connman_error("set pending call failed");
+		rval = FALSE;
+		goto out;
+	}
+
+	if (!dbus_pending_call_set_notify(call, get_connman_state_reply,
+								NULL, NULL)) {
+		connman_error("set notify to pending call failed");
+
+		if (call)
+			dbus_pending_call_unref(call);
+
+		rval = FALSE;
+	}
+
+out:
+	if (msg)
+		dbus_message_unref(msg);
+
+	/* In case sending was success, unset timeout function id */
+	if (rval) {
+		DBG("unsetting get_connman_state_timeout id");
+		get_connman_state_timeout = 0;
+	}
+
+	/* Return FALSE in case of success to remove from main event loop */
+	return !rval;
+}
+
+static void get_connman_state()
+{
+	if (get_connman_state_timeout)
+		return;
+
+	get_connman_state_timeout = g_timeout_add(STATE_INTERVAL_DEFAULT,
+						run_get_connman_state, NULL);
+}
+
+static void connman_service_watch_connected(DBusConnection *conn,
+				void *user_data)
+{
+	DBG("");
+	get_connman_state();
+}
+
+static void connman_service_watch_disconnected(DBusConnection *conn,
+				void *user_data)
+{
+	DBG("");
+
+	set_state(CONNMAN_STATE_IDLE);
+
+	/* Set state query variable to initial state */
+	state_query_completed = false;
+}
+
 int __vpn_provider_init(void)
 {
 	int err;
@@ -3233,6 +3566,20 @@ int __vpn_provider_init(void)
 
 	provider_hash = g_hash_table_new_full(g_str_hash, g_str_equal,
 						NULL, unregister_provider);
+
+	connman_service_watch = g_dbus_add_service_watch(connection,
+					CONNMAN_SERVICE,
+					connman_service_watch_connected,
+					connman_service_watch_disconnected,
+					NULL, NULL);
+
+	connman_signal_watch = g_dbus_add_signal_watch(connection,
+					CONNMAN_SERVICE, NULL,
+					CONNMAN_MANAGER_INTERFACE,
+					PROPERTY_CHANGED,
+					connman_property_changed,
+					NULL, NULL);
+
 	return 0;
 }
 
@@ -3247,5 +3594,13 @@ void __vpn_provider_cleanup(void)
 	g_hash_table_destroy(provider_hash);
 	provider_hash = NULL;
 
+	if (get_connman_state_timeout) {
+		if (!g_source_remove(get_connman_state_timeout))
+			connman_error("connman state timeout not removed");
+	}
+
+	g_dbus_remove_watch(connection, connman_service_watch);
+	g_dbus_remove_watch(connection, connman_signal_watch);
+
 	dbus_connection_unref(connection);
 }
-- 
2.20.1

