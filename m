Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEF1199A9
	for <connman@lists.linux.dev>; Sat, 30 Sep 2023 22:27:07 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1dd830ed844so3589416fac.2
        for <connman@lists.linux.dev>; Sat, 30 Sep 2023 15:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696112826; x=1696717626; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rtUgNRmKraV/4yIoG7dulBNO+T178513by96GklGA0=;
        b=h72MttqoZJHd9r35CQS6PXDPjwkZYAFKPcrqfT1CdtPGjv2yMROUjr68EjK7/FE3WD
         hdsdhQZR/sueVZSvDHhdqPx2opS+QlkCbJo/q6+vT2Ohjb2ncV6UeCTI3NlhDaCzsegj
         TzMTHENTyBzxHVD04YJEnZlw3Lcpd5XjCzXEOUqzov83nfXyH07xgOSvL4yFCeepdzOG
         0E7tM0nZ52VFPx5VzNklqxZDl5OuzsuIR7UnKyuD203nLaIj+36BezSkmDKHPyVcnjH1
         /a9+0NNoytyDPIqpEonFErnvCG62y6uRgwHrnnnlix0jhV51iESxGbO8FJea1JpLAf1T
         m3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696112826; x=1696717626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rtUgNRmKraV/4yIoG7dulBNO+T178513by96GklGA0=;
        b=h5D66MUCZoYC49726ivpsTbB6rioWWFHE9Zel3aQoTQkoYkHxkClcA9tBLENZrXAQ4
         Eh/PAwowe9wtwqqsus/ZA2SvZZM4+bjmIzRb/0P+Bfs8iLC8+FroJuw+VZ7l2O9ilNAe
         pQHeDjEqpL7iU+ip3B9QKvAxdxP91ymo3o7kcN+auSi6mhg6X7QkydQjm6BrcYVpoasy
         0NcuVMI7e/tFWEc5hXb0WXCnZMj3jOTsgpkv9GDcQKKH/VdWhqIXqBgRdvNoQ4oiHkfL
         IvcRxLo7nUtP1Ick4/7WykhlTTXBvVrrokQOv/hZ5plUpSnLY9/W/cUo4JyT7T2qpZFP
         VIgg==
X-Gm-Message-State: AOJu0YwTjpn4edkTi7Qk0ikD7GmHIyyl7zGK+yDuCvy4C5UgpDQo7Nwc
	FXh2qA8u8Uezw6CVsSvN8D6spLRGwDg=
X-Google-Smtp-Source: AGHT+IFhtuvjOMhwERMHZhAgrj/GxkRqBHQ8ywx1OL3MtqBFOeWA7IB2eM02ssU1OzsjfqpOO5P2SA==
X-Received: by 2002:a05:6870:2306:b0:1bf:12ab:e16b with SMTP id w6-20020a056870230600b001bf12abe16bmr8878412oao.2.1696112826486;
        Sat, 30 Sep 2023 15:27:06 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm2328360oal.1.2023.09.30.15.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 15:27:06 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 4/6] service: Remove unused functions
Date: Sat, 30 Sep 2023 17:25:55 -0500
Message-ID: <20230930222615.654178-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230930222615.654178-1-denkenz@gmail.com>
References: <20230930222615.654178-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__connman_service_is_provider_pending and
__connman_service_set_provider_pending were never used.  Get rid of
them.  Also remove provider_pending member which is no longer set
anywhere and is thus unused.
---
 src/connman.h |  3 ---
 src/service.c | 36 +-----------------------------------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index f7da5e5b..f87d13e3 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -755,9 +755,6 @@ int __connman_service_disconnect(struct connman_service *service);
 void __connman_service_set_active_session(bool enable, GSList *list);
 void __connman_service_auto_connect(enum connman_service_connect_reason reason);
 bool __connman_service_remove(struct connman_service *service);
-bool __connman_service_is_provider_pending(struct connman_service *service);
-void __connman_service_set_provider_pending(struct connman_service *service,
-							DBusMessage *msg);
 void __connman_service_set_hidden_data(struct connman_service *service,
 				gpointer user_data);
 void __connman_service_return_error(struct connman_service *service,
diff --git a/src/service.c b/src/service.c
index 9b8f4427..bc2afb5d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -125,7 +125,6 @@ struct connman_service {
 	char *private_key_passphrase;
 	char *phase2;
 	DBusMessage *pending;
-	DBusMessage *provider_pending;
 	guint timeout;
 	struct connman_stats stats;
 	struct connman_stats stats_roaming;
@@ -3893,12 +3892,6 @@ static void reply_pending(struct connman_service *service, int error)
 		connman_dbus_reply_pending(service->pending, error, NULL);
 		service->pending = NULL;
 	}
-
-	if (service->provider_pending) {
-		connman_dbus_reply_pending(service->provider_pending,
-				error, service->path);
-		service->provider_pending = NULL;
-	}
 }
 
 static void service_complete(struct connman_service *service)
@@ -4372,30 +4365,6 @@ static void vpn_auto_connect(void)
 		g_idle_add(run_vpn_auto_connect, NULL);
 }
 
-bool
-__connman_service_is_provider_pending(struct connman_service *service)
-{
-	if (!service)
-		return false;
-
-	if (service->provider_pending)
-		return true;
-
-	return false;
-}
-
-void __connman_service_set_provider_pending(struct connman_service *service,
-							DBusMessage *msg)
-{
-	if (service->provider_pending) {
-		DBG("service %p provider pending msg %p already exists",
-			service, service->provider_pending);
-		return;
-	}
-
-	service->provider_pending = msg;
-}
-
 static void check_pending_msg(struct connman_service *service)
 {
 	if (!service->pending)
@@ -6134,7 +6103,7 @@ int __connman_service_indicate_error(struct connman_service *service,
 
 int __connman_service_clear_error(struct connman_service *service)
 {
-	DBusMessage *pending, *provider_pending;
+	DBusMessage *pending;
 
 	DBG("service %p", service);
 
@@ -6146,8 +6115,6 @@ int __connman_service_clear_error(struct connman_service *service)
 
 	pending = service->pending;
 	service->pending = NULL;
-	provider_pending = service->provider_pending;
-	service->provider_pending = NULL;
 
 	__connman_service_ipconfig_indicate_state(service,
 						CONNMAN_SERVICE_STATE_IDLE,
@@ -6158,7 +6125,6 @@ int __connman_service_clear_error(struct connman_service *service)
 						CONNMAN_IPCONFIG_TYPE_IPV4);
 
 	service->pending = pending;
-	service->provider_pending = provider_pending;
 
 	return 0;
 }
-- 
2.42.0

