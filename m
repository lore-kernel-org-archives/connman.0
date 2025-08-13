Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876527EC80
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099622; cv=none; b=QjNPiAi+x/u7A29vsHlynHsx53WSqNNVzentFPXFCepAdsIpw74AQWc5nXwFUN0avXsAYcV5mWWDBS0rnAxxjRVVzsuvg+SmWYMaUoovnu8RKOeDOT+S+q6ud2cVAK/6SUZbKH1dQTWRQIwOYn/4ZaFQ7Ln3NoFVOJ6lG8REY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099622; c=relaxed/simple;
	bh=Q9O1V/gmG5iWb9ftTPDKNUeUMaoGOT5ZqT6fJq81O4k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SvoNJ9Jc2Ha/Ii9thJq48dNqnCcKGxMJNYkiZTnm8j+MByy1iQiJKbu8kW8hH07VgWfGphZrIs91IL5SN50DH8VjVbAp5jrtk4ZABFZUIXqXX9oVceLLghks7nfQ0NJyiQzoqST41IbzW/yZUx9Ch8h7fd0itDpjb4kMVV8KKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=Gf+mkdQx; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Gf+mkdQx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FDic0RIXYalTeGFEIdT4fZDNo2GaSOpv2kWMqr21k5k=; b=Gf+mkdQxHQJnmiW7gQSzgth28F
	z651nNqPvQKUE2bFvupyt3P2Bz5b2SvJJRGsQmWxH7u0WI7e4j9R9HhkwyaJ6fLwdSka0MkWe26JJ
	z1maz+mWwzQzkXlCLl2HUSoMhpdf2fvG3uRem7ePNeFb+PTs6V5ehCuwYpXRjr3E25DzkChzXiGYN
	I8nQ0/GPo/NbyJBv2LufDi0XNvEStDUd+XQeF3oOSaUdjY2go2coEt6O0y0hMnIaPEnojRthVH2re
	XaoCMA6E97Jzy3/S3E/kjNpU5x/yVyPctVjhhwN9oPAU26+rHWiFewLXffNOwBvMJnFvdByR4SmHa
	hTWhyQ+Q==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-1z
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 37/42] vpn-provider: Delay connect of daemonless VPNs until connmand is online
Date: Wed, 13 Aug 2025 18:02:09 +0300
Message-Id: <20250813150214.189282-38-jussi.laakkonen@jolla.com>
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

When the connmand state has been queried and a daemonless VPN is being
connected it must be connected later when online state is reached. This
ensures that if the online check on connmand transport is slow, the
daemonless VPN will get connected when state changes.
---
 vpn/vpn-provider.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index b81e3df4..966866b9 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -920,6 +920,15 @@ static DBusMessage *do_connect(DBusConnection *conn, DBusMessage *msg,
 
 	if (!is_connman_connected(provider)) {
 		if (state_query_completed) {
+			/* Query done but connmand not online for daemonless */
+			if (connman_online_state >= CONNMAN_READY) {
+				DBG("Provider %s start delayed, wait for "
+						"connman online state",
+						provider->identifier);
+				do_connect_later(provider, conn, msg);
+				return NULL;
+			}
+
 			DBG("%s not started - ConnMan not online/ready",
 				provider->identifier);
 			return __connman_error_failed(msg, ENOLINK);
-- 
2.39.5

