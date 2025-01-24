Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8902248BA
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745172; cv=none; b=b3W0/6WVd9woHe09GMbh1VSlcoln/WQSMvQQicx2BFibQl6h/NX2bQ76xvyxyPjUXx01AGRZIWJ68rYB5kfJ0qDH7051SlvMYHYcT76kljcxJt4QE6rslozoqoWC+gt2JxhF4SvPf3SZcS80p3hUL3rkWivZJ3vGmksCnUNlIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745172; c=relaxed/simple;
	bh=h4f47qvxj66aiSbRd0LrXsVrSiFb8ZIChsz178gmrsU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAOfgza5O/UH4At4nbZUot9m689IBkdQBn1Vs94p2oxvbaSfifLzOGCEcQgnN/Vb7Pug7vILAKSbRBVm1UiH9t6C3VPk6qkkEcQ0UON+Ev5m71ehI7XZaM0qT812uhHaxvx6zP91n/N282k3j4JqEYylPhDShNewrSg2ZPyNsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=GYfGrzpa; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="GYfGrzpa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IMVf7t9XK6FVY0qRTEmZvst0spMdPyYwKxMOqUy7AD4=; b=GYfGrzpaPV0Kedv4I0mHOh0/tl
	utDHXYpVR8Wlwt//WcGiZCWLHabsTmK50hsQgOLcqcKcjEc+B22PGPwVfF7Dnvh0lUbE8Qff8Qovw
	IkqrBrK1xbPlZn3rSLnHh5XGOFpU5dgb71DpAHk4uaoGiiN7hbUb0lyqx5MGk7idhQiliyihLhurw
	NK9cpdA7jXtGKYENrjnkXJQjUi1Q/v4QubWZdHj3ejL8b+WjeE7ekhL2BcUN7Y0JHQtEFZLiARpmD
	dYkD9lUoschxBHyljw1+8TqtKk7jAL0jIsFz+VX9fgUaQX7MVF09xJ9/R/3t6imUZuWwOOR4IbT4u
	j5pKrHDA==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtr-006LTc-0T
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:59:27 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 12/12] wireguard: Tokenize host for getaddrinfo()
Date: Fri, 24 Jan 2025 20:59:16 +0200
Message-Id: <20250124185916.1546471-13-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9
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
index 307b3b37..549969c7 100644
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

