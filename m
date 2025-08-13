Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647212376F8
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098951; cv=none; b=p0lB4TaEkL5HC81Q7WWQdmI3mkuQ6zVnwyTAoVQtr3vsicrQuxuG0wOpHYhbAgTWnvrDKvqLso0q6/9Ci0suyYDdMLgIN0tDv5+X82d8lwj57T6yk+HCzA57w+Dvvkx/m8D+jgqMvV+73Que3GRVODx229QHC/UO+J+JdzOgusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098951; c=relaxed/simple;
	bh=2UtZqw/k/TIeM7PSCL/vgxQoSLd2PSGsuH2zUneac/E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KBkhmFRU0wfe5v77T8dVljY6Wig9ase8/9ZamC7WPHr1ZRMEpCkjcWrceBpcnzf9wAnsql5LuogXEXGD4dAKGNkPjENCpQ/X+6qRK3OwVxi5ATyhRXxOWgZLnMDxE0MUptAPNKaxes4U/sQ8SjkDLGS8i/X/o43KQ29VgxDGD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=xtnKXwbj; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="xtnKXwbj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tm+RWjEhLXn0tZT4eyXd7dRcGbmbMcDDLHKfurYDMSw=; b=xtnKXwbjgzYmZmVjFrKj/zg/o2
	O6JgJ38GomxbtK+MonLWVPB8wt/XNFfrCpATorva8Ir3Cbm8LrgHWJxe5ZWtf7ThqoDG2V2KHFYdI
	LARq/VSnVwTAMmd054KWCmAxyUWhNdwouG/F83+Fsw55MK8UBFVsJhP/GIPqT4l9lMDyBCXMPTu4G
	YhldQBGMmFMA+KYdYmNx1jZ38Aae41E7Mcgo9SuJSII/I/uIfIkkOuokJiJHHcN+e/trzRvbJP5/R
	W12lzq6DLTuBUn7XJPjY+LyPmXuxO2nPFhyhfD1Q2iDi3ktucMQQNmuRUwH31ieDtGjXt2QDaWyDu
	7a0W4TXw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-18
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 31/42] wireguard: Fix string list parsing and IP tunneling
Date: Wed, 13 Aug 2025 18:02:03 +0300
Message-Id: <20250813150214.189282-32-jussi.laakkonen@jolla.com>
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

The string lists read, for example, Mullvad config files do not contain
spaces, use g_strsplit_set() for this.

Prevent adding only the any routes for the current peer family to avoid
duplicates. This fixes dual protocol tunneling on a single WireGuard
peer, such as IPv4 server with both IPv4 and IPv6 addresses.
---
 vpn/plugins/wireguard.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 92a538ea..022055ad 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -147,7 +147,7 @@ static int parse_allowed_ips(const char *allowed_ips, wg_peer *peer,
 
 	*do_split_routing = true;
 	curaip = NULL;
-	tokens = g_strsplit(allowed_ips, ", ", -1);
+	tokens = g_strsplit_set(allowed_ips, ", ", -1);
 	for (i = 0; tokens[i]; i++) {
 		toks = g_strsplit(tokens[i], "/", -1);
 		if (g_strv_length(toks) != 2) {
@@ -294,7 +294,7 @@ static int parse_addresses(const char *address, const char *gateway,
 	int err;
 	int i;
 
-	addresses = g_strsplit(address, ", ", -1);
+	addresses = g_strsplit_set(address, ", ", -1);
 	if (!g_strv_length(addresses)) {
 		g_strfreev(addresses);
 		return -EINVAL;
@@ -631,12 +631,6 @@ static gboolean wg_route_setup_cb(gpointer user_data)
 	}
 
 	wg_for_each_allowedip(&info->peer, allowedip) {
-		// TODO: search peers when multiple peers are supported
-		if (allowedip->family != family) {
-			DBG("Ignoring AllowedIP with different family as host");
-			continue;
-		}
-
 		memset(&addr, 0, INET6_ADDRSTRLEN);
 
 		switch (allowedip->family) {
@@ -661,7 +655,9 @@ static gboolean wg_route_setup_cb(gpointer user_data)
 			continue;
 		}
 
-		if (connman_inet_is_any_addr(addr, allowedip->family)) {
+		/* Ignore any routes for this peer family to avoid duplicates */
+		if (connman_inet_is_any_addr(addr, allowedip->family) &&
+						allowedip->family == family) {
 			DBG("ignore any addr %s", addr);
 			continue;
 		}
@@ -881,6 +877,7 @@ error:
 	 */
 	vpn_provider_add_error(provider, VPN_PROVIDER_ERROR_LOGIN_FAILED);
 	err = -ECONNABORTED;
+
 	goto done;
 }
 
-- 
2.39.5

