Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A282E7BC1
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244076; cv=none; b=Khvu74e81yXPM4vGdfro/ywb/d4OIDMSaUZTQpIL3QryXcaF517kpCiduIenKwSsPg/j7okb99L0Upr0CV9W68BmkHWYcj4iuyI0cM3Q8anm+qfRwuVHWAt4hDh/Hfy5P7DZFMnJygH/R0SDPPZ6n4dCMDGcRevdpMWQps6DGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244076; c=relaxed/simple;
	bh=8TPmbV7Z5kN+jSqxsZDMc3GNZxlIQdUjytg3G7K2l/U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avmwTxFon2WHV+tmb5cQ4APfiHYSAHcvn6j6evk5dhpoNmbVpGjazqjUVb+Xhe1HMi/VCByh4RB0T7u40fMSUafIJ9oBrwSX3dNz7t7ho3nVdpEfsQWElkrER/NCb8uYB08kxknIuwmDoilZq3Dp3FlBDXlPCuee9yKZBsgh+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=hE2My6FH; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="hE2My6FH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=o47jM5puqWRahwjALk69en7oGhX1/t29HZdlnsjnjlY=; b=hE2My6FHadAPycg4cZ6dU6B9nP
	ZbOx9KGf2r1G6vlgNGHt1QrqNrp42ULhRdnYUtu9LqvanqW6u6Djw4OhxD5S4a0lx8fYMdK0iEPLs
	/w+sy7xQBaDKD3n1wzMiuYFH4TJpeQildC+TD8o1fb7OVevo1d0r22B7AmxKcVnlqV2QaG4zk+XgI
	KAKVpO55EegKraG7m3h6zlL6AxofURdg9v6V/mzo+YJmnTAc8wuwJxTc8zdCq0K5179dgpLqRRLyl
	57jdlbDno5gMKC5FlKfc1khPwUDdp4aZQDt5SdsLrV+gppUM+RLOlOhdgkO7IEAFYIvT+dL/+xyqF
	H9eHQjgg==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-05
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 28/45] inet: Expose __connman_inet_is_any_addr() for plugins to use
Date: Fri, 11 Jul 2025 17:27:19 +0300
Message-Id: <20250711142736.1757060-29-jussi.laakkonen@jolla.com>
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

---
 include/inet.h | 1 +
 src/inet.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/inet.h b/include/inet.h
index 5b2015ed..b7ea0a9b 100644
--- a/include/inet.h
+++ b/include/inet.h
@@ -39,6 +39,7 @@ char *connman_inet_ifname(int index);
 int connman_inet_ifup(int index);
 int connman_inet_ifdown(int index);
 bool connman_inet_is_ifup(int index);
+bool connman_inet_is_any_addr(const char *address, int family);
 
 int connman_inet_set_address(int index, struct connman_ipaddress *ipaddress);
 int connman_inet_clear_address(int index, struct connman_ipaddress *ipaddress);
diff --git a/src/inet.c b/src/inet.c
index 54c283ff..e9006e2c 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -466,6 +466,11 @@ done:
 	return ret;
 }
 
+bool connman_inet_is_any_addr(const char *address, int family)
+{
+	return __connman_inet_is_any_addr(address, family);
+}
+
 struct in6_ifreq {
 	struct in6_addr ifr6_addr;
 	__u32 ifr6_prefixlen;
-- 
2.39.5

