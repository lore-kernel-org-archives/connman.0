Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6F2C86
	for <connman@lists.linux.dev>; Tue, 12 Oct 2021 07:07:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62DAB616D8;
	Tue, 12 Oct 2021 09:06:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634022413; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=NDO6MyjAT7gJ5stZpACEUfQEKfjRbrstxGnxnl9WMqo=;
	b=BM+LrUHXeKsD3J1lHlmOqA62JcNsvYlHSVx6SOfeC1Rj0W8K8EQF12T0/vhR/bzwiXcpOE
	A1um+cN4oumt9yQJ/wlLOeYvBfAonu6I7MKB7VevMcINCN1y/OkcZtBt7XejSQLOSceVjy
	tWqBxY2z2ksKAjytSZWMiy3WNbbjPUO6k8XJWmyESpl6uh5knmBiFzMd+tOzpFhfCYlXJ7
	2/bqZBnH6R4f8r7cuO6C6c54Gxg+OIlKWKnAhGQW/cQrwKSDTLWdfQw78XiTE7ci+fxLFD
	4beOaAWjj9bYWhQHRsRtIgFrJPTnVu2JYKIeGNQwlMyhx60AYUlQoYxh7W459Q==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 2/3] inet: Remove unused ipv6_addr_advert_mult
Date: Tue, 12 Oct 2021 09:06:47 +0200
Message-Id: <20211012070648.28947-3-wagi@monom.org>
In-Reply-To: <20211012070648.28947-1-wagi@monom.org>
References: <20211012070648.28947-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

clang complains with

src/inet.c:1839:20: error: unused function 'ipv6_addr_advert_mult' [-Werror,-Wunused-function]
static inline void ipv6_addr_advert_mult(const struct in6_addr *addr,
                   ^
Remove the ipv6_addr_advert_mult function.
---
 src/inet.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/src/inet.c b/src/inet.c
index df94d1eebaa7..4039a73ca498 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -1836,13 +1836,6 @@ int __connman_inet_ipv6_send_rs(int index, int timeout,
 	return 0;
 }
 
-static inline void ipv6_addr_advert_mult(const struct in6_addr *addr,
-					struct in6_addr *advert)
-{
-	ipv6_addr_set(advert, htonl(0xFF020000), 0, htonl(0x2),
-			htonl(0xFF000000) | addr->s6_addr32[3]);
-}
-
 #define MSG_SIZE_SEND 1452
 
 static int inc_len(int len, int inc)
-- 
2.33.0

