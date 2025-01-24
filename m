Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240427726
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745240; cv=none; b=CQloFNkkZ0T/HzvfE43ovPAFyxA6a///fpchrC3gzxG5W4QbnPWqn3GpV1/UFJ75a6M1sebPTZd+W6L2+c7anJ7oLtNkwf0kSV1wBDfRwQmEhShABmicwIhIlGXzRA6iL4NFoAdWjMFrZMDlxByYFkvGerrBH7wFtQKV9SdxVvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745240; c=relaxed/simple;
	bh=DkCIUnUHkW1xpACS/pwvc7gSvXYJrp+DT2AiIK08uMA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Da5EocsSviQdOStCXuw9evq0u/QxW1cVobZ4RbbatwHyrE0B+/1QrxClTiwhItcgv2U2inzHQ7RP1JzAMC9mnPMt2jcs4sle+fuGlFCygjEMiBJkJo2vf0l+KUlXGWlZmD/ZXRwatyUbFg0m/sgsE3br3/wYq/IQ+H30tNqX+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=RAkQk2ln; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="RAkQk2ln"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=x5PJqjtYAU8EoXJ6DpsjyXB2faSiX+JTvIU36Cpnx4I=; b=RAkQk2lnQYBvX2xBLzM6lCw2ue
	Q/zeiUgOYAM4W2pl6F3XXdg99s+wcG7jaJtpTG+OdQg4UAWYSBa5/gLhrqfW69g0+z6khc81qmtts
	a2wL4hBUq5EBgIIDBmdpHQ3yhxwMquM+13EjnjOnz/3ssIn4kb1VhcziWnUO3iEQq2iUQMOd/jNG2
	MkVsENbLtwpAbhVdJTbvjWIR7SB2vBMN7/NwosRbo2nm9w0LB4r9WpeyNhEIDEmoJlSnaFuZVnJJz
	bBXkeQ3ncY7+qGNpQthz4ffuuTg7cjTM1grApiF7aRKUo9pmYy5ObS0NrCJVgkZa/Yrr2cI4tMkcr
	cAp30xqA==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtI-006LIb-2u
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:58:52 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 09/11] vpn: Add VPN agent use callback for plugins
Date: Fri, 24 Jan 2025 20:58:43 +0200
Message-Id: <20250124185845.1546384-10-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
References: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
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

[vpn] Add VPN agent use callback for plugins. JB#59447

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
index 5cc4c757..b55b1222 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -797,6 +797,27 @@ static int vpn_route_env_parse(struct vpn_provider *provider, const char *key,
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
@@ -822,6 +843,7 @@ int vpn_register(const char *name, const struct vpn_driver *vpn_driver,
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

