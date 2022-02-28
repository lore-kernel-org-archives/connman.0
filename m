Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B6559B
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 12:49:41 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id p15so24528726ejc.7
        for <connman@lists.linux.dev>; Mon, 28 Feb 2022 04:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6vukLHIEWumeNdbY7mo1YMydGNuuFC6nRgOwTbf2e8=;
        b=maX30mUCv9/qvIlopmQQ+85IowvkaWiVPY7ZOCtFrC2rP9vCBCAr/DA4hyo4yhemBy
         oRIp+ubE9mL0KUpEMQwz5rjuFi0Dpwgo9GswDv5I0dsPddTJclDauco3mSd3LUWP7SkE
         aHslpG9ah1h94IrZsb4X12qrVhlCGDV/coy9F4bNHUTK+aZUsSalynamEC/8BN7FpEYv
         e4AO/Mb+drYRgVQ/5NxX7m+ARTAc9QtQss4qltpQL8NZg74NbAr/SVLbHZcgjmXexQV6
         qZDo3Ul6MCc0nqHvfSEdNVIExfkyAFt1ZdeN83KyADOFKXQYIXGwshyUmA20DvxDHqJe
         pqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6vukLHIEWumeNdbY7mo1YMydGNuuFC6nRgOwTbf2e8=;
        b=zuuPtkINdJuDF8SDax+bPJPkYB7GOBA2H1xP2bWswmUAyi9G6rzC8b7ei3BwlPERj3
         M9jICwyRkigjcUmN2k/RjIA/qbHBNs22FTaNjH7b0ioeHeL3U3fINSjYNsm8TBIvd8hx
         5KOpuSAZlrvhDWgWtoknt0NG0NK9T/DKsXc0lERbtH3YcxzFYZPGXHALsaO85Xdrn3NB
         4TIQeo10GDpuPKmzvVtRgudZons3/HFBFGWoRRbfFq2aV7d4H8XYvfyXBLF+5Da8qMDt
         3RDD344vZPubsGt/Izk5MyfZZ93Hm3gVAFvvp5jIWD+Cke5ai5O3x8Z4c+c2ea+w3hcE
         mHAw==
X-Gm-Message-State: AOAM5327OQWwxpg85OP6yk5JWfm2iikLmAMJpPEA7poOCOdVKXytSj4w
	W3qxfmogZaZVyDB9R5r36DRYJykWCt1abg==
X-Google-Smtp-Source: ABdhPJxpgtf96a/tVAB5YaTcIP7IFX/ibkTI4gVjT07W9+BSDmLsVR6Dfh60rR1dmwVkFG9koPGyMA==
X-Received: by 2002:a17:906:2bc1:b0:6cf:d009:7f6b with SMTP id n1-20020a1709062bc100b006cfd0097f6bmr14947330ejg.17.1646052579996;
        Mon, 28 Feb 2022 04:49:39 -0800 (PST)
Received: from localhost.localdomain (ptr-gppolqqj1pmj1s3xvfl.18120a2.ip6.access.telenet.be. [2a02:1812:2d0c:4800:5a95:daff:d376:c061])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7cfcb000000b00412c58c43ccsm5981484edy.37.2022.02.28.04.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:49:39 -0800 (PST)
From: Nicky Geerts <nicky.geerts@gmail.com>
To: connman@lists.linux.dev
Cc: Nicky Geerts <nicky.geerts@gmail.com>
Subject: [PATCH 1/2] timeserver: refresh the nameservers before each lookup
Date: Mon, 28 Feb 2022 13:49:29 +0100
Message-Id: <20220228124930.4010311-2-nicky.geerts@gmail.com>
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

There is a possibility where the UDP channel connections in the resolv
instance are being closed because of how the external DNS service might
respond, and are never opened again.  The DNS resolve will keep failing,
and there is no automatic recovery from this.

Similar to the behavior of the WISPR module, refresh the nameservers in
the resolv instance before each DNS request.

---
 src/timeserver.c | 93 ++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/src/timeserver.c b/src/timeserver.c
index feef8e83..968739c3 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -47,6 +47,7 @@ static GResolv *resolv = NULL;
 static int resolv_id = 0;
 
 static void sync_next(void);
+static void ts_set_nameservers(struct connman_service *service);
 
 static void resolv_debug(const char *str, void *data)
 {
@@ -183,6 +184,7 @@ static void sync_next(void)
 	}
 
 	__connman_ntp_stop();
+    ts_set_nameservers(ts_service);
 
 	while (ts_list) {
 		ts_current = ts_list->data;
@@ -347,24 +349,35 @@ static void ts_recheck_enable(void)
 			NULL);
 }
 
-static void ts_reset(struct connman_service *service)
+static int ts_setup_resolv(struct connman_service *service)
 {
-	char **nameservers;
-	int i;
+    int i;
 
-	if (!resolv)
-		return;
+   	i = __connman_service_get_index(service);
+	if (i < 0)
+		return -EINVAL;
+ 
+   	if (resolv) {
+		g_resolv_unref(resolv);
+		resolv = NULL;
+	}
 
-	__connman_timeserver_set_synced(false);
+	resolv = g_resolv_new(i);
+	if (!resolv) {
+		return -ENOMEM;
+	}
 
-	/*
-	 * Before we start creating the new timeserver list we must stop
-	 * any ongoing ntp query and server resolution.
-	 */
+   	if (getenv("CONNMAN_RESOLV_DEBUG"))
+		g_resolv_set_debug(resolv, resolv_debug, "RESOLV");
 
-	__connman_ntp_stop();
+    return 0;
+}
 
-	ts_recheck_disable();
+
+static void ts_set_nameservers(struct connman_service *service)
+{
+	char **nameservers;
+    int i;
 
 	if (resolv_id > 0)
 		g_resolv_cancel_lookup(resolv, resolv_id);
@@ -378,6 +391,27 @@ static void ts_reset(struct connman_service *service)
 
 		g_strfreev(nameservers);
 	}
+}
+
+static void ts_reset(struct connman_service *service)
+{
+	int i;
+
+	if (!resolv)
+		return;
+
+	__connman_timeserver_set_synced(false);
+
+	/*
+	 * Before we start creating the new timeserver list we must stop
+	 * any ongoing ntp query and server resolution.
+	 */
+
+	__connman_ntp_stop();
+
+	ts_recheck_disable();
+
+    ts_set_nameservers(service);
 
 	g_slist_free_full(timeservers_list, g_free);
 
@@ -434,42 +468,17 @@ void __connman_timeserver_set_synced(bool status)
 
 static int timeserver_start(struct connman_service *service)
 {
-	char **nameservers;
 	int i;
+    int rv;
 
 	DBG("service %p", service);
 
-	i = __connman_service_get_index(service);
-	if (i < 0)
-		return -EINVAL;
-
-	nameservers = connman_service_get_nameservers(service);
-
-	/* Stop an already ongoing resolution, if there is one */
-	if (resolv && resolv_id > 0)
-		g_resolv_cancel_lookup(resolv, resolv_id);
-
 	/* get rid of the old resolver */
-	if (resolv) {
-		g_resolv_unref(resolv);
-		resolv = NULL;
-	}
-
-	resolv = g_resolv_new(i);
-	if (!resolv) {
-		g_strfreev(nameservers);
-		return -ENOMEM;
-	}
-
-	if (getenv("CONNMAN_RESOLV_DEBUG"))
-		g_resolv_set_debug(resolv, resolv_debug, "RESOLV");
+    rv = ts_setup_resolv(service);
+    if (rv)
+        return rv;
 
-	if (nameservers) {
-		for (i = 0; nameservers[i]; i++)
-			g_resolv_add_nameserver(resolv, nameservers[i], 53, 0);
-
-		g_strfreev(nameservers);
-	}
+    ts_set_nameservers(service);
 
 	__connman_timeserver_sync(service);
 
-- 
2.25.1

