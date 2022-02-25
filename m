Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCB1FC3
	for <connman@lists.linux.dev>; Fri, 25 Feb 2022 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id cd440e12-9629-11ec-ae1c-005056bdf889;
	Fri, 25 Feb 2022 12:58:02 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] service: Check if hidden service has a pending request on agent
Date: Fri, 25 Feb 2022 12:58:00 +0200
Message-Id: <20220225105800.501005-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225105800.501005-1-jussi.laakkonen@jolla.com>
References: <20220225105800.501005-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hidden (WiFi) services do not save the pending request to the service
struct and this utilizes agent-connman.c to check if there is a agent
request already set for the service. In such case this reports in
progress error back to the caller as with visible service.

Otherwise there would be a possibility to request connect for at least
twice for a hidden WiFi network. And when agent is in use this would
result in two requests to be sent, first one is the current active one
and the second would be waiting in agent queue, which in case of
time-out would be then be sent to the agent as a duplicate request.
---
 src/service.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 1d2b78a6..f1abb963 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4562,7 +4562,10 @@ static DBusMessage *connect_service(DBusConnection *conn,
 
 	DBG("service %p", service);
 
-	if (service->pending)
+	/* Hidden services do not keep the pending msg, check it from agent */
+	if (service->pending || (service->hidden &&
+				__connman_agent_is_request_pending(service,
+						dbus_message_get_sender(msg))))
 		return __connman_error_in_progress(msg);
 
 	index = __connman_service_get_index(service);
-- 
2.30.2

