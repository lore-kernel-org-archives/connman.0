Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA963B3
	for <connman@lists.linux.dev>; Sun, 18 Dec 2022 19:28:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3F80DADB3;
	Sun, 18 Dec 2022 20:28:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1671391711; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=OSkpYwhXcybTx9AQC1myiedAYFooGeLNqtVOED0w+xE=;
	b=qk2dJHt9G0QZBjmsw0nqJfPSDNSJM+Ht68N/zAKEwU/td20XZbYmF7OVD9y3p9yypJMFSP
	N9C6M+wTwgP3vv9VIi0ighg8yzKEKnBTCAtFtx+OPhStm1g1IMDEhBOMmBSxajHs9R9jl2
	kmFKy+YRxN4CHewcPf4Dbl5sXXPxb6YpjeBP81SRufqphx8JwAW/QUeGI1a9vUZZL2XDiE
	/gkSwhPCfskUBVfVX+kvD2qvOFcmZoQzbnD62k73oed8q1GrD0WaDJtZACj9e4hJEUfEPd
	5nzQtdB55lNP+Ez1nVCACuSiqdya4ktGCk/F85KENXpNlxlUurz9vZp+ekJCSw==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Geoffrey Van Landeghem <geoffrey.vl@gmail.com>,
	"i . Dark_Templar" <darktemplar@dark-templar-archives.net>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 2/2] main: Add Hamachi interface to ignore list
Date: Sun, 18 Dec 2022 20:28:20 +0100
Message-Id: <20221218192820.22937-3-wagi@monom.org>
In-Reply-To: <20221218192820.22937-1-wagi@monom.org>
References: <20221218192820.22937-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Hamachi VPN daemon setups a network interface calles 'ham0' which
is under control of this daemon. ConnMan should ignore it and not
starting to auto configure it.

Reported by: i.Dark_Templar <darktemplar@dark-templar-archives.net>
---
 src/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/main.c b/src/main.c
index 70277f66efce..ae4a450dea11 100644
--- a/src/main.c
+++ b/src/main.c
@@ -78,6 +78,7 @@ static char *default_blacklist[] = {
 	"ifb",
 	"ve-",
 	"vb-",
+	"ham",
 	NULL
 };
 
-- 
2.39.0

