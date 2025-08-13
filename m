Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997F27F000
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099629; cv=none; b=b1G+u9lZ0Gnut0H0upZh5Z+CYFx8u1Cyi3Dh0yGXLTQvQDROSVydUz59D6DY2XV/Oz4nkk8Vpyc7+9hlUkJm09+nvpAWcvilMjqrz4bgyVF5ksTbB51yvYhRlwdvkpSQaWau19ix3d217zq1j2cYzov4+TSQA90t6BqpZiP7CKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099629; c=relaxed/simple;
	bh=npHwDB5o7ORxE6D6L8fuFKvEeFsrujvOgooQ+XUU9J4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g98jPEZTIOOfmieYk3MBCBsNSoFd3nDGU9Z2PA+d9bGfUIZcOY3AY091jfhGv4ftLb9nUD/mK8NKKChVjKhY+ZRer2oghKtW3V9/r4/cWO7H6Bx6s1g0MXmMppYQ3XR62x1BBwxCEBdmwQh4OuiT1ZweZfa9kdFouWo0oArhbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=GrgDsHrh; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="GrgDsHrh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YwO8c31lXcfETINsFJ4brKCQe1EZYptwpb0VtwGcDts=; b=GrgDsHrh+RD+lw2voFJ0SnN78L
	KWeeT8IqtFgJ1YOtXgpJH9dqyiP3lM48hEZtEn2Qq9gXieWRlyMR9MLyfZvfit1ftwLtBnCtI+IFA
	3TvbnpykmyiTPnK0sSc1fBSYM7mO5/X4aBCFWhpJR9zk2GxJdnIEYXzCPulUhDxFZ+GOWPDRQW9H9
	3B3M/hJvV25ceqc7qVYxzKawT954gX23K9/6TfDSXTJG2l8XEwwVZfCtlYI1ayqpDTGtLFykDtzHg
	44FMRF9264CN5CGRlH3EubXVDpLwyWkaQZExEZ6eoBYT35qUvfkQgQeRhhchkYpHxY+5GJoos/krQ
	I3Lz2EeQ==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-1Y
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 34/42] vpn-provider: Make daemonless VPNs to connect when connmand is online
Date: Wed, 13 Aug 2025 18:02:06 +0300
Message-Id: <20250813150214.189282-35-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
References: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:b275:797e:525b:8df9
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Reformat the connmand status checking code to account the exact online
state. Add a function get_flags for vpn_provider_driver struct to get
the flags set by the plugin to determine whether VPN can be attempted to
connect in ready or online state. Do connect daemonless VPNs only after
connmand reports being online, as they may be connected too early and
network is not setup yet if they get connected when connmand has reached
ready state. Thus, this does not change the functionality for the VPNs
using a daemon.
---
 vpn/vpn-provider.c | 67 +++++++++++++++++++++++++++++++++-------------
 vpn/vpn-provider.h |  1 +
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index 3942c937..b81e3df4 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -125,7 +125,14 @@ static unsigned int get_connman_state_timeout;
 static guint connman_signal_watch;
 static guint connman_service_watch;
 
-static bool connman_online;
+enum connman_state {
+	CONNMAN_IDLE = 0,
+	CONNMAN_OFFLINE,
+	CONNMAN_READY,
+	CONNMAN_ONLINE
+};
+
+static enum connman_state connman_online_state = CONNMAN_IDLE;
 static bool state_query_completed;
 
 
@@ -164,22 +171,46 @@ static void set_state(const char *new_state)
 	if (!new_state || !*new_state)
 		return;
 
-	DBG("old state %s new state %s",
-				connman_online ?
-				CONNMAN_STATE_ONLINE "/" CONNMAN_STATE_READY :
-				CONNMAN_STATE_OFFLINE "/" CONNMAN_STATE_IDLE,
-				new_state);
-
-	/* States "online" and "ready" mean connman is online */
-	if (!g_ascii_strcasecmp(new_state, CONNMAN_STATE_ONLINE) ||
-			!g_ascii_strcasecmp(new_state, CONNMAN_STATE_READY))
-		connman_online = true;
-	/* Everything else means connman is offline */
+	DBG("received %s, old state %d", new_state, connman_online_state);
+
+	if (!g_ascii_strcasecmp(new_state, CONNMAN_STATE_ONLINE))
+		connman_online_state = CONNMAN_ONLINE;
+	else if (!g_ascii_strcasecmp(new_state, CONNMAN_STATE_READY))
+		connman_online_state = CONNMAN_READY;
+	else if (!g_ascii_strcasecmp(new_state, CONNMAN_STATE_OFFLINE))
+		connman_online_state = CONNMAN_OFFLINE;
 	else
-		connman_online = false;
+		connman_online_state = CONNMAN_IDLE;
+
+	DBG("new state %d ", connman_online_state);
+}
+
+static bool is_connman_connected(struct vpn_provider *provider)
+{
+	int flags = 0;
+
+	DBG("provider %p connmand state %d", provider, connman_online_state);
+
+	if (provider && provider->driver && provider->driver->get_flags)
+		flags = provider->driver->get_flags(provider);
 
-	DBG("set state %s connman_online=%s ", new_state,
-				connman_online ? "true" : "false");
+	switch (connman_online_state) {
+	case CONNMAN_IDLE:
+	case CONNMAN_OFFLINE:
+		return false;
+	case CONNMAN_READY:
+		/* VPNs without daemon may require that network is setup. */
+		if (flags & VPN_FLAG_NO_DAEMON) {
+			DBG("daemonless provider, return false in ready");
+			return false;
+		}
+
+		/* fall-through */
+	case CONNMAN_ONLINE:
+		break;
+	}
+
+	return true;
 }
 
 static void free_route(gpointer data)
@@ -832,8 +863,8 @@ static gboolean do_connect_timeout_function(gpointer data)
 
 	DBG("");
 
-	/* Keep in main loop if connman is not online. */
-	if (!connman_online)
+	/* Keep in main loop if connman is not ready for this VPN. */
+	if (!is_connman_connected(provider))
 		return G_SOURCE_CONTINUE;
 
 	provider->do_connect_timeout = 0;
@@ -887,7 +918,7 @@ static DBusMessage *do_connect(DBusConnection *conn, DBusMessage *msg,
 
 	DBG("conn %p provider %p", conn, provider);
 
-	if (!connman_online) {
+	if (!is_connman_connected(provider)) {
 		if (state_query_completed) {
 			DBG("%s not started - ConnMan not online/ready",
 				provider->identifier);
diff --git a/vpn/vpn-provider.h b/vpn/vpn-provider.h
index c7487525..a7ec5109 100644
--- a/vpn/vpn-provider.h
+++ b/vpn/vpn-provider.h
@@ -175,6 +175,7 @@ struct vpn_provider_driver {
 			int *family, unsigned long *idx,
 			enum vpn_provider_route_type *type);
 	bool (*uses_vpn_agent) (struct vpn_provider *provider);
+	int (*get_flags)(struct vpn_provider *provider);
 };
 
 int vpn_provider_driver_register(struct vpn_provider_driver *driver);
-- 
2.39.5

