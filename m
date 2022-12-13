Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F45CAD
	for <connman@lists.linux.dev>; Tue, 13 Dec 2022 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (88-113-60-36.elisa-laajakaista.fi [88.113.60.36])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 700da5f0-7aef-11ed-a85e-005056bdd08f;
	Tue, 13 Dec 2022 16:07:11 +0200 (EET)
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [RFC PATCH 5/9] service: Explicit VPN connect timeout, ignore in VPN agent wait
Date: Tue, 13 Dec 2022 16:07:03 +0200
Message-Id: <20221213140707.278313-6-jussi.laakkonen@jolla.com>
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

Ignore the connect timeout autostarting when connecting a VPN service
because initially the VPN is in association state in which the VPN is
waiting for the VPN agent. Separate the starting of connect timeout into
its own function __connman_service_start_connect_timeout() so provider.c
can call it when it enters configuration state.

When a VPN is waiting for user input it should not be affected by
connect timeout as the connection is not yet attempted. This may happen
if VPN resumes to association state when requiring the VPN agent for
other, e.g., encrypted private key input after credential input.
---
 src/connman.h |  2 ++
 src/service.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index b955d98b..863924de 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -754,6 +754,8 @@ int __connman_service_connect(struct connman_service *service,
 int __connman_service_disconnect(struct connman_service *service);
 void __connman_service_set_active_session(bool enable, GSList *list);
 void __connman_service_auto_connect(enum connman_service_connect_reason reason);
+void __connman_service_start_connect_timeout(struct connman_service *service,
+				bool restart);
 bool __connman_service_remove(struct connman_service *service);
 bool __connman_service_is_provider_pending(struct connman_service *service);
 void __connman_service_set_provider_pending(struct connman_service *service,
diff --git a/src/service.c b/src/service.c
index 079c7a6c..05527954 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4527,8 +4527,27 @@ static gboolean connect_timeout(gpointer user_data)
 
 	if (service->network)
 		__connman_network_disconnect(service->network);
-	else if (service->provider)
+	else if (service->provider) {
+		/*
+		 * Remove timeout when the VPN is waiting for user input in
+		 * association state. By default the VPN agent timeout is
+		 * 300s whereas default connection timeout is 120s. Provider
+		 * will start connect timeout for the service when it enters
+		 * configuration state.
+		 */
+		const char *statestr = connman_provider_get_string(
+					service->provider, "State");
+		if (!g_strcmp0(statestr, "association")) {
+			DBG("VPN provider %p is waiting for VPN agent, "
+						"stop connect timeout",
+						service->provider);
+			return G_SOURCE_REMOVE;
+		}
+
 		connman_provider_disconnect(service->provider);
+	}
+
+
 
 	__connman_stats_service_unregister(service);
 
@@ -4556,7 +4575,27 @@ static gboolean connect_timeout(gpointer user_data)
 				CONNMAN_SERVICE_CONNECT_REASON_USER)
 		do_auto_connect(service, CONNMAN_SERVICE_CONNECT_REASON_AUTO);
 
-	return FALSE;
+	return G_SOURCE_REMOVE;
+}
+
+void __connman_service_start_connect_timeout(struct connman_service *service,
+								bool restart)
+{
+	DBG("");
+
+	if (!service)
+		return;
+
+	if (!restart && service->timeout)
+		return;
+
+	if (restart && service->timeout) {
+		DBG("cancel running connect timeout");
+		g_source_remove(service->timeout);
+	}
+
+	service->timeout = g_timeout_add_seconds(CONNECT_TIMEOUT,
+				connect_timeout, service);
 }
 
 static DBusMessage *connect_service(DBusConnection *conn,
@@ -6790,9 +6829,12 @@ int __connman_service_connect(struct connman_service *service,
 		return 0;
 
 	if (err == -EINPROGRESS) {
-		if (service->timeout == 0)
-			service->timeout = g_timeout_add_seconds(
-				CONNECT_TIMEOUT, connect_timeout, service);
+		/*
+		 * VPN will start connect timeout when it enters CONFIGURATION
+		 * state.
+		 */
+		if (service->type != CONNMAN_SERVICE_TYPE_VPN)
+			__connman_service_start_connect_timeout(service, false);
 
 		return -EINPROGRESS;
 	}
-- 
2.30.2

