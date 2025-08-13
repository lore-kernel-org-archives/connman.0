Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94311CBA
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100730; cv=none; b=P3unHOFcwUReywsquDVFcNF9a23CkJy9ik1OC79N+717ZegKWNsh1hpwJpyM1dMljwnC85NcpkrDHTcKnUi1bhcI1Rf6AeUezBO7MrwHdcQHzSrw0L+f3H2/R2ScR4uXd1fJPZ0j3B0poXhnVC7tH7Fug2NDn+oMgAIG0i8imNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100730; c=relaxed/simple;
	bh=0QIgCPEqnY+KN2q3Wm4Be3OgItOXi2uhl6jNWNIuKB0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGVvZU6bWVWdVGxAKVvd0ITpwFDdpGG4jj13zYD0N+SpDR0/bCDrZi7kCVoc3Rq2EH5ENpKJpEv0VUQEOoe2gGXnt6QhxjcwGuGdXiWdABYdYCS7CCXZ0QSZh0L4wtCByC2bZObLgKaZPF1VLQO2Wjdz83ekQhu2rP8iJbRn9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=TZToZhbs; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="TZToZhbs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=85y7HZcYsVWob+jhrm2MiwsDLmOcQ5QhCDMYeeOBQKc=; b=TZToZhbs7yCrZnsKv4q6w6niIj
	cICySnLo2YlawyR7GeEbIjX7jdlz39xYS3LSd3pIilp7DgVygAv9v8srI9G0lP8lCnsMUbVhCcG3M
	5vMPprdbxZZ/JUSnEuLtGYEh6KJ0YUPWdBqP+d171chbstK1ejqKP4tOj1Coi/7mjiOBZ7F0BUK2x
	j/eIVhlwo2Uq7XOyJkIE93gxm9LcmxuDWI5pvU6XYEwDXl+HrJ1ewynO+vhgbcZ+spEOs3HSNV62A
	U24dPB+Iq0PbtA9XW78YONENtHWwiFnnwKMYzEBksZajorOJl7xFN6wF0gf6oGECVbt1AZ7xPaC29
	Xin8gNTQ==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-0i
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 28/42] Revert "vpn: Remove unused __vpn_provider_check_routes"
Date: Wed, 13 Aug 2025 18:02:00 +0300
Message-Id: <20250813150214.189282-29-jussi.laakkonen@jolla.com>
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

This reverts commit 192696c5b032b0bdfa09950c43b569131315d490.
---
 vpn/vpn-provider.c | 16 ++++++++++++++++
 vpn/vpn.h          |  1 +
 2 files changed, 17 insertions(+)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index c05e4cf5..0462978b 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -3025,6 +3025,22 @@ void vpn_provider_set_auth_error_limit(struct vpn_provider *provider,
 	provider->auth_error_limit = limit;
 }
 
+bool __vpn_provider_check_routes(struct vpn_provider *provider)
+{
+	if (!provider)
+		return false;
+
+	if (provider->user_routes &&
+			g_hash_table_size(provider->user_routes) > 0)
+		return true;
+
+	if (provider->routes &&
+			g_hash_table_size(provider->routes) > 0)
+		return true;
+
+	return false;
+}
+
 void *vpn_provider_get_data(struct vpn_provider *provider)
 {
 	return provider->driver_data;
diff --git a/vpn/vpn.h b/vpn/vpn.h
index 1f8c8fcd..97c0ad6c 100644
--- a/vpn/vpn.h
+++ b/vpn/vpn.h
@@ -73,6 +73,7 @@ void __vpn_ipconfig_cleanup(void);
 #include "vpn-provider.h"
 
 char *__vpn_provider_create_identifier(const char *host, const char *domain);
+bool __vpn_provider_check_routes(struct vpn_provider *provider);
 int __vpn_provider_append_user_route(struct vpn_provider *provider,
 				int family, const char *network,
 				const char *netmask, const char *gateway);
-- 
2.39.5

