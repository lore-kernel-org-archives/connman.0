Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96E2E7BB7
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244075; cv=none; b=oVk02toPr6aWGMR2OucYzdxh4UzUt0U7eAYx2C2IduUENbs8DOlqEszh/vJRyIstLUhJembgpMQSmIwYhFLMkNg19u6CjJ3RCY7eM2kslOuQF662Z2KUcGNzxCHDYInKOsp9Rr4Ix73psi7Yc2COiZPCqAjPf3rWVL4C2B3rK1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244075; c=relaxed/simple;
	bh=6ns5ze2mbOdasljYOKt4TnH1z4TgIse9oBrDozyfjys=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAJFTLibIWNpd0dfDxIxwcmSaKY367iAVUHxBz/n+4HH1R9FOyBIN/DJGku0SbgQ4I2105ZslD87BIidnSX35xNO9r1P/d58cY8FhvH6Mu8iYqqgOv6zVeZ7aNiLeG3+wk1Q5Jgsf2fSdoWyQqJ5/KpGPRTO+H0oiC/IO71rm2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=GOhckFyV; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="GOhckFyV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8I07Qg3IMpMQRltPasZ2BBFuQEl3xG7+d5vl3xQuqxs=; b=GOhckFyVPq0gGvhgPI89cKE+m6
	tupgiGX4PMMRR2Jr0Xg2PtpQyQDI0t1vgvEkxnhttv3f0op7mJANbb1v+wKSIKwgzOK/3OddkfwGu
	CNFvpBbIx8g/LLKdoF/Dv6lpxG2iSmcl/5ezE+0++l4pzeeGfO/YuK6yEtadhXOyxbFsRTkkzyCn0
	iqAIPpUMyI++c0qI1weRwAghWypdLIiYqMIKl5g4le1yfUp9hXNd1izFGC34jS9vMmeXwcDYHp9fZ
	aubTVc1eW3iRK2Sj2eCcfJY1bdQJJOG46jgxJ7+rIJFAh3i7bi0E6oQ30NWcW20ZIoBhpM9UJ9SUo
	mbpeeyXA==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-2S
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 22/45] wireguard: Tokenize host for getaddrinfo()
Date: Fri, 11 Jul 2025 17:27:13 +0300
Message-Id: <20250711142736.1757060-23-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:7901:7c96:5fcf:719b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

The host parameter contains the address and netmask in CIDR notation
with IPv6 to define also the PrefixLength to be used in D-Bus for
connmand. getaddrinfo() relies inet_pton() that does not work with the
notation so tokenize host before passing it to getaddrinfo().
---
 vpn/plugins/wireguard.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index ac63b558..e2714c54 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -187,8 +187,25 @@ static int parse_endpoint(const char *host, const char *port, struct sockaddr_u
 {
 	struct addrinfo hints;
 	struct addrinfo *result, *rp;
+	char **tokens;
 	int sk;
 	int err;
+	unsigned int len;
+
+	/*
+	 * getaddrinfo() relies on inet_pton() that suggests using addresses
+	 * without CIDR notation. Host should contain the address in CIDR
+	 * notation to be able to pass the prefix length to ConnMan via D-Bus.
+	 */
+	tokens = g_strsplit(host, "/", -1);
+	len = g_strv_length(tokens);
+	if (len > 2 || len < 1) {
+		DBG("Failure tokenizing host %s", host);
+		g_strfreev(tokens);
+		return -EINVAL;
+	}
+
+	DBG("using host %s", tokens[0]);
 
 	memset(&hints, 0, sizeof(struct addrinfo));
 	hints.ai_family = AF_UNSPEC;
@@ -196,7 +213,9 @@ static int parse_endpoint(const char *host, const char *port, struct sockaddr_u
 	hints.ai_flags = 0;
 	hints.ai_protocol = 0;
 
-	err = getaddrinfo(host, port, &hints, &result);
+	err = getaddrinfo(tokens[0], port, &hints, &result);
+	g_strfreev(tokens);
+
 	if (err < 0) {
 		DBG("Failed to resolve host address: %s", gai_strerror(err));
 		return -EINVAL;
-- 
2.39.5

