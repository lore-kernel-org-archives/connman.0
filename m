Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0023B63E
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098912; cv=none; b=UATHWt1cdr6BzA1IUsyvV/OO+nneY23XJISMzw1P+CdjgSr4DcGg1aDc48/8JDrA82afN1+qy71BbeRc3JcbeonXRNrjs4kvDHlAcHskzl9oIAEnJkq9sYI1CiacAtVRUt4sFPQOM5Gl9B+zYJOrg/XfgT0JzIAR1xYNm0UiQOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098912; c=relaxed/simple;
	bh=TIurnKpDubMfZv+/C8aLS2HHfwiS7CcZWFCxghaVgvs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tkCWo7jC5kBboGI7dQ4S9L1D+1+Tf7NErvE9xtY3r0gQCvyInGQz4AQcNmJzJEVh+6Vxx2Lov68AsTtaxYEWu5iTQC/s8NVbINAfwj8YMk0J14Ldopb//uOVfw6s2Q5s4NoQF4tMJSQTkfcxG+8H/++1HrQTMJBEJJqx8qnH1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=BZPrksJh; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="BZPrksJh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YCJKG2UKBr+pRfB2PcTrsqS4Ta1rsZWzgDH2CsJ3e0I=; b=BZPrksJhvIRmA7D3C9VnLD6kc8
	gMLTgUanWfWXe1zvfpspA+bi/ucyqy5RNff3XG8zN3KrqQ7TM2WOlYIi+b/NzefzKJ+2bzymnxtVa
	v32W472oxGlckNilWRVt+xyHYCQcNkdm29frEE0f7GDtp95fipWtRFxlHKDIZJGmhe77EE3h5R8zU
	eEv9I9nzbtJnfbxQS9oqJZJ3nWjD/b6CU8rsHYzrJCeaeKl7gy2bM/4jiFbeTlXaNOdQp2f8yb5FC
	E7dP/Zsnbb+YJzpi+rPH8+vLEhAvwr4+Pb3mBMfq75QLeeNhWQHp4TVC4fzTFSZnTjrI70Ab2LBvF
	FwZ9b3zA==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-2e
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 19/42] vpn: Check if disconnect is implemented before calling in stop_vpn()
Date: Wed, 13 Aug 2025 18:01:51 +0300
Message-Id: <20250813150214.189282-20-jussi.laakkonen@jolla.com>
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

Check if the disconnect() is implemented for the vpn_driver before
attempting to call it when stopping a VPN. Also cleanup the code a bit.
Amends changes made in ffec305c1c93301534144774fffebb25fb9c6c7a
---
 vpn/plugins/vpn.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index 8f04ceb6..047808b6 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -76,6 +76,7 @@ static int stop_vpn(struct vpn_provider *provider)
 {
 	struct vpn_data *data = vpn_provider_get_data(provider);
 	struct vpn_driver_data *vpn_driver_data;
+	const struct vpn_driver *vpn_driver = NULL;
 	const char *name;
 	struct ifreq ifr;
 	int fd, err;
@@ -88,16 +89,19 @@ static int stop_vpn(struct vpn_provider *provider)
 		return -EINVAL;
 
 	vpn_driver_data = g_hash_table_lookup(driver_hash, name);
+	if (vpn_driver_data)
+		vpn_driver = vpn_driver_data->vpn_driver;
 
-	if (vpn_driver_data && vpn_driver_data->vpn_driver &&
-			vpn_driver_data->vpn_driver->flags & VPN_FLAG_NO_TUN) {
+	if (vpn_driver && vpn_driver->flags & VPN_FLAG_NO_TUN) {
 		/*
 		 * Disconnect only VPNs with daemon, otherwise in error return
 		 * there is a double free with vpn_died() or the failure state
 		 * is overridden by changes made by disconnect to state.
 		 */
-		if (!(vpn_driver_data->vpn_driver->flags & VPN_FLAG_NO_DAEMON))
-			vpn_driver_data->vpn_driver->disconnect(data->provider);
+		if (!(vpn_driver->flags & VPN_FLAG_NO_DAEMON) &&
+							vpn_driver->disconnect)
+			vpn_driver->disconnect(data->provider);
+
 		return 0;
 	}
 
-- 
2.39.5

