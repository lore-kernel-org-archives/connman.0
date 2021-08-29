Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A22FAF
	for <connman@lists.linux.dev>; Sun, 29 Aug 2021 19:53:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E532B61667;
	Sun, 29 Aug 2021 21:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1630266808; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jpBsBWXuYGLC3nAeCkEu5Fl+2YWd7GUSxJ8YdRk6/5E=;
	b=NcVxUqWDQjauQmEDJK+fL4/gDlusoo1n9ABNS6jF31j6BYXmdhT3b/8E54scqRRUjqlLp2
	/PL6zUBfb1kBuidqUyStk1vKFlBMPnc8k0+vo6Y/B5SzaqJJrZmNcxs1lyDopfAsnLEUBO
	Q7t7euery6AgkIM4ilSXeAHwx8drSLtjU8MZvhiu6qF3KQIJv4hfPUyGrohi8kKYRivgfx
	PwnBXkcaAJI/IfccVG1ePtleM08huBfHm9fbKZCGwUKAntWE6c4F9sOpOn3IiQhcFgxN4m
	LY5K0Lp2SjtQ9psC6QV/pPfnpxkBtuhHrOtmEKr6Q1u8zxK+RmTaxmDi2VsCKA==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 2/2] service: Do not trigger wispr start when EnableOnlineCheck is disabled
Date: Sun, 29 Aug 2021 21:53:21 +0200
Message-Id: <20210829195321.23396-3-wagi@monom.org>
In-Reply-To: <20210829195321.23396-1-wagi@monom.org>
References: <20210829195321.23396-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Do not try to use wispr when the user has disabled the online check.

Reported by Страхиња Радић
---
 src/service.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/service.c b/src/service.c
index 237c88e15506..8097f5373250 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1597,6 +1597,12 @@ bool __connman_service_index_is_default(int index)
 
 static void start_wispr_when_connected(struct connman_service *service)
 {
+	if (!connman_setting_get_bool("EnableOnlineCheck")) {
+		connman_info("Online check disabled. "
+			"Default service remains in READY state.");
+		return;
+	}
+
 	if (__connman_service_is_connected_state(service,
 			CONNMAN_IPCONFIG_TYPE_IPV4))
 		__connman_service_wispr_start(service,
-- 
2.32.0

