Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF0C23B63C
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099001; cv=none; b=f6ytKZTyFd1tJhiAhrOlzArtNrkmWUTRLcXKuZ0zaTL7YiRGMAAnbKJLVq8BU+7fXl123M3+Kve6b7LjSp2nbzVjU4oeMLImoo+TPVBZpoRxf9vyRv1pYRtC07MNnLCYmKzC1FM25u7Iu/y04HdOMEuuBxixdMLdgVtaivi+vHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099001; c=relaxed/simple;
	bh=agZTWC8+OcR3GdTQ/PgxBe90YgUFFtWwEDUYVfV1JVY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzHSy0kjVM3dVhJjdsxJjKJjDWhwcrd1QPRMmIotEyD3HX/bbUDIqqSSJkx4HRcJRUolCB9n9b1qxmhsO5yQnjEvZZKgDoyss91H7t5fq0cfunVpW3pg7OqYJD8lN8vub4TKfnkF6+/rQkdFozCm0UnKndcy6OOVy3wDGgewq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=aacUX2id; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="aacUX2id"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DBEV3OOOOLowG5qFeuGvl36EK7HWQ1+fi0BL7EP0iYs=; b=aacUX2idWE8LPP7t1mGEoe1Qw7
	0ATTvVarB00hEBoU9uIXlU67jLNGyJVjMMiUvMw7IRtdHki2P/YP4O15/lsGlgw9BnhE4AShC0szc
	KOkjYcgO24/aPa8j1zsuD9prNPVFJfbMIkvqL0QEnzLQuvzuIEtIR8XUySDnBFoQ2eHpwG1HN6sJf
	HTkwZSoVh4BpXWwPjZuygSXE1iQ4BaSSAsFafL9dMNjJOWtm5tgksvijgCnlXfYPY1xGkLp964qPb
	TMx3qG69vF489VCb027l7V+qJ/tTbrL4+9tyfL4Fn+0zrhj9IsLacTgbkuBJ1d0csVFq3ZnfmKLrH
	l/G3Zu+A==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-1A
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 09/42] vpn-provider: Transition to CONNECT state with agentless VPNs
Date: Wed, 13 Aug 2025 18:01:41 +0300
Message-Id: <20250813150214.189282-10-jussi.laakkonen@jolla.com>
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

