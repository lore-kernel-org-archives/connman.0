Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E5199A6
	for <connman@lists.linux.dev>; Sat, 30 Sep 2023 22:27:09 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1dd830ed844so3589426fac.2
        for <connman@lists.linux.dev>; Sat, 30 Sep 2023 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696112828; x=1696717628; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTms4ipQu4OBwplGXrpKuvTN67M9L+jRX9wORqr9tp4=;
        b=UADOVY8088jVKpUrC2u78Q/u+8jomYQPwkfXhOtAVGHYv/bFW4TP9sakAEjh5Ru2ck
         JJ0nBs1scJ6dxHXktlW/3MxYc5UlAOyy40tgSNhM+peb+W0E4A431ybxi6ay1um3O2Gm
         SWmB8xM4Dp9S/iMO3lrQs28NoW3kllB7/5RTQ6eTMbB2XxEnX3kTfkhnOe3CowpADUzw
         s0E7oR3L/+xqZVgmjVbCuOPNmQY51ti0SYvlZPc3xsy7tUrIJFv01/pb3g3fFQlj/rB0
         lKWMNcMzT4iLA6dV/S80fm5jaD8K6e0i4fcXEqss1QHpDj6RsYrtVFMgFAxSoXuodJYT
         UGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696112828; x=1696717628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTms4ipQu4OBwplGXrpKuvTN67M9L+jRX9wORqr9tp4=;
        b=R5o1YmFUmQPEUC12InX/lWis4B5hv0Ok8WnIm20/q1vkjSuSpNO3aF/6mFN1Dn9tBP
         PTgUrjkVPhVA7WZA9EWqr5Vw8vZw9Hr9+48quatpooSmeLQYdUUCARn5bYlg6lS+BMID
         TxsQxA4InXQ3TPFL3ToEDHosBitxyrJNPrp2SzNNRsJuWjUauArPhMwKQHf2y40vUgpB
         L95TMcIkdtt1b+tgxkPKqZJFrrK9z/HovcZ6+poBvgHcwLAZ5IaVUjlZ9yJij8IPMboL
         TnOcQmatK5oGLCgwo15S009/qGufdQXK7Z4vWwFWmFF7qKtB75wyyvO7KM+rWM8ZnM/c
         keog==
X-Gm-Message-State: AOJu0YyQxL1WZStjpm2ff3piPSbgR1+cYCsnGkDhXbQ3oDc+IDZ621e3
	IvhjEZp2wFducU2oHDRHwYus/pgXnMY=
X-Google-Smtp-Source: AGHT+IG4U8GCT7pNF9BHKXr+o0c1Ge5unpsemc4Uu5QaTh1wqns6HrwsgBl68hu8VxHa1tqzeH/W6w==
X-Received: by 2002:a05:6870:ec86:b0:1b7:3fd5:87cd with SMTP id eo6-20020a056870ec8600b001b73fd587cdmr9804663oab.48.1696112828454;
        Sat, 30 Sep 2023 15:27:08 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm2328360oal.1.2023.09.30.15.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 15:27:08 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/6] vpn: Remove vpn_rtnl_register & vpn_rtnl_unregister
Date: Sat, 30 Sep 2023 17:25:57 -0500
Message-ID: <20230930222615.654178-6-denkenz@gmail.com>
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

These functions were never used.  In fact, in some functions, the paths
that used struct vpn_rtnl callbacks were never actually reachable (see
process_newroute and process_delroute).  Remove these functions.  Also,
as a result, struct vpn_rtnl is now never actually used.  Remove it as
well and any code that uses it.
---
 vpn/vpn-rtnl.c | 88 --------------------------------------------------
 vpn/vpn-rtnl.h | 18 -----------
 2 files changed, 106 deletions(-)

diff --git a/vpn/vpn-rtnl.c b/vpn/vpn-rtnl.c
index 98682722..a6b07858 100644
--- a/vpn/vpn-rtnl.c
+++ b/vpn/vpn-rtnl.c
@@ -145,61 +145,6 @@ void vpn_rtnl_remove_watch(unsigned int id)
 	}
 }
 
-static void trigger_rtnl(int index, void *user_data)
-{
-	struct vpn_rtnl *rtnl = user_data;
-
-	if (rtnl->newlink) {
-		unsigned short type = __vpn_ipconfig_get_type_from_index(index);
-		unsigned int flags = __vpn_ipconfig_get_flags_from_index(index);
-
-		rtnl->newlink(type, index, flags, 0);
-	}
-}
-
-static GSList *rtnl_list = NULL;
-
-static gint compare_priority(gconstpointer a, gconstpointer b)
-{
-	const struct vpn_rtnl *rtnl1 = a;
-	const struct vpn_rtnl *rtnl2 = b;
-
-	return rtnl2->priority - rtnl1->priority;
-}
-
-/**
- * vpn_rtnl_register:
- * @rtnl: RTNL module
- *
- * Register a new RTNL module
- *
- * Returns: %0 on success
- */
-int vpn_rtnl_register(struct vpn_rtnl *rtnl)
-{
-	DBG("rtnl %p name %s", rtnl, rtnl->name);
-
-	rtnl_list = g_slist_insert_sorted(rtnl_list, rtnl,
-							compare_priority);
-
-	vpn_ipconfig_foreach(trigger_rtnl, rtnl);
-
-	return 0;
-}
-
-/**
- * vpn_rtnl_unregister:
- * @rtnl: RTNL module
- *
- * Remove a previously registered RTNL module
- */
-void vpn_rtnl_unregister(struct vpn_rtnl *rtnl)
-{
-	DBG("rtnl %p name %s", rtnl, rtnl->name);
-
-	rtnl_list = g_slist_remove(rtnl_list, rtnl);
-}
-
 static const char *operstate2str(unsigned char operstate)
 {
 	switch (operstate) {
@@ -320,13 +265,6 @@ static void process_newlink(unsigned short type, int index, unsigned flags,
 					GINT_TO_POINTER(index), interface);
 	}
 
-	for (list = rtnl_list; list; list = list->next) {
-		struct vpn_rtnl *rtnl = list->data;
-
-		if (rtnl->newlink)
-			rtnl->newlink(type, index, flags, change);
-	}
-
 	for (list = watch_list; list; list = list->next) {
 		struct watch_data *watch = list->data;
 
@@ -344,7 +282,6 @@ static void process_dellink(unsigned short type, int index, unsigned flags,
 	struct rtnl_link_stats stats;
 	unsigned char operstate = 0xff;
 	const char *ifname = NULL;
-	GSList *list;
 
 	memset(&stats, 0, sizeof(stats));
 	extract_link(msg, bytes, NULL, &ifname, NULL, &operstate, &stats);
@@ -354,13 +291,6 @@ static void process_dellink(unsigned short type, int index, unsigned flags,
 						ifname, index, operstate,
 						operstate2str(operstate));
 
-	for (list = rtnl_list; list; list = list->next) {
-		struct vpn_rtnl *rtnl = list->data;
-
-		if (rtnl->dellink)
-			rtnl->dellink(type, index, flags, change);
-	}
-
 	switch (type) {
 	case ARPHRD_ETHER:
 	case ARPHRD_LOOPBACK:
@@ -426,7 +356,6 @@ static void extract_ipv6_route(struct rtmsg *msg, int bytes, int *index,
 static void process_newroute(unsigned char family, unsigned char scope,
 						struct rtmsg *msg, int bytes)
 {
-	GSList *list;
 	char dststr[INET6_ADDRSTRLEN], gatewaystr[INET6_ADDRSTRLEN];
 	int index = -1;
 
@@ -463,21 +392,12 @@ static void process_newroute(unsigned char family, unsigned char scope,
 
 		if (!IN6_IS_ADDR_UNSPECIFIED(&dst))
 			return;
-	} else
-		return;
-
-	for (list = rtnl_list; list; list = list->next) {
-		struct vpn_rtnl *rtnl = list->data;
-
-		if (rtnl->newgateway)
-			rtnl->newgateway(index, gatewaystr);
 	}
 }
 
 static void process_delroute(unsigned char family, unsigned char scope,
 						struct rtmsg *msg, int bytes)
 {
-	GSList *list;
 	char dststr[INET6_ADDRSTRLEN], gatewaystr[INET6_ADDRSTRLEN];
 	int index = -1;
 
@@ -514,14 +434,6 @@ static void process_delroute(unsigned char family, unsigned char scope,
 
 		if (!IN6_IS_ADDR_UNSPECIFIED(&dst))
 			return;
-	} else
-		return;
-
-	for (list = rtnl_list; list; list = list->next) {
-		struct vpn_rtnl *rtnl = list->data;
-
-		if (rtnl->delgateway)
-			rtnl->delgateway(index, gatewaystr);
 	}
 }
 
diff --git a/vpn/vpn-rtnl.h b/vpn/vpn-rtnl.h
index aa640a66..514fe02f 100644
--- a/vpn/vpn-rtnl.h
+++ b/vpn/vpn-rtnl.h
@@ -40,24 +40,6 @@ unsigned int vpn_rtnl_add_newlink_watch(int index,
 
 void vpn_rtnl_remove_watch(unsigned int id);
 
-#define VPN_RTNL_PRIORITY_LOW      -100
-#define VPN_RTNL_PRIORITY_DEFAULT     0
-#define VPN_RTNL_PRIORITY_HIGH      100
-
-struct vpn_rtnl {
-	const char *name;
-	int priority;
-	void (*newlink) (unsigned short type, int index,
-					unsigned flags, unsigned change);
-	void (*dellink) (unsigned short type, int index,
-					unsigned flags, unsigned change);
-	void (*newgateway) (int index, const char *gateway);
-	void (*delgateway) (int index, const char *gateway);
-};
-
-int vpn_rtnl_register(struct vpn_rtnl *rtnl);
-void vpn_rtnl_unregister(struct vpn_rtnl *rtnl);
-
 #ifdef __cplusplus
 }
 #endif
-- 
2.42.0

