Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4562E7BAF
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244079; cv=none; b=nNNuXCHgRM1UsAV0XA46UO+m5TthVjX9u/og5RP+wG5OdlDAwKbja4WbCBVrORuQ7Vwf37OfWvLNl2NlAhI+fB6o31VqEJXQGsSrjm1I7mDN6oJDcMBvbqSOuq307tSwkj/oS+UFN6U5j4vDfnDQYcvO8Srsn9xvys908eYIvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244079; c=relaxed/simple;
	bh=3u4lYJJWoN2cIWjyOSqLnQNTnxmclfeonw8/OtWiwrU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gfcfTBo2NXYNGKZ+x3IJtUi1Zkb6xNV33TE/VJvhDT68qvbZrhtns79KUYwyhu57Js9sG35GRDfdbMk98ngbl6M5T0zyUkcf+JVKO9/1Pz7sXj+/kfZwysdyT7Jd4GUuWi+CE0/lvPrtT+42VkPFQf02V1vxiABbjO4aK51jIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=R+uPZ2jx; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="R+uPZ2jx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=b7Z3hWU9KKqi1fJR39HaRz6mdh/rMN1eYKsXzuf7gM0=; b=R+uPZ2jxfPYJWx8Zxec0U9X7j2
	0PjjjmaoWlpw7mVGBZffBN2/wMdDSfQfTgnraB21ryRL6OmTGGX54zfcChR1TRSxPOqk7FTei/Jjd
	BE5IinzFVIW256jKuz9FHbDc/4jYq4zFvUhdUrzrEcscr+4Kmkq20l/OmvCB+W5FycXBBGVDkO9vE
	/Dj0Nck1/evweOArbITRk+pgql6tgnBffNcnYQK7yBKwpo8HCgF6e9RB5Dn+0O1HS3At0uTTnnWY9
	NRyiTko02QuA6QIcDWnjq/dbiBd9gFB3hxYSD4Icp/g839vB0uDGBZBM7C9rgJLjultl3RGKbGWDr
	H0SuIT/w==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-21
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 19/45] vpn: Drop state changes from update_provider_state()
Date: Fri, 11 Jul 2025 17:27:10 +0300
Message-Id: <20250711142736.1757060-20-jussi.laakkonen@jolla.com>
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
index 81a62ff4..2651d4d0 100644
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

