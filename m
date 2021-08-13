Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC952FAF
	for <connman@lists.linux.dev>; Fri, 13 Aug 2021 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (88-113-61-133.elisa-laajakaista.fi [88.113.61.133])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 45502279-fc3c-11eb-b1af-005056bdfda7;
	Fri, 13 Aug 2021 16:42:15 +0300 (EEST)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/3] pptp: Improve invalid auth and disconnect notify, fix cb use
Date: Fri, 13 Aug 2021 16:42:09 +0300
Message-Id: <20210813134209.23253-4-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210813134209.23253-1-jussi.laakkonen@jolla.com>
References: <20210813134209.23253-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop the task running pptp when it notifies being disconnected as in
case the authentication fails the process keeps on looping with the
notify and cannot be given new credentials until stopped with a D-Bus
call to disconnect. Implement a connect done function to ensure that the
callback is called only once as it sends a reply back to the caller. Use
this function when stopping, having invalid credentials or other errors.

Also, call the callback via connect done only after the connection is
established. This fixes the issue of pptp reporting back 0 ("ok") before
it gets an response from the connection negotiation, which informed the
caller with completely invalid information.
---
 vpn/plugins/pptp.c | 127 ++++++++++++++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 43 deletions(-)

diff --git a/vpn/plugins/pptp.c b/vpn/plugins/pptp.c
index 4a704bb1..7274376f 100644
--- a/vpn/plugins/pptp.c
+++ b/vpn/plugins/pptp.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2010,2013-2014  BMW Car IT GmbH.
  *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2019-2021  Jolla Ltd.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -86,12 +87,40 @@ struct {
 static DBusConnection *connection;
 
 struct pptp_private_data {
+	struct vpn_provider *provider;
 	struct connman_task *task;
 	char *if_name;
 	vpn_provider_connect_cb_t cb;
 	void *user_data;
 };
 
+static void pptp_connect_done(struct pptp_private_data *data, int err)
+{
+	vpn_provider_connect_cb_t cb;
+	void *user_data;
+
+	if (!data || !data->cb)
+		return;
+
+	/* Ensure that callback is called only once */
+	cb = data->cb;
+	user_data = data->user_data;
+	data->cb = NULL;
+	data->user_data = NULL;
+	cb(data->provider, user_data, err);
+}
+
+static void free_private_data(struct pptp_private_data *data)
+{
+	if (vpn_provider_get_plugin_data(data->provider) == data)
+		vpn_provider_set_plugin_data(data->provider, NULL);
+
+	pptp_connect_done(data, EIO);
+	vpn_provider_unref(data->provider);
+	g_free(data->if_name);
+	g_free(data);
+}
+
 static DBusMessage *pptp_get_sec(struct connman_task *task,
 				DBusMessage *msg, void *user_data)
 {
@@ -125,6 +154,9 @@ static int pptp_notify(DBusMessage *msg, struct vpn_provider *provider)
 	char *addressv4 = NULL, *netmask = NULL, *gateway = NULL;
 	char *ifname = NULL, *nameservers = NULL;
 	struct connman_ipaddress *ipaddress = NULL;
+	struct pptp_private_data *data;
+
+	data = vpn_provider_get_plugin_data(provider);
 
 	dbus_message_iter_init(msg, &iter);
 
@@ -143,11 +175,22 @@ static int pptp_notify(DBusMessage *msg, struct vpn_provider *provider)
 		vpn_provider_set_string_hide_value(provider, "PPTP.Password",
 					NULL);
 
+		pptp_connect_done(data, EACCES);
 		return VPN_STATE_AUTH_FAILURE;
 	}
 
-	if (strcmp(reason, "connect"))
+	if (strcmp(reason, "connect")) {
+		pptp_connect_done(data, EIO);
+
+		/*
+		 * Stop the task to avoid potential looping of this state when
+		 * authentication fails.
+		 */
+		if (data && data->task)
+			connman_task_stop(data->task);
+
 		return VPN_STATE_DISCONNECT;
+	}
 
 	dbus_message_iter_recurse(&iter, &dict);
 
@@ -217,6 +260,7 @@ static int pptp_notify(DBusMessage *msg, struct vpn_provider *provider)
 	g_free(nameservers);
 	connman_ipaddress_free(ipaddress);
 
+	pptp_connect_done(data, 0);
 	return VPN_STATE_CONNECT;
 }
 
@@ -278,6 +322,16 @@ static void pptp_write_bool_option(struct connman_task *task,
 	}
 }
 
+static void pptp_died(struct connman_task *task, int exit_code,
+							void *user_data)
+{
+	struct pptp_private_data *data = user_data;
+
+	vpn_died(task, exit_code, data->provider);
+
+	free_private_data(data);
+}
+
 struct request_input_reply {
 	struct vpn_provider *provider;
 	vpn_provider_password_cb_t callback;
@@ -435,18 +489,18 @@ static int request_input(struct vpn_provider *provider,
 	return -EINPROGRESS;
 }
 
-static int run_connect(struct vpn_provider *provider,
-			struct connman_task *task, const char *if_name,
-			vpn_provider_connect_cb_t cb, void *user_data,
-			const char *username, const char *password)
+static int run_connect(struct pptp_private_data *data, const char *username,
+							const char *password)
 {
+	struct vpn_provider *provider = data->provider;
+	struct connman_task *task = data->task;
 	GString *pptp_opt_s;
 	const char *opt_s;
 	const char *host;
 	char *str;
 	int err, i;
 
-	if (!username || !password) {
+	if (!username || !*username || !password || !*password) {
 		DBG("Cannot connect username %s password %p",
 						username, password);
 		err = -EINVAL;
@@ -498,27 +552,19 @@ static int run_connect(struct vpn_provider *provider,
 	connman_task_add_argument(task, "plugin",
 				SCRIPTDIR "/libppp-plugin.so");
 
-	err = connman_task_run(task, vpn_died, provider,
-				NULL, NULL, NULL);
+	err = connman_task_run(task, pptp_died, data, NULL, NULL, NULL);
 	if (err < 0) {
 		connman_error("pptp failed to start");
 		err = -EIO;
-		goto done;
 	}
 
 done:
-	if (cb)
-		cb(provider, user_data, err);
+	if (err)
+		pptp_connect_done(data, -err);
 
 	return err;
 }
 
-static void free_private_data(struct pptp_private_data *data)
-{
-	g_free(data->if_name);
-	g_free(data);
-}
-
 static void request_input_cb(struct vpn_provider *provider,
 			const char *username,
 			const char *password,
@@ -526,7 +572,7 @@ static void request_input_cb(struct vpn_provider *provider,
 {
 	struct pptp_private_data *data = user_data;
 
-	if (!username || !password)
+	if (!username || !*username || !password || !*password)
 		DBG("Requesting username %s or password failed, error %s",
 			username, error);
 	else if (error)
@@ -536,10 +582,7 @@ static void request_input_cb(struct vpn_provider *provider,
 	vpn_provider_set_string_hide_value(provider, "PPTP.Password",
 								password);
 
-	run_connect(provider, data->task, data->if_name, data->cb,
-		data->user_data, username, password);
-
-	free_private_data(data);
+	run_connect(data, username, password);
 }
 
 static int pptp_connect(struct vpn_provider *provider,
@@ -547,9 +590,21 @@ static int pptp_connect(struct vpn_provider *provider,
 			vpn_provider_connect_cb_t cb, const char *dbus_sender,
 			void *user_data)
 {
+	struct pptp_private_data *data;
 	const char *username, *password;
 	int err;
 
+	data = g_try_new0(struct pptp_private_data, 1);
+	if (!data)
+		return -ENOMEM;
+
+	data->provider = vpn_provider_ref(provider);
+	data->task = task;
+	data->if_name = g_strdup(if_name);
+	data->cb = cb;
+	data->user_data = user_data;
+	vpn_provider_set_plugin_data(provider, data);
+
 	DBG("iface %s provider %p user %p", if_name, provider, user_data);
 
 	if (connman_task_set_notify(task, "getsec",
@@ -563,34 +618,20 @@ static int pptp_connect(struct vpn_provider *provider,
 
 	DBG("user %s password %p", username, password);
 
-	if (!username || !password) {
-		struct pptp_private_data *data;
-
-		data = g_try_new0(struct pptp_private_data, 1);
-		if (!data)
-			return -ENOMEM;
-
-		data->task = task;
-		data->if_name = g_strdup(if_name);
-		data->cb = cb;
-		data->user_data = user_data;
-
+	if (!username || !*username || !password || !*password) {
 		err = request_input(provider, request_input_cb, dbus_sender,
 									data);
-		if (err != -EINPROGRESS) {
-			free_private_data(data);
-			goto done;
-		}
+		if (err != -EINPROGRESS)
+			goto error;
+
 		return err;
 	}
 
-done:
-	return run_connect(provider, task, if_name, cb, user_data,
-							username, password);
+	return run_connect(data, username, password);
 
 error:
-	if (cb)
-		cb(provider, user_data, err);
+	pptp_connect_done(data, -err);
+	free_private_data(data);
 
 	return err;
 }
-- 
2.20.1

