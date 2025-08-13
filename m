Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB222230268
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099636; cv=none; b=g9sAtzkpPxcKGJgwK1nPG2r4DzcfPo/+LjLoSHs19XOX4im1meCw90tu47MrLpUlUPcCJdelXxLDoAoOUkm6+uuSNgJlw1s0rwQvCKqo2gG2DJtxytHJv51Oo5BugdgOgRm+lR6iHEjSXXIPpQafDyYd/ub5RUwK802dfiPJ3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099636; c=relaxed/simple;
	bh=GO2zg/VCKj8rynAQJo7xGmdN1WTFYXOl5eXxwNi63FE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HlCs9gZ51MvvRANWh0gALd6o3p9QUqoe+uUY11TdWRQznjHDDM5n+XvJbwTkUbKIssEbLOAwu5HOwjwEy+bQlpkd3iCACzJMI4Qf0AEyKXyE+FBBwp1ICOXMjtUKtHNS2qpBFqH8qUFPeMpufrz2HnqjB8UwkJm1XdCXzwFEHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=0q4uwnNy; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="0q4uwnNy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=j1800XvM+VBb/FkBhbaVm32F6Pj+yfhlbyyQwhSQ6sg=; b=0q4uwnNy+snbyaNdW5ytdGQPNj
	Kq/q/RnqHi97ZEgv/GHoiR7srSQ09tqJqsSTsoWTfJ4tqfRO1yf6dtK9xYyTL6Dhzgl441RYCOK/d
	gMXN1cIjYQNqN5Xl5EuWN9HC9EQuGc8rV4gI48RQOC46r2kMEpM4W3z1loKxgGZPbA4JJs+1yKbGy
	hFyguIuiKX3vxNkRnffjxp71i6s6GdhaWjgVzok0YbaB9lWRTGesMKqCGfmuiGULFRvHtSpBUE2Uz
	/PaGnqYk822paT3AsgVRwLmsvVb+6L9VxpFkf9dHiGN/X9dmEyeNs/Udfk4GFZmnx5BDfdA+oKRIr
	ccmUfU2A==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-2P
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 40/42] wireguard: Add option for using transport nameservers for DNS reresolve
Date: Wed, 13 Aug 2025 18:02:12 +0300
Message-Id: <20250813150214.189282-41-jussi.laakkonen@jolla.com>
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

If the "WireGuard.ReresolveUseTransportDNS" is defined add the
nameservers of the transport to be used for DNS reresolve queries. This
affects only the GResolv queries done after the intial connection to
reresolve the endpoint address.
---
 vpn/plugins/wireguard.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/vpn/plugins/wireguard.c b/vpn/plugins/wireguard.c
index 07829cd6..a99d0b75 100644
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
@@ -599,6 +601,9 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 {
 	struct wireguard_info *info = user_data;
 	GError *error = NULL;
+	char **nameservers;
+	bool option;
+	int i;
 
 	DBG("");
 
@@ -616,6 +621,19 @@ static gboolean wg_dns_reresolve_cb(gpointer user_data)
 	}
 
 	DBG("endpoint_fqdn %s", info->endpoint_fqdn);
+
+	option = vpn_provider_get_boolean(info->provider,
+					"WireGuard.ReresolveUseTransportDNS",
+					false);
+	if (option) {
+		nameservers = vpn_provider_get_string_list(info->provider,
+						"TransportNameservers");
+		for (i = 0; nameservers && nameservers[i]; i++)
+			g_resolv_add_nameserver(info->resolv,
+							nameservers[i],
+							DNS_DEFAULT_PORT, 0);
+	}
+
 	info->resolv_id = g_resolv_lookup_hostname(info->resolv,
 						info->endpoint_fqdn,
 						resolve_endpoint_cb, info,
-- 
2.39.5

