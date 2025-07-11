Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A892E7BA0
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=YOVVUH77Tq0XlQKq6wYCSGxyBgi6UOOFCsLV2qb/9/jmGlzokgsFXuvpD1iGlPb+da1kEDDR58aHSZbTDookEruvKSvm0oYe+ihYN/iYBMFDjCdRgwXSXJ08Z9tHjySWnX8jvaK6fIL51qvQ1RG8KfJ2XV8hCN0YtD4ggjuA5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=Kt5XS2ZyL+M6mJ2oCairxyAwVJPs0Yno0/aLck+1c8A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9KUIVwyDnPCSGnFiup2Mt6rHym741II88GAX98rz0UdpFBlm8zy+UQ+2+2a4ugtT+6wTVHPZ8LM3HgYkQ2208ML/gHJXxbzG7jKjbFZBGsqQ0o8btrAmskqpL4FhUasOlCIA/uoGAp+Okh9UlrcMURywzghA16I6856kmA2SQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=OwRkvb1r; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="OwRkvb1r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KtaDy+iE8oaBMA1PzbKHPQVBiCoYWAU5MQvW++d+bz8=; b=OwRkvb1rZh4yZpDlVkZLi5fAx2
	7lsfdelcyA54z6ddgr2MTeu4WqV5Q3I5wpeMktAxDvmGDlaTSDS/U3DcR/T3zWwlbbj86Y+KEAYPS
	LROmrMXd2fOwjHDFp1N7I92DrtaEpEqPo2DPk2q2ZhPnkZb8OQWMSKb5MNLqPZj9TwtqHsOTZ7uaZ
	uv/fInOiF4N7WAH9P3KeR7u5Nw1NSXeZ92js6fMHEGE9RM6u0AhuyJU0g51oK9GNLFceqISKyZ9XG
	C+O+Pxxo2t/ZwAUsmCxXcZWhkUqcjAnobotuAMqt9cRu+Ov8NaLKJbaZpn7ETb6gbz5pEX4VYVu3h
	Y/zIaS+w==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-0c
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 09/45] vpn: Add VPN agent use callback for plugins
Date: Fri, 11 Jul 2025 17:27:00 +0300
Message-Id: <20250711142736.1757060-10-jussi.laakkonen@jolla.com>
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

Add callback that can be used by the VPN plugins to tell the vpn_driver
whether it uses VPN agent or not. Default to using VPN agent if the
function is not defined.

This is done to accommodate the state transition in vpn-provider when
the VPN does not utilize VPN agent.
---
 vpn/plugins/vpn.c  | 22 ++++++++++++++++++++++
 vpn/plugins/vpn.h  |  1 +
 vpn/vpn-provider.h |  1 +
 3 files changed, 24 insertions(+)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index 52f7cac7..2f87cf04 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -800,6 +800,27 @@ static int vpn_route_env_parse(struct vpn_provider *provider, const char *key,
 	return 0;
 }
 
+static bool vpn_uses_vpn_agent(struct vpn_provider *provider)
+{
+	struct vpn_driver_data *vpn_driver_data = NULL;
+	const char *name = NULL;
+
+	if (!provider)
+		return false;
+
+	name = vpn_provider_get_driver_name(provider);
+	vpn_driver_data = g_hash_table_lookup(driver_hash, name);
+
+	if (vpn_driver_data && vpn_driver_data->vpn_driver->uses_vpn_agent)
+		return vpn_driver_data->vpn_driver->uses_vpn_agent(provider);
+
+	/*
+	 * Default to using the VPN agent, in cases where the function is not
+	 * implemented. The use of VPN agent must be explicitly dropped.
+	 */
+	return true;
+}
+
 int vpn_register(const char *name, const struct vpn_driver *vpn_driver,
 			const char *program)
 {
@@ -825,6 +846,7 @@ int vpn_register(const char *name, const struct vpn_driver *vpn_driver,
 	data->provider_driver.save = vpn_save;
 	data->provider_driver.set_state = vpn_set_state;
 	data->provider_driver.route_env_parse = vpn_route_env_parse;
+	data->provider_driver.uses_vpn_agent = vpn_uses_vpn_agent;
 
 	if (!driver_hash)
 		driver_hash = g_hash_table_new_full(g_str_hash,
diff --git a/vpn/plugins/vpn.h b/vpn/plugins/vpn.h
index a8d24fc3..b24cbf9b 100644
--- a/vpn/plugins/vpn.h
+++ b/vpn/plugins/vpn.h
@@ -57,6 +57,7 @@ struct vpn_driver {
 	int (*route_env_parse) (struct vpn_provider *provider, const char *key,
 			int *family, unsigned long *idx,
 			enum vpn_provider_route_type *type);
+	bool (*uses_vpn_agent) (struct vpn_provider *provider);
 };
 
 int vpn_register(const char *name, const struct vpn_driver *driver,
diff --git a/vpn/vpn-provider.h b/vpn/vpn-provider.h
index c81476c6..8a8b6bfd 100644
--- a/vpn/vpn-provider.h
+++ b/vpn/vpn-provider.h
@@ -167,6 +167,7 @@ struct vpn_provider_driver {
 	int (*route_env_parse) (struct vpn_provider *provider, const char *key,
 			int *family, unsigned long *idx,
 			enum vpn_provider_route_type *type);
+	bool (*uses_vpn_agent) (struct vpn_provider *provider);
 };
 
 int vpn_provider_driver_register(struct vpn_provider_driver *driver);
-- 
2.39.5

