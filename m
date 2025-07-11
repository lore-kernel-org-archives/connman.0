Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F582E7BC5
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244078; cv=none; b=BawWpc3fnUF8F/v9X8DsWm6SpEokawlrWHs5aCalenquO0Ms/otc93WRvVYIbatOFic5Hl128s6nsBX3YCHbyZKJ2LPE6TsrJ0y+18xroKY6c3P7awKeAManqFbyaatj87+KjkmDpgZMvbg6tykLO2RIPfw3MkhCx8R83bFkHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244078; c=relaxed/simple;
	bh=QFzgpTCUJyMtTg+C0DkfxUHmoXXUwV+IXFlE7Q2aSVI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nUSOS5nRoA0n09jbUZMpYeuRxE34kA1Oo5mK1seG0sJGaHpMZoPXBFn3xPdsSLpXbNZE+JEEuxY1ShRG22S5Wi5wNV8CA65S4AGedTCykOzTP4UXqrdB10EhFzPB41im26oGmOKHhmgkB5XDKT36YTNZX8ezQcfeh5uTGeHoGXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ZHYF8Y9H; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ZHYF8Y9H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MKpnbDoXDG5g+BmD8kx9AyxQdD6YymlJauDO0s9aTaA=; b=ZHYF8Y9Hsk25HrKQnAdxysTqt0
	L6oFsRvWoEFONRoKrq1+8pO2m7mWDO5kLyKvMtiTOZ9M10Tu6mTizxfOPdSBAOU7ZbinWOt7GijLN
	j//Nss4gDGM9U+eT8JLvah6LkVLB085zM01sYfnVESHsk4d1JiNiwX6wgRc52pMwi2IsTDs1IBrWG
	K9UiojsJIw8+F4bPnZaYjoG0uN6FBXucuDrERbIOdm5PlNEnMBzP+cliZ6BicLYTuowx1IFCEBMqi
	1/EEAT7Qeuge2+j9tT57LRjjrE5lijsHZsZqZimt/zedYmTcG2a27IK86mU0flmmdPHIgiA0HcDWk
	L8CZ2XMg==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-2t
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 25/45] provider: Add support for dual-IP VPNs
Date: Fri, 11 Jul 2025 17:27:16 +0300
Message-Id: <20250711142736.1757060-26-jussi.laakkonen@jolla.com>
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

Handle both IP family types for a VPN if it, like WireGuard, has them.
Use a boolean array to define AFs for a VPN.

Change the functionality regarding supported families to use a boolean
array defining which address families are supported by a VPN.

Modify the connman_provider_get_family() to be a query type based on the
AF given.
---
 include/provider.h |  2 +-
 src/provider.c     | 88 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/include/provider.h b/include/provider.h
index aac47527..3e6ea2c7 100644
--- a/include/provider.h
+++ b/include/provider.h
@@ -117,7 +117,7 @@ void connman_provider_set_autoconnect(struct connman_provider *provider,
 bool connman_provider_is_split_routing(struct connman_provider *provider);
 int connman_provider_set_split_routing(struct connman_provider *provider,
 							bool split_routing);
-int connman_provider_get_family(struct connman_provider *provider);
+bool connman_provider_get_family(struct connman_provider *provider, int family);
 
 const char *connman_provider_get_driver_name(struct connman_provider *provider);
 const char *connman_provider_get_save_group(struct connman_provider *provider);
diff --git a/src/provider.c b/src/provider.c
index ab4aeafb..e790ccea 100644
--- a/src/provider.c
+++ b/src/provider.c
@@ -31,6 +31,7 @@
 #include <gweb/gresolv.h>
 
 #include "connman.h"
+#include "src/shared/util.h"
 
 static DBusConnection *connection = NULL;
 
@@ -44,11 +45,35 @@ struct connman_provider {
 	struct connman_service *vpn_service;
 	int index;
 	char *identifier;
-	int family;
+	bool family[AF_ARRAY_LENGTH];
 	struct connman_provider_driver *driver;
 	void *driver_data;
 };
 
+static void provider_set_family(struct connman_provider *provider, int family)
+{
+	if (!provider)
+		return;
+
+	util_set_afs(provider->family, family);
+}
+
+static bool provider_get_family(struct connman_provider *provider, int family)
+{
+	if (!provider)
+		return false;
+
+	return util_get_afs(provider->family, family);
+}
+
+static void provider_reset_family(struct connman_provider *provider)
+{
+	if (!provider)
+		return;
+
+	util_reset_afs(provider->family);
+}
+
 void __connman_provider_append_properties(struct connman_provider *provider,
 							DBusMessageIter *iter)
 {
@@ -171,6 +196,8 @@ int connman_provider_disconnect(struct connman_provider *provider)
 		provider_indicate_state(provider,
 					CONNMAN_SERVICE_STATE_IDLE);
 
+	provider_reset_family(provider);
+
 	return 0;
 }
 
@@ -258,22 +285,36 @@ static int set_connected(struct connman_provider *provider,
 					bool connected)
 {
 	struct connman_service *service = provider->vpn_service;
-	struct connman_ipconfig *ipconfig;
+	struct connman_ipconfig *ipconfig_ipv4 = NULL;
+	struct connman_ipconfig *ipconfig_ipv6 = NULL;
 
 	if (!service)
 		return -ENODEV;
 
-	ipconfig = __connman_service_get_ipconfig(service, provider->family);
+	if (provider_get_family(provider, AF_INET))
+		ipconfig_ipv4 = __connman_service_get_ipconfig(service,
+								AF_INET);
+
+	if (provider_get_family(provider, AF_INET6))
+		ipconfig_ipv6 = __connman_service_get_ipconfig(service,
+								AF_INET6);
 
 	if (connected) {
-		if (!ipconfig) {
+		if (!ipconfig_ipv4 && !ipconfig_ipv6) {
 			provider_indicate_state(provider,
 						CONNMAN_SERVICE_STATE_FAILURE);
 			return -EIO;
 		}
 
-		__connman_ipconfig_address_add(ipconfig);
-		__connman_ipconfig_gateway_add(ipconfig);
+		if (ipconfig_ipv4) {
+			__connman_ipconfig_address_add(ipconfig_ipv4);
+			__connman_ipconfig_gateway_add(ipconfig_ipv4);
+		}
+
+		if (ipconfig_ipv6) {
+			__connman_ipconfig_address_add(ipconfig_ipv6);
+			__connman_ipconfig_gateway_add(ipconfig_ipv6);
+		}
 
 		provider_indicate_state(provider,
 					CONNMAN_SERVICE_STATE_READY);
@@ -283,10 +324,16 @@ static int set_connected(struct connman_provider *provider,
 						CONNMAN_PROVIDER_ROUTE_ALL);
 
 	} else {
-		if (ipconfig) {
+		if (ipconfig_ipv4) {
 			provider_indicate_state(provider,
 					CONNMAN_SERVICE_STATE_DISCONNECT);
-			__connman_ipconfig_gateway_remove(ipconfig);
+			__connman_ipconfig_gateway_remove(ipconfig_ipv4);
+		}
+
+		if (ipconfig_ipv6) {
+			provider_indicate_state(provider,
+					CONNMAN_SERVICE_STATE_DISCONNECT);
+			__connman_ipconfig_gateway_remove(ipconfig_ipv6);
 		}
 
 		provider_indicate_state(provider,
@@ -570,7 +617,7 @@ int connman_provider_set_ipaddress(struct connman_provider *provider,
 	if (!ipconfig)
 		return -EINVAL;
 
-	provider->family = ipaddress->family;
+	provider_set_family(provider, ipaddress->family);
 
 	__connman_ipconfig_set_method(ipconfig, CONNMAN_IPCONFIG_METHOD_FIXED);
 
@@ -665,19 +712,15 @@ int connman_provider_set_split_routing(struct connman_provider *provider,
 		return -EALREADY;
 	}
 
-	switch (provider->family) {
-	case AF_INET:
+	if (provider_get_family(provider, AF_INET) &&
+				provider_get_family(provider, AF_INET6))
+		type = CONNMAN_IPCONFIG_TYPE_ALL;
+	else if (provider_get_family(provider, AF_INET))
 		type = CONNMAN_IPCONFIG_TYPE_IPV4;
-		break;
-	case AF_INET6:
+	else if (provider_get_family(provider, AF_INET6))
 		type = CONNMAN_IPCONFIG_TYPE_IPV6;
-		break;
-	case AF_UNSPEC:
-		type = CONNMAN_IPCONFIG_TYPE_ALL;
-		break;
-	default:
+	else
 		type = CONNMAN_IPCONFIG_TYPE_UNKNOWN;
-	}
 
 	if (!__connman_service_is_connected_state(provider->vpn_service,
 								type)) {
@@ -719,12 +762,9 @@ out:
 	return err;
 }
 
-int connman_provider_get_family(struct connman_provider *provider)
+bool connman_provider_get_family(struct connman_provider *provider, int family)
 {
-	if (!provider)
-		return AF_UNSPEC;
-
-	return provider->family;
+	return provider_get_family(provider, family);
 }
 
 static void unregister_provider(gpointer data)
-- 
2.39.5

