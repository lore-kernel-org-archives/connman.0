Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265B2248B7
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745172; cv=none; b=RZDkOApjd0XqDkOAO+oFSdegC/KwMbsVIy7dM0+V604V4hmsUhtpRpuM8VcXwo4pLJDcLCX0Ww3fI9ML8JlH1ElE2il+tkEN/zY8NsJsIz2AinlLHJpXPtw1fRiKH4a6uQmy7DCAvInG16Fpq8cpthfZhl0alKWeAwW/7jFpgz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745172; c=relaxed/simple;
	bh=5aBTMweiEV1rJDms5JN2dwKLgjtvp2HFmrOHwhfJbrA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVDN/69hE76EcYU9+bzjOkLIVdzlJIr6vU2IGjQ0KRYL4NXRpLzuJD2s4r0Q3/c+T2kE6m+UgUfakxcQfSaYtRdo4nX+E5ATvLBzkojSP/Tld8q/CGu08rs0tPBxaEkT7RYUlkAxcCs2gV1kLh/9IxMDAuC4Wk/K75n7gPo0jsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=Y8mVWLpL; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Y8mVWLpL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=J4jbWXLZw++O2aKnqH2VhsFPT9rT1du4s9TYt7PbQjQ=; b=Y8mVWLpLCangxRtDs4GRGB03RN
	m30qtSp9f2YLk+aFaMsnyOfh0ztiiCqj/HDpnw1/0AvbooNqaKj6sJTbFTIf+NB11R7kP378CZZeA
	RY0SO1iMUYszspVtfKfYuSImVbm+5qLZBEM45yorKHe+MD7/w8SPVCr6iVJyuojegKC9dMdy5f7sc
	+eTc55v/IQ/WfF+eE9FKGhiVkviQhG4ktBlhzeS7GGkIkDQhR2irjhKGQV8YAqAgLNmvhizpCz4wR
	PhQ/1jYcPs97NfRZpNs54N5ZNogmnItjU0+cINeWzbVPzXpW4Dm1mXQHOkL6QuYxu01uBjWgKt0sp
	cMLZkC4g==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtq-006LTc-23
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:59:26 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 01/12] wireguard: Add saving of provider properties
Date: Fri, 24 Jan 2025 20:59:05 +0200
Message-Id: <20250124185916.1546471-2-jussi.laakkonen@jolla.com>
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

Save all provider properties to provider configuration file. This
follows the example defined in doc/vpn-config-format.txt
---
 vpn/plugins/wireguard.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 03658943..735bac58 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -50,6 +50,7 @@
 #include "wireguard.h"
 
 #define DNS_RERESOLVE_TIMEOUT 20
+#define ARRAY_SIZE(a) (sizeof(a)/sizeof(a[0]))
 
 struct wireguard_info {
 	struct wg_device device;
@@ -67,6 +68,21 @@ struct sockaddr_u {
 	};
 };
 
+struct {
+	const char	*opt;
+	bool		save;
+} wg_options[] = {
+	{"WireGuard.Address", true},
+	{"WireGuard.ListenPort", true},
+	{"WireGuard.DNS", true},
+	{"WireGuard.PrivateKey", true}, // TODO set false after agent support
+	{"WireGuard.PresharedKey", true}, // TODO set false after agent support
+	{"WireGuard.PublicKey", true},
+	{"WireGuard.AllowedIPs", true},
+	{"WireGuard.EndpointPort", true},
+	{"WireGuard.PersistentKeepalive", true}
+};
+
 static int parse_key(const char *str, wg_key key)
 {
 	unsigned char *buf;
@@ -462,10 +478,32 @@ static void wg_disconnect(struct vpn_provider *provider)
 	g_free(info);
 }
 
+static int wg_save(struct vpn_provider *provider, GKeyFile *keyfile)
+{
+	const char *option;
+	int i;
+
+	for (i = 0; i < (int)ARRAY_SIZE(wg_options); i++) {
+		if (!wg_options[i].save)
+			continue;
+
+		option = vpn_provider_get_string(provider, wg_options[i].opt);
+		if (!option)
+			continue;
+
+		g_key_file_set_string(keyfile,
+					vpn_provider_get_save_group(provider),
+					wg_options[i].opt, option);
+	}
+
+	return 0;
+}
+
 static struct vpn_driver vpn_driver = {
 	.flags		= VPN_FLAG_NO_TUN | VPN_FLAG_NO_DAEMON,
 	.connect	= wg_connect,
 	.disconnect	= wg_disconnect,
+	.save		= wg_save,
 };
 
 static int wg_init(void)
-- 
2.39.5

