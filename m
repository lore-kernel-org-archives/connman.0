Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9032E7F13
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244078; cv=none; b=PSadExorsLCQqr3CR0qeVJQ3sBea4NBbPF0Pe0Ad9WkGC1Et6GyQodUsiXmfZvCBuD3wxGKLqEtqyOT3pBvvxrRAwQijBNJ2MkvKujpoktopHGtktywHnthz9lp1OPYJ1QI9UbRoBEfr2k/TIgDXSzigW8budm/v9NTTmnC9yRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244078; c=relaxed/simple;
	bh=70ATb5Z8Fkc+6R+vOd0Azoip7nxT2aR9rjBZPhngJz0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HrI1TUPunCn8DqmfvjYbmNNS0zfNcMpBFdGBt28ZFxxxJdUszCPg9q88U1sDTRsSY/jfHoU+Mlif/gKCMdXIFxKg/7X/byZdNH0/M5TaZLduRHdREuZ1Wu8lMmwFtTxMxCF/T9hgxf8jsZBSr80IiPonj5N74r4Bm+DzhdJdXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=NbExXavh; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="NbExXavh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yk6AF5D6R3GUzP7BzaASBnAX4mUTkv6y/iGvBOIrdpU=; b=NbExXavheI8RKfiqi2PbSSNx00
	/2HJVWGX/RxEk2geQPnjBC4jrX9ixHDoiA9CZwEevbq3Bg2yTIn4Fxq/MsUvGAdb3L9D9phQqsViB
	TRTkQfJve5FvCYXoiq3DLmTDOTmcdwWOl9mMRFCqWaEQtSDoLaZZ4CJF5K29rztiDgm+HZjO42bPe
	66X5/ve5CMjvBlkfM99xrTsV2WIv/i51UqnjQZ7RNHABZsywyumq+yht7w3POMw82FhwD4QXSoXOg
	ujP51Qbe85PwL9tQTimlzudGCTnDDH8iZVnoN05J6xbAEZyYFSz/wNmYmv1WUnZk2/eElZIoC/tUy
	lzVeXFbQ==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-2K
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 43/45] wireguard: Add option for using transport nameservers for DNS reresolve
Date: Fri, 11 Jul 2025 17:27:34 +0300
Message-Id: <20250711142736.1757060-44-jussi.laakkonen@jolla.com>
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

If the "WireGuard.ReresolveUseTransportDNS" is defined add the
nameservers of the transport to be used for DNS reresolve queries. This
affects only the GResolv queries done after the intial connection to
reresolve the endpoint address.
---
 vpn/plugins/wireguard.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index a2d92ec6..2787aa7e 100644
--- a/vpn/plugins/wireguard.c
+++ b/vpn/plugins/wireguard.c
@@ -53,6 +53,7 @@
 
 #define DNS_RERESOLVE_TIMEOUT 20
 #define DNS_RERESOLVE_ERROR_LIMIT 5
+#define DNS_DEFAULT_PORT 53
 #define ROUTE_SETUP_TIMEOUT 200 // ms
 #define ARRAY_SIZE(a) (sizeof(a)/sizeof(a[0]))
 
@@ -90,7 +91,8 @@ struct {
 	{"WireGuard.PublicKey", true},
 	{"WireGuard.AllowedIPs", true},
 	{"WireGuard.EndpointPort", true},
-	{"WireGuard.PersistentKeepalive", true}
+	{"WireGuard.PersistentKeepalive", true},
+	{"WireGuard.ReresolveUseTransportDNS", false}
 };
 
 static struct wireguard_info *create_private_data(struct vpn_provider *provider)
@@ -532,7 +534,7 @@ static void resolve_endpoint_cb(GResolvResultStatus status,
 	case G_RESOLV_RESULT_STATUS_NO_ANSWER:
 	case G_RESOLV_RESULT_STATUS_NO_RESPONSE:
 	case G_RESOLV_RESULT_STATUS_SERVER_FAILURE:
-		DBG("retry DNS reresolve");
+		DBG("retry DNS reresolve, status %d", status);
 		if (info->provider)
 			vpn_provider_add_error(info->provider,
 					VPN_PROVIDER_ERROR_CONNECT_FAILED);
@@ -544,7 +546,7 @@ static void resolve_endpoint_cb(GResolvResultStatus status,
 	case G_RESOLV_RESULT_STATUS_FORMAT_ERROR:
 	case G_RESOLV_RESULT_STATUS_NOT_IMPLEMENTED:
 	case G_RESOLV_RESULT_STATUS_REFUSED:
-		DBG("stop DNS reresolve, error %d", status);
+		DBG("stop DNS reresolve, status %d", status);
 		if (err && info->provider)
 			vpn_provider_add_error(info->provider,
 					VPN_PROVIDER_ERROR_CONNECT_FAILED);
@@ -598,7 +600,10 @@ static int disconnect(struct vpn_provider *provider, int error);
 static gboolean wg_dns_reresolve_cb(gpointer user_data)
 {
 	struct wireguard_info *info = user_data;
+	char **nameservers;
+	bool option;
 	int err;
+	int i;
 
 	DBG("");
 
@@ -617,6 +622,18 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 
 	DBG("endpoint_fqdn %s", info->endpoint_fqdn);
 
+	option = vpn_provider_get_boolean(info->provider,
+					"WireGuard.ReresolveUseTransportDNS",
+					false);
+	if (option) {
+		nameservers = vpn_provider_get_string_list(info->provider,
+						"TransportNameservers");
+		for (i = 0; nameservers && nameservers[i]; i++)
+			vpn_util_resolv_add_nameserver(info->resolv,
+							nameservers[i],
+							DNS_DEFAULT_PORT, 0);
+	}
+
 	info->resolv_id = vpn_util_resolve_hostname(info->resolv,
 						info->endpoint_fqdn,
 						resolve_endpoint_cb, info);
-- 
2.39.5

