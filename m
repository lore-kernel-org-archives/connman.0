Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA39559B
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 12:49:43 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id i11so17399939eda.9
        for <connman@lists.linux.dev>; Mon, 28 Feb 2022 04:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8j+9vHgMiqe1Urr/afKFvGOnRAhI/ENqrbNSIV6SuKQ=;
        b=Z1ohtcDebijyr/Qw/G6xjwxgQ/MPcElxnYNPryVls9uZN/H6ZSFjUOHdtSkCfL035S
         wxhpSGbzZ3ssDfbP28j4cXC0TkU+/cKTKrcFzIe0qcOzD8AXz71YNdkiUYSaeil9pbTk
         RE7qXHqF0wv/mLZYV2GKlAqO2h4bi0HeXT1rAe+hkf+6PNoWFht41YnL4tTs0bcpP9yE
         7CoSnkbXB6rtR4DfG3/hqlhDvd5UUBE0vC17kuVgxwU3Cvq4urZL+C7Nb98L8JWSb3oo
         B0uJMdPqlukeVuPPLUSbPIvGU584x2xXfb6+HA+OYF/qUtetdXshX3qteGFZH0VmAW6a
         WTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8j+9vHgMiqe1Urr/afKFvGOnRAhI/ENqrbNSIV6SuKQ=;
        b=QUnqTEMF7IzhhJeilDH0AQ1LDYnUVZiGdZ2LYMwmiL0RVT0x0fCVI0lfceqs1/WCH9
         dhjHkzF47/lHd4dQRTxe1XhzvxQRRMuNqdX26P/YbLipiYI3stYkT79sGJqKtLN4t8M+
         OztTDa4Z7HmpCjp0l+HsUnq5Rdn5VmYIheQBctkZuZQ+y3QQM7fw9CWZArYVTyr2vcWC
         eINc9/BrHyAcU6y6G+0FcAewJ0hk1PzQc5Tt/A4qer5+EuqdkvTB9+lVeYi6a2FNTtdD
         zEPYVMPbvPvB1BhPf7t+5FTHqVDqgsWyp7q4bjP0o+B4onJcf8+eKB5UFAH6Zi+YUj+H
         XDLA==
X-Gm-Message-State: AOAM530woSOO2jb6c2iMQBqLQDvGQeLqK29mPAkAQMA6y90msM5nGaPi
	znaEuTnza4k8oSkdHHqXNTmL4JhMRSLS5A==
X-Google-Smtp-Source: ABdhPJynS1jIv87fAoFt30vtCt4SJ5yMzG3DSDe/ZGafdTyT/XTOOC6mLsrg7nuk+f95vViEL4mEMw==
X-Received: by 2002:a05:6402:845:b0:412:ad14:863e with SMTP id b5-20020a056402084500b00412ad14863emr19459864edz.380.1646052581574;
        Mon, 28 Feb 2022 04:49:41 -0800 (PST)
Received: from localhost.localdomain (ptr-gppolqqj1pmj1s3xvfl.18120a2.ip6.access.telenet.be. [2a02:1812:2d0c:4800:5a95:daff:d376:c061])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7cfcb000000b00412c58c43ccsm5981484edy.37.2022.02.28.04.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:49:40 -0800 (PST)
From: Nicky Geerts <nicky.geerts@gmail.com>
To: connman@lists.linux.dev
Cc: Nicky Geerts <nicky.geerts@gmail.com>
Subject: [PATCH 2/2] timeserver: include the reason why a timeserver sync is requested
Date: Mon, 28 Feb 2022 13:49:30 +0100
Message-Id: <20220228124930.4010311-3-nicky.geerts@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228124930.4010311-1-nicky.geerts@gmail.com>
References: <20220228124930.4010311-1-nicky.geerts@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Except for the initial connman_timeserver_start call, and potential
updated of the default service, all subsequent calls to resynchronise
the timeserver are blocked because of the check whether service equals
ts_service in __connman_timeserver_sync.

DHCP updates, which could replace the timeserver and nameservers, and state
change updates are ignored.

As previously suggested by Daniel Wagner on Nov 19th 2019 in a mail to
Vivien Henriet, it would be best to pass the reason of the sync call,
and add the logic in __connman_timeserver_sync.

---
 include/timeserver.h |  7 +++++++
 src/connman.h        |  2 +-
 src/service.c        |  4 ++--
 src/timeserver.c     | 25 ++++++++++++++++++++-----
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/timeserver.h b/include/timeserver.h
index 48ea1945..f1d6f1e8 100644
--- a/include/timeserver.h
+++ b/include/timeserver.h
@@ -26,6 +26,13 @@
 extern "C" {
 #endif
 
+enum connman_timeserver_sync_reason {
+    CONNMAN_TIMESERVER_SYNC_REASON_START = 0,
+    CONNMAN_TIMESERVER_SYNC_REASON_ADDRESS_UPDATE = 1,
+    CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE = 2,
+    CONNMAN_TIMESERVER_SYNC_REASON_TS_CHANGE = 3,
+};
+
 int __connman_timeserver_system_set(char **server);
 
 #ifdef __cplusplus
diff --git a/src/connman.h b/src/connman.h
index 33dbec69..0985cb11 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -451,7 +451,7 @@ char **__connman_timeserver_system_get();
 GSList *__connman_timeserver_add_list(GSList *server_list,
 		const char *timeserver);
 GSList *__connman_timeserver_get_all(struct connman_service *service);
-void __connman_timeserver_sync(struct connman_service *service);
+void __connman_timeserver_sync(struct connman_service *service, enum connman_timeserver_sync_reason reason);
 void __connman_timeserver_conf_update(struct connman_service *service);
 
 bool __connman_timeserver_is_synced(void);
diff --git a/src/service.c b/src/service.c
index f1abb963..52c4ee4c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1476,7 +1476,7 @@ static void address_updated(struct connman_service *service,
 		nameserver_add_all(service, type);
 		start_online_check(service, type);
 
-		__connman_timeserver_sync(service);
+		__connman_timeserver_sync(service, CONNMAN_TIMESERVER_SYNC_REASON_ADDRESS_UPDATE);
 	}
 }
 
@@ -6504,7 +6504,7 @@ int __connman_service_ipconfig_indicate_state(struct connman_service *service,
 	if (!is_connected(old_state) && is_connected(new_state))
 		nameserver_add_all(service, type);
 
-	__connman_timeserver_sync(service);
+	__connman_timeserver_sync(service, CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE);
 
 	return service_indicate_state(service);
 }
diff --git a/src/timeserver.c b/src/timeserver.c
index 968739c3..3bae9074 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -309,7 +309,7 @@ static gboolean ts_recheck(gpointer user_data)
 		g_slist_free_full(ts, g_free);
 
 		service = connman_service_get_default();
-		__connman_timeserver_sync(service);
+		__connman_timeserver_sync(service, CONNMAN_TIMESERVER_SYNC_REASON_TS_CHANGE);
 
 		return FALSE;
 	}
@@ -430,12 +430,27 @@ static void ts_reset(struct connman_service *service)
 	timeserver_sync_start();
 }
 
-void __connman_timeserver_sync(struct connman_service *service)
+void __connman_timeserver_sync(struct connman_service *service, enum connman_timeserver_sync_reason reason)
 {
-	if (!service || ts_service == service)
+	if (!service)
 		return;
 
-	ts_reset(service);
+    switch (reason) {
+    case CONNMAN_TIMESERVER_SYNC_REASON_START:
+    case CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE:
+        if (ts_service == service)
+            return;
+        break;
+    case CONNMAN_TIMESERVER_SYNC_REASON_ADDRESS_UPDATE:
+    case CONNMAN_TIMESERVER_SYNC_REASON_TS_CHANGE:
+        if (ts_service != service)
+            return;
+        break;
+    default:
+        return;
+    }
+
+    ts_reset(service);
 }
 
 void __connman_timeserver_conf_update(struct connman_service *service)
@@ -480,7 +495,7 @@ static int timeserver_start(struct connman_service *service)
 
     ts_set_nameservers(service);
 
-	__connman_timeserver_sync(service);
+	__connman_timeserver_sync(service, CONNMAN_TIMESERVER_SYNC_REASON_START);
 
 	return 0;
 }
-- 
2.25.1

