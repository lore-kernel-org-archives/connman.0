Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167723A9B1
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098943; cv=none; b=FyzxiS/sv8EqUIOjofy6Qf8YopRkZ622onhA8L4c/8+Cyk3E+yurPv/xIEkWX8H7puDGvlB+Is42G3TvfaHvHweXftvXy78HshZ6GgHZCaJKbmHTcUVaoreHz8xNwx5554YArG3tFAuS3gSaW+EFnamnfPqWLH6VDtAxth5F7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098943; c=relaxed/simple;
	bh=5koIp6/pj4EfKXep9qXciz0ZbPCXGd4XONkrv83z3wo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFJRP6+ktSLpaCfHUp3Fq/NJFbiLd/6xsSKX89Eil1b/XhV9Xu0JJ4pOma57D4AiNFbnxbcK5RHxMVCHkpBdtO/QzUWkIDlJ9WSdRN4hY/duBEQXKI78xI52LxyWTuXm5fsBlRtX/UnIsPGw4Pwa5VuSouBcKDXN5wGIfyKHD34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=JMtUcb0V; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="JMtUcb0V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+J8h8gmREsyoxFugM8GAope/pIaGxGowMeoQZ2djs9o=; b=JMtUcb0VOtW35zMAuBhvCqvFcU
	iRZkODPKQkCfcGYFpThBkWx3A/Oziu/wgk3UmTW5MpMQBrYsFwD++VCR1afFcOfNX9UIoXs7pMnkD
	LG8vJT+UD2WT0qGV6dYX3z8qk36Z6+H0+GzOfmSh36KE2aCH9ELm6E9WtI7hr7IP5oE9VTrPr7BUl
	3JBd6MeUzRIv3+cliAMNVcBYGmbz0OJ0fXdjj6iodzVfkivRk39mi1dfSS7T6zRSVHSaJsAuLa/b/
	9N6bNcEe3ieePtse3ImdtkcAQemvoX9RZjhSR3KkYuVnDOikuSy9jVJQW31R5jRsxBTQe0pUHo8R7
	mSS2Rzag==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-1h
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 35/42] vpn: Implement getter for the flags set by the VPN
Date: Wed, 13 Aug 2025 18:02:07 +0300
Message-Id: <20250813150214.189282-36-jussi.laakkonen@jolla.com>
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

Allow the provider to get the flags set by the VPN plugin. Add this to
the updated provider_driver struct.
---
 vpn/plugins/vpn.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index 047808b6..e04615e0 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -827,6 +827,22 @@ static bool vpn_uses_vpn_agent(struct vpn_provider *provider)
 	return !(vpn_driver_data->vpn_driver->flags & VPN_FLAG_NO_AGENT);
 }
 
+static int vpn_get_flags(struct vpn_provider *provider)
+{
+	struct vpn_driver_data *vpn_driver_data = NULL;
+	const char *name = NULL;
+
+	if (!provider)
+		return 0;
+
+	name = vpn_provider_get_driver_name(provider);
+	vpn_driver_data = g_hash_table_lookup(driver_hash, name);
+	if (vpn_driver_data)
+		return vpn_driver_data->vpn_driver->flags;
+
+	return 0;
+}
+
 int vpn_register(const char *name, const struct vpn_driver *vpn_driver,
 			const char *program)
 {
@@ -853,6 +869,7 @@ int vpn_register(const char *name, const struct vpn_driver *vpn_driver,
 	data->provider_driver.set_state = vpn_set_state;
 	data->provider_driver.route_env_parse = vpn_route_env_parse;
 	data->provider_driver.uses_vpn_agent = vpn_uses_vpn_agent;
+	data->provider_driver.get_flags = vpn_get_flags;
 
 	if (!driver_hash)
 		driver_hash = g_hash_table_new_full(g_str_hash,
-- 
2.39.5

