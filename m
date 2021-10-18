Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A452C88
	for <connman@lists.linux.dev>; Mon, 18 Oct 2021 08:16:44 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id n7-20020a05600c4f8700b00323023159e1so685347wmq.2
        for <connman@lists.linux.dev>; Mon, 18 Oct 2021 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHkdnMqD8j2aTsGHju9uPe+PTMhu/jIVWDEzlG7OUeY=;
        b=DbjALjabt6Pbf3zDeqh7sgcaNRgIWe/+8N7ww2hTn0MHo3CQ7dJkYdaf6olIgBq8/y
         UT5SPurhIoW6XkKR5di3bAIrfndqpU3us8DktNBX//pNEbUkEcPjKW+1rq1tv5RB6/D+
         lkdgkUgg08Z1X3Q8ii5gfFjWqdqDZQvVgHm1gOULe/7faFX+DoHos6ADAGEuX51ftzGQ
         WYIyj8pcNKA2ArODD3dSM/jZfjSP0p2CX78+lqCqQNDazLFyJUay4GlvO00eto4jKfdu
         PAzjhInIdOpJ6l5ezb0/8G/xbO8b9QslIivgvZTU6NrFAQTybgNjbg60zOyOcSXrgk2T
         K5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHkdnMqD8j2aTsGHju9uPe+PTMhu/jIVWDEzlG7OUeY=;
        b=SiN/SwNLZiFTDkO4lPQu31jp+/fPeihuQZ9GTSJHHod9c/GuMSfLfDHAtuoxtDyfCL
         MOGVKefUajqlN9n5dQnp1m8vAUfBUTNEBZAsjeGoTy2gkStgyQfVULkCNPjaicPpLOv5
         S2LKPXSCtbgBwNRbMVVPczogRQ0Y6PJqmY2qoDc4DaLVFWN8QmDQXofEZz7IDLbDjNBq
         ux057NqrIBEH6aAQCUkNZUIJR1WOytumx7GGC0CboKYrtRdoW7ovcPaDE/2RXBpBnxaR
         CqKGNIaN5IuX/bp9Vy5nHOWHGoTvB0NZdSF6mYJI9u4XLrBo+qap+F22DtlEmwbe1uqJ
         GT7A==
X-Gm-Message-State: AOAM5308+2s35tAA+udwKH8H4tJiQx1JAFkPEsFwX1nn7tFB6rN226Mk
	ndx39EHeUUnKj4aP+rHuqVY8vbjxLzK3uA==
X-Google-Smtp-Source: ABdhPJy+0TtLp5vLKM56jIpWyq3gqJENglN+L6+owBXSlhArBFCuM4+VqOfFsTTObU67P0NEqkFYwg==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr26820778wmc.159.1634545003422;
        Mon, 18 Oct 2021 01:16:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:958:8af0:83c2:ab5b:663:7b6d])
        by smtp.gmail.com with ESMTPSA id q7sm11991500wrs.73.2021.10.18.01.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:16:43 -0700 (PDT)
From: Emmanuel VAUTRIN <emmanuel.vautrin@gmail.com>
X-Google-Original-From: Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
To: connman@lists.linux.dev
Cc: Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
Subject: [PATCH 2/3] build: Fix uninitialized errors in iptables tests
Date: Mon, 18 Oct 2021 10:16:01 +0200
Message-Id: <20211018081602.82984-2-Emmanuel.VAUTRIN@cpexterne.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211018081602.82984-1-Emmanuel.VAUTRIN@cpexterne.org>
References: <20211018081602.82984-1-Emmanuel.VAUTRIN@cpexterne.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gcc reports with:

 tools/iptables-test.c: In function 'main':
 tools/iptables-test.c:148:3: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   148 |   exit(err);
       |   ^~~~~~~~~
 tools/ip6tables-test.c: In function 'main':
 tools/ip6tables-test.c:149:3: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   149 |   exit(err);
       |   ^~~~~~~~~
---
 tools/ip6tables-test.c | 2 +-
 tools/iptables-test.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/ip6tables-test.c b/tools/ip6tables-test.c
index 41e842dd64af..a52f4af04edf 100644
--- a/tools/ip6tables-test.c
+++ b/tools/ip6tables-test.c
@@ -45,7 +45,7 @@ int main(int argc, char *argv[])
 {
 	enum iptables_command cmd = IPTABLES_COMMAND_UNKNOWN;
 	char *table = NULL, *chain = NULL, *rule = NULL, *tmp;
-	int err, c, i;
+	int err = -EINVAL, c, i;
 
 	opterr = 0;
 
diff --git a/tools/iptables-test.c b/tools/iptables-test.c
index e9b7cb224d7a..f9d091eb9490 100644
--- a/tools/iptables-test.c
+++ b/tools/iptables-test.c
@@ -44,7 +44,7 @@ int main(int argc, char *argv[])
 {
 	enum iptables_command cmd = IPTABLES_COMMAND_UNKNOWN;
 	char *table = NULL, *chain = NULL, *rule = NULL, *tmp;
-	int err, c, i;
+	int err = -EINVAL, c, i;
 
 	opterr = 0;
 
-- 
2.25.1

