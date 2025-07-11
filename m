Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2662E7BB9
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=Qz7FKVcymTam9VhpGWPafiQ7/bR8YQdYZNbPHW0hnfMsPNottDWEDS5+Zsap52ZXqvnfnDkfJJEHeRTTr/lnkWYUfRY3Vz8jqiucr9AgOOcHA7fDqAW7J9ZKepVAGL1UU4iFPEJZQL+bD7O77f6DEkumrV6YbdTyhvuE0v6qJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=eJB3OCqTMF1oaTuYLEUHp9HXYBjJiCQvpGh88MpqPuU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HchOcynyYkfjaUkSE8t2JMHtFr1vXmo7gLSakXG5/EhPs5WoDVwaJp7/Ek8zBvXBvpOfuMFjRMmJWE23ZtaM41LoRKm4YP0nyviOEsY8OycyBS6tiAxDHMvJ3V9DxC+v3zfSJuWeNjX70fyjXSnKIkVw1qfZIBAYQMfKLn5MMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ZT+8dmLI; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ZT+8dmLI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OeANa1pxLY3ibDiDRHvOGGvGqIOH3+14SD79eZkrKMc=; b=ZT+8dmLISyj67f0aQhIK3WfjfI
	IjaSCzpDLFER9TlNwEmxbGAB1qTrKi4rvJ5i0gmZqFys6T6LFGz534hPZ5Iggo8pYUH0zkmKfw7Wy
	bNtCA7JIQcyFNqMfmv6NEt2FFVauyauIvGmEnz0PRGvaEcF/SIq2COwkaAkyR8JzjdMh6/gFQyD0p
	wPbX/RJo/LrKBhL+Bj2E21m5UV2wel7EkI09y84dld2wG4t3/hspM2/pww+a9+UjZn7jYC+kcP20A
	KmQcOKaRmzS9Nu0u1um2Yj5qDJXblSuhVJrgUWI/cIqESeleGmua1Fs7b0KoMBfv1piixhfVxUrAh
	+Ms/DqdA==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-1U
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 37/45] vpn: Implement getter for the flags set by the VPN
Date: Fri, 11 Jul 2025 17:27:28 +0300
Message-Id: <20250711142736.1757060-38-jussi.laakkonen@jolla.com>
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

Allow the provider to get the flags set by the VPN plugin. Add this to
the updated provider_driver struct.
---
 vpn/plugins/vpn.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index a6b738b0..d06473d9 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -830,6 +830,22 @@ static bool vpn_uses_vpn_agent(struct vpn_provider *provider)
 	return true;
 }
 
+static int vpn_get_flags(struct vpn_provider *provider)
+{
+	struct vpn_driver_data *vpn_driver_data = NULL;
+	const char *name = NULL;
+
+	if (!provider)
+		return 0;
+
+	name = vpn_provider_get_driver_name(provider);
+	vpn_driver_data = g_hash_table_lookup(driver_hash, name);
+	if (vpn_driver_data)
+		return vpn_driver_data->vpn_driver->flags;
+
+	return 0;
+}
+
 int vpn_register(const char *name, const struct vpn_driver *vpn_driver,
 			const char *program)
 {
@@ -856,6 +872,7 @@ int vpn_register(const char *name, const struct vpn_driver *vpn_driver,
 	data->provider_driver.set_state = vpn_set_state;
 	data->provider_driver.route_env_parse = vpn_route_env_parse;
 	data->provider_driver.uses_vpn_agent = vpn_uses_vpn_agent;
+	data->provider_driver.get_flags = vpn_get_flags;
 
 	if (!driver_hash)
 		driver_hash = g_hash_table_new_full(g_str_hash,
-- 
2.39.5

