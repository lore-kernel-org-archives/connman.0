Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73E238C3A
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098984; cv=none; b=cBJfnTqsmtW6vjAfCKl0kxf4wCdcJ23kMV4UcHYumcAlaBHsr+gM0zbwrGZAySTPd/QII+zJxZd0Gw+iRau+DccelTyDlZLZmvza/p161ElBwImCnOFdUtAtc7E4+tz8IYSI7hJEueyKaLviAXibaYXPaTRqcVEXxdLZjCtFOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098984; c=relaxed/simple;
	bh=NMTkJJqM3YCnZTvOu0zVEO2aT7kgzxpzgwjxuQORzbs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIgxdLqxxb1AhZaUe6v5/U83t+1SOJS2iUXuIiynH1DTT2Z663gLJ+0BoLzE/DUWOsapzy3dOUqEpgeBoBd1AKNma+foHEFdiDiMzyQHb+YBeRarEaDWJhEC5hZA88/jyZPQw2s1hqAGBFXeAKlNvZMV/MiuN4O1BD1ltNFRDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=zsBwKEGs; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="zsBwKEGs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AC6nWDYcbAM1MBZDp8fW0EJOE7wMqg1cBqtXu5Qcleg=; b=zsBwKEGsdURqZtQ27gn6mKgfNK
	aYCAJy5MWAytzcXiWmzI29X3CXqkwW/gMwDNxMTFBTR8VpOErXRsKw+ey3+mhuauH/frlclypkWey
	Lt39kGM/n54rGPi1bjabYjwdLKkIhg3kDMUZX00+kC0d/syYKdgTCnkCyHbB//614xkXg958ae4BL
	rYVWzlNcDujWgjaCzIKUG3RoykFHtH1HnIGLoOJdZzXKnh12wLv5r22Dfr52rq0zZirDm9Sim9lbd
	9xr8fkbY7JzuD5jeJK2kTITcSwjw65mc8QEq+K6DuS1oC3Md6so+BRaPcbR+7jDheM+pj73Poxwrr
	64T4Xsjw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-2n
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 20/42] wireguard: Tokenize host for getaddrinfo()
Date: Wed, 13 Aug 2025 18:01:52 +0300
Message-Id: <20250813150214.189282-21-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
References: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:b275:797e:525b:8df9
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
index ee97f378..2f077880 100644
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

