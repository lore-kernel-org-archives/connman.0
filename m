Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9F199A6
	for <connman@lists.linux.dev>; Sat, 30 Sep 2023 22:27:08 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1bbb4bde76dso7991374fac.2
        for <connman@lists.linux.dev>; Sat, 30 Sep 2023 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696112827; x=1696717627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws1Pvs21BWfg/OBG1VDnYfSTL7xuovgAH45BSn838bg=;
        b=RP9Kbrs04SBnHGf6zJom3Dq3ZXcSqQlUVQSyc+z1Oa4seHtfM22J3tCD72T3c8AJ7i
         lChURyZhkM6f7D2TFVjZdHjsNcFB2J+cCxPKexR984ORRbJG8hEZ+ZdemeyHu/ejRLzt
         61Ax3dbxb6sSip/g3bGklZri5W/YQphp9d87jlGAtmuiYPiN+Njy4BBpI65d4zA03NRZ
         ssFJgMQeh8lbmthOHagIHPf3/dpGJHcEornHvqL5yclml9tJbNOlODY/T2K6aIDdo16M
         72GkQ3hi+cX0u0wsvO2AXWsnTkvPVCYzw6zrq5C3WOZKnG8aXFxGza1eDLz8yWKF3vuw
         9XRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696112827; x=1696717627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ws1Pvs21BWfg/OBG1VDnYfSTL7xuovgAH45BSn838bg=;
        b=Zeg8KNTYehOwIqz9n6RdOoHMbVNMszbt3IdwFm5eQJB3HcWn8WVsgZecpokt+k7cCp
         5eaK9l+Hdt8ASWIbDO+SwyCfCL5VIJ4FfgwvxwZu9YmUMiPQYwWrkWwfb0/OcIQ+1B99
         j37Jgh1U6hyiEtX9MZ0nfacezJKbWvti7Td7IPCV/nPuQiyHUdRn6gCJlFoLTccVpUT1
         zti9Aesebpndz2dyfYprlpnQAC3bxjeGX96RhEiywSO/+XY5AwvhOr7hGUXCkXzSbNCA
         XIkNWdCpc4CfJUmeDj7aHjdMEs9UTXxre+FP1HIuYli9DIcOzeV3SxBMv5xufbj89E7j
         CMXw==
X-Gm-Message-State: AOJu0YzIUT65fkaPZjrH/PtY7AKuLa0bFLMRXpy+ekQalXtSX5fHxB9H
	QN9opYVYT5rY8bp8juHq2fsDP+R+YBM=
X-Google-Smtp-Source: AGHT+IFFeOAGGBDFitTQfPUyFYYvSBpCY+lCpXvULlFZg5RoV9fKjhrAho7OHMOhfpyJzcGAQvb6cg==
X-Received: by 2002:a05:6871:146:b0:1d4:d016:7cee with SMTP id z6-20020a056871014600b001d4d0167ceemr8721832oab.31.1696112827481;
        Sat, 30 Sep 2023 15:27:07 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm2328360oal.1.2023.09.30.15.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 15:27:07 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/6] vpn: Remove unused functions
Date: Sat, 30 Sep 2023 17:25:56 -0500
Message-ID: <20230930222615.654178-5-denkenz@gmail.com>
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

__vpn_rtnl_update_interval_remove, __vpn_rtnl_update_interval_add and
vpn_rtnl_request_update were never used.  Remove them.
---
 vpn/vpn-rtnl.c | 74 --------------------------------------------------
 vpn/vpn.h      |  3 --
 2 files changed, 77 deletions(-)

diff --git a/vpn/vpn-rtnl.c b/vpn/vpn-rtnl.c
index 5a02d779..98682722 100644
--- a/vpn/vpn-rtnl.c
+++ b/vpn/vpn-rtnl.c
@@ -64,8 +64,6 @@ static GSList *watch_list = NULL;
 static unsigned int watch_id = 0;
 
 static GSList *update_list = NULL;
-static guint update_interval = G_MAXUINT;
-static guint update_timeout = 0;
 
 struct interface_data {
 	int index;
@@ -1017,78 +1015,6 @@ static int send_getroute(void)
 	return queue_request(hdr);
 }
 
-static gboolean update_timeout_cb(gpointer user_data)
-{
-	__vpn_rtnl_request_update();
-
-	return TRUE;
-}
-
-static void update_interval_callback(guint min)
-{
-	if (update_timeout > 0)
-		g_source_remove(update_timeout);
-
-	if (min < G_MAXUINT) {
-		update_interval = min;
-		update_timeout = g_timeout_add_seconds(update_interval,
-						update_timeout_cb, NULL);
-	} else {
-		update_timeout = 0;
-		update_interval = G_MAXUINT;
-	}
-}
-
-static gint compare_interval(gconstpointer a, gconstpointer b)
-{
-	guint val_a = GPOINTER_TO_UINT(a);
-	guint val_b = GPOINTER_TO_UINT(b);
-
-	return val_a - val_b;
-}
-
-unsigned int __vpn_rtnl_update_interval_add(unsigned int interval)
-{
-	guint min;
-
-	if (interval == 0)
-		return 0;
-
-	update_list = g_slist_insert_sorted(update_list,
-			GUINT_TO_POINTER(interval), compare_interval);
-
-	min = GPOINTER_TO_UINT(g_slist_nth_data(update_list, 0));
-	if (min < update_interval) {
-		update_interval_callback(min);
-		__vpn_rtnl_request_update();
-	}
-
-	return update_interval;
-}
-
-unsigned int __vpn_rtnl_update_interval_remove(unsigned int interval)
-{
-	guint min = G_MAXUINT;
-
-	if (interval == 0)
-		return 0;
-
-	update_list = g_slist_remove(update_list, GINT_TO_POINTER(interval));
-
-	if (update_list)
-		min = GPOINTER_TO_UINT(g_slist_nth_data(update_list, 0));
-
-	if (min > update_interval)
-		update_interval_callback(min);
-
-	return min;
-}
-
-int __vpn_rtnl_request_update(void)
-{
-	return send_getlink();
-}
-
 int __vpn_rtnl_init(void)
 {
 	struct sockaddr_nl addr;
diff --git a/vpn/vpn.h b/vpn/vpn.h
index dafb40c3..1f8c8fcd 100644
--- a/vpn/vpn.h
+++ b/vpn/vpn.h
@@ -103,9 +103,6 @@ int __vpn_rtnl_init(void);
 void __vpn_rtnl_start(void);
 void __vpn_rtnl_cleanup(void);
 
-unsigned int __vpn_rtnl_update_interval_add(unsigned int interval);
-unsigned int __vpn_rtnl_update_interval_remove(unsigned int interval);
-int __vpn_rtnl_request_update(void);
 int __vpn_rtnl_send(const void *buf, size_t len);
 
 int __vpn_config_init(void);
-- 
2.42.0

