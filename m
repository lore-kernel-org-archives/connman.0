Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0575CAB
	for <connman@lists.linux.dev>; Tue, 13 Dec 2022 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6f526170-7aef-11ed-a85e-005056bdd08f;
	Tue, 13 Dec 2022 16:07:10 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH 3/9] vpn: Add association state before connect state
Date: Tue, 13 Dec 2022 16:07:01 +0200
Message-Id: <20221213140707.278313-4-jussi.laakkonen@jolla.com>
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

This changes the state machine by adding the VPN_STATE_ASSOCIATION to be
entered right after connect() callback is called. This is needed in
order to properly react with the user input dialog waiting on VPNs.
connect state is now set when the dialog is closed to indicate that user
input is given and now the VPN really connects.

When VPN notify() allback is called the connect state is enforced if the
return value indicates so and the internal state is different. This is
to accommodate the changes required and to operate as a fallback that
the states of provider and driver are kept in sync.

Handle also association state in vpn_notify() where the state reported by
plugin can only be transitioned back to association from connect state.
The initial state for the plugins is association so in that case there
is no state change done. If this state is notified back in any other
state it is logged as a warning with the plugin that caused the state
transition attempt.
---
 vpn/plugins/vpn.c | 29 ++++++++++++++++++++++++++++-
 vpn/plugins/vpn.h |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index cb0d304b..51b202e4 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -219,6 +219,9 @@ static int vpn_set_state(struct vpn_provider *provider,
 	case VPN_PROVIDER_STATE_IDLE:
 		data->state = VPN_STATE_IDLE;
 		break;
+	case VPN_PROVIDER_STATE_ASSOCIATION:
+		data->state = VPN_STATE_ASSOCIATION;
+		break;
 	case VPN_PROVIDER_STATE_CONNECT:
 	case VPN_PROVIDER_STATE_READY:
 		data->state = VPN_STATE_CONNECT;
@@ -280,7 +283,30 @@ static DBusMessage *vpn_notify(struct connman_task *task,
 	DBG("provider %p driver %s state %d", provider, name, state);
 
 	switch (state) {
+	case VPN_STATE_ASSOCIATION:
+		/*
+		 * If plugin states it should be still waiting for VPN agent
+		 * we revert the state to association only if previous was
+		 * CONNECT state.
+		 */
+		if (data->state == VPN_STATE_CONNECT) {
+			data->state = VPN_STATE_ASSOCIATION;
+			vpn_provider_set_state(provider,
+						VPN_PROVIDER_STATE_ASSOCIATION);
+		} else if (data->state != VPN_STATE_ASSOCIATION) {
+			connman_warn("Invalid %s vpn_notify() state transition "
+					"from %d to %d (ASSOCIATION)",
+					vpn_driver_data->name, data->state,
+					state);
+		}
+		break;
 	case VPN_STATE_CONNECT:
+		if (data->state != VPN_STATE_CONNECT) {
+			data->state = VPN_STATE_CONNECT;
+			vpn_provider_set_state(provider,
+						VPN_PROVIDER_STATE_CONNECT);
+		}
+		/* fall through */
 	case VPN_STATE_READY:
 		if (data->state == VPN_STATE_READY) {
 			/*
@@ -565,6 +591,7 @@ static int vpn_connect(struct vpn_provider *provider,
 		data->state = VPN_STATE_IDLE;
 		break;
 
+	case VPN_STATE_ASSOCIATION:
 	case VPN_STATE_CONNECT:
 		return -EINPROGRESS;
 
@@ -645,7 +672,7 @@ static int vpn_connect(struct vpn_provider *provider,
 	DBG("%s started with dev %s",
 		vpn_driver_data->provider_driver.name, data->if_name);
 
-	data->state = VPN_STATE_CONNECT;
+	data->state = VPN_STATE_ASSOCIATION;
 
 	return -EINPROGRESS;
 
diff --git a/vpn/plugins/vpn.h b/vpn/plugins/vpn.h
index fd10addf..92609b92 100644
--- a/vpn/plugins/vpn.h
+++ b/vpn/plugins/vpn.h
@@ -39,6 +39,7 @@ enum vpn_state {
 	VPN_STATE_DISCONNECT    = 4,
 	VPN_STATE_FAILURE       = 5,
 	VPN_STATE_AUTH_FAILURE  = 6,
+	VPN_STATE_ASSOCIATION   = 7,
 };
 
 struct vpn_driver {
-- 
2.30.2

