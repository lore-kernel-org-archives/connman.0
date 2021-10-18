Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4C168
	for <connman@lists.linux.dev>; Mon, 18 Oct 2021 08:16:46 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso7735602wmb.3
        for <connman@lists.linux.dev>; Mon, 18 Oct 2021 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmJu+FtZezyJwLGc8PHveSoP1HV3HiS2hZfSrq5qx2o=;
        b=pCKhMhLxy1nTTgTekhwasONiLPjIjcL7f30509fMTgyEfbbpJt91m2KZ5V8QVnV1+K
         A2HNvr4ywS3nGF9OHc87GaWZ4EYDKGSNfF4AIdy2W870Z8z/zP/uzTvKF0avu0wQiT9L
         Wu4KscHrVfGaJpiyy8//BBi3h7hsyRZ//+DHoxkdqPLMhaHiWFEqSHKPqyFRrGzFSfhg
         Pi4jMN929jFS6pldYLQW52nlwEd6YUs9JZL6R+RKIa4pEKJ3KOuEprXAdV32TXW16hPR
         UBo42jv0kuIFdqbSkDhN4nI8vwkJ8CGnSaleA+IGlNCa5LnOdWuRpTLdE4WjMNVV+4U7
         KEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmJu+FtZezyJwLGc8PHveSoP1HV3HiS2hZfSrq5qx2o=;
        b=2hSM+OkOacqeL1cZo6iMoIDBmhT8lP5FAovZwrJSx2EdZv3tihugpLvDliBD5k6mKp
         o7qFriT59UrGXu4kj4zN9TVYBmIrWju/02pJVjBgPmlUvhxoNChskFEn5Yb/O7Qo8GoQ
         5APsRIXGezGqIRcqQGFwdAsXK4AdO+VShd1y+vJ/ODAfZMMf10ZpaGEaH+FsL+UG8n2z
         ZmfQ/MGYVbxZMPVkMRlEgViRUp0bzBuxuQsp2zYPoHgCBnTYT5mLgQN7Pu1Cykf2GKNR
         RAckzBdxvvdeKtJ6MVhufuAB7w5brmJPqA7H/bp5fdh3UzF9Hdt0ZeIao+0HM8iMoP7e
         /QYQ==
X-Gm-Message-State: AOAM5307hhaHFoNvhmR20bVTs1mvSBKZOXVnWlNB0CBzKEFYHCiiUgHd
	hy9pLVfzhywtWdvDDoSy2IOl6jD7mDxeYw==
X-Google-Smtp-Source: ABdhPJwD2FjNxNOvvh7lxMbnoKu3b0gkIDOP9u4YoKnWrN2nFazTesLTxJzeE6YRa1wAJJozOhkwUg==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr43636359wmh.119.1634545005253;
        Mon, 18 Oct 2021 01:16:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:958:8af0:83c2:ab5b:663:7b6d])
        by smtp.gmail.com with ESMTPSA id q7sm11991500wrs.73.2021.10.18.01.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:16:44 -0700 (PDT)
From: Emmanuel VAUTRIN <emmanuel.vautrin@gmail.com>
X-Google-Original-From: Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
To: connman@lists.linux.dev
Cc: Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
Subject: [PATCH 3/3] build: Fix uninitialized false positive in dnsproxy
Date: Mon, 18 Oct 2021 10:16:02 +0200
Message-Id: <20211018081602.82984-3-Emmanuel.VAUTRIN@cpexterne.org>
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

 git/src/dnsproxy.c: In function 'update_domain':
 git/src/dnsproxy.c:2735:4: error: 'dom' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  2735 |    g_free(dom);
       |    ^~~~~~~~~~~
---
 src/dnsproxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 4b65b3790bb9..fbbee0413f8f 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -2707,7 +2707,7 @@ static void update_domain(int index, const char *domain, bool append)
 	for (list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
 		GList *dom_list;
-		char *dom;
+		char *dom = NULL;
 		bool dom_found = false;
 
 		if (data->index < 0)
-- 
2.25.1

