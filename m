Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618262777FC
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099640; cv=none; b=AvgOFF/XNgN5CxAcyHWOveae9/sn1WSZ5AwnOReIxqp78AzsImkzedzy6Pk1FeQYamglQ1Icg6e5OuINiXRZwSAnj+QQxGSR+rUDWNRpHWbgLsLoIRAXS75BVaOi0spIjZAOsKHtxhcfzVaut4xQiMzIRUN3PamR/ZfGZl4DAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099640; c=relaxed/simple;
	bh=NI4eBsxXqWzySbyJEOJhHddJH3+bcshWqDwCAtgJhIA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bh9FsBL9fDEc44JkUYLeLxw59V3GZds33AlTbBS4oU94rFNJbjwxvHJ1RzhWNpHrpEWFGASBukO0HRlVPJAFzhOja3NXBfE+XBCkgLb5tw33pS+YLuM23pHjB4Uj305GvCDGT5p2oD186ejJQIjbglhsA0ISc0IGN4VTazlhiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=eac7w7ZQ; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="eac7w7ZQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bxNNou3zN+/N3RQx1HCuSmBsyPWlxIGfVZiotHnI0Vg=; b=eac7w7ZQ0K0TEXoA09MdolWpo+
	xLA1acXXRoavjGelCyq38+A04Jnyiz3P4kB3Aw1up0lsk9AUiffSP/VU37n3jucu6NwoKYDaH51gF
	k3TH2ukqoF+IQPVEGPb35y9w7M67+A4RM4aS4kFW3CnmxgBQnhiEp1N00n9YACt+B+gK3oNX2BDe/
	KSMc7m3tYTZ+vao4vOBYstUMyxdjGcpT6zFtPzbURkLGiEoGToCIyIR3YmrLkU6Z8Vp/sZCBPnxP3
	nYfH49FynpmNp8+wEWrfbMdSKrWo/XbsfeB9bFgk3Ta+OadXTeuYvMtOYRZQa4ISpytdO6CCV5Kfz
	Q4jkm8Vg==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-11
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 08/42] vpn: Add VPN agent use flag for plugins
Date: Wed, 13 Aug 2025 18:01:40 +0300
Message-Id: <20250813150214.189282-9-jussi.laakkonen@jolla.com>
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

Add a flag that can be used by the VPN plugins to tell the vpn_driver
whether it uses VPN agent or not. Default to using VPN agent if the flag
is omitted.

This is done to accommodate the state transition in vpn-provider when
the VPN does not utilize VPN agent.
---
 vpn/plugins/vpn.c  | 19 +++++++++++++++++++
 vpn/plugins/vpn.h  |  1 +
 vpn/vpn-provider.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index 52f7cac7..ea64fdc2 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -800,6 +800,24 @@ static int vpn_route_env_parse(struct vpn_provider *provider, const char *key,
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
+	if (!vpn_driver_data || !vpn_driver_data->vpn_driver)
+		return false;
+
+	/* The use of VPN agent must be explicitly dropped by the driver. */
+	return !(vpn_driver_data->vpn_driver->flags & VPN_FLAG_NO_AGENT);
+}
+
 int vpn_register(const char *name, const struct vpn_driver *vpn_driver,
 			const char *program)
 {
@@ -825,6 +843,7 @@ int vpn_register(const char *name, const struct vpn_driver *vpn_driver,
 	data->provider_driver.save = vpn_save;
 	data->provider_driver.set_state = vpn_set_state;
 	data->provider_driver.route_env_parse = vpn_route_env_parse;
+	data->provider_driver.uses_vpn_agent = vpn_uses_vpn_agent;
 
 	if (!driver_hash)
 		driver_hash = g_hash_table_new_full(g_str_hash,
diff --git a/vpn/plugins/vpn.h b/vpn/plugins/vpn.h
index a8d24fc3..21cb2481 100644
--- a/vpn/plugins/vpn.h
+++ b/vpn/plugins/vpn.h
@@ -30,6 +30,7 @@ extern "C" {
 
 #define VPN_FLAG_NO_TUN     1
 #define VPN_FLAG_NO_DAEMON  2
+#define VPN_FLAG_NO_AGENT   4
 
 enum vpn_state {
 	VPN_STATE_UNKNOWN       = 0,
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

