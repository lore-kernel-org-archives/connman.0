Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599353C2B84
	for <connman@lists.linux.dev>; Tue, 12 May 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600209; cv=none; b=uJTZxgWRz2aJFlMm54eRF3SPtTZ1RmNgNXOKwxS3olp4j3XtTZGnppN74ZkjAibi537fExJ0js/JqY7SW8r/fa1Od4E+8JVsS4VwDkT5XMeI8FIIhJDDSgtL0Gpf2aFrL4q9I1Vs4u/1TNbM46EkUwkJcqGKAy335z3ddw7WIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600209; c=relaxed/simple;
	bh=RdxOTENkkm4gidTFwdhu4xsQ1bE1IwYwaOo7QwjcMxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNliVh1+ix4eQlSo6RWRfjdPBcz4Y+tGhP8gwAu9twkwrlJksLs5bGOwqBqRw4Uj1O3JMaSrpb7d+R94AOsO2vh6ZNJzU+t1H2ZfTcq+dTUICnEHDbenikUt9EofNQ48+C5rf6ToRUfv40d3ve93XPEVyhttRMfaCw28RbijT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=XuaBZEb0; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="XuaBZEb0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JVtF8qQxAcX/R+6emYiyS0vjCxMR/UP8zWn3jZMW5Ro=; b=XuaBZEb0mO4MQEdwfTO6S5uUiD
	r85CJ8o94/uH3bToXFl1+ZbaxaaZimsbT/uDnfYduZLDk3Sh0XwqX74NYD9t0iXTybIeHIsZp+gvV
	f0sakzOAKyIDD29TfgbOWpREyD3WH4KBYiyBwRSg9WgYxiYiXBXVOxXtpWBcXn4TJ1NYJ+IffMaUb
	VHkAEI1aL6xzuT/RxCBPsCNJ9qZR4q4U60Ek5mHNXK21ZjIaGGDUD0zmxu+GUOXPbYABGqGYw+zn+
	ixVsUBZrlMETdR4jbK1JrQQTjp64h9qUucYGf43NfQN8XUozdvAJXQzmXARkOX7Ddct5S0tHj9g2H
	9D4s9DgQ==;
Received: from [2a10:a5c0:37:6500:9c0c:5ab0:fb2a:7a98] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wMpA0-00EZ9d-28;
	Tue, 12 May 2026 18:36:40 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Cc: Simo Piiroinen <simo.piiroinen@jollamobile.com>
Subject: [PATCH 2/3] config: Add FallbackDeviceTypes configuration option
Date: Tue, 12 May 2026 18:36:23 +0300
Message-ID: <20260512153627.443352-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512153627.443352-1-jussi.laakkonen@jolla.com>
References: <20260512153627.443352-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: RCPT_COUNT_TWO(0.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260512153627.443352-3-jussi.laakkonen@jolla.com

From: Simo Piiroinen <simo.piiroinen@jollamobile.com>

In some devices some /sys/class/net/<interface>/uevent files might be
completely missing DEVTYPE information. Heuristics exist for detecting
wifi devices, but everything else is assumed to be ethernet device. Any
other than known device type is ignored with a warning.

For example for rndis interfaces gadget might be more appropriate
device type assumption than ethernet. This can be accomplished by
adding to main.conf, in General section:

FallbackDeviceTypes = rndis0:gadget

Co-authored-by: Jussi Laakkonen <jussi.laakkonen@jolla.com>
---
 doc/connman.conf.5.in |  6 +++++
 src/connman.h         |  2 ++
 src/main.c            | 60 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index a81ac7bb..ab0ae5c2 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -338,6 +338,12 @@ If this option is not set, it tries to write into
 @runstatedir@/connman/resolv.conf and fallbacks to @sysconfdir@/resolv.conf if
 it fails (@runstatedir@/connman does not exist or is not writeable).
 If you do not want to update resolv.conf, you can set /dev/null.
+.TP
+.BI FallbackDeviceTypes= interface:devtype\fR[,...]
+If /sys/class/net/<interface>/uevent does not contain DEVTYPE information,
+heuristics are used to choose between wifi and ethernet device types. If
+neither is appropriate, this setting can be used to provide more suitable
+fallback value - e.g. rndis0:gadget.
 .SH "EXAMPLE"
 The following example configuration disables hostname updates and enables
 ethernet tethering.
diff --git a/src/connman.h b/src/connman.h
index e55be0a2..188f74a0 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -149,6 +149,8 @@ void __connman_log_enable(struct connman_debug_desc *start,
 
 #include <connman/setting.h>
 
+const char *__connman_setting_get_fallback_device_type(const char *interface);
+
 #include <connman/plugin.h>
 
 int __connman_plugin_init(const char *pattern, const char *exclude);
diff --git a/src/main.c b/src/main.c
index 70909264..ddb28276 100644
--- a/src/main.c
+++ b/src/main.c
@@ -136,6 +136,7 @@ static struct {
 	char *localtime;
 	bool regdom_follows_timezone;
 	char *resolv_conf;
+	GHashTable *fallback_device_types;
 } connman_settings  = {
 	.bg_scan = true,
 	.pref_timeservers = NULL,
@@ -173,6 +174,7 @@ static struct {
 	.use_gateways_as_timeservers = false,
 	.localtime = NULL,
 	.resolv_conf = NULL,
+	.fallback_device_types = NULL,
 };
 
 #define CONF_BG_SCAN                    "BackgroundScanning"
@@ -210,6 +212,7 @@ static struct {
 #define CONF_LOCALTIME                  "Localtime"
 #define CONF_REGDOM_FOLLOWS_TIMEZONE    "RegdomFollowsTimezone"
 #define CONF_RESOLV_CONF                "ResolvConf"
+#define CONF_FALLBACK_DEVICE_TYPES      "FallbackDeviceTypes"
 
 static const char *supported_options[] = {
 	CONF_BG_SCAN,
@@ -247,6 +250,7 @@ static const char *supported_options[] = {
 	CONF_LOCALTIME,
 	CONF_REGDOM_FOLLOWS_TIMEZONE,
 	CONF_RESOLV_CONF,
+	CONF_FALLBACK_DEVICE_TYPES,
 	NULL
 };
 
@@ -322,6 +326,39 @@ static char **parse_fallback_nameservers(char **nameservers, gsize len)
 	return servers;
 }
 
+static GHashTable *parse_fallback_device_types(char **devtypes, gsize len)
+{
+	GHashTable *h;
+
+	h = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, g_free);
+
+	for (gsize i = 0; i < len; ++i) {
+		char **v;
+
+		v = g_strsplit(devtypes[i], ":", 2);
+		if (!v)
+			continue;
+
+		if (v[0] && v[1]) {
+			if (__connman_device_string2type(v[1]) ==
+						CONNMAN_DEVICE_TYPE_UNKNOWN)
+				connman_warn("Invalid FallbackDeviceType in %s",
+								devtypes[i]);
+			else
+				g_hash_table_replace(h, g_strdup(v[0]),
+								g_strdup(v[1]));
+		}
+
+		g_strfreev(v);
+	}
+
+	if (g_hash_table_size(h) > 0)
+		return h;
+
+	g_hash_table_unref(h);
+	return NULL;
+}
+
 static void check_config(GKeyFile *config, const char *file)
 {
 	char **keys;
@@ -851,6 +888,17 @@ static void parse_config(GKeyFile *config, const char *file)
 	g_clear_error(&error);
 
 	online_check_settings_log();
+
+	str_list = __connman_config_get_string_list(config, GENERAL_GROUP,
+			CONF_FALLBACK_DEVICE_TYPES, &len, &error);
+
+	if (!error)
+		connman_settings.fallback_device_types =
+				parse_fallback_device_types(str_list, len);
+
+	g_strfreev(str_list);
+
+	g_clear_error(&error);
 }
 
 static int config_init(const char *file)
@@ -1165,6 +1213,15 @@ unsigned int connman_timeout_browser_launch(void)
 	return connman_settings.timeout_browserlaunch;
 }
 
+const char *__connman_setting_get_fallback_device_type(const char *interface)
+{
+	if (!connman_settings.fallback_device_types)
+		return NULL;
+
+	return g_hash_table_lookup(connman_settings.fallback_device_types,
+			interface);
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -1347,6 +1404,9 @@ int main(int argc, char *argv[])
 	g_free(connman_settings.online_check_ipv6_url);
 	g_free(connman_settings.localtime);
 
+	if (connman_settings.fallback_device_types)
+		g_hash_table_unref(connman_settings.fallback_device_types);
+
 	g_free(option_debug);
 	g_free(option_wifi);
 
-- 
2.47.3

