Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE702E7F34
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244078; cv=none; b=cq+3JlaGZLib6HMj2Ujuhufvj/vj8mFNRqCOkHCGIIaG8JZi8HncEu6fNp8WqJoCtBL0NfFrNT+2i11oqRgDHhDh2EhpggjNWWA0bWgSDEPwD47Ofvo4sc3NwRmTqHzqg50nyijuKzRnlOy/2xG8Bsg36IS5FKP+pp12wMVNiG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244078; c=relaxed/simple;
	bh=IY/VuegZTD2xiULVHBvKrRdv4Y3dFLRGB3i/lwZgSzQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HH/7IiVn6TT39P6pRNHxnxeJNFvgLpfi9dtspk5FoFWoiWggXd5DP8CFHz8igAU25ztAXT6KkUEK5mfwQ4A1nckQCmaXtMthdq/c8SZutfuXDTm8zFdz08tVRzGrwc2+OwLo2AiHSucHC5semnhcM7y3jbyWpG4NXb0ChwcRoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=fAJdKVJP; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="fAJdKVJP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wXexJ0c6M4ZHYmCXMUqMC2NeAATUIS+4POl8HXX3Cy4=; b=fAJdKVJP7W9+tCayl+POVn2VGF
	9y/wI1oG2tSqscfOuQYtZ7VtfuVQ8t615cntDx4P8l5gbxslYMzPrFMzOW2y+nAHrgCER/96gvPgl
	NAha5gr7hWNua0zm4NLMzzWuvyuQXcBtUD01yBGFW7vMzSX/DVR8O+cfLCJ6JY+rjtHxCAHoxQscz
	Wsy4ifjYVJAWj2mr0jRAa2Xl1t6QmgSVNV16Garq2t6MZhqOor1FSG6qGnLBHoJBuwXTLTJckexFq
	v9MTKS7k0/E7eNNA7Sf77uXQu8BYYCSZQh7g89zROYprOBDGE4HgKAl5gOhipl2XThG6w4h/a1IMR
	BH54/AXA==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-2b
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 45/45] provider: Add the VPN nameserver routes when connected
Date: Fri, 11 Jul 2025 17:27:36 +0300
Message-Id: <20250711142736.1757060-46-jussi.laakkonen@jolla.com>
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

Setup the routes to nameservers when VPN has reached ready state, i.e.,
connected.
---
 src/provider.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/provider.c b/src/provider.c
index e790ccea..613504ff 100644
--- a/src/provider.c
+++ b/src/provider.c
@@ -323,6 +323,10 @@ static int set_connected(struct connman_provider *provider,
 			provider->driver->set_routes(provider,
 						CONNMAN_PROVIDER_ROUTE_ALL);
 
+		__connman_service_nameserver_add_routes(provider->vpn_service,
+					provider->driver->get_property(
+						provider, "HostIP"));
+
 	} else {
 		if (ipconfig_ipv4) {
 			provider_indicate_state(provider,
-- 
2.39.5

