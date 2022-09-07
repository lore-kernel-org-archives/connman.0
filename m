Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7DE20EB
	for <connman@lists.linux.dev>; Wed,  7 Sep 2022 18:52:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 894BF5E0CB;
	Wed,  7 Sep 2022 20:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1662576746; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Xfl0w+VIZ+Dj3Z1jUoJNglzgcxmV46k+PHXiffVUsS0=;
	b=BSZ2DkDgDiylPxIbBupH/uvce6QfPB4Cki/5DX8LGfvUe2fxCjCqgl2wDK2G/upprIsUu9
	HQZYlNsEtmvZyca+1SVaB0sjQgV43Xe0yaR6QUPPb52GwJk/7yZH53YHL8aKQWgIgdNjwr
	ueyuzpZLWTN0lXWAvWI1fO5jmDhkShGD2iV4PYLwoZ4sOziZfIKlmWH+zfAmMVQ8itR2eu
	OIVgcdA+Wr37cry5n1eLSKzboRCIsBoQHYJZ81NRlqyO+e4UNSgp/ZIGZdvpplf2jRb3Wo
	ck/625Gy2gQ/OWGQqJut6fcf2GO2LpzRLYFzjKGmtGL54kIlhz25CxHia4n/XA==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v2 3/3] wispr: Simplify the IP version check
Date: Wed,  7 Sep 2022 20:52:21 +0200
Message-Id: <20220907185221.2981-4-wagi@monom.org>
In-Reply-To: <20220907185221.2981-1-wagi@monom.org>
References: <20220907185221.2981-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

No need to be clever. There is IPv4 and IPv6 nothing else.
---
 src/wispr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index a7562e8462f3..a4372018a3e1 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1033,12 +1033,8 @@ int __connman_wispr_start(struct connman_service *service,
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		wp_context = wispr_portal->ipv4_context;
-	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
+	else
 		wp_context = wispr_portal->ipv6_context;
-	else {
-		err = -EINVAL;
-		goto free_wp;
-	}
 
 	/* If there is already an existing context, we wipe it */
 	if (wp_context)
-- 
2.37.2

