Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3642E7BC8
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244079; cv=none; b=IK1plSPvNg5n7XCIfZ3RBkGLgh3nVNWEJlr+ENnSA5uEsBi/xQ/y8oep2RfR3/PQoxLTsf8iv1bQgtjTuZvX8BoakX5OQZ12Fc2zGoSMw6GN+BGyzrLfjDhISl5RCz6Rozer8mjjJElCQ7NwKdS1k5JTNkpK6uc4HqUKb6GIh9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244079; c=relaxed/simple;
	bh=ZVs1IxkkOSrtDRFavAtYwoyOJGu8mAXQseVeeYG2EO8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=heFEQRrnSGQM/MRd88MoI6l8XjBJ2Wfe8DyItUknXGsM/J0et66+E5ffc+pUhPXTFZfT/Xo+g1n7No/IHno3tK+URPtvoOD3Qm13C7b0vOz8pxnkVf1cuYwiDLqCJFdyrPunqeLrew9iQiRpPKwXMkA39AJgO/MO2YQDteEkDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=KuOqBmvI; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="KuOqBmvI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NOYN9ELOwBqfpP7ACiGguFoOwDf23iPWlZ8ydYBaQ/0=; b=KuOqBmvI1HX8wUYLkkuxf1SoIs
	PZ9xvKyVb9npk6hX46/NdiVGTTevDwAoMfQph8xLba7t4KCSUHgxAj84Xph6ELU9EehLykFQoZGSy
	TQ+6SoszrpkSk17JpXW0hk23AyDOzQz0FfYX3J2BJMyggPZmfZU2zWnVTlupsfpAVY9e21sEXYC5L
	2LItJ0GrGZ8BWohcQqy8Os5X6++pIPhsTO2yCL4viIY83DuzmeEwVs3eYx8CGwaxzgH1Sunly97Xr
	yjqdOQ/uZ+Mv+fYmjL0hxarT+y3PUSHVJPU95oaN2olerUuaTTFhOkM96+140//sSMTXWU1lQ45Tc
	Sit/Dsug==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-0r
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 33/45] wireguard: Fix string list parsing and IP tunneling
Date: Fri, 11 Jul 2025 17:27:24 +0300
Message-Id: <20250711142736.1757060-34-jussi.laakkonen@jolla.com>
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

The string lists read, for example, Mullvad config files do not contain
spaces, use g_strsplit_set() for this.

Prevent adding only the any routes for the current peer family to avoid
duplicates. This fixes dual protocol tunneling on a single WireGuard
peer, such as IPv4 server with both IPv4 and IPv6 addresses.
---
 vpn/plugins/wireguard.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index a22402c8..ee7149b7 100644
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
@@ -628,12 +628,6 @@ static gboolean wg_route_setup_cb(gpointer user_data)
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
@@ -658,7 +652,9 @@ static gboolean wg_route_setup_cb(gpointer user_data)
 			continue;
 		}
 
-		if (connman_inet_is_any_addr(addr, allowedip->family)) {
+		/* Ignore any routes for this peer family to avoid duplicates */
+		if (connman_inet_is_any_addr(addr, allowedip->family) &&
+						allowedip->family == family) {
 			DBG("ignore any addr %s", addr);
 			continue;
 		}
-- 
2.39.5

