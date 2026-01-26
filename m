Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB633A6E9
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435089; cv=none; b=stuhKFajyDfLptDIF/c/oVzviFpiDCMuU6cbITOqHKGqm8GDmuf6W9taReUVme0isa9TnXnRbMawEcfYryxRgyLG61FnAa+RsDOaNqRihc7KPSLRWfKok1dgvSc2cFwVrUxWwE++yHdGc7V/ELPyj4ps6EQKlheUGZ903ocAN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435089; c=relaxed/simple;
	bh=AwFaKw9Tio9a3VbzLPO9liXMRjcmfs88mPXeEZFy8YA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujwPDKW7dl+Px+uupWExj9JWa/8r2bFuzENGlg6EU65aE2Fe+Y9LkdMpx5jEeMOOu2meif6gU2kS43axksCMScl8vMhjUricoTzNz7GNghZZeXqY8OX3myHt+fjuDjHlbwx4c2JGyWEuAo5DjI3C9NDD6b4Hc5Ad4Xvz9hlH1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=i8aUmkDc; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="i8aUmkDc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=j+Oo6y18i72IZxRXiitiCksbHRLcrnM7Hh6ebyVPKb0=; b=i8aUmkDctvtHrKcfGs9sLKUg+N
	h1mlyaX6G9WAWtpmZsvxHKZ50HT3JSHRhS/aMy5cgfwOTVHXi8KU8Q0ZONsXwRVDzOQY93rbPpA4A
	e/9vil40fiWkLGmydrFWr1WLqrvIbGBt6WK24Kmi6gd+tPetaJaZmjZdv1IPVahJ77lk+ijHQ3iVw
	kMBgKfjZ82Wtto5RP5NSaph1fBe4y/IRA0NKpUj41LItsOp8Kqo4Dhc5v+4TcZrc51snSIoveGDzv
	XRqkL3EmKE5kb/hNPbe29/GdeW+hnSlH6qDgISThthJl9HVImXz5z511x0xRWXkVAisi7rHYWmaod
	02GdPkIg==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMtZ-00C0gj-2N
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 15:44:45 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 6/9] l2tp: Fix clearing of credentials and use error int in callback
Date: Mon, 26 Jan 2026 15:43:45 +0200
Message-ID: <20260126134410.55749-7-jussi.laakkonen@jolla.com>
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
agent returns with timeout or no message error call l2tp_connect_done()
immediately with the error code. This avoids getting credentials being
unnecessarily reset.

Use ECONNREFUSED as an error in case l2tp_notify() gets connection
error.
---
 vpn/plugins/l2tp.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/vpn/plugins/l2tp.c b/vpn/plugins/l2tp.c
index ee40dd72..c3b01493 100644
--- a/vpn/plugins/l2tp.c
+++ b/vpn/plugins/l2tp.c
@@ -219,7 +219,7 @@ static int l2tp_notify(DBusMessage *msg, struct vpn_provider *provider)
 	}
 
 	if (strcmp(reason, "connect")) {
-		l2tp_connect_done(data, EIO);
+		l2tp_connect_done(data, ECONNREFUSED);
 
 		/*
 		 * Stop the task to avoid potential looping of this state when
@@ -228,7 +228,7 @@ static int l2tp_notify(DBusMessage *msg, struct vpn_provider *provider)
 		if (data && data->task)
 			connman_task_stop(data->task);
 
-		return VPN_STATE_DISCONNECT;
+		return VPN_STATE_FAILURE;
 	}
 
 	dbus_message_iter_recurse(&iter, &dict);
@@ -547,7 +547,6 @@ static void request_input_reply(DBusMessage *reply, void *user_data)
 {
 	struct request_input_reply *l2tp_reply = user_data;
 	struct l2tp_private_data *data;
-	const char *error = NULL;
 	char *username = NULL, *password = NULL;
 	char *key;
 	DBusMessageIter iter, dict;
@@ -555,8 +554,10 @@ static void request_input_reply(DBusMessage *reply, void *user_data)
 
 	DBG("provider %p", l2tp_reply->provider);
 
-	if (!reply)
+	if (!reply) {
+		err = ENOMSG;
 		goto done;
+	}
 
 	data = l2tp_reply->user_data;
 
@@ -567,7 +568,6 @@ static void request_input_reply(DBusMessage *reply, void *user_data)
 		/* Ensure cb is called only once */
 		data->cb = NULL;
 		data->user_data = NULL;
-		error = dbus_message_get_error_name(reply);
 		goto done;
 	}
 
@@ -616,7 +616,7 @@ static void request_input_reply(DBusMessage *reply, void *user_data)
 	}
 
 done:
-	l2tp_reply->callback(l2tp_reply->provider, username, password, error,
+	l2tp_reply->callback(l2tp_reply->provider, username, password, err,
 				l2tp_reply->user_data);
 
 	g_free(username);
@@ -625,13 +625,9 @@ done:
 	g_free(l2tp_reply);
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
@@ -776,15 +772,15 @@ done:
 static void request_input_cb(struct vpn_provider *provider,
 			const char *username,
 			const char *password,
-			const char *error, void *user_data)
+			int error, void *user_data)
 {
 	struct l2tp_private_data *data = user_data;
 
-	if (!username || !*username || !password || !*password)
-		DBG("Requesting username %s or password failed, error %s",
-			username, error);
-	else if (error)
-		DBG("error %s", error);
+	if (error || (!username || !*username || !password || !*password)) {
+		DBG("Requesting credentials failed: %s", strerror(error));
+		l2tp_connect_done(data, error);
+		return;
+	}
 
 	vpn_provider_set_string(provider, "L2TP.User", username);
 	vpn_provider_set_string_hide_value(provider, "L2TP.Password",
-- 
2.47.3

