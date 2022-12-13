Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23E5CB1
	for <connman@lists.linux.dev>; Tue, 13 Dec 2022 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 711341a2-7aef-11ed-a85e-005056bdd08f;
	Tue, 13 Dec 2022 16:07:13 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH 8/9] vpn: Check if connecting when setting state or disconnecting
Date: Tue, 13 Dec 2022 16:07:06 +0200
Message-Id: <20221213140707.278313-9-jussi.laakkonen@jolla.com>
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

Add checking of connected and connecting state in cases when the state
is being set and state transitions to disconnecting. This change avoids
clearing the transport ident when VPN is waiting for input from VPN
agent (association state).
---
 plugins/vpn.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index d9a56ae1..bec7f59f 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -270,6 +270,13 @@ static bool provider_is_connected(struct connection_data *data)
 			g_str_equal(data->state, "configuration"));
 }
 
+static bool provider_is_connected_or_connecting(struct connection_data *data)
+{
+	return data && (g_str_equal(data->state, "ready") ||
+			g_str_equal(data->state, "configuration") ||
+			g_str_equal(data->state, "association"));
+}
+
 static void set_provider_state(struct connection_data *data)
 {
 	enum connman_provider_state state = CONNMAN_PROVIDER_STATE_UNKNOWN;
@@ -278,7 +285,11 @@ static void set_provider_state(struct connection_data *data)
 
 	DBG("provider %p new state %s", data->provider, data->state);
 
-	connected = provider_is_connected(data);
+	/*
+	 * To avoid clearing transport ident when VPN is waiting for agent
+	 * take also connecting state into account.
+	 */
+	connected = provider_is_connected_or_connecting(data);
 
 	if (g_str_equal(data->state, "ready")) {
 		state = CONNMAN_PROVIDER_STATE_READY;
@@ -1076,7 +1087,7 @@ static int provider_disconnect(struct connman_provider *provider)
 	if (!data)
 		return -EINVAL;
 
-	if (provider_is_connected(data))
+	if (provider_is_connected_or_connecting(data))
 		err = disconnect_provider(data);
 
 	if (data->call) {
@@ -1730,7 +1741,7 @@ static void destroy_provider(struct connection_data *data)
 {
 	DBG("data %p", data);
 
-	if (provider_is_connected(data))
+	if (provider_is_connected_or_connecting(data))
 		connman_provider_disconnect(data->provider);
 
 	connman_provider_set_data(data->provider, NULL);
@@ -2183,7 +2194,7 @@ static bool vpn_is_valid_transport(struct connman_service *transport)
 
 static void vpn_disconnect_check_provider(struct connection_data *data)
 {
-	if (provider_is_connected(data)) {
+	if (provider_is_connected_or_connecting(data)) {
 		/* With NULL service ident NULL is returned immediately */
 		struct connman_service *service =
 			connman_service_lookup_from_identifier
-- 
2.30.2

