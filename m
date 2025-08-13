Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E692857C1
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100776; cv=none; b=U7WtrUZQzGoN82NszpZnG2wKIpQ/n37Ml6VA1/mMAfjojztnVG2mEY8MJ9YC1DvLpud+MJIhS7hc19WnbxIKgBO3UZOz0jgIJ70u3L95Kp2sReZ7GTfHTcPvdtMcony15hTFQ8X9CS6sis8suHrkIg6vAj8zLlNklB78pDUHhfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100776; c=relaxed/simple;
	bh=aep1sVvzvEcY9mY8Hn8BNw3/Gi6Df5ByrPxG/oMupY0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eG3phUMWpX6yJZxgwlTtuOPpoJu81OpeiI0wCwwPSD/AKPXaixVsUOo4OkfbTOzQR7r0RRvMRSa3Ekw5xyGgcNRM50wKuJ+Hokq4z4lKt2tuVNaVI7iYDjaLm/scboSkirZCXprcmeF12s6eZsQIkBs05XvDGf8L7zvwzv9qJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ug5/veRM; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ug5/veRM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YKDbvFUF7vRF+33fIujmaN2nwRz0aKUSLsO8z7rYtw8=; b=ug5/veRMibJccIYdWUUFbpDzsH
	myZApJE1Py2vEE1IcDi2gZ18m5xUYOPjqA0GpHRtINfq6fxijV5596Bv2ilFNBqIlT19gFa7PWA6A
	IesQz8aGX9qtTT+iFNODDhfqrxwdS32srL6nPRpILSJbAMWTm4wzLHtp8YEZ9ZLuf2L8FkWhyz49b
	Jv6BLVXObasoFIidKnsavK7fX/ZQh74yMKWLNpxIM9re3lJsC7cS103sllQXRkTxBXs9Ebx0rClkh
	6SfMltJ2GIAEu2EcSU719MJTm+4u6CN2nie4vLWKBXEyrcRObmt7st29vVRcwPJbE8siJ6rz2qfsl
	qDIYO8Sw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-35
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 22/42] vpn-provider: Add support for dual-IP VPNs
Date: Wed, 13 Aug 2025 18:01:54 +0300
Message-Id: <20250813150214.189282-23-jussi.laakkonen@jolla.com>
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

WireGuard can use both IP addresses, for example. Use a the utils afs to
define AFs for a VPN.
---
 Makefile.am        |  3 ++-
 vpn/vpn-provider.c | 64 ++++++++++++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 3dc3bb5c..28a8b7d5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -181,7 +181,8 @@ vpn_connman_vpnd_SOURCES = $(builtin_vpn_sources) $(backtrace_sources) \
 			vpn/vpn-ipconfig.c src/inet.c vpn/vpn-rtnl.c \
 			src/dbus.c src/storage.c src/ipaddress.c src/agent.c \
 			vpn/vpn-agent.c vpn/vpn-agent.h src/inotify.c \
-			vpn/vpn-config.c vpn/vpn-settings.c vpn/vpn-util.c
+			vpn/vpn-config.c vpn/vpn-settings.c vpn/vpn-util.c \
+			src/shared/util.c
 
 vpn_connman_vpnd_LDADD = gdbus/libgdbus-internal.la $(builtin_vpn_libadd) \
 				@GIO_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ @GNUTLS_LIBS@ \
diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index b79b7963..c05e4cf5 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -55,6 +55,7 @@
 #include "vpn-provider.h"
 #include "vpn.h"
 #include "plugins/vpn.h"
+#include "../src/shared/util.h"
 
 static DBusConnection *connection;
 static GHashTable *provider_hash;
@@ -85,7 +86,7 @@ struct vpn_provider {
 	char *type;
 	char *host;
 	char *domain;
-	int family;
+	struct supported_afs family;
 	bool do_split_routing;
 	GHashTable *routes;
 	struct vpn_provider_driver *driver;
@@ -127,6 +128,31 @@ static guint connman_service_watch;
 static bool connman_online;
 static bool state_query_completed;
 
+
+static bool provider_get_family(struct vpn_provider *provider, int family)
+{
+	if (!provider)
+		return false;
+
+	return util_get_afs(&provider->family, family);
+}
+
+static void provider_set_family(struct vpn_provider *provider, int family)
+{
+	if (!provider)
+		return;
+
+	util_set_afs(&provider->family, family);
+}
+
+static void provider_reset_family(struct vpn_provider *provider)
+{
+	if (!provider)
+		return;
+
+	util_reset_afs(&provider->family);
+}
+
 static void append_properties(DBusMessageIter *iter,
 				struct vpn_provider *provider);
 static int vpn_provider_save(struct vpn_provider *provider);
@@ -1875,11 +1901,11 @@ static int provider_indicate_state(struct vpn_provider *provider,
 					VPN_CONNECTION_INTERFACE, "Index",
 					DBUS_TYPE_INT32, &provider->index);
 
-		if (provider->family == AF_INET)
+		if (provider_get_family(provider, AF_INET))
 			connman_dbus_property_changed_dict(provider->path,
 					VPN_CONNECTION_INTERFACE, "IPv4",
 					append_ipv4, provider);
-		else if (provider->family == AF_INET6)
+		if (provider_get_family(provider, AF_INET6))
 			connman_dbus_property_changed_dict(provider->path,
 					VPN_CONNECTION_INTERFACE, "IPv6",
 					append_ipv6, provider);
@@ -1976,10 +2002,10 @@ static void append_properties(DBusMessageIter *iter,
 	connman_dbus_dict_append_basic(&dict, "SplitRouting",
 					DBUS_TYPE_BOOLEAN, &split_routing);
 
-	if (provider->family == AF_INET)
+	if (provider_get_family(provider, AF_INET))
 		connman_dbus_dict_append_dict(&dict, "IPv4", append_ipv4,
 						provider);
-	else if (provider->family == AF_INET6)
+	if (provider_get_family(provider, AF_INET6))
 		connman_dbus_dict_append_dict(&dict, "IPv6", append_ipv6,
 						provider);
 
@@ -2032,18 +2058,16 @@ static void connection_added_signal(struct vpn_provider *provider)
 static int set_connected(struct vpn_provider *provider,
 					bool connected)
 {
-	struct vpn_ipconfig *ipconfig;
-
 	DBG("provider %p id %s connected %d", provider,
 					provider->identifier, connected);
 
 	if (connected) {
-		if (provider->family == AF_INET6)
-			ipconfig = provider->ipconfig_ipv6;
-		else
-			ipconfig = provider->ipconfig_ipv4;
-
-		__vpn_ipconfig_address_add(ipconfig, provider->family);
+		if (provider_get_family(provider, AF_INET))
+			__vpn_ipconfig_address_add(provider->ipconfig_ipv4,
+								AF_INET);
+		if (provider_get_family(provider, AF_INET6))
+			__vpn_ipconfig_address_add(provider->ipconfig_ipv6,
+								AF_INET6);
 
 		provider_indicate_state(provider,
 					VPN_PROVIDER_STATE_READY);
@@ -2053,6 +2077,7 @@ static int set_connected(struct vpn_provider *provider,
 
 		provider_indicate_state(provider,
 					VPN_PROVIDER_STATE_IDLE);
+		provider_reset_family(provider);
 	}
 
 	return 0;
@@ -3077,7 +3102,7 @@ int vpn_provider_set_ipaddress(struct vpn_provider *provider,
 	if (!ipconfig)
 		return -EINVAL;
 
-	provider->family = ipaddress->family;
+	provider_set_family(provider, ipaddress->family);
 
 	if (provider->state == VPN_PROVIDER_STATE_CONNECT ||
 			provider->state == VPN_PROVIDER_STATE_READY) {
@@ -3367,18 +3392,13 @@ unsigned int vpn_provider_get_connection_errors(
 
 void vpn_provider_change_address(struct vpn_provider *provider)
 {
-	switch (provider->family) {
-	case AF_INET:
+	if (provider_get_family(provider, AF_INET))
 		connman_inet_set_address(provider->index,
 			__vpn_ipconfig_get_address(provider->ipconfig_ipv4));
-		break;
-	case AF_INET6:
+
+	if (provider_get_family(provider, AF_INET6))
 		connman_inet_set_ipv6_address(provider->index,
 			__vpn_ipconfig_get_address(provider->ipconfig_ipv6));
-		break;
-	default:
-		break;
-	}
 }
 
 void vpn_provider_clear_address(struct vpn_provider *provider, int family)
-- 
2.39.5

