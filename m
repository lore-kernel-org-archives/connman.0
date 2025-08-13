Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690612376F8
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098955; cv=none; b=eKdVnp4egh/QSGmD2OhVfkJyNm2OJy7XtwCYsHA8ZcwylirKkKKsfkK3bMDlcUUGEcE/g73p3Ns8vTn4GhFh17kjJNJR9h7K8ZW7u1XltWrbpMlDdgN3bOI2eqtMgI9t3AasgCgO1Hpp51DUp26pjkaZocYYjCAEMveSzMLYOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098955; c=relaxed/simple;
	bh=k/2ZW1ry8d4VtWM7WUQ/pG7uIm2qS/uYcEAy8RQDW5c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gepRDl6YsPVpsWTZLmXuYVrqT+U9qpjeUldXa7LSciebKiGoQUIFpNFCE7GDS+QZqjC24b11C6DkFlrZGsryQbMhXKOOVNwnToZQTptYIijXClVd2lRy3r63p5w1y6NzJiqZin4C7Hp3uBV7Lpdluw7BELbsLHlOTRxpCZUt6EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=b1xSRHCz; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="b1xSRHCz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wncz0qPwWIpa//bnXKoTYl98LF1qFdNDbsrwsDBdtGk=; b=b1xSRHCz7NNEVLCfhEZWThnvbv
	rCWgIJg4ORpwS/pN2h+Wi7EePA7Z8qA4SZiAXYQo10HAt2z6sGjH5xVnreazr0yML/gHZiYJrghct
	cyNrMrBgGMt1WbBGIYT3mvLLrZKflVolnKQDmpdv2E/doHB9mMWAwumjvAkl+RKFNglCF3UGhRjiz
	ebGgIYsav/x7y8ayaiXjU47qzjjmBYWgEqudL4iothse1rtpc+RRvXvkWo8DUcoGCdaOEq35LhWYm
	ietGTSxm256B5zL4ifRAmB0GJ9PuyMFv+vgzTb+mpqFkzNY3W2QfaCp15eOGjglDi1HRyq9ACwFuG
	Y9PwgIsw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-2M
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 17/42] vpn: Drop state changes from update_provider_state()
Date: Wed, 13 Aug 2025 18:01:49 +0300
Message-Id: <20250813150214.189282-18-jussi.laakkonen@jolla.com>
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

It is not necessary to change the state in vpn.c for non-daemon VPNs
because the vpn-provider.c:__vpn_provider_connect() changes the state
according to the state machine. ASSOCIATION state will be assigned for
every VPN after connect, then depending on VPN agent use the state
changes either directly, or after the agent has finished, to CONNECT
state.
---
 vpn/plugins/vpn.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index 9ff2ad6c..8f04ceb6 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -556,8 +556,6 @@ static gboolean update_provider_state(gpointer data)
 	vpn_data->watch = vpn_rtnl_add_newlink_watch(index,
 						vpn_newlink, provider);
 	connman_inet_ifup(index);
-	vpn_data->state = VPN_STATE_CONNECT;
-	vpn_provider_set_state(provider, VPN_PROVIDER_STATE_CONNECT);
 
 	return FALSE;
 }
-- 
2.39.5

