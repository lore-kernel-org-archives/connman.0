Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801017F
	for <connman@lists.linux.dev>; Tue, 29 Jun 2021 07:33:30 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id 6649950051C;
	Tue, 29 Jun 2021 09:33:28 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
	by mail.monom.org (Postfix) with ESMTPSA id 345925003CD;
	Tue, 29 Jun 2021 09:33:28 +0200 (CEST)
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: John Keeping <john@metanate.com>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH] agent: Always inform upper layer via callback
Date: Tue, 29 Jun 2021 09:33:26 +0200
Message-Id: <20210629073326.22689-1-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The upper state machine expects to be called in all cases. Do not
silenty eat up the callback.

Fixes: 8ea2d67a6e89 ("service: Complete only after user connection retries")
Reported by John Keeping
---
 src/agent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/agent.c b/src/agent.c
index d6113af745fa..d4f9add478fb 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -366,9 +366,9 @@ static void report_error_reply(DBusMessage *reply, void *user_data)
 			retry = true;
 	}
 
+out:
 	report_error->callback(report_error->user_context, retry,
 			report_error->user_data);
-out:
 	g_free(report_error);
 }
 
-- 
2.32.0
