Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336B33D4
	for <connman@lists.linux.dev>; Tue, 13 Dec 2022 14:08:19 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6e8d089f-7aef-11ed-a85e-005056bdd08f;
	Tue, 13 Dec 2022 16:07:08 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH 1/9] agent: Cancel agent request on NoReply D-Bus error
Date: Tue, 13 Dec 2022 16:06:59 +0200
Message-Id: <20221213140707.278313-2-jussi.laakkonen@jolla.com>
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

Handle also the NoReply D-Bus error as this is commonly sent back when
the timeout set for the request is exceeded. Canceling the request later
becomes impossible as agent->pending will be set to NULL in
agent_finalize_pending(). Thus, making later calls to
connman_agent_cancel() to not to close down agent dialogs but instead
they are piled up on top of each other.
---
 src/agent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/agent.c b/src/agent.c
index 23517d9b..e2d1ef09 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -201,7 +201,9 @@ static void agent_receive_message(DBusPendingCall *call, void *user_data)
 	if (dbus_message_is_error(reply,
 			"org.freedesktop.DBus.Error.Timeout") ||
 			dbus_message_is_error(reply,
-			"org.freedesktop.DBus.Error.TimedOut")) {
+			"org.freedesktop.DBus.Error.TimedOut") ||
+			dbus_message_is_error(reply,
+			"org.freedesktop.DBus.Error.NoReply")) {
 		send_cancel_request(agent, agent->pending);
 	}
 
-- 
2.30.2

