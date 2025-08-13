Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279BB286D6B
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099611; cv=none; b=TVc4J8Cc9UzJ0Njx2tf9BeQ2tZKfdW1w8U4HdckrfBQAnf2oO0EjzMp6hyoCcoaxIx7LXtSIdAFKKWl7/67e4/S2kyc6D+FOTTxjSH4ztfsqE49KsNezdWiELGodnc99hDc5lPG7ndJMdgz1LWax+8dQM9fzBK5QeYPhWpC8bp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099611; c=relaxed/simple;
	bh=lQtNL615u72qVz634XPwOQrKQp8bCjgt6oIjwGswj38=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FcLVjUmq96naW0ikxUxNAe3QOYFhMbBrIjwOK+GjpMR16jXZE/EbAI57vXWmaKmdEFQA8XkUSP0Eq7MUr7N5WMJT7+vYhKeR1YywW8Vb2i1+H2fvtibmDes+x7Qqgzth6v8ERTxSMUS/hbA45N9MMUyFSaFW3aCIgBnE/7e/iwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=giW+ZmrN; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="giW+ZmrN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=emYeZ4h7rPezZTt5bkycveQhOTDYl4JJORP6b21YuEc=; b=giW+ZmrNKs8rr2icv5/igu05mV
	nm0rc1qWTvnpeRwZQQmBrMMhQyy88lbuQOq6rXu5KXGRvximgDEFiOTb+KxS7lowZiHm0XGZe3w3y
	Y8IFDMV7+V9eQpa/Pe/co22D6uteb18hJTNBhY4kN/DbuFhsIvuypuPZU4KVDZmInS0qgH3wIoTPn
	dlFiv9FojgUaBRh4Oj6Mpw4duj+lYvPi5aSPMGQk8GJ7bgxIHgocdI2PnSit0s/HWo+ixYtITsP40
	clGaNVA7C0w782RxXLAPnC7x5HuiBbJQkCI3Nk1TEOkNB7lLAa5arMhfLaT9nNLQAz0FwtASq67Nf
	MaZ0u1nQ==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-02
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 01/42] vpn-provider: Use association state for VPN agent input wait
Date: Wed, 13 Aug 2025 18:01:33 +0300
Message-Id: <20250813150214.189282-2-jussi.laakkonen@jolla.com>
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

Use the association state with VPNs to define that VPN is waiting for
input via agent. The same state is used for every service in connmand so
this change synchronizes the states in both.

Set the state to be identical to connmand side states by injecting this
into the VPN state machine before the connect state ("configuration"
state). This is then changed when the state is set to connected either
by getting a non-error reply from VPN agent or via VPN driver gets
connect state notify.

In this is association state the VPN indicates to connmand that the VPN
is requesting user input via agent and shouldn't be subject to connect
timeout checks. Having this additional state allows to obey the D-Bus VPN
agent query timeout value, instead of getting the dialog shut down at
connection timeout.
---
 vpn/vpn-provider.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 vpn/vpn-provider.h |  6 ++++++
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index 4bcb8373..56040e65 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -1487,6 +1487,23 @@ int __vpn_provider_disconnect(struct vpn_provider *provider)
 	return err;
 }
 
+static bool is_connected_state(enum vpn_provider_state state)
+{
+	switch (state) {
+	case VPN_PROVIDER_STATE_UNKNOWN:
+	case VPN_PROVIDER_STATE_IDLE:
+	case VPN_PROVIDER_STATE_DISCONNECT:
+	case VPN_PROVIDER_STATE_FAILURE:
+		break;
+	case VPN_PROVIDER_STATE_CONNECT:
+	case VPN_PROVIDER_STATE_READY:
+	case VPN_PROVIDER_STATE_ASSOCIATION:
+		return true;
+	}
+
+	return false;
+}
+
 static void connect_cb(struct vpn_provider *provider, void *user_data,
 								int error)
 {
@@ -1509,6 +1526,8 @@ static void connect_cb(struct vpn_provider *provider, void *user_data,
 			 * No reply, disconnect called by connmand because of
 			 * connection timeout.
 			 */
+			vpn_provider_indicate_error(provider,
+					VPN_PROVIDER_ERROR_CONNECT_FAILED);
 			break;
 		case ENOMSG:
 			/* fall through */
@@ -1533,9 +1552,7 @@ static void connect_cb(struct vpn_provider *provider, void *user_data,
 			 * process gets killed and vpn_died() is called to make
 			 * the provider back to idle state.
 			 */
-			if (provider->state == VPN_PROVIDER_STATE_CONNECT ||
-						provider->state ==
-						VPN_PROVIDER_STATE_READY) {
+			if (is_connected_state(provider->state)) {
 				if (provider->driver->set_state)
 					provider->driver->set_state(provider,
 						VPN_PROVIDER_STATE_DISCONNECT);
@@ -1597,6 +1614,17 @@ int __vpn_provider_connect(struct vpn_provider *provider, DBusMessage *msg)
 		if (reply)
 			g_dbus_send_message(connection, reply);
 
+		return -EINPROGRESS;
+	case VPN_PROVIDER_STATE_ASSOCIATION:
+		/*
+		 * Do not interrupt user when inputting credentials via agent.
+		 * The driver is in CONNECT state that would return EINPROGRESS
+		 * and change provider state to CONNECT.
+		 */
+		reply = __connman_error_in_progress(msg);
+		if (reply)
+			g_dbus_send_message(connection, reply);
+
 		return -EINPROGRESS;
 	case VPN_PROVIDER_STATE_UNKNOWN:
 	case VPN_PROVIDER_STATE_IDLE:
@@ -1626,7 +1654,7 @@ int __vpn_provider_connect(struct vpn_provider *provider, DBusMessage *msg)
 		return -EOPNOTSUPP;
 
 	if (err == -EINPROGRESS)
-		vpn_provider_set_state(provider, VPN_PROVIDER_STATE_CONNECT);
+		vpn_provider_set_state(provider, VPN_PROVIDER_STATE_ASSOCIATION);
 
 	return err;
 }
@@ -1767,6 +1795,8 @@ static const char *state2string(enum vpn_provider_state state)
 		break;
 	case VPN_PROVIDER_STATE_IDLE:
 		return "idle";
+	case VPN_PROVIDER_STATE_ASSOCIATION:
+		return "association";
 	case VPN_PROVIDER_STATE_CONNECT:
 		return "configuration";
 	case VPN_PROVIDER_STATE_READY:
@@ -1875,6 +1905,9 @@ static void append_state(DBusMessageIter *iter,
 	case VPN_PROVIDER_STATE_IDLE:
 		str = "idle";
 		break;
+	case VPN_PROVIDER_STATE_ASSOCIATION:
+		str = "association";
+		break;
 	case VPN_PROVIDER_STATE_CONNECT:
 		str = "configuration";
 		break;
@@ -2026,6 +2059,10 @@ int vpn_provider_set_state(struct vpn_provider *provider,
 	case VPN_PROVIDER_STATE_IDLE:
 		return set_connected(provider, false);
 	case VPN_PROVIDER_STATE_CONNECT:
+		if (provider->driver && provider->driver->set_state)
+			provider->driver->set_state(provider, state);
+		return provider_indicate_state(provider, state);
+	case VPN_PROVIDER_STATE_ASSOCIATION:
 		return provider_indicate_state(provider, state);
 	case VPN_PROVIDER_STATE_READY:
 		return set_connected(provider, true);
diff --git a/vpn/vpn-provider.h b/vpn/vpn-provider.h
index 5d1455da..c81476c6 100644
--- a/vpn/vpn-provider.h
+++ b/vpn/vpn-provider.h
@@ -44,6 +44,12 @@ enum vpn_provider_state {
 	VPN_PROVIDER_STATE_READY         = 3,
 	VPN_PROVIDER_STATE_DISCONNECT    = 4,
 	VPN_PROVIDER_STATE_FAILURE       = 5,
+	/*
+	 * Special state to indicate that user interaction is being waited for
+	 * and disconnect timeout in connmand should not terminate this VPN but
+	 * to let the agent timeout handle the case.
+	 */
+	VPN_PROVIDER_STATE_ASSOCIATION   = 6,
 };
 
 enum vpn_provider_error {
-- 
2.39.5

