Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB141FC2
	for <connman@lists.linux.dev>; Fri, 25 Feb 2022 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id ccde6e44-9629-11ec-ae1c-005056bdf889;
	Fri, 25 Feb 2022 12:58:01 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/2] agent: Add support to check for active pending requests
Date: Fri, 25 Feb 2022 12:57:59 +0200
Message-Id: <20220225105800.501005-2-jussi.laakkonen@jolla.com>
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

This adds a simple search to agent.c that can be used via
agent-connman.c to check if there is a pending request for the service.
Both current active pending request for the agent is checked as well as
the list of the queries for the given user context.
---
 include/agent.h     |  1 +
 src/agent-connman.c | 16 ++++++++++++++++
 src/agent.c         | 28 ++++++++++++++++++++++++++++
 src/connman.h       |  2 ++
 4 files changed, 47 insertions(+)

diff --git a/include/agent.h b/include/agent.h
index 6961f7a1..27020203 100644
--- a/include/agent.h
+++ b/include/agent.h
@@ -71,6 +71,7 @@ int connman_agent_queue_message(void *user_context,
 				DBusMessage *msg, int timeout,
 				agent_queue_cb callback, void *user_data,
 				void *agent_data);
+bool connman_agent_queue_search(void *user_context, void *agent_data);
 
 void *connman_agent_get_info(const char *dbus_sender, const char **sender,
 							const char **path);
diff --git a/src/agent-connman.c b/src/agent-connman.c
index fca7cc1f..139a19fc 100644
--- a/src/agent-connman.c
+++ b/src/agent-connman.c
@@ -865,3 +865,19 @@ int __connman_agent_request_peer_authorization(struct connman_peer *peer,
 
 	return -EINPROGRESS;
 }
+
+bool __connman_agent_is_request_pending(struct connman_service *service,
+						const char *dbus_sender)
+{
+	void *agent;
+
+	/* Default agent will be returned if no dbus_sender */
+	agent = connman_agent_get_info(dbus_sender, NULL, NULL);
+
+	DBG("agent %p service %p", agent, service);
+
+	if (!service || !agent)
+		return false;
+
+	return connman_agent_queue_search(service, agent);
+}
diff --git a/src/agent.c b/src/agent.c
index d4f9add4..6a9eb1e0 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -257,6 +257,34 @@ int connman_agent_queue_message(void *user_context,
 	return err;
 }
 
+bool connman_agent_queue_search(void *user_context, void *agent_data)
+{
+	struct connman_agent *agent = agent_data;
+	struct connman_agent_request *queue_data;
+	GList *iter;
+
+	DBG("user context %p agent %p", user_context, agent);
+
+	if (!agent || !user_context)
+		return false;
+
+	if (agent->pending && agent->pending->user_context == user_context) {
+		DBG("user context %p is pending for reply", user_context);
+		return true;
+	}
+
+	for (iter = agent->queue; iter; iter = iter->next) {
+		queue_data = iter->data;
+
+		if (queue_data && queue_data->user_context == user_context) {
+			DBG("user context %p is in queue", user_context);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static void set_default_agent(void)
 {
 	struct connman_agent *agent = NULL;
diff --git a/src/connman.h b/src/connman.h
index 909b53ae..33dbec69 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -126,6 +126,8 @@ int __connman_agent_request_peer_authorization(struct connman_peer *peer,
 						bool wps_requested,
 						const char *dbus_sender,
 						void *user_data);
+bool __connman_agent_is_request_pending(struct connman_service *service,
+						const char *dbus_sender);
 
 #include <connman/log.h>
 
-- 
2.30.2

