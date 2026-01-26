Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FCC3385BE
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435090; cv=none; b=Oknc3t13ISRYA5jKr6jfmA7Es3MYy/um2Xt4YhHi+WJvjwc+dUUysOiEozas8oj8nAwLX0OG7ghw0+MXLekOjNklELIiU+qlQGshqSsyjhauu2MsiLY7HjYaN82LpjlMIyjGXomR5acGpcbB78YzNSnRW/bK6n+S9TM4wMi78sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435090; c=relaxed/simple;
	bh=vtto/MMLr5gz5l658jH3ZhN0GHV+TrHwAS+c8Lyd6Rs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGn2C/g0zcHOFDVW+viqS2nMzmCcKbxD01nDCUfx3AZBDJwy2ph0sbLo9lVFCWcusZuv+5QBnrWweTIUZDHH/2EiN0xPRtgI1A+VkJqEdUN58QeL935u8sr39l8hrrqssWcE4aHn9bbH/vCD7p7/bcQ5hNjcMj2sQLzb+fy+SPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=Rufx3TCc; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Rufx3TCc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gZ0DLJoGn9f4VllietZwDMxrVRcOnxJ7G4d22J6wzto=; b=Rufx3TCc894wq+91JviimaSHuV
	njoGFg5IKji9c6SvascVwL4IjeCXplbaLOwxIVgoNnSL8KBhNrBU5PvJQlw3aAUAZR3uT5eOYyA59
	vdI4dtQeC5x5UPwpyCLw0j10m6BvidbuHHorNM0oDgdDPur2ccIt1arUdSxhTHV3TqtExt8xf5D1j
	tRKXx4ZdYyvSaG31gm1erbhG5vj6obTPaZgGNh/cxtc3gAigsG3dp5lLxWzSNlm2qj4nmCFdbHfl2
	dULWkG00IMEGMg/Gyerr1kA6Mdf66lurGS9NUhpXFZzdXHpCvo7a1d4YXDqVNCK0Xgn8cQC+F3YvJ
	RUIYAuhw==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMtZ-00C0gj-1u
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 15:44:45 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/9] pptp: Fix clearing of credentials and use error int in callback
Date: Mon, 26 Jan 2026 15:43:42 +0200
Message-ID: <20260126134410.55749-4-jussi.laakkonen@jolla.com>
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

Use the error code parsed by VPN agent for the agent callback.  When the
agent returns with timeout or no message error call pptp_connect_done()
immediately with the error code. This avoids getting credentials being
unnecessarily reset.

Use ECONNREFUSED as an error in case pptp_notify() gets connection
error. Add some debug messages to be able to see what error causes
termination.
---
 vpn/plugins/pptp.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/vpn/plugins/pptp.c b/vpn/plugins/pptp.c
index 04498a53..171f66d4 100644
--- a/vpn/plugins/pptp.c
+++ b/vpn/plugins/pptp.c
@@ -110,6 +110,9 @@ static void pptp_connect_done(struct pptp_private_data *data, int err)
 	user_data = data->user_data;
 	data->cb = NULL;
 	data->user_data = NULL;
+
+	DBG("error %d", err);
+
 	cb(data->provider, user_data, err);
 }
 
@@ -183,7 +186,9 @@ static int pptp_notify(DBusMessage *msg, struct vpn_provider *provider)
 	}
 
 	if (strcmp(reason, "connect")) {
-		pptp_connect_done(data, EIO);
+		DBG("failed to connect");
+
+		pptp_connect_done(data, ECONNREFUSED);
 
 		/*
 		 * Stop the task to avoid potential looping of this state when
@@ -192,7 +197,7 @@ static int pptp_notify(DBusMessage *msg, struct vpn_provider *provider)
 		if (data && data->task)
 			connman_task_stop(data->task);
 
-		return VPN_STATE_DISCONNECT;
+		return VPN_STATE_FAILURE;
 	}
 
 	dbus_message_iter_recurse(&iter, &dict);
@@ -354,7 +359,6 @@ static void request_input_reply(DBusMessage *reply, void *user_data)
 {
 	struct request_input_reply *pptp_reply = user_data;
 	struct pptp_private_data *data;
-	const char *error = NULL;
 	char *username = NULL, *password = NULL;
 	char *key;
 	DBusMessageIter iter, dict;
@@ -362,8 +366,10 @@ static void request_input_reply(DBusMessage *reply, void *user_data)
 
 	DBG("provider %p", pptp_reply->provider);
 
-	if (!reply)
+	if (!reply) {
+		err = ENOMSG;
 		goto done;
+	}
 
 	data = pptp_reply->user_data;
 
@@ -374,7 +380,6 @@ static void request_input_reply(DBusMessage *reply, void *user_data)
 		/* Ensure cb is called only once */
 		data->cb = NULL;
 		data->user_data = NULL;
-		error = dbus_message_get_error_name(reply);
 		goto done;
 	}
 
@@ -423,7 +428,7 @@ static void request_input_reply(DBusMessage *reply, void *user_data)
 	}
 
 done:
-	pptp_reply->callback(pptp_reply->provider, username, password, error,
+	pptp_reply->callback(pptp_reply->provider, username, password, err,
 				pptp_reply->user_data);
 
 	g_free(username);
@@ -432,13 +437,9 @@ done:
 	g_free(pptp_reply);
 }
 
-typedef void (* request_cb_t)(struct vpn_provider *provider,
-				const char *username, const char *password,
-				const char *error, void *user_data);
-
 static int request_input(struct vpn_provider *provider,
-			request_cb_t callback, const char *dbus_sender,
-			void *user_data)
+			vpn_provider_password_cb_t callback,
+			const char *dbus_sender, void *user_data)
 {
 	DBusMessage *message;
 	const char *path, *agent_sender, *agent_path;
@@ -589,15 +590,15 @@ done:
 static void request_input_cb(struct vpn_provider *provider,
 			const char *username,
 			const char *password,
-			const char *error, void *user_data)
+			int error, void *user_data)
 {
 	struct pptp_private_data *data = user_data;
 
-	if (!username || !*username || !password || !*password)
-		DBG("Requesting username %s or password failed, error %s",
-			username, error);
-	else if (error)
-		DBG("error %s", error);
+	if (error || (!username || !*username || !password || !*password)) {
+		DBG("Requesting credentials failed: %s", strerror(error));
+		pptp_connect_done(data, error);
+		return;
+	}
 
 	vpn_provider_set_string(provider, "PPTP.User", username);
 	vpn_provider_set_string_hide_value(provider, "PPTP.Password",
@@ -659,6 +660,7 @@ error:
 
 static int pptp_error_code(struct vpn_provider *provider, int exit_code)
 {
+	DBG("exit code %d", exit_code);
 
 	switch (exit_code) {
 	case 1:
-- 
2.47.3

