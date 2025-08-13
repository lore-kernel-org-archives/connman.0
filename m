Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6F242D6F
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098905; cv=none; b=sOtZjxoMc5YhettXtUi9jZa5MsgYildRGdaUe691yk62siCe1hus7MoDFx+VM/7dYB4RC9irCMx5qhgXaL6oSTdZyWyp+UmmLfZsUj18lHQ6040rY9HredpDSmpOjz3iccpqULes0Kd0nlMJ0W/p7iMWYlhR/oUQ5EjcrvgwvM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098905; c=relaxed/simple;
	bh=ICYYuuPj/zuQ1Ht//NgSPnd+Tu6wKo3XXhu3Zzh6Yaw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ihgk3gs91ODdYk2QoTTRoX9JO0oXAFtk1axj8YbHXvVLPylkbk+x3lGCf5AsR/xS+a2YTVZGAkcnF+xMjZzwvw+8VdTjuVMHdLNaYNoJhG8bWhB+2fKCQerp+rb+kiefk30LaSb+N5FYA2+6jhjuVKlnhYlnCF6S7wxgOK1j5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=N10DvfSg; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="N10DvfSg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YChC9H0UkSu0wzQXN/NgDo2FJnPUaeTfvbHFF0iqsEM=; b=N10DvfSgcmwy8Yjhu6pwB09hLw
	4faQqFSYgUymQC9cvdhbfvOj53+sEmG/W8bIlmj+QbtbdgvJrQq5rud836DMA8v5pVbcF20oRkCSC
	hCuos6K530Kz883k7O1BOwO5zl02aol/dXMaZY+t7tdWyOKqNj05ZmLNEBabYnaX7yvMqIjasU1Em
	amsJUF+OUS7MHQOCQ/3uwsEtbvRMnk+scFpBtymoBqUPUqbxEXVq9lvKg1b2ITtJhyKfWeuOmJ9Kf
	eY3Vu7JGZC7mQDp1CvR47wj8BAdGjjAx587rU/ZjAAfjREE4KFmxFcXlpT9KNBa2w+20DG++ZFTok
	gutmrU2A==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-0Q
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 26/42] inet: Expose __connman_inet_is_any_addr() for plugins to use
Date: Wed, 13 Aug 2025 18:01:58 +0300
Message-Id: <20250813150214.189282-27-jussi.laakkonen@jolla.com>
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

---
 include/inet.h |  1 +
 src/connman.h  |  2 --
 src/inet.c     | 10 +++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

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
diff --git a/src/connman.h b/src/connman.h
index 1a8952e4..7952fc13 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -172,8 +172,6 @@ int __connman_inet_get_interface_address(int index, int family, void *address);
 int __connman_inet_get_interface_ll_address(int index, int family, void *address);
 int __connman_inet_get_interface_mac_address(int index, uint8_t *mac_address);
 
-bool __connman_inet_is_any_addr(const char *address, int family);
-
 const char *__connman_inet_table2string(uint32_t table_id);
 
 #include <netinet/ip6.h>
diff --git a/src/inet.c b/src/inet.c
index 54c283ff..81d198b3 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -232,7 +232,7 @@ static bool is_addr_ll(int family, struct sockaddr *addr)
 	}
 }
 
-bool __connman_inet_is_any_addr(const char *address, int family)
+bool connman_inet_is_any_addr(const char *address, int family)
 {
 	bool ret = false;
 	struct addrinfo hints;
@@ -1687,7 +1687,7 @@ int connman_inet_add_network_route(int index, const char *host,
 	 * since given IPv4 any address (0.0.0.0) equals the value set with
 	 * INADDR_ANY.
 	 */
-	if (gateway && !__connman_inet_is_any_addr(gateway, AF_INET))
+	if (gateway && !connman_inet_is_any_addr(gateway, AF_INET))
 		rt.rt_flags |= RTF_GATEWAY;
 	if (!netmask)
 		rt.rt_flags |= RTF_HOST;
@@ -2145,7 +2145,7 @@ int connman_inet_add_ipv6_network_route(int index, const char *host,
 	 * NULL or IPv6 any address should have the same effect.
 	 */
 
-	if (gateway && !__connman_inet_is_any_addr(gateway, AF_INET6) &&
+	if (gateway && !connman_inet_is_any_addr(gateway, AF_INET6) &&
 		inet_pton(AF_INET6, gateway, &rt.rtmsg_gateway) == 1)
 		rt.rtmsg_flags |= RTF_GATEWAY;
 
@@ -4496,8 +4496,8 @@ bool connman_inet_is_ipv6_supported()
 bool connman_inet_is_default_route(int family, const char *host,
 				const char *gateway, const char *netmask)
 {
-	return __connman_inet_is_any_addr(host, family) &&
-				__connman_inet_is_any_addr(netmask, family);
+	return connman_inet_is_any_addr(host, family) &&
+				connman_inet_is_any_addr(netmask, family);
 }
 
 int __connman_inet_get_interface_address(int index, int family, void *address)
-- 
2.39.5

