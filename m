Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A552E7F0B
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244078; cv=none; b=hdU8gxnu4jSNIFP+O8jrxhpx3zK7DwP0zgstBTsJsZjIyskk7N2d4yEbuDAxxSreSTB9hPPnWdQQpa2qid4XmqMrkTBSN0d6ppxkcUeGl1x2Uhb6HHOlacJmdWoINhSbnImzE5iaL18+HViJj9SYW9VJZ0VF3HOKeO3utr2Rfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244078; c=relaxed/simple;
	bh=iBL7Nw8f3xFfk10H1lRMM/+ROVkCx6tkmRBwxwZ3FWA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjRlNTmMbD8osBly/0AehoWyRHjELWsBVIGvjb0M17jlAERW16Rev4p/vvNeAoei2SUQ3EdZGngwsc0LwQazlOEy6iIYOSPtEZufl7ZVNxR7TbYBYpMvZwPPwfsR6jrPk22DlQADFyT/25tst8cGOjW9XmmFFczR1IAS/dQ9g6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=unbpQZB0; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="unbpQZB0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e4+4h0c9HRBoY9rOEqnvzzaS+jbd23JbLRxf+rVxN8Q=; b=unbpQZB0ftg51wkqzLLCoLw0W8
	XMNbf4Id8WopyD08b1A4yW2poq8TJ/HeeImrT/sL3/i/rFE5EKLjQd6KdON4Z8rcRb3GNtxjFtf7X
	v0MSvqV3QK4s77BQZH8gvGIZmFT6fjYI+OENSenzGks5sEBEgIhKyqCWv//ZMk3FHvxUAfbK6De36
	+qmtX0x9+0WRCau4NHsOmU0MZQsI1qVsqfTRLPVcB7XAixm/AXbbhpuJIl9LSn3CmMPvE5rrRf/9+
	lv+FOtUBbhzuHzebDdHax3t1SKgscFceBP0z3+zRDnTdRKDfJQPEUAkHR8FeKNCRWET9S5n+B31AF
	rE9JmERg==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-2B
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 42/45] vpn-provider: Add support for set/get "TransportNameservers"
Date: Fri, 11 Jul 2025 17:27:33 +0300
Message-Id: <20250711142736.1757060-43-jussi.laakkonen@jolla.com>
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

Set the transport nameservers when property change is received as a
D-Bus signal from connmand. The code to get the nameservers is identical
to plugins/vpn.c:extract_nameservers(). And add a generic getter for
plugins to use.
---
 vpn/vpn-provider.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 vpn/vpn-provider.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/vpn/vpn-provider.c b/vpn/vpn-provider.c
index f72030af..d3affc0e 100644
--- a/vpn/vpn-provider.c
+++ b/vpn/vpn-provider.c
@@ -112,6 +112,7 @@ struct vpn_provider {
 	unsigned int signal_watch;
 	unsigned int auth_error_limit;
 	time_t previous_connect_time;
+	char **transport_nameservers;
 };
 
 struct vpn_provider_connect_data {
@@ -1504,6 +1505,7 @@ static void provider_destruct(struct vpn_provider *provider)
 	g_free(provider->config_entry);
 	connman_ipaddress_free(provider->prev_ipv4_addr);
 	connman_ipaddress_free(provider->prev_ipv6_addr);
+	g_strfreev(provider->transport_nameservers);
 	g_free(provider);
 }
 
@@ -2243,6 +2245,41 @@ static gboolean provider_property_changed(DBusConnection *conn,
 		 */
 		vpn_provider_set_boolean(provider, "SplitRouting",
 					split_routing, true);
+	} else if (g_str_equal(key, "TransportNameservers")) {
+		DBusMessageIter entry;
+		char **nameservers = NULL;
+		int i = 0;
+
+		DBG("TransportNameservers");
+
+		dbus_message_iter_recurse(&value, &entry);
+
+		while (dbus_message_iter_get_arg_type(&entry) ==
+							DBUS_TYPE_STRING) {
+			const char *nameserver;
+
+			dbus_message_iter_get_basic(&entry, &nameserver);
+
+			DBG("DNS%d: %s", i, nameserver);
+
+			nameservers = g_try_renew(char *, nameservers, i + 2);
+			if (!nameservers)
+				break;
+
+			nameservers[i] = g_strdup(nameserver);
+			if (!nameservers[i]) {
+				g_strfreev(nameservers);
+				nameservers = NULL;
+				break;
+			}
+
+			nameservers[++i] = NULL;
+
+			dbus_message_iter_next(&entry);
+		}
+
+		g_strfreev(provider->transport_nameservers);
+		provider->transport_nameservers = nameservers;
 	}
 
 out:
@@ -2985,6 +3022,17 @@ const char *vpn_provider_get_string(struct vpn_provider *provider,
 	return setting->value;
 }
 
+char **vpn_provider_get_string_list(struct vpn_provider *provider,
+							const char *key)
+{
+	DBG("provider %p key %s", provider, key);
+
+	if (g_str_equal(key, "TransportNameservers"))
+		return provider->transport_nameservers;
+
+	return NULL;
+}
+
 int vpn_provider_set_boolean(struct vpn_provider *provider, const char *key,
 						bool value, bool force_change)
 {
diff --git a/vpn/vpn-provider.h b/vpn/vpn-provider.h
index a7ec5109..6bd64205 100644
--- a/vpn/vpn-provider.h
+++ b/vpn/vpn-provider.h
@@ -87,6 +87,8 @@ int vpn_provider_set_string_hide_value(struct vpn_provider *provider,
 					const char *key, const char *value);
 const char *vpn_provider_get_string(struct vpn_provider *provider,
 							const char *key);
+char **vpn_provider_get_string_list(struct vpn_provider *provider,
+							const char *key);
 bool vpn_provider_get_string_immutable(struct vpn_provider *provider,
 							const char *key);
 int vpn_provider_set_boolean(struct vpn_provider *provider, const char *key,
-- 
2.39.5

