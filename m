Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215B10EE
	for <connman@lists.linux.dev>; Mon,  7 Mar 2022 08:45:02 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id p15so30215260ejc.7
        for <connman@lists.linux.dev>; Mon, 07 Mar 2022 00:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwA11L+cTdVv3g4I5HGdfv38+akdd4sKW7aDveJr++g=;
        b=GOlIqKJ7o0R1aFv3Raf3bVF+BIuQrvPSSpcZHxcBoDpg7FCqfAWGTsyezK7mJdycCA
         L5od2/LpovTwijFGfULonZgZSWsiB6Vrcd4362J6iLqRlV+wbxCYEhdDm5PFxmgrD5tN
         f743UqRn9Xf0/r5iizj1E5kV4ua0EMfyXF02H0w0U8wf4830IzWc02clizN8i2hGtXJK
         12cpGZgKUNPSH13OiF1D/NfJ0hmu+Mmdho9/C3U9jaNNa7uWy3Rl8DzpOUj1ilvZvUX3
         tSXnJHugSbi5OzWL7YIHqMDFa+rSKJDk68f16QkfUoOvvkZT0w44A++bcn7oIH+LOArD
         YLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwA11L+cTdVv3g4I5HGdfv38+akdd4sKW7aDveJr++g=;
        b=nk6o2APV/YqDrDtsVx3sQAouN2ITUNkfeeLTKZd6TNj/GowDPPffNBeVO74frXapOl
         nZIpAM5QbDkwLRdHl8q1bE0dHIrb0dEzasePeG6dJuj88ABnUkBucHsc4kxyCGf3jUag
         ZkWtFMc7mDNrXcCHentZCyIcrmkiFLU5S59Tci6gkYxnJvUaTwBqZvlpTQ8qReY8ewrk
         ZychqQsjYiXW09QCGxV3Lq2t888XzmypPKoG2r8LSkKwR7G/Us4xTSRX3H77jdQYE8WL
         y0P7DLF3HZlz/POr3BKDYVTpiscU+ryBUf/39RBmVxfv9QAmBgpdc+dnSnQ4HIslKmt2
         8yeg==
X-Gm-Message-State: AOAM530p9QcEB3z9MQ5wMwSzU1IoEyE/TfIGTpHBZw8BS3AWjSNKMDoa
	sE75SUuS556M6py6tkaCZjJHkZWP8eCdCw==
X-Google-Smtp-Source: ABdhPJzn8eIr5paqr4YTD/BigJM7/bZ1FDPmF8hnFXArODSnDjBv1rl7PGuJcT14mOUjxrnhajRlAg==
X-Received: by 2002:a17:907:a414:b0:6da:654c:aa08 with SMTP id sg20-20020a170907a41400b006da654caa08mr8471387ejc.756.1646642700468;
        Mon, 07 Mar 2022 00:45:00 -0800 (PST)
Received: from localhost.localdomain (ptr-gppolqr6fd9o21yoj3q.18120a2.ip6.access.telenet.be. [2a02:1812:2d0c:4800:854a:5fbf:b3f4:9cb6])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b006d144662b24sm4464151ejd.152.2022.03.07.00.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:44:59 -0800 (PST)
From: Nicky Geerts <nicky.geerts@gmail.com>
To: connman@lists.linux.dev
Cc: Nicky Geerts <nicky.geerts@gmail.com>
Subject: [PATCH 1/2] timeserver: refresh the nameservers before each lookup
Date: Mon,  7 Mar 2022 09:44:31 +0100
Message-Id: <20220307084432.62446-2-nicky.geerts@gmail.com>
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
 src/timeserver.c | 91 ++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/src/timeserver.c b/src/timeserver.c
index feef8e83..0ea73d63 100644
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
+	ts_set_nameservers(ts_service);
 
 	while (ts_list) {
 		ts_current = ts_list->data;
@@ -347,24 +349,35 @@ static void ts_recheck_enable(void)
 			NULL);
 }
 
-static void ts_reset(struct connman_service *service)
+static int ts_setup_resolv(struct connman_service *service)
 {
-	char **nameservers;
 	int i;
 
-	if (!resolv)
-		return;
+	i = __connman_service_get_index(service);
+	if (i < 0)
+		return -EINVAL;
+ 
+	if (resolv) {
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
+	if (getenv("CONNMAN_RESOLV_DEBUG"))
+		g_resolv_set_debug(resolv, resolv_debug, "RESOLV");
 
-	__connman_ntp_stop();
+	return 0;
+}
 
-	ts_recheck_disable();
+
+static void ts_set_nameservers(struct connman_service *service)
+{
+	char **nameservers;
+	int i;
 
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
+	ts_set_nameservers(service);
 
 	g_slist_free_full(timeservers_list, g_free);
 
@@ -434,42 +468,17 @@ void __connman_timeserver_set_synced(bool status)
 
 static int timeserver_start(struct connman_service *service)
 {
-	char **nameservers;
 	int i;
+	int rv;
 
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
+	rv = ts_setup_resolv(service);
+	if (rv)
+		return rv;
 
-	if (getenv("CONNMAN_RESOLV_DEBUG"))
-		g_resolv_set_debug(resolv, resolv_debug, "RESOLV");
-
-	if (nameservers) {
-		for (i = 0; nameservers[i]; i++)
-			g_resolv_add_nameserver(resolv, nameservers[i], 53, 0);
-
-		g_strfreev(nameservers);
-	}
+	ts_set_nameservers(service);
 
 	__connman_timeserver_sync(service);
 
-- 
2.25.1

