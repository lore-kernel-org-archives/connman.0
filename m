Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0086CF
	for <connman@lists.linux.dev>; Tue,  6 Sep 2022 18:15:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27EB65E0B1;
	Tue,  6 Sep 2022 20:15:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1662488106; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=1CWk63kAppKAHOf62xK290xHAg38jDTmKdBjC2JOISE=;
	b=xzvfNYKGTqEP8fMPmM4AFFMnNJ3+agUOZEh3icJyRY1JcQzvxiSWUpkoSdDPwdHIMDSm6R
	fr0a2kkX5yQh1vlvEQbbWFW8b8yFx54nGqAB0+0Ey2xd7HyGHB1sBB/Zhy+OfHxx/uEWZJ
	wG4rIA+huD6jY6vGC0eYT6tJ/p4nwxtroGgcIUPqSs4wU6cr3EJN08bPyvJUeMRjRn803Y
	5oP4+cVi9JT+JQbuYHyhx7Qo0UkrY8jyGS7eW8WcVqvVIK0eO2xBocz5ySom9bS4kiuCei
	/xpJscBOrGZPEJPIGRe6EqE4yVxYPS9V2Tes1LnueU0Qi8nglsRqYbrXsQAq2w==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 1/2] service: Track online check for IPv4 and IPv6 separately
Date: Tue,  6 Sep 2022 20:15:03 +0200
Message-Id: <20220906181504.7539-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The online check is not distinguishing between IPv4 and IPv6 but the
rest of the code assumes we handle them separately.
---
 src/service.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/src/service.c b/src/service.c
index 988928e7859e..079c7a6cda84 100644
--- a/src/service.c
+++ b/src/service.c
@@ -137,7 +137,8 @@ struct connman_service {
 	char *pac;
 	bool wps;
 	bool wps_advertizing;
-	guint online_timeout;
+	guint online_timeout_ipv4;
+	guint online_timeout_ipv6;
 	unsigned int online_check_interval_ipv4;
 	unsigned int online_check_interval_ipv6;
 	bool do_split_routing;
@@ -1438,12 +1439,16 @@ static bool check_proxy_setup(struct connman_service *service)
 
 static void cancel_online_check(struct connman_service *service)
 {
-	if (service->online_timeout == 0)
-		return;
-
-	g_source_remove(service->online_timeout);
-	service->online_timeout = 0;
-	connman_service_unref(service);
+	if (service->online_timeout_ipv4) {
+		g_source_remove(service->online_timeout_ipv4);
+		service->online_timeout_ipv4 = 0;
+		connman_service_unref(service);
+	}
+	if (service->online_timeout_ipv6) {
+		g_source_remove(service->online_timeout_ipv6);
+		service->online_timeout_ipv6 = 0;
+		connman_service_unref(service);
+	}
 }
 
 static void start_online_check(struct connman_service *service,
@@ -1461,7 +1466,7 @@ static void start_online_check(struct connman_service *service,
 	online_check_max_interval =
 		connman_setting_get_uint("OnlineCheckMaxInterval");
 
-	if (type != CONNMAN_IPCONFIG_TYPE_IPV4 || check_proxy_setup(service)) {
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV6 || check_proxy_setup(service)) {
 		cancel_online_check(service);
 		__connman_service_wispr_start(service, type);
 	}
@@ -6330,20 +6335,20 @@ static void service_rp_filter(struct connman_service *service,
 static void redo_wispr(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
-	service->online_timeout = 0;
-	connman_service_unref(service);
-
 	DBG("Retrying %s WISPr for %p %s",
 		__connman_ipconfig_type2string(type),
 		service, service->name);
 
 	__connman_wispr_start(service, type);
+	connman_service_unref(service);
 }
 
 static gboolean redo_wispr_ipv4(gpointer user_data)
 {
 	struct connman_service *service = user_data;
 
+	service->online_timeout_ipv4 = 0;
+
 	redo_wispr(service, CONNMAN_IPCONFIG_TYPE_IPV4);
 
 	return FALSE;
@@ -6353,6 +6358,8 @@ static gboolean redo_wispr_ipv6(gpointer user_data)
 {
 	struct connman_service *service = user_data;
 
+	service->online_timeout_ipv6 = 0;
+
 	redo_wispr(service, CONNMAN_IPCONFIG_TYPE_IPV6);
 
 	return FALSE;
@@ -6365,6 +6372,10 @@ void __connman_service_online_check(struct connman_service *service,
 	GSourceFunc redo_func;
 	unsigned int *interval;
 	enum connman_service_state current_state;
+	int timeout;
+
+	DBG("service %p type %s success %d\n",
+		service, __connman_ipconfig_type2string(type), success);
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		interval = &service->online_check_interval_ipv4;
@@ -6393,8 +6404,12 @@ void __connman_service_online_check(struct connman_service *service,
 	DBG("service %p type %s interval %d", service,
 		__connman_ipconfig_type2string(type), *interval);
 
-	service->online_timeout = g_timeout_add_seconds(*interval * *interval,
+	timeout = g_timeout_add_seconds(*interval * *interval,
 				redo_func, connman_service_ref(service));
+	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
+		service->online_timeout_ipv4 = timeout;
+	else
+		service->online_timeout_ipv6 = timeout;
 
 	/* Increment the interval for the next time, set a maximum timeout of
 	 * online_check_max_interval seconds * online_check_max_interval seconds.
-- 
2.37.2

