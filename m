Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB00C5CAA
	for <connman@lists.linux.dev>; Tue, 13 Dec 2022 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6fb7e4af-7aef-11ed-a85e-005056bdd08f;
	Tue, 13 Dec 2022 16:07:10 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH 4/9] vpn-agent: Do connect state transition after input dialog check
Date: Tue, 13 Dec 2022 16:07:02 +0200
Message-Id: <20221213140707.278313-5-jussi.laakkonen@jolla.com>
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

When the VPN requests input (credentials) via the VPN agent the
vpn_agent_check_and_process_reply_error() does transition the state of
the VPN provider to connect state when there is no error. This is done
to facilitate the transition from the association state to connect
state as each VPN should use this function to verify the D-Bus reply
and, thus will be called after each reply.
---
 vpn/vpn-agent.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/vpn/vpn-agent.c b/vpn/vpn-agent.c
index ab6fea55..f1cc7e36 100644
--- a/vpn/vpn-agent.c
+++ b/vpn/vpn-agent.c
@@ -257,8 +257,12 @@ int vpn_agent_check_and_process_reply_error(DBusMessage *reply,
 
 	dbus_error_init(&error);
 
-	if (!dbus_set_error_from_message(&error, reply))
+	if (!dbus_set_error_from_message(&error, reply)) {
+		DBG("Dialog without error, set provider %p to CONNECT",
+					provider);
+		vpn_provider_set_state(provider, VPN_PROVIDER_STATE_CONNECT);
 		return 0;
+	}
 
 	if (!g_strcmp0(error.name, VPN_AGENT_INTERFACE ".Error.Canceled"))
 		err = ECANCELED;
-- 
2.30.2

