Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E64C62E
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745289; cv=none; b=oTydshPy1TMdpSqWtR0pfRCdyt4r7t8hFkKzjGtKQgmDBxJRinFC2k9YQxJ9j+POTGHaWjL8IGlE00AiHFOkWbmzEO6jReclKULECGm1seFdtgkOtrK8BlnaeRLko9a1JQnz1BbaNRAH6EClhTFMVLL0QObTGI1TSEzi0IKBRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745289; c=relaxed/simple;
	bh=D+lqGdt3S93xtrCq2iHdQUDGhQTyLCMVXVOEbng7638=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJIqj0VPIlvnM5N+I8aChXhVHT0hMoxBJMscTHgYtt9B4NROLEPW14IdCM7Ms4wzq4y4cznSo0EdXW3fsbPddzLwGdFXYHu1WfAwhqCvv3OBGuh5bsPcK6VNTceWy07bwVWuJffjNYoZnIW3q5nzlweknVBAGNbOGKKOrPfVhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=f79Imf/j; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="f79Imf/j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ne17UrEGbBbWv9ZzmDs+EDrs60gG87jS+6dRa5pyG5g=; b=f79Imf/jcqFZjZ3rKepgPt5wr3
	ChFX6Sc8zjrLD+dYroQwSSAgIBKA7L5jH8gpWtp++/DYTuluhuWDc0dj2X0n71qyfjs+6roJ4W1OS
	h5yEgfkzYMCOePRdpwOP/Wc1bNY96gpAAcDYw+nTfHPyy7CS+ROmmNa/GVghXHzoTyMkUFHj6nqLk
	kAiHSZ3H4YtzLKK5LWZ4ka3F7QwLuPD/kU9kNISTX8fqj9FdcSqVN0D+q4aeqQxftzZWq+SlTJ8Uf
	B58ZEKYLVXprNnqOj3ta94r9WIUlXSKFN9dSzA+aLUaJZ0NqAZ4NSbnLdS3P4/Bktf8xRF7tnxVZK
	4MkHcIvw==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtI-006LIb-2K
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:58:52 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 05/11] service: Explicit VPN connect timeout, ignore in VPN agent wait
Date: Fri, 24 Jan 2025 20:58:39 +0200
Message-Id: <20250124185845.1546384-6-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
References: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9
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
index 32ba5591..a92e19d7 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -787,6 +787,8 @@ int __connman_service_connect(struct connman_service *service,
 int __connman_service_disconnect(struct connman_service *service);
 void __connman_service_set_active_session(bool enable, GSList *list);
 void __connman_service_auto_connect(enum connman_service_connect_reason reason);
+void __connman_service_start_connect_timeout(struct connman_service *service,
+				bool restart);
 bool __connman_service_remove(struct connman_service *service);
 void __connman_service_set_hidden_data(struct connman_service *service,
 				gpointer user_data);
diff --git a/src/service.c b/src/service.c
index 805cfca7..9dfb4ead 100644
--- a/src/service.c
+++ b/src/service.c
@@ -7098,8 +7098,27 @@ static gboolean connect_timeout(gpointer user_data)
 
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
 
@@ -7127,7 +7146,27 @@ static gboolean connect_timeout(gpointer user_data)
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
@@ -9751,9 +9790,12 @@ int __connman_service_connect(struct connman_service *service,
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

