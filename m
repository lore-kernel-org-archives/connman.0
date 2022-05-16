Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC459A52
	for <connman@lists.linux.dev>; Mon, 16 May 2022 06:22:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52CA45D872;
	Mon, 16 May 2022 08:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1652681680; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=f210X+/+menMVQLj0Gl1/NMxTWImDIIdPOQoISfWV6o=;
	b=O7HpyYKdTAbAa2JmJRIz5aopf+AXDTYhfyxryAML9xKHuqcSOt0cy76alAt5mY58r/9C2u
	JdUl0iQZEJuzlChxAHGzgueBvFlF8Cfe9bb3vMwuvpDmd7+lvi1JSZO9KDRkIeX28ZOLJz
	AzWrTSTMuy2j7XNvwPeCWNOjDVmoFQSK7AMUEVIbtR4NoVyAmBtYv5qEcHQ2JsDxh1L9W8
	9sJ1ApHxFr6bwgIaCJshVcOp1gKvayIsDG8HrC4hXYGJ9WMMHI/I/ykXWi414kaf6tSFCR
	+K0grx3aCNlpgbWMTX7IX1JswcVyWTbZe82yZeYenuFBoJPeAS7jfneeTxaDSg==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] doc: Add note SingleConnectedTechnology can't be used with VPN
Date: Mon, 16 May 2022 08:14:36 +0200
Message-Id: <20220516061436.5180-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

SingleConnectedTechnology can't be used with VPNs. VPNs rely on a
transport which is from a different technology group.

Reported by Thomas Bartosik.
---
 doc/connman.conf.5.in | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index cb36e9fb2220..d80841182253 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -129,7 +129,8 @@ are in 'online' or 'ready' states, the newly connected service is
 the only one that will be kept connected. A service connected by the
 user will be used until going out of network coverage. With this
 setting enabled applications will notice more network breaks than
-normal. Default value is false.
+normal. Note this options can't be used with VPNs.
+Default value is false.
 .TP
 .BI TetheringTechnologies= technology\fR[,...]
 List of technologies that are allowed to enable tethering separated by ",".
-- 
2.36.0

