Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519F715C3
	for <connman@lists.linux.dev>; Fri, 29 Sep 2023 16:45:23 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-406609df1a6so5959205e9.3
        for <connman@lists.linux.dev>; Fri, 29 Sep 2023 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696005921; x=1696610721; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jgi7MESiuowEXQ3b5w1ePqnNar58fnFceJffwF6exjw=;
        b=XmF//n3u7OvU52MQDZhjEOWKqrC/fIo4sBm/bpoFmTMWMf7sDkfz/TTgheYEPa7Olf
         9Ax1gEe+PD4R/G0qSROazDq8Kso3Ad1i+irIHCsOtkofBVQ0286v0MMdSbcPJ4f+hfym
         bNvpsFwdMCpA2sRIAuvUecwYZM2gZeUG+KDy7goxTVsSTF0aKmwfGt4GBxz3ZkJVzAXg
         6ZnUAQMdHy/TrM6H1IJiE7C+U2dm5afYF6kV+kOOj5W3gcM7kLFR1K590Ce6xTxMnjG7
         gSR6d251UITTifac6gdBHvRYJNkehIbwY6n9ZnQI21KcNrNvOc2KdgEXLJCEWxcNh/bT
         +IfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696005921; x=1696610721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgi7MESiuowEXQ3b5w1ePqnNar58fnFceJffwF6exjw=;
        b=OE/vJly8i5ad+0CZUFWxYCC1ItmvyrRQnqcWMGb48kO4EnKB9u02P/Ua0YyLO88wV2
         DqmIYBrkOJOUMu+P4rZEqBxJ6NXgxnjU+Z+X5rTgFBZtNCGYnmyj7EEj8OVoSDZQL3Ul
         iDlWoWga8p/+6njkCWnB4I1LZoXp6n8KfGCAwWDfo0Lv4z7QwrfuImZHQ98r7/hdiBJ3
         pNIM4ghM94JIro+LSlLwNWL2JHZRFFAj4bk74SCko9t+sRd4fIJEb709z3Ds4MVsJhnE
         jfEGypljowfKNSR9M1JDNgiLfPsX36jGjR2MceZzFqLL6bqRMshZ5AHyZrU3/yXqYeX4
         jYEA==
X-Gm-Message-State: AOJu0Yz+0x1JJ4UtiNDs/dV0elgO4J6K4NPGRMUGXMuznyXjZRGCNZzm
	oiScAVOZ1bPeP0Vj6tFynSPJIxgFGaE=
X-Google-Smtp-Source: AGHT+IEJs7/0hgb0QtPd4EOi1rTrJFRkv5XTosPMZ1oIu8qPOtSxaG4fqB3gcvijiNlfrZcXH4AqYg==
X-Received: by 2002:a7b:ce8f:0:b0:404:f9c1:d5d7 with SMTP id q15-20020a7bce8f000000b00404f9c1d5d7mr4396978wmj.25.1696005920829;
        Fri, 29 Sep 2023 09:45:20 -0700 (PDT)
Received: from kali.home (lfbn-ren-1-787-165.w83-197.abo.wanadoo.fr. [83.197.114.165])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c024c00b004051f8d6207sm1774621wmj.6.2023.09.29.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:45:20 -0700 (PDT)
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
To: connman@lists.linux.dev
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] resolve: musl does not implement res_ninit
Date: Fri, 29 Sep 2023 18:45:16 +0200
Message-Id: <20230929164516.6756-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khem Raj <raj.khem@gmail.com>

ported from
http://git.alpinelinux.org/cgit/aports/plain/testing/connman/libresolv.patch

Upstream-Status: Pending

Signed-off-by: Khem Raj <raj.khem@gmail.com>

---
 gweb/gresolv.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/gweb/gresolv.c b/gweb/gresolv.c
index 954e7cf..2a9bc51 100644
--- a/gweb/gresolv.c
+++ b/gweb/gresolv.c
@@ -878,8 +879,6 @@ GResolv *g_resolv_new(int index)
 	resolv->index = index;
 	resolv->nameserver_list = NULL;
 
-	res_ninit(&resolv->res);
-
 	return resolv;
 }
 
@@ -919,8 +918,6 @@ void g_resolv_unref(GResolv *resolv)
 
 	flush_nameservers(resolv);
 
-	res_nclose(&resolv->res);
-
 	g_free(resolv);
 }
 
@@ -1023,24 +1020,19 @@ guint g_resolv_lookup_hostname(GResolv *resolv, const char *hostname,
 	debug(resolv, "hostname %s", hostname);
 
 	if (!resolv->nameserver_list) {
-		int i;
-
-		for (i = 0; i < resolv->res.nscount; i++) {
-			char buf[100];
-			int family = resolv->res.nsaddr_list[i].sin_family;
-			void *sa_addr = &resolv->res.nsaddr_list[i].sin_addr;
-
-			if (family != AF_INET &&
-					resolv->res._u._ext.nsaddrs[i]) {
-				family = AF_INET6;
-				sa_addr = &resolv->res._u._ext.nsaddrs[i]->sin6_addr;
+		FILE *f = fopen("/etc/resolv.conf", "r");
+		if (f) {
+			char line[256], *s;
+			int i;
+			while (fgets(line, sizeof(line), f)) {
+				if (strncmp(line, "nameserver", 10) || !isspace(line[10]))
+					continue;
+				for (s = &line[11]; isspace(s[0]); s++);
+				for (i = 0; s[i] && !isspace(s[i]); i++);
+				s[i] = 0;
+				g_resolv_add_nameserver(resolv, s, 53, 0);
 			}
-
-			if (family != AF_INET && family != AF_INET6)
-				continue;
-
-			if (inet_ntop(family, sa_addr, buf, sizeof(buf)))
-				g_resolv_add_nameserver(resolv, buf, 53, 0);
+			fclose(f);
 		}
 
 		if (!resolv->nameserver_list)
