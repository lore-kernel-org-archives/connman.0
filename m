Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD52E7656
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244079; cv=none; b=bam9QSeNdHEaCJdhB/k0X5kDphtXt7mN4mVdolsV2NeH0g35ZcrTg/KIe9ZF3FrVHhhpS7sNMg+sGj42MZuc+pf42zds9HHO6oCtFwevPTZ0S2KajyKN/MTc9Dds+am3L1McQikEWlxJskcfyAAvi27RF47BjnZ5Wu1oooA2LyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244079; c=relaxed/simple;
	bh=agZTWC8+OcR3GdTQ/PgxBe90YgUFFtWwEDUYVfV1JVY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHbknnNrUZjemPU9dUUmixcDJn9cIWKVZwAuGcvvzo+/eytxFssDlfqDovy4dW1PtRHPOL0SAr+5R4TdFEnbZyC+AGHGgI5XXAa+v6FsyYMXPY3zNhOGLT+9L47f8Gzyd6tzVTqAhIAZFQ44EqrGOSB28fG+zQKlc+29+LEklQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ZoY3X/eY; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ZoY3X/eY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DBEV3OOOOLowG5qFeuGvl36EK7HWQ1+fi0BL7EP0iYs=; b=ZoY3X/eY1/2VrqQBXT1enZrutT
	cqy7S9DZck85r3x2LW1JQ5ocgIixr/zD28cZfmO55I03VYz2ID20rtZw3z3XgEN4fXY90v/kfNFty
	wXKxLaho7C2q+0WfUtVamRA6v5w1Ic3i+722XkGtVfjF9qK9U1zJt5xisjIn0UgOa6K8LsuPdzYgn
	l6Kz6q0FWgSvdfQNjILjF866ILJVxEWEkf9W6t/P72sAZE4hLScUtC012DV1QuGgZZhEDuPMsXY0i
	p6e7L5h2/Dt0U1YtRnfKLTVs+zHSXDd+wXFb+iDIiz88rmP3+b089O3UzoBPW7a9RogmCdfhtTSCk
	b1f7xkiQ==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-0k
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 10/45] vpn-provider: Transition to CONNECT state with agentless VPNs
Date: Fri, 11 Jul 2025 17:27:01 +0300
Message-Id: <20250711142736.1757060-11-jussi.laakkonen@jolla.com>
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

