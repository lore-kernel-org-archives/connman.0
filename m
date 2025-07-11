Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8D2E762C
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244079; cv=none; b=DgVNt2LpOD2Y2LVX1zzXImQzbo2GpIdSTmxrNPGi3nE+yUW2nM6plHoIMeLfi9gcu54qUt059FiLyCGJhOdlMEAihjv8CHfOKYuRl1qAJsJTGt8q35buJlk7g7VXtWn/kRM6EFmf2fA1dBiRneVKPvNG+XJJ/+nzWpsjicQiDzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244079; c=relaxed/simple;
	bh=5aBTMweiEV1rJDms5JN2dwKLgjtvp2HFmrOHwhfJbrA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owj00ia6jaqsqYwxsJmtWTJxVy+PhHMPdVKW6yI5PZKkU2cbuYwEmnD3uZkGHzr+JhHvWuKFp7h+Zi0UE5qEyeN30wZY8TG1vNhJzRlai8ktggTSYSsDOOa7PeXyrYfUIVQEXnhD3PlXmakDKKUvqLJQ9GE6LJNPO8pYCMKOsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=xlQindgT; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="xlQindgT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=J4jbWXLZw++O2aKnqH2VhsFPT9rT1du4s9TYt7PbQjQ=; b=xlQindgTlfmGYtYt0sqaoUqFkS
	/ZkUblO9AyZVgQVlj851DoxU/TFvheMcxpSCR69cqi7/tU77LrP0TwHJr/O4HEhHrNa+XjUZt/GpH
	EJ7qL2EDvwQ0sn++QEQcBAv69FDs9vNfcPdsz4PqaBLcpYRm7K85b4pH3M241G4hjwNNa3oztF1HR
	QvreCpb2mbFzT8yavOnfgE/1wDytaOsf0T1a5yYUpj7iHdZXLBpPlIJcpz6LwJjbO2Oh0brEUMKqG
	1TG07XZeU0eYx5/sQi1HycPf9bvMthytKE7mU5JRGFc2YnbDnmw1PDHaFiHu+jDjT59bAV7D5ymuS
	5t+qJodQ==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-12
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 12/45] wireguard: Add saving of provider properties
Date: Fri, 11 Jul 2025 17:27:03 +0300
Message-Id: <20250711142736.1757060-13-jussi.laakkonen@jolla.com>
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

