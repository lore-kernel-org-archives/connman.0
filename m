Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148D4699
	for <connman@lists.linux.dev>; Sun, 28 Aug 2022 18:10:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51E755DFFF;
	Sun, 28 Aug 2022 20:10:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1661710254; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=V96CeeYv3yOWO7PiozETPcFuk8tgye0HFwE2nIwdNew=;
	b=SGIFxIOoK8btp1FfLqtdk4cUIuXoz/3dKsNTga8T2/U3CYv52DsDYzXl+w6/WTKsEzNbxp
	vbEQbbpwTeQYKEuNSfP47HCfRljipKZ7WpdDK/kVydw57lpjT5vSEpmj4+fpylMGF11hrg
	dioOmhA53CcoLxd+66nFj2PV6HOS4C2C5LWtYu6hV8KIxGY+0Gn/e5d9N4D3PpaWCDo8GW
	fJQpX3IppWjxBmn2Aw8F7SIgqpaO5aaC1lVY3eJ1RpC0f2R1SwbDYPg42YTCvvDDFyS2vu
	qhAIaygXpLmZ52c+hGLuFozp/Cc6bE+VnubJTVAOAsmC9Ekz/ecJZhltPpdY1g==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] ipconfig: Don't add invalid gateway routes
Date: Sun, 28 Aug 2022 20:10:52 +0200
Message-Id: <20220828181052.27467-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When we assign an IPV4LL address we are calling
__connman_ipconfig_gateway_add() with an invalid GW set. It's propably
a safe bet to say NULL is never a valid GW, so let's filter it out for
all callers.
---
 src/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 34b1724a22bb..9f17f4989ea8 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -1172,7 +1172,7 @@ int __connman_ipconfig_gateway_add(struct connman_ipconfig *ipconfig)
 
 	DBG("");
 
-	if (!ipconfig->address)
+	if (!ipconfig->address || !ipconfig->address->gateway)
 		return -EINVAL;
 
 	service = __connman_service_lookup_from_index(ipconfig->index);
-- 
2.37.2

