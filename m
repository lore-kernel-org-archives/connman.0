Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227027726
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745172; cv=none; b=iZ5TkiEbazSVxwgwR/B+cw9BvEpMZJMiQnQQj2NrJOcYEAMmuRySYFsPh6dc9R2ilZoD4g/9nEEPJYvVZtNx2fF7EEhxaSqf+OAsyXcBxZg0K1c7w8sJcYdKmPcrDcG8VfY92GuRKQL7JIBfSzIo0s45EP1GeT25xtR338lgXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745172; c=relaxed/simple;
	bh=O86GMZZs4I/T71fJgzvpFcTa7Q/8PC0zDSDOAO+BkDQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIfUVO5Kml2RVINOTARUykjqD4yMuRvQPF8Y9CWYkfUKIb4rloXwDF8/cvFGNbQ9hBtFjeFFHxEgqfABvR91nTOKkHl8EvW/xkC1ol4tDiEEHCWt5wYeTRW0Zftmh9l7DUULv1wg36EWVWElLv8PSVUpEAzJQ1BZDlCJoMgDkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=VI/PadPS; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="VI/PadPS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zN+F6HNz3oxAc5t5CI6kUULAfxSD05D6d/BAmbOGbgk=; b=VI/PadPSI9uyi9CtDnqpv7F+Gz
	S6zEKzb4R9msLXzdT7RxvBVcnt9G2ekwGByJ7wFjghoSqsdfbAg3KRfuxAsxjbOLamOMlJvFLqHdJ
	ehnoR6LHfy8arIUmZJTZ0WXT08bwbDBrGvOvnstu3+62FdGhTT8X+Wyp5DsFumrhhFo7E29QU4Atm
	TjcuddYRqlhwXeLyp0u7bVJQ7G1fdhVh8x9dmct0PIeF2mEWJ+YGYY9pqSvXUeSftVVKDqAd8RQmH
	wL1eYN8a19s0vrF+hoZf4g/3SAgfaucebAV+ya8RWCUjBZBp+dwmvskBDxAWDQa3euei45YhecAl0
	/KOo98Rw==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtq-006LTc-36
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:59:26 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 08/12] vpn: Drop state changes from update_provider_state()
Date: Fri, 24 Jan 2025 20:59:12 +0200
Message-Id: <20250124185916.1546471-9-jussi.laakkonen@jolla.com>
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
index d963b985..18ec7ed3 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -534,8 +534,6 @@ static gboolean update_provider_state(gpointer data)
 	vpn_data->watch = vpn_rtnl_add_newlink_watch(index,
 						vpn_newlink, provider);
 	connman_inet_ifup(index);
-	vpn_data->state = VPN_STATE_CONNECT;
-	vpn_provider_set_state(provider, VPN_PROVIDER_STATE_CONNECT);
 
 	return FALSE;
 }
-- 
2.39.5

