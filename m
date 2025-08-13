Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACE27FD74
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099643; cv=none; b=RcOLj7uA9seD4CneJZrRx0/TylGOiQnVffo3XPvn2enbpysFG/ECT6VupNjPQJujblNuBBdtGklziq8MtpcMPTLRmsvR7fpuWH+7ibEKCcC2ebr5IcPjLJVRIrBrubh7U5l0ZaqGItwGo/8tH10gxXoA35Ym6t4F8el5fgTZQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099643; c=relaxed/simple;
	bh=hCMF9WBFx4DHJUb+jgjEYkZ/oDrRmlth3IXJMlHwmR4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+W+T1ghMakh0WzdFr8nNCch4aeLF7c6tnGcmxj3Vp398uEL0EkhLzH0PvQDjDsX5MhG6XSx2RNOmv/rlO48rEj9D32+1uUHqCK7M5jO22Mnc0BCoLlPV+x9IJtiu/Cw7949atlzLhckWoWsfia9xr/oJmLktyIYyNouSdh/F1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=dHXUQb0O; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="dHXUQb0O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XHBrjjD6TzGrB4Hrg+jFGyvtgC6Or29Cp9tCE74JkFw=; b=dHXUQb0OZiQdf7aRdyOUnJxC2d
	DEP1i5ymdVmDGF8eS4i3eHHvofk+72hJ77Gu8fQnGJODzpkDpQZ4qbFsT6vC85hZFIHiVvuiK3sUw
	i6yzVo69LVscTmuh+qHYAk7TRnmQY/fegb+FlrUEUlgubdsua2QKM1kFoKsRHKtP1kYaZCF2qOP6X
	kQWGxiS1/5oHTnHss5Tki+MZeXYE5Ui3T4ZDJjHL9P1gRGwuz8PIJN21AdOPk0hVhM7hQIZ/7JNcZ
	xiHQl0AzOlIEX3jA+tV5kHHMZ9nIq/0OfFckVFb3SXqBdmUnQecrArAxNR8+3ooqjO0zIZrQhHw6P
	xmB5vHQQ==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-0S
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 04/42] service: Explicit VPN connect timeout, ignore in VPN agent wait
Date: Wed, 13 Aug 2025 18:01:36 +0300
Message-Id: <20250813150214.189282-5-jussi.laakkonen@jolla.com>
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

Ignore the connect timeout autostarting when connecting a VPN service
because initially the VPN is in association state in which the VPN is
waiting for the VPN agent. Separate the starting of connect timeout into
its own function __connman_service_start_connect_timeout() so provider.c
can call it when it enters configuration state.

When a VPN is waiting for user input it should not be affected by
connect timeout as the connection is not yet attempted. This may happen
if VPN resumes to association state when requiring the VPN agent for
other, e.g., encrypted private key input after credential input.

Thus, this change makes it possible to respect both timeout values that
are configurable for vpnd and connmand separately. If the timeout for
vpnd is longer than the timeout of connmand the VPN agent dialog can be
prematurely terminated as connection timeout terminates the VPN
connection. It is more clear this way that let vpnd wait the time it is
configured to wait for the VPN agent to ask for credentials, and,
therefore, separetes the responsibilities of the two daemons.
---
 src/connman.h |  2 ++
 src/service.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 7ebda7af..1a8952e4 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -788,6 +788,8 @@ int __connman_service_connect(struct connman_service *service,
 int __connman_service_disconnect(struct connman_service *service);
 void __connman_service_set_active_session(bool enable, GSList *list);
 void __connman_service_auto_connect(enum connman_service_connect_reason reason);
+void __connman_service_start_connect_timeout(struct connman_service *service,
+				bool restart);
 bool __connman_service_remove(struct connman_service *service);
 void __connman_service_set_hidden_data(struct connman_service *service,
 				gpointer user_data);
diff --git a/src/service.c b/src/service.c
index d5869b14..28e82c81 100644
--- a/src/service.c
+++ b/src/service.c
@@ -7322,8 +7322,27 @@ static gboolean connect_timeout(gpointer user_data)
 
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
 
@@ -7351,7 +7370,32 @@ static gboolean connect_timeout(gpointer user_data)
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
+	/* When called for a VPN do start only in configuration state */
+	if (service->type == CONNMAN_SERVICE_TYPE_VPN &&
+			service->state != CONNMAN_SERVICE_STATE_CONFIGURATION)
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
@@ -9975,9 +10019,12 @@ int __connman_service_connect(struct connman_service *service,
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
2.39.5

