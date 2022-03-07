Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3B38E2
	for <connman@lists.linux.dev>; Mon,  7 Mar 2022 08:45:03 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id hw13so30108340ejc.9
        for <connman@lists.linux.dev>; Mon, 07 Mar 2022 00:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLP2GfPANnCyHjB7eCNeau2Zs/Ca0qWYg/lRyLP+acA=;
        b=Rxwi5VkxYSl5qjIBYXp+Ov1KVT7hplhuhTeKKfp4fuUcJAPIlZLDUQFlt/JLpdYKPT
         YTsKRYZYe2Qq38Hjstcpy7SU9CcylGrQdsLPv1sQXmCIODUSkQ8l+HE4MY0d98nqaf1+
         /FnPSm0weNBzcceQWHg1q8JHuIIKmQMXsw/dKKpxzcAlZKoFbLzDv0PG+UUNep79mlK1
         /xIzl5RKiojEXE/x/fmPrgiSCl6iip+apjN8+TMpliGJgWPZbvFH1Hgw50Lr3y0ziWFh
         d0Vd6PYSd/MbcIgu3W6QpJ+A6zBo7m/o/Mt9vXgPfz48i/BWfOVwLaDoICMUYyrvpty9
         PxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLP2GfPANnCyHjB7eCNeau2Zs/Ca0qWYg/lRyLP+acA=;
        b=U2QZhwjy4EgHTSF/m4uqpP2C8/qWaIAK1bVpmYM4MlvIWOlvbUMUj5C/55Rm5I9x5b
         KZtg4E0W09Y7O7WVxGK95ryKDo6rmksIrQt5EdeBukIeR4ktm+oqKm6zUepbCsaj8MnY
         FD9YDBtl5p+PP0vbLcp+tVKaKX5IPV5jQaS7gPpSb6jILGoMbqBfJ6N9lp7t/ScUGrpD
         +/hevJnU/AoceeUlSMnwbtNopyaEhGbREr8uilh+tqsfmVxJQV9DvrwgOyP0F5W75fGA
         nHnCpf09qT8SujRCk2lo3z0siOvZY+uwBfOzTgQ/C/PxcrsV+v7ExGnrVz3kUEcinaFO
         M+GA==
X-Gm-Message-State: AOAM533+9pMu0MnmVXMHCMEedThMSHRJ3XEO1oUXAVqwkpKcYZ41J/+4
	QNevwtMQyTqRckVro3+YxwL2MLqgcKOkWg==
X-Google-Smtp-Source: ABdhPJwVkGRe6syzGqq0rT0nCsXOhHfUDB6xbIpfTbhG6TB2B+4VSK/Fh+oA1/A3tjL3UXslSh3xZA==
X-Received: by 2002:a17:906:7706:b0:6d6:e521:5471 with SMTP id q6-20020a170906770600b006d6e5215471mr8236022ejm.387.1646642701635;
        Mon, 07 Mar 2022 00:45:01 -0800 (PST)
Received: from localhost.localdomain (ptr-gppolqr6fd9o21yoj3q.18120a2.ip6.access.telenet.be. [2a02:1812:2d0c:4800:854a:5fbf:b3f4:9cb6])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b006d144662b24sm4464151ejd.152.2022.03.07.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:45:01 -0800 (PST)
From: Nicky Geerts <nicky.geerts@gmail.com>
To: connman@lists.linux.dev
Cc: Nicky Geerts <nicky.geerts@gmail.com>
Subject: [PATCH 2/2] timeserver: include the reason why a timeserver sync is requested
Date: Mon,  7 Mar 2022 09:44:32 +0100
Message-Id: <20220307084432.62446-3-nicky.geerts@gmail.com>
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
 src/timeserver.c     | 23 +++++++++++++++++++----
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/timeserver.h b/include/timeserver.h
index 48ea1945..2e209f1c 100644
--- a/include/timeserver.h
+++ b/include/timeserver.h
@@ -26,6 +26,13 @@
 extern "C" {
 #endif
 
+enum connman_timeserver_sync_reason {
+	CONNMAN_TIMESERVER_SYNC_REASON_START = 0,
+	CONNMAN_TIMESERVER_SYNC_REASON_ADDRESS_UPDATE = 1,
+	CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE = 2,
+	CONNMAN_TIMESERVER_SYNC_REASON_TS_CHANGE = 3,
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
index 0ea73d63..4efd84d0 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -309,7 +309,7 @@ static gboolean ts_recheck(gpointer user_data)
 		g_slist_free_full(ts, g_free);
 
 		service = connman_service_get_default();
-		__connman_timeserver_sync(service);
+		__connman_timeserver_sync(service, CONNMAN_TIMESERVER_SYNC_REASON_TS_CHANGE);
 
 		return FALSE;
 	}
@@ -430,11 +430,26 @@ static void ts_reset(struct connman_service *service)
 	timeserver_sync_start();
 }
 
-void __connman_timeserver_sync(struct connman_service *service)
+void __connman_timeserver_sync(struct connman_service *service, enum connman_timeserver_sync_reason reason)
 {
-	if (!service || ts_service == service)
+	if (!service)
 		return;
 
+	switch (reason) {
+	case CONNMAN_TIMESERVER_SYNC_REASON_START:
+	case CONNMAN_TIMESERVER_SYNC_REASON_STATE_UPDATE:
+		if (ts_service == service)
+			return;
+		break;
+	case CONNMAN_TIMESERVER_SYNC_REASON_ADDRESS_UPDATE:
+	case CONNMAN_TIMESERVER_SYNC_REASON_TS_CHANGE:
+		if (ts_service != service)
+			return;
+		break;
+	default:
+		return;
+	}
+
 	ts_reset(service);
 }
 
@@ -480,7 +495,7 @@ static int timeserver_start(struct connman_service *service)
 
 	ts_set_nameservers(service);
 
-	__connman_timeserver_sync(service);
+	__connman_timeserver_sync(service, CONNMAN_TIMESERVER_SYNC_REASON_START);
 
 	return 0;
 }
-- 
2.25.1

