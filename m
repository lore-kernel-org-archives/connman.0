Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35F7F
	for <connman@lists.linux.dev>; Mon,  1 Aug 2022 08:00:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FD775DF36;
	Mon,  1 Aug 2022 10:00:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1659340850; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=OWG0S+EQDkF0ACgmVT9nUum7UjGYSQHm2QYitav4Wbc=;
	b=Lf13bhRl3+zsFaYISeZYt1D+r6SolPR0JlY9FYeThemvDhzjsZYXmrDPddj/LlqInmFTL0
	KDO5hWhplUeg7VwcoBf+qyXILYl8OgOmIMMsB2wNzObS3nfVMPQR4UaGHr/68dgs1qzxdl
	aJYjge44oUMOdjffgVJfF9ZmPZXRaqMOXAyGw5IjBac3K8ZJUY4uMVODB2kCqGBpBxIMnn
	YHlHXJ/iT4OujNlOP4fEOb/36BfWT9pdkXxmZ5k7MLz4j2iLNWuSlWh1iUAcyLnU6U6bX3
	g2YRQMgsq1EG1Kwrpn4OyJXSg8GhfyxXlINZ35fyhS7PKPKR3wEQ9O6915wseA==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 6/6] AUTHORS: Mention Nathan's contributions
Date: Mon,  1 Aug 2022 10:00:43 +0200
Message-Id: <20220801080043.4861-6-wagi@monom.org>
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

---
 AUTHORS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/AUTHORS b/AUTHORS
index b4c6e6e7a039..59b1ddd17afa 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -178,3 +178,4 @@ Christian Taedcke <christian.taedcke@lemonbeat.com>
 Matthias Gerstner <mgerstner@suse.de>
 Sebastian Pipping <sebastian@pipping.org>
 Daniel Linjama <daniel@dev.linjama.com>
+Nathan Crandall <ncrandall@tesla.com>
-- 
2.37.1

