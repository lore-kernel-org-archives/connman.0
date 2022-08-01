Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0417E1
	for <connman@lists.linux.dev>; Mon,  1 Aug 2022 08:07:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0E9D5DF2D;
	Mon,  1 Aug 2022 10:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1659340847; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=A2ZN+5vmx8vkK1zJ05j1zljB2kNJCV6K+dJDIRXgims=;
	b=Bib3AEW1HubcHj/J2LxpH75q9oXhpvOpGr6KVa1hG6vXCs99SHfdBDj/7gicE8aXd3AB0M
	Q/Dl813FMHgtuJmEAReA+kmsXnU/VF1hID5CJFBZ38DonxBAQc2VjjNp0oJ/a2uWhaGaSv
	G137D/srl0Q4IsN9qEz4Tt5+0ihM4NPC3+4BPUl2ehOPIeFjxYd9RWwkXyZp+vq4DejYlj
	+n33rxtDysgnLkAXQGx2iAjNWqUF9rbKvhyUlrT9XrjO0fzi64nOI/UCHxBw0qlfPDW+0d
	eH1JP7DOmkfMkskS63p548iCZSdbHPC4AGEVA+C5AEFHN8UA3R6KnmIXkJNcog==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 2/6] wispr: Ignore NULL proxy
Date: Mon,  1 Aug 2022 10:00:39 +0200
Message-Id: <20220801080043.4861-2-wagi@monom.org>
In-Reply-To: <20220801080043.4861-1-wagi@monom.org>
References: <20220801080043.4861-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

connmand[16822]: Failed to find URL:http://ipv6.connman.net/online/status.html
connmand[16822]: src/wispr.c:proxy_callback() proxy (null)
(connmand:16449): GLib-CRITICAL **: 10:15:43.812: g_str_has_prefix: assertion 'str != NULL' failed
---
 src/wispr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wispr.c b/src/wispr.c
index 9bd2a2ef1d5f..a07896cabe48 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -835,7 +835,7 @@ static void proxy_callback(const char *proxy, void *user_data)
 
 	DBG("proxy %s", proxy);
 
-	if (!wp_context)
+	if (!wp_context || !proxy)
 		return;
 
 	wp_context->token = 0;
-- 
2.37.1

