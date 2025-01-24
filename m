Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925742248B4
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745171; cv=none; b=FLbrp9nN0OpdlkBM2AVjJ5k24tLXW/h9Y0sbsAHzjhS2/Zv6k9ODI6d5gEgzLwrreszgzBNnGADs618Badv6b90ZwFUf0yYjLEuEpqoGw/KL+wdUhZ6FL5RFde/31bmrCRtQP2gQFqkwa7uMtoURI3d/kfTARlOnpP0072pjmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745171; c=relaxed/simple;
	bh=/mw3fnbkOwLA2+fFtxioe+3h1hdSNPceu4E+phSCe00=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fW97QS/QvpHl1w59vbbMsdUncvocEcP+OZtVeGdAB0Qe7JrTM5RXG4YVLuSqlM15SigBPbs1TZpVHLVy24waLDhIr+FXi96PzOvZuL19K9Fvz9nrcQcz+rgt+IDVAFWZdGW2d+X5HDs7kFmVdpuATjOs4XE1k6NEpUoTKPPfBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ueNOCv0d; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ueNOCv0d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=51PFvVzKehKDalSmdjqxXpcfKI4pu9Af+uC3o36wgWI=; b=ueNOCv0d1Zaj336LWll6ejfeIS
	viRa3s0Zjf+OPHbLlpm2TulRXX5knSOTzzmi6XJJwJVA7H+BJF+qoI23lGnr4yorevgfAIHf9Ahnu
	5zI/oFB9v4fWPhEFdLQfuhBhYLzCGiai5bepm0FGAorwuuczGvgehATCZmIqbUSenaaTnjE/q+MEu
	HjG6iD1x+oMinWmYliAsVPloTnByMCZqssQzWqxV+L4oxBLXZyIlXRJubEmyt7E5H0EnXykfjQjBJ
	KDHcIssWNdE1Uh6sAZIOnE+RxDKe6hA8mm/xIwVZ48gAt8CBwOsW6dnhiMDxnN/RZlxjNwteoX8V1
	BIfsCi5g==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtr-006LTc-0A
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:59:27 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 10/12] vpn: Check if disconnect is implemented before calling in stop_vpn()
Date: Fri, 24 Jan 2025 20:59:14 +0200
Message-Id: <20250124185916.1546471-11-jussi.laakkonen@jolla.com>
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

Check if the disconnect() is implemented for the vpn_driver before
attempting to call it when stopping a VPN. Also cleanup the code a bit.
Amends changes made in ffec305c1c93301534144774fffebb25fb9c6c7a
---
 vpn/plugins/vpn.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index 18ec7ed3..16d11b4e 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -75,6 +75,7 @@ static int stop_vpn(struct vpn_provider *provider)
 {
 	struct vpn_data *data = vpn_provider_get_data(provider);
 	struct vpn_driver_data *vpn_driver_data;
+	const struct vpn_driver *vpn_driver = NULL;
 	const char *name;
 	struct ifreq ifr;
 	int fd, err;
@@ -87,16 +88,19 @@ static int stop_vpn(struct vpn_provider *provider)
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

