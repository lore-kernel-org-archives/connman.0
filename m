Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905233A00C
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435088; cv=none; b=CqawwxsudHvcxYeS28dmgYYtCfFNPquzmxwo0k2N3z0CIJD2X58rJ1banAOlYFXw5w1Pqm7we1XjG9/Dgdi9bZ4CWcAeLTRe8LGwNEWAL79Op35YTWk2jzfTB17GtmWl/HjyzMwgndFyPNsJ2GXgFOLo/Zj7ydkKrN6TzUTE8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435088; c=relaxed/simple;
	bh=q0nYKMTvHKcI2WJozfHUxTRTUy7u79Za1Qzmw4ojkXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSqGwsFBkijNRKmhmoqfr7g/qDDDN/5lKjntgGH5eaZ94NohYZrpevCNBNk/QzwfDjYj0dMXokdtAfPJXNToHizPe1imT/lttMsch36rIQ61rt3iQPoYZHuOgXiYqChJ1ziGL7kLtgFzFF/laCQxu7AEV+o6mZf5xbc+V71qnYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=d4j8d0c5; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="d4j8d0c5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aLohBrAfMKKZCSw6sM6lzB1JApDPtcUeIOVueH+MWIA=; b=d4j8d0c5QYVllha8uvlKwWjCo7
	HhiYLFGwUeyCNLfQS4mTVatr2/5oysVxNtr7KPolMpfjd7aPq9F4whU6IwLAa+oPS87Jl3Jjxuowq
	Q01UxaQPVQsHa2L86q5+OWk/oGKZMMlLacteoCfbeigb+YTz8QwZcTWksRZGArdwwxEFxxUE5lOG3
	KnvyKX3A3UCBdCEjjb/qn48+RZCmb+qhjA/B09jUdJv7eMg5YOgAMw/133uS1BvMHuSSLvvPliio7
	ovbm5kQXN5TEJZAqkLl2iyHcGx1auxZb/gE5VLr0clxWfrZ541xaaambdgQOTid1xv7DA2qLsiDef
	P4rkpUSA==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMtZ-00C0gj-11
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 15:44:45 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/9] vpn-provider: Change vpn_provider_password_cb_t to use int error
Date: Mon, 26 Jan 2026 15:43:40 +0200
Message-ID: <20260126134410.55749-2-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
References: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:4460:24f0:14b1:617b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

The use of this callback is in VPN plugins only, it is meant to be used
after the reply from agent is received. To reduce code and not to
require parsing the char string error message it is preferred to use the
vpn_agent_check_and_process_reply_error() to get the error code for the
message and use it for the callbacks.
---
 vpn/vpn-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vpn/vpn-provider.h b/vpn/vpn-provider.h
index 5d1455da..5c7ea5b8 100644
--- a/vpn/vpn-provider.h
+++ b/vpn/vpn-provider.h
@@ -145,7 +145,7 @@ typedef void (* vpn_provider_auth_cb_t) (struct vpn_provider *provider,
 typedef void (* vpn_provider_password_cb_t) (struct vpn_provider *provider,
 					const char *username,
 					const char *password,
-					const char *error, void *user_data);
+					int error, void *user_data);
 
 struct vpn_provider_driver {
 	const char *name;
-- 
2.47.3

