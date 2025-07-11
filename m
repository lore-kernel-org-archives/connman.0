Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7A3C0C
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244076; cv=none; b=DjAzS1GTuKZPwiKQyh53fEhptwBYhuGR+l6Oebh1dczemK4Ov0QYs3KbfyxiXw43pSLadQwN4Z5co4N+vAiduIK91575gAhb1T5x3uBSYfVtkRp8jbiP0tfaPLvmoaBLIMekyTcf7ZkJvWXHnBSTpYlKT9ZR7CMNdJ3iG+pxnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244076; c=relaxed/simple;
	bh=i+u4rzi3a6RCMD+631D0t9K08onlbL+WDu/ZYBcYeXM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMHEKia4uo9L8Rvuo/2vwUqKx2GIVVfLC0GLFQdCRB1E/W4Qttc3EHeyJSdZkTd8h50iimzAsUev2bUhlPQQ4LXIVNX/qlV+YYvwgENSWWffG1iZKa/682SF4y2XMdysEsgmyLcbWXfqAQBFVzb9D/6wZLqwO23ENR3e6UTrKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=zt8uqv6l; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="zt8uqv6l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Hnog+C+MvZwFP8x5AM18wP/+qZAn2c78cVRv2cNGp0k=; b=zt8uqv6l0lwmXYEPVseEuOMvId
	abTrDNToy/CxfLqvTZjX9H7MQqPe4A07GgY4Tmt9792V4m7frMxas9ockW/pUyIvcj1lJxwUNkPG8
	Pg5CvSmZuUEKm7nrkxt2fenNc4dZu6KgbJXQr7ZXtmXgQzJM12unLQ0PckKRLDx3egRedqy1y0BpL
	PXCRlp+JwK9AuqmvKwXFMD4hQZaV8eRQ45ZqQeujnRfLmZbDjr9MyAiAW8A+LhnbXfveTxLnfLL69
	1R1sgR22uw//vAMQH4xVSZOfixHGHjn6xWP9t4Y1Y/SrOcs+Y/C3KpFuUUbjedW6dBF+anY4kTF5d
	8cU96uCA==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-00
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 05/45] service: Explicit VPN connect timeout, ignore in VPN agent wait
Date: Fri, 11 Jul 2025 17:26:56 +0300
Message-Id: <20250711142736.1757060-6-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:7901:7c96:5fcf:719b
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
---
 src/connman.h |  2 ++
 src/service.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 5 deletions(-)

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
index f73f42eb..9fd8fdb1 100644
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
 
@@ -7351,7 +7370,27 @@ static gboolean connect_timeout(gpointer user_data)
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
@@ -9975,9 +10014,12 @@ int __connman_service_connect(struct connman_service *service,
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

