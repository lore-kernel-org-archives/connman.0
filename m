Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A25CA9
	for <connman@lists.linux.dev>; Tue, 13 Dec 2022 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6ee62587-7aef-11ed-a85e-005056bdd08f;
	Tue, 13 Dec 2022 16:07:09 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH 2/9] vpn-provider: Use association state for VPN agent input wait
Date: Tue, 13 Dec 2022 16:07:00 +0200
Message-Id: <20221213140707.278313-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221213140707.278313-1-jussi.laakkonen@jolla.com>
References: <20221213140707.278313-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index cc325967..30b9fa25 100644
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
2.30.2

