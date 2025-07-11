Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D32E7BDA
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244079; cv=none; b=XeJ6IA/Sebe6/b/TU/SmGu8EKCI7Kgf1vtutwPtZoGqRg+WA5a8JaQbb2EVrshTfLTKlBdv4JJfSQTfaOSY0fUWaPZA77lCXgcMq/QP9ttfTpgQWGTLoPUljsqVnH6LvT98icuQu1Kb6w2yykzuV/SAG2BaKGCe2fk/ocIHGd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244079; c=relaxed/simple;
	bh=6Mlaczn74A6rMLcqeaSYeLzyovpg1dNpiUXZii41WFA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dU2hNaaIM+0w3DrAOuiSmRvBBeCVE/FYKpP+Z2eUxh7ZqkVC1I++nF7eBOgvmhgdW8Zra3XGcQhm52jJVaC0U79/N8YWqmQUegp/DZHhDgiO1XYZp3Jib7aNN3qsDWiDAEyyr183FcH/rnH+txdgxEDUuxBlKeKTtzKstF1OyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=g5Bwus56; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="g5Bwus56"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OFjm+yhhX+8ADhfyOcU/bdZFRFD40V0WubAkGeN8WDI=; b=g5Bwus56VHRRZ5E8YxBNuAgHW5
	T+UM71Q9r37+47VqBxWnwYqLkAVPQHZDO28I2PRO3jVmLoRs3zayp4B36aIkzmRyJ+Iy4WAp//FY0
	chu+12Jfm2ZIGZ6zKmNoRdIEAv03cv/U2ajLCtl72yzNO2T9ROc6oohjrKrvVI/mUkkDot83MFesy
	nBBB+fgodvA78CG67W5BLPcm5RTGrjeV4Lsgiks21BiwmW2mXg1KCmO56qTeG9jMuZeST1HMIDKoa
	Rp6Pcs/wLlwcPxYg/TZrMQtyd0+l2KWPpRZCO1xUKaRYyIAdLs/8DgkB5yxmKjCtf9C8VfNZLX/TF
	3oj2wtHw==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-0Q
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 30/45] Revert "vpn: Remove unused __vpn_provider_check_routes"
Date: Fri, 11 Jul 2025 17:27:21 +0300
Message-Id: <20250711142736.1757060-31-jussi.laakkonen@jolla.com>
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

This reverts commit 192696c5b032b0bdfa09950c43b569131315d490.
---
 vpn/vpn-provider.c | 16 ++++++++++++++++
 vpn/vpn.h          |  1 +
 2 files changed, 17 insertions(+)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index 7aa72ef0..ff81592c 100644
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
index 88afce45..01e9ac11 100644
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

