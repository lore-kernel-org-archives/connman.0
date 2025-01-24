Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A727726
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745266; cv=none; b=n00e1aOIieAR91X7PAigH45nP3nO+fEhNZ29E7if3bqrdqtWUhTFXhZPuH5grbKfPV/HY5le9D8Ik/7LQScUXa4q2vjauNr8oyN8qLk5k4umCE03hQQO9j55/3e6Wi/XzdXjpBX6nrfN9SkBmTz4DiLOTBJ6hXNZ1rsRyJsPHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745266; c=relaxed/simple;
	bh=L/dqWw2isTm+zUYZIvbzKqltKwZr3dVz1ATA2h5rXKA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uaFUqfbvQJJl7PvV3xylU1k2oMO1OLW4pzZO1FhKICnP6PHaM/tZCknigIAA0/FE0y3r8dChpENgqBSei2u2w64GXrmVXrGuJkdwisKIOxvr8tVbkKkqXlRffipkaA22Nqiie+GHr6cwIbrnCnLEcSI+S0jGjSdsrSZLSAwFl6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=jKGzsquQ; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="jKGzsquQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=S9mQnJoAq5lZGrDJ8XWB/87GXKbN7MAakqdjhejWuKg=; b=jKGzsquQ2iv4Uw21v01sFxZj/A
	UvCI7W7cV3E+1HRl//Xj2sZeyBr84X5m0Uy0KWOsl25IU/dMes99+oNpmFJb+dyejY7kO9vds/hYC
	BidH/OVU8zJygdgFmn0DltWUBd9Wp6F3yuJPeEZkf1wu69ZUXoiYzUbAJAdeXHUQAhEXw4BDuRh/t
	B07iHvQZcclpHYXUC4rG/ZV3VuYgmpd6BMUpVxo/8M7w8OZxZoC02IXsTmplxV97fdwmIeenRCwon
	6ve2nBsNdNEolpRtyEt/rwXHBejj/lS/xv8mFRmcX1xFH4feUixDKzLCWqvJgfefWtkmtaXqv9yLh
	WUb4fCAQ==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtI-006LIb-33
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:58:52 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 10/11] vpn-provider: Transition to CONNECT state with agentless VPNs
Date: Fri, 24 Jan 2025 20:58:44 +0200
Message-Id: <20250124185845.1546384-11-jussi.laakkonen@jolla.com>
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

[vpn-provider] Transition to CONNECT state with agentless VPNs

Set to transition to CONNECT state immediately after ASSOCIATION state
after initializing connection procedure with a VPN if it does not use
VPN agent. This is done to accommodate the full state machine
transitions as the VPN agent, when success, will do the transition but
when VPN agent is not used the transition would be required to be done
by the plugin.
---
 vpn/vpn-provider.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index 56040e65..b21e9e61 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -1653,8 +1653,19 @@ int __vpn_provider_connect(struct vpn_provider *provider, DBusMessage *msg)
 	} else
 		return -EOPNOTSUPP;
 
-	if (err == -EINPROGRESS)
-		vpn_provider_set_state(provider, VPN_PROVIDER_STATE_ASSOCIATION);
+	if (err == -EINPROGRESS) {
+		vpn_provider_set_state(provider,
+					VPN_PROVIDER_STATE_ASSOCIATION);
+
+		/*
+		 * If the VPN does not use VPN agent do direct transition to
+		 * connect in order to support the complete state machine.
+		 */
+		if (provider->driver && provider->driver->uses_vpn_agent &&
+				!provider->driver->uses_vpn_agent(provider))
+			vpn_provider_set_state(provider,
+						VPN_PROVIDER_STATE_CONNECT);
+	}
 
 	return err;
 }
-- 
2.39.5

