Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFB33A707
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435089; cv=none; b=O/0s0jj2R0jmCEprzIHiI1g8N0VZzPQDV8zKLOSo3JQM/JtT4fSVRJjiCssJ1b7Zvu57ePdHZg9pcAiRwY6lZAJOqBPPZrFJZvmZuW2EU7egSnTMtUvFR7o9MgNvvu8/ow0ZOqccMrsb/2kY8opISsTk4HgYr22rCh19WhRLm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435089; c=relaxed/simple;
	bh=n9yo+aRXvUx9ZYLpNBta6wHq5cKrUd+h5iga5+ycFYw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozWLsfyb6r0Lk+bqsQJABRHwd1SvJJ6VfXGrKPjybsfnsYmzaSmkqfm1Z2zKBRdl7PqkasiLmcfXHu3tIsDfJaPDzUym1O323fsT62osbsqO7EF+TImlxL9RrgL64i5WFJr8EJJ3CqWzsXMfuv7aGCp2EvWK3Hw9Nili4B0OgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ZCgdRp67; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ZCgdRp67"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7NT7Q7EQ5kWmhhdBIGtikofSVFno3+yUzVSj7SwjyY0=; b=ZCgdRp67lz5Y4IOZyXs6jtVwc6
	m78aweU9Q/UmC/K6kTf5EysBITj8q7OzB+yRpsJMbFQxdT4AN5fP4fujG4R8JComEq4E5QbWQcNUl
	rZnpHqHRCtb+cV7HOfiUiJl9CutNkGnvy266gSx+jL7tvO7SBlIq+dZng/5lhXv3ytNFJ1t7nbDJR
	Jq99aLyuywCg59h7U+A061H6nbZszHDhQG/0gd70obV11zv8MBXaKByMY1rkwj6l3b1pVVFwshOIr
	q4HwmwTQ51WkMLtE1QzZgXpKbTlv63988lZlDNsnU4gvWgx031DWYtAnfVmSY0O+92KKU7edWRula
	yxlQ+JcA==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMtZ-00C0gj-2W
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 15:44:45 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 7/9] l2tp: Implement shared secret support using file or VPN agent
Date: Mon, 26 Jan 2026 15:43:46 +0200
Message-ID: <20260126134410.55749-8-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
References: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:4460:24f0:14b1:617b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Use the "Challenge" option properly by implementing the shared secret
support either by 1) user defined file 2) system l2tp-secrets file or 3)
using VPN agent to ask the shared secret, local and remote hostnames
from the user. With 1) and 2) the file is used as is. With 3) the
secrets file connman-xl2tpd-secrets.conf is created in the VPN_STATEDIR
and is removed like the rest of the configuration files.

Use the "AuthFile" to specify a secrets file to use, or if it is defined
as "-" use the system file instead. If "Challenge" is enabled the
defined auth file is automatically used, if there is no auth file
defined VPN agent is used to query the user.

A new callback for setting the shared secret info is added that is always
executed before the credentials callback.  All information is requested
in the VPN agent query (5 strings total) if "Challenge" is enabled and
no auth file is defined.
---
 vpn/plugins/l2tp.c | 338 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 313 insertions(+), 25 deletions(-)

diff --git a/vpn/plugins/l2tp.c b/vpn/plugins/l2tp.c
index c3b01493..d770a96e 100644
--- a/vpn/plugins/l2tp.c
+++ b/vpn/plugins/l2tp.c
@@ -67,6 +67,7 @@ enum {
 	OPT_L2	= 3,
 	OPT_PPPD = 4,
 	OPT_L2LNS = 5,
+	OPT_L2SEC = 6,
 };
 
 struct {
@@ -100,6 +101,8 @@ struct {
 	{ "L2TP.Rand Source", "rand source", OPT_L2G, NULL, OPT_STRING },
 	{ "L2TP.IPsecSaref", "ipsec saref", OPT_L2G, "no", OPT_STRING },
 	{ "L2TP.Port", "port", OPT_L2G, NULL, OPT_STRING },
+	{ "L2TP.LocalHostname", "", OPT_L2SEC, NULL, OPT_STRING},
+	{ "L2TP.RemoteHostname", "", OPT_L2SEC, NULL, OPT_STRING},
 	{ "PPPD.EchoFailure", "lcp-echo-failure", OPT_PPPD, "0", OPT_STRING },
 	{ "PPPD.EchoInterval", "lcp-echo-interval", OPT_PPPD, "0", OPT_STRING },
 	{ "PPPD.Debug", "debug", OPT_PPPD, NULL, OPT_STRING },
@@ -127,6 +130,7 @@ struct l2tp_private_data {
 	char *if_name;
 	vpn_provider_connect_cb_t cb;
 	void *user_data;
+	bool remove_secrets_file;
 };
 
 static void l2tp_connect_done(struct l2tp_private_data *data, int err)
@@ -219,6 +223,7 @@ static int l2tp_notify(DBusMessage *msg, struct vpn_provider *provider)
 	}
 
 	if (strcmp(reason, "connect")) {
+		DBG("failure, reason: %s", reason);
 		l2tp_connect_done(data, ECONNREFUSED);
 
 		/*
@@ -484,6 +489,11 @@ static int l2tp_write_fields(struct vpn_provider *provider,
 		if (!opt_s)
 			continue;
 
+		/* When auth file is  set to "-" use system l2tp-secrets file */
+		if (!g_strcmp0(pppd_options[i].cm_opt, "L2TP.AuthFile") &&
+							!g_strcmp0(opt_s, "-"))
+			continue;
+
 		if (pppd_options[i].type == OPT_STRING)
 			l2tp_write_section(fd,
 				pppd_options[i].pppd_opt, opt_s);
@@ -519,11 +529,42 @@ static int l2tp_write_config(struct vpn_provider *provider,
 	return 0;
 }
 
+static int l2tp_write_secret(struct vpn_provider *provider, int fd)
+{
+	const char *local;
+	const char *remote;
+	const char *shared;
+	char *buf;
+	int err;
+
+	local = vpn_provider_get_string(provider, "L2TP.LocalHostname");
+	remote = vpn_provider_get_string(provider, "L2TP.RemoteHostname");
+	shared = vpn_provider_get_string(provider, "L2TP.SharedSecret");
+
+	if (!shared || !*shared) {
+		connman_error("L2TP shared secret required but not set");
+		return -ENOENT;
+	}
+
+	buf = g_strdup_printf("%s\t%s\t%s\n", (local && *local) ? local : "*",
+					(remote && *remote) ? remote : "*",
+					shared);
+	if (!buf)
+		return -ENOMEM;
+
+	err = full_write(fd, buf, strlen(buf));
+	g_free(buf);
+
+	return err;
+}
+
 static void l2tp_died(struct connman_task *task, int exit_code, void *user_data)
 {
 	struct l2tp_private_data *data = user_data;
 	char *conf_file;
 
+	DBG("died of %d", exit_code);
+
 	vpn_died(task, exit_code, data->provider);
 
 	conf_file = g_strdup_printf(VPN_STATEDIR "/connman-xl2tpd.conf");
@@ -534,12 +575,27 @@ static void l2tp_died(struct connman_task *task, int exit_code, void *user_data)
 	unlink(conf_file);
 	g_free(conf_file);
 
+	if (data->remove_secrets_file) {
+		conf_file = g_strconcat(VPN_STATEDIR,
+						"/connman-xl2tpd-secrets.conf",
+						NULL);
+		unlink(conf_file);
+		g_free(conf_file);
+	}
+
 	free_private_data(data);
 }
 
+typedef void (* l2tp_shared_secret_cb_t) (struct vpn_provider *provider,
+					const char *local_host,
+					const char *remote_host,
+					const char *shared_secret,
+					int error, void *user_data);
+
 struct request_input_reply {
 	struct vpn_provider *provider;
 	vpn_provider_password_cb_t callback;
+	l2tp_shared_secret_cb_t secret_callback;
 	void *user_data;
 };
 
@@ -547,7 +603,11 @@ static void request_input_reply(DBusMessage *reply, void *user_data)
 {
 	struct request_input_reply *l2tp_reply = user_data;
 	struct l2tp_private_data *data;
-	char *username = NULL, *password = NULL;
+	char *username = NULL;
+	char *password = NULL;
+	char *secret = NULL;
+	char *local = NULL;
+	char *remote = NULL;
 	char *key;
 	DBusMessageIter iter, dict;
 	int err;
@@ -612,21 +672,140 @@ static void request_input_reply(DBusMessage *reply, void *user_data)
 			password = g_strdup(str);
 		}
 
+		if (g_str_equal(key, "L2TP.LocalHostname")) {
+			dbus_message_iter_next(&entry);
+			if (dbus_message_iter_get_arg_type(&entry)
+							!= DBUS_TYPE_VARIANT)
+				break;
+			dbus_message_iter_recurse(&entry, &value);
+			if (dbus_message_iter_get_arg_type(&value)
+							!= DBUS_TYPE_STRING)
+				break;
+			dbus_message_iter_get_basic(&value, &str);
+			local = g_strdup(str);
+		}
+
+		if (g_str_equal(key, "L2TP.RemoteHostname")) {
+			dbus_message_iter_next(&entry);
+			if (dbus_message_iter_get_arg_type(&entry)
+							!= DBUS_TYPE_VARIANT)
+				break;
+			dbus_message_iter_recurse(&entry, &value);
+			if (dbus_message_iter_get_arg_type(&value)
+							!= DBUS_TYPE_STRING)
+				break;
+			dbus_message_iter_get_basic(&value, &str);
+			remote = g_strdup(str);
+		}
+
+		if (g_str_equal(key, "L2TP.SharedSecret")) {
+			dbus_message_iter_next(&entry);
+			if (dbus_message_iter_get_arg_type(&entry)
+							!= DBUS_TYPE_VARIANT)
+				break;
+			dbus_message_iter_recurse(&entry, &value);
+			if (dbus_message_iter_get_arg_type(&value)
+							!= DBUS_TYPE_STRING)
+				break;
+			dbus_message_iter_get_basic(&value, &str);
+			secret = g_strdup(str);
+		}
+
 		dbus_message_iter_next(&dict);
 	}
 
 done:
-	l2tp_reply->callback(l2tp_reply->provider, username, password, err,
-				l2tp_reply->user_data);
+	if (l2tp_reply->secret_callback)
+		l2tp_reply->secret_callback(l2tp_reply->provider, local, remote,
+					secret, err, l2tp_reply->user_data);
+
+	if (l2tp_reply->callback)
+		l2tp_reply->callback(l2tp_reply->provider, username, password,
+					err, l2tp_reply->user_data);
 
 	g_free(username);
 	g_free(password);
+	g_free(local);
+	g_free(remote);
+	g_free(secret);
 
 	g_free(l2tp_reply);
 }
 
+static void request_input_append(DBusMessageIter *iter,
+		const char *str_type, const char *str, void *user_data)
+{
+	const char *string;
+
+	connman_dbus_dict_append_basic(iter, "Type",
+				DBUS_TYPE_STRING, &str_type);
+	connman_dbus_dict_append_basic(iter, "Requirement",
+				DBUS_TYPE_STRING, &str);
+
+	if (!user_data)
+		return;
+
+	string = user_data;
+	connman_dbus_dict_append_basic(iter, "Value", DBUS_TYPE_STRING,
+				&string);
+}
+
+static void request_input_append_informational(DBusMessageIter *iter,
+		void *user_data)
+{
+	request_input_append(iter, "string", "informational", user_data);
+}
+
+static void request_input_append_optional(DBusMessageIter *iter,
+		void *user_data)
+{
+	request_input_append(iter, "string", "optional", user_data);
+}
+
+static void request_input_append_password(DBusMessageIter *iter,
+		void *user_data)
+{
+	request_input_append(iter, "password", "mandatory", user_data);
+}
+
+static void request_input_append_to_dict(struct vpn_provider *provider,
+			DBusMessageIter *dict,
+			connman_dbus_append_cb_t function_cb, const char *key)
+{
+	const char *str;
+	bool immutable = false;
+
+	if (!provider || !dict || !function_cb || !key)
+		return;
+
+	str = vpn_provider_get_string(provider, key);
+	/* Ignore empty informational content */
+	if (!str && function_cb == request_input_append_informational)
+		return;
+
+	/* If value is "-", it is cleared by VPN agent */
+	if (!g_strcmp0(str, "-"))
+		str = NULL;
+
+	if (str)
+		immutable = vpn_provider_get_string_immutable(provider, key);
+
+	if (immutable) {
+		/* Hide immutable password types */
+		if (function_cb == request_input_append_password)
+			str = "********";
+
+		/* Send immutable as informational */
+		function_cb = request_input_append_informational;
+	}
+
+	connman_dbus_dict_append_dict(dict, key, function_cb,
+				str ? (void *)str : NULL);
+}
+
 static int request_input(struct vpn_provider *provider,
 			vpn_provider_password_cb_t callback,
+			l2tp_shared_secret_cb_t secret_callback,
 			const char *dbus_sender, void *user_data)
 {
 	DBusMessage *message;
@@ -659,7 +838,22 @@ static int request_input(struct vpn_provider *provider,
 	if (vpn_provider_get_authentication_errors(provider))
 		vpn_agent_append_auth_failure(&dict, provider, NULL);
 
-	vpn_agent_append_user_info(&dict, provider, "L2TP.User");
+	if (callback)
+		vpn_agent_append_user_info(&dict, provider, "L2TP.User");
+
+	if (secret_callback) {
+		request_input_append_to_dict(provider, &dict,
+					request_input_append_optional,
+					"L2TP.LocalHostname");
+
+		request_input_append_to_dict(provider, &dict,
+					request_input_append_optional,
+					"L2TP.RemoteHostname");
+
+		request_input_append_to_dict(provider, &dict,
+					request_input_append_password,
+					"L2TP.SharedSecret");
+	}
 
 	vpn_agent_append_host_and_name(&dict, provider);
 
@@ -673,6 +867,7 @@ static int request_input(struct vpn_provider *provider,
 
 	l2tp_reply->provider = provider;
 	l2tp_reply->callback = callback;
+	l2tp_reply->secret_callback = secret_callback;
 	l2tp_reply->user_data = user_data;
 
 	err = connman_agent_queue_message(provider, message,
@@ -691,12 +886,18 @@ static int request_input(struct vpn_provider *provider,
 }
 
 static int run_connect(struct l2tp_private_data *data,
-			const char *username, const char *password)
+			const char *username, const char *password,
+			bool use_challenge, const char *auth_file)
 {
 	struct vpn_provider *provider = data->provider;
 	struct connman_task *task = data->task;
-	char *l2tp_name, *ctrl_name, *pppd_name;
-	int l2tp_fd, pppd_fd;
+	char *l2tp_name = NULL;
+	char *ctrl_name = NULL;
+	char *pppd_name = NULL;
+	char *secrets_name = NULL;
+	int l2tp_fd = -1;
+	int pppd_fd = -1;
+	int secrets_fd = -1;
 	int err;
 
 	if (!username || !*username || !password || !*password) {
@@ -712,7 +913,6 @@ static int run_connect(struct l2tp_private_data *data,
 
 	l2tp_fd = open(l2tp_name, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
 	if (l2tp_fd < 0) {
-		g_free(l2tp_name);
 		connman_error("Error writing l2tp config");
 		err = -EIO;
 		goto done;
@@ -722,9 +922,6 @@ static int run_connect(struct l2tp_private_data *data,
 
 	if (mkfifo(ctrl_name, S_IRUSR|S_IWUSR) != 0 && errno != EEXIST) {
 		connman_error("Error creating xl2tp control pipe");
-		g_free(l2tp_name);
-		g_free(ctrl_name);
-		close(l2tp_fd);
 		err = -EIO;
 		goto done;
 	}
@@ -734,14 +931,29 @@ static int run_connect(struct l2tp_private_data *data,
 	pppd_fd = open(pppd_name, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
 	if (pppd_fd < 0) {
 		connman_error("Error writing pppd config");
-		g_free(l2tp_name);
-		g_free(ctrl_name);
-		g_free(pppd_name);
-		close(l2tp_fd);
 		err = -EIO;
 		goto done;
 	}
 
+	secrets_name = g_strdup(auth_file);
+	if (use_challenge && (!secrets_name)) {
+		secrets_name = g_strconcat(VPN_STATEDIR,
+						"/connman-xl2tpd-secrets.conf",
+						NULL);
+
+		secrets_fd = open(secrets_name, O_RDWR|O_CREAT|O_TRUNC,
+						S_IRUSR|S_IWUSR);
+		if (secrets_fd < 0) {
+			connman_error("Error writing l2tp secrets");
+			err = -EIO;
+			goto done;
+		}
+
+		/* Toggle the created file to be removed at shutdown */
+		data->remove_secrets_file = true;
+		l2tp_write_secret(provider, secrets_fd);
+	}
+
 	l2tp_write_config(provider, pppd_name, l2tp_fd);
 
 	write_pppd_option(provider, pppd_fd);
@@ -750,11 +962,8 @@ static int run_connect(struct l2tp_private_data *data,
 	connman_task_add_argument(task, "-C", ctrl_name);
 	connman_task_add_argument(task, "-c", l2tp_name);
 
-	g_free(l2tp_name);
-	g_free(ctrl_name);
-	g_free(pppd_name);
-	close(l2tp_fd);
-	close(pppd_fd);
+	if (use_challenge && g_strcmp0(secrets_name, "-"))
+		connman_task_add_argument(task, "-s", secrets_name);
 
 	err = connman_task_run(task, l2tp_died, data, NULL, NULL, NULL);
 	if (err < 0) {
@@ -763,18 +972,78 @@ static int run_connect(struct l2tp_private_data *data,
 	}
 
 done:
+	g_free(l2tp_name);
+	g_free(ctrl_name);
+	g_free(pppd_name);
+	g_free(secrets_name);
+
+	if (l2tp_fd != -1)
+		close(l2tp_fd);
+
+	if (pppd_fd != -1)
+		close(pppd_fd);
+
+	if (secrets_fd != -1)
+		close(secrets_fd);
+
 	if (err)
 		l2tp_connect_done(data, -err);
 
 	return err;
 }
 
+static void request_input_secret_cb(struct vpn_provider *provider,
+			const char *local_host,
+			const char *remote_host,
+			const char *shared_secret,
+			int error, void *user_data)
+{
+	struct l2tp_private_data *data = user_data;
+
+	if (error || !shared_secret || !*shared_secret) {
+		DBG("Requesting shared secret failed: %s", strerror(error));
+		l2tp_connect_done(data, error ? error : -ENOENT);
+		return;
+	}
+
+	vpn_provider_set_string(provider, "L2TP.LocalHostname", local_host);
+	vpn_provider_set_string(provider, "L2TP.RemoteHostname", remote_host);
+	vpn_provider_set_string_hide_value(provider, "L2TP.SharedSecret",
+								shared_secret);
+}
+
+static bool request_shared_secret(struct vpn_provider *provider,
+							bool *use_challenge)
+{
+	const char *auth_file;
+	const char *secret;
+
+	*use_challenge = vpn_provider_get_boolean(provider, "L2TP.Challenge",
+									false);
+	if (!*use_challenge)
+		return false;
+
+	auth_file = vpn_provider_get_string(provider, "L2TP.AuthFile");
+	if (auth_file) {
+		DBG("Use auth file: %s", auth_file);
+		return false;
+	}
+
+	secret = vpn_provider_get_string(provider, "L2TP.SharedSecret");
+	if (secret && *secret)
+		return false; /* Already set */
+
+	return true;
+}
+
 static void request_input_cb(struct vpn_provider *provider,
 			const char *username,
 			const char *password,
 			int error, void *user_data)
 {
 	struct l2tp_private_data *data = user_data;
+	const char *auth_file;
+	bool use_challenge;
 
 	if (error || (!username || !*username || !password || !*password)) {
 		DBG("Requesting credentials failed: %s", strerror(error));
@@ -786,7 +1055,11 @@ static void request_input_cb(struct vpn_provider *provider,
 	vpn_provider_set_string_hide_value(provider, "L2TP.Password",
 								password);
 
-	run_connect(data, username, password);
+	auth_file = vpn_provider_get_string(provider, "L2TP.AuthFile");
+	use_challenge = vpn_provider_get_boolean(provider, "L2TP.Challenge",
+								false);
+
+	run_connect(data, username, password, use_challenge, auth_file);
 }
 
 static int l2tp_connect(struct vpn_provider *provider,
@@ -795,7 +1068,11 @@ static int l2tp_connect(struct vpn_provider *provider,
 			void *user_data)
 {
 	struct l2tp_private_data *data;
-	const char *username, *password;
+	const char *username;
+	const char *password;
+	const char *auth_file;
+	bool request_secret;
+	bool use_challenge;
 	int err;
 
 	data = g_try_new0(struct l2tp_private_data, 1);
@@ -817,19 +1094,25 @@ static int l2tp_connect(struct vpn_provider *provider,
 
 	username = vpn_provider_get_string(provider, "L2TP.User");
 	password = vpn_provider_get_string(provider, "L2TP.Password");
+	auth_file = vpn_provider_get_string(provider, "L2TP.AuthFile");
 
 	DBG("user %s password %p", username, password);
 
+	request_secret = request_shared_secret(provider, &use_challenge);
+
 	if (!username || !*username || !password || !*password) {
-		err = request_input(provider, request_input_cb, dbus_sender,
-									data);
+		err = request_input(provider, request_input_cb,
+					request_secret ?
+						request_input_secret_cb : NULL,
+					dbus_sender, data);
 		if (err != -EINPROGRESS)
 			goto error;
 
 		return err;
 	}
 
-	return run_connect(data, username, password);
+	return run_connect(data, username, password, use_challenge, auth_file);
+
 
 error:
 	l2tp_connect_done(data, -err);
@@ -840,6 +1123,8 @@ error:
 
 static int l2tp_error_code(struct vpn_provider *provider, int exit_code)
 {
+	DBG("exit code %d", exit_code);
+
 	switch (exit_code) {
 	case 1:
 		return CONNMAN_PROVIDER_ERROR_CONNECT_FAILED;
@@ -853,7 +1138,10 @@ static void l2tp_disconnect(struct vpn_provider *provider)
 	if (!provider)
 		return;
 
+	DBG("");
+
 	vpn_provider_set_string_hide_value(provider, "L2TP.Password", NULL);
+	vpn_provider_set_string_hide_value(provider, "L2TP.SharedSecret", NULL);
 
 	connman_agent_cancel(provider);
 }
-- 
2.47.3

