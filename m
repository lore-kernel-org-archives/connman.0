Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343329CA
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 19:53:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 735B161675;
	Sun, 29 Aug 2021 21:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630266807; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=gb6GSUU7v4D7QZ3iw9jbvPgXK6C5QMyVvbZIyCqr6kg=;
	b=NjpZF/alGWQDKwMH4FC0pYyIz4QiilURg2u91fx1bxUwx9Ed4OnElYMYkicKWvXjURIaZ1
	rrJXPNoz5MZ28M8UMSEKbswvvSu3yK1QJBF+i4XzsVusuMm+HKeYwoP89P2lhynVTUIGg8
	gj1j+kr1xVA6clzQwz1hN8eE0JgHwDqZnrKfgzrMWjGNx3Ciask6uYNCuzuI1S1qMSFhjp
	qMyQpAUt+j58vZw/TXWBtoZHXoL7pTSnGSUQbFfb0HYkENdyTdit+4nWyGgptfvP85+nqS
	ZMngWCJdhBply1VrJOG0ERwEIaV7QM6HXQBTmJowI2ZhVbj6lRCICqczgotqTQ==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 1/2] service: Move wispr start code into helper
Date: Sun, 29 Aug 2021 21:53:20 +0200
Message-Id: <20210829195321.23396-2-wagi@monom.org>
In-Reply-To: <20210829195321.23396-1-wagi@monom.org>
References: <20210829195321.23396-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

We want to be able to extend the functionally around the
__connman_service_wispr_start() code. Instead having to update the
open code part for IPv4 and IPv6 handling, let's move into a small
helper.
---
 src/service.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/src/service.c b/src/service.c
index a5a5cfde30fd..237c88e15506 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1595,6 +1595,19 @@ bool __connman_service_index_is_default(int index)
 	return __connman_service_get_index(service) == index;
 }
 
+static void start_wispr_when_connected(struct connman_service *service)
+{
+	if (__connman_service_is_connected_state(service,
+			CONNMAN_IPCONFIG_TYPE_IPV4))
+		__connman_service_wispr_start(service,
+					CONNMAN_IPCONFIG_TYPE_IPV4);
+
+	if (__connman_service_is_connected_state(service,
+			CONNMAN_IPCONFIG_TYPE_IPV6))
+		__connman_service_wispr_start(service,
+					CONNMAN_IPCONFIG_TYPE_IPV6);
+}
+
 static void default_changed(void)
 {
 	struct connman_service *service = connman_service_get_default();
@@ -1619,15 +1632,7 @@ static void default_changed(void)
 				connman_setting_get_bool("AllowDomainnameUpdates"))
 			__connman_utsname_set_domainname(service->domainname);
 
-		if (__connman_service_is_connected_state(service,
-						CONNMAN_IPCONFIG_TYPE_IPV4))
-			__connman_service_wispr_start(service,
-						CONNMAN_IPCONFIG_TYPE_IPV4);
-
-		if (__connman_service_is_connected_state(service,
-						CONNMAN_IPCONFIG_TYPE_IPV6))
-			__connman_service_wispr_start(service,
-						CONNMAN_IPCONFIG_TYPE_IPV6);
+		start_wispr_when_connected(service);
 
 		/*
 		 * Connect VPN automatically when new default service
@@ -3726,13 +3731,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 		nameserver_add_all(service, CONNMAN_IPCONFIG_TYPE_ALL);
 		dns_configuration_changed(service);
 
-		if (__connman_service_is_connected_state(service,
-						CONNMAN_IPCONFIG_TYPE_IPV4))
-			__connman_service_wispr_start(service, CONNMAN_IPCONFIG_TYPE_IPV4);
-
-		if (__connman_service_is_connected_state(service,
-						CONNMAN_IPCONFIG_TYPE_IPV6))
-			__connman_service_wispr_start(service, CONNMAN_IPCONFIG_TYPE_IPV6);
+		start_wispr_when_connected(service);
 
 		service_save(service);
 	} else if (g_str_equal(name, "Timeservers.Configuration")) {
-- 
2.32.0

