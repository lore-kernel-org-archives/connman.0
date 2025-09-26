Received: from mail.oscloud.info (oscloud.info [89.58.28.149])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFA1C8606
	for <connman@lists.linux.dev>; Fri, 26 Sep 2025 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758911964; cv=none; b=Jt198xZWDtOE4vB9rB03R7oguLQwhptVnjJlbagHPJgp8cUYdkLbRkYm+ipBsS1xjBKZqK+xGuIAehTFfYsP/3ukt/R/Uaezo87yVqKgvFxqqlRKS7y4INmk6NFhwMGHYzPVECYOoJQRHX+x83o1aYzvTwc59JnjczcEqyYAsj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758911964; c=relaxed/simple;
	bh=xyN5irhuCI7kHoRvshaAzT6T7gShLTTNN+SqcK+Mjwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hN326tMNUDjMOIgKiewpBTwKCL8gRwZzRw4pxt+2z/GaScVipNJpLv6fjBCibBtajI2n8Zzx46izo+lXz5sI5yk0EKLXL/P/uivzZyxIi8Sw9an7FSNfxveYKfzpTwj9mzwN+cQW+Wt9AJyWy3LHYTDDQV1i6Dvvq6FL7r8X74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oscloud.info; spf=pass smtp.mailfrom=oscloud.info; dkim=pass (2048-bit key) header.d=oscloud.info header.i=@oscloud.info header.b=K5K5H2To; arc=none smtp.client-ip=89.58.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oscloud.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oscloud.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oscloud.info header.i=@oscloud.info header.b="K5K5H2To"
From: Oskar Roesler <o.roesler@oscloud.info>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oscloud.info;
	s=2023; t=1758911952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=swwKM/Kqui1k8YF40OAgv7IvkDGlfTItIO16BERTjdc=;
	b=K5K5H2TovGNdCjzLBEoeKQfQl/3tFeRjjk/wTLscU++l7u/8Kux2qwsXblMCe68VtANvhD
	LWeyurGXtJPu6myGZu2oC7F38L58mDa1WQ7tICiSTcL/8BBhKvUN/sUG77cUAUYzrHgvIu
	hsXxcsZ0Gy5+4IkcgzXHfbHUHBFwXU8hqlHN2B7It8JyY56UYGhdJq38tHwM25tmTsT1Ht
	jAVdTbo+a0tysmsks+iBJRMskjtP7ggiVEciPACtyY3NZwKMDf0GOoiRgtQg5IMJo2uWh5
	mwb4saiJ9YAiHLgGmq6VXbkm1Lr4bekP6SpZjw8A86LcRB1XTIpUj34GAySEMw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=oskar@oscloud.info smtp.mailfrom=o.roesler@oscloud.info
To: connman@lists.linux.dev
Cc: Oskar Roesler <o.roesler@oscloud.info>
Subject: [PATCH] log: Add config option for setting a loglevel in connmand.
Date: Fri, 26 Sep 2025 20:37:13 +0200
Message-ID: <20250926183712.36332-2-o.roesler@oscloud.info>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uses the setlogmask(3) function of libc. Of all loglevels in the
library, only info, warn & err can be configured. The default loglevel
is info.
If debugging is enabled, the loglevel setting gets ignored.

Signed-off-by: Oskar Roesler <o.roesler@oscloud.info>
---
 Makefile.am           |  1 +
 doc/connman.conf.5.in |  4 ++++
 src/connman.h         |  1 +
 src/log.c             | 18 ++++++++++++++++++
 src/main.c            | 17 +++++++++++++++++
 src/main.conf         |  4 ++++
 6 files changed, 45 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 3dc3bb5..736217f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -254,6 +254,7 @@ endif
 
 src_connmand_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ \
 				@GNUTLS_CFLAGS@ $(builtin_cflags) \
+				-DTARGET_CONNMAND \
 				-DCONNMAN_PLUGIN_BUILTIN \
 				-DSTATEDIR=\""$(statedir)"\" \
 				-DPLUGINDIR=\""$(build_plugindir)"\" \
diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index a81ac7b..6adce5d 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -338,6 +338,10 @@ If this option is not set, it tries to write into
 @runstatedir@/connman/resolv.conf and fallbacks to @sysconfdir@/resolv.conf if
 it fails (@runstatedir@/connman does not exist or is not writeable).
 If you do not want to update resolv.conf, you can set /dev/null.
+.TP
+.BI LogLevel= string
+Sets one of 3 loglevels for connmand: info, warn or err.
+The Default loglevel is info.
 .SH "EXAMPLE"
 The following example configuration disables hostname updates and enables
 ethernet tethering.
diff --git a/src/connman.h b/src/connman.h
index 7ebda7a..9bfe6d6 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -144,6 +144,7 @@ int __connman_log_init(const char *program, const char *debug,
 void __connman_log_cleanup(gboolean backtrace);
 void __connman_log_enable(struct connman_debug_desc *start,
 					struct connman_debug_desc *stop);
+void __connman_log_setloglevel(void);
 
 #include <connman/backtrace.h>
 
diff --git a/src/log.c b/src/log.c
index 108dcb0..d71a70d 100644
--- a/src/log.c
+++ b/src/log.c
@@ -228,6 +228,24 @@ int __connman_log_init(const char *program, const char *debug,
 	return 0;
 }
 
+void __connman_log_setloglevel(void)
+{
+#ifdef TARGET_CONNMAND
+	if (enabled) // debugging enabled, ignore loglevel setting
+		return;
+
+	const char *loglevel_str = connman_setting_get_string("LogLevel");
+	int loglevel = LOG_INFO;
+
+	if (g_strcmp0("warn", loglevel_str) == 0)
+		loglevel = LOG_WARNING;
+	else if (g_strcmp0("err", loglevel_str) == 0)
+		loglevel = LOG_ERR;
+
+	setlogmask(LOG_UPTO(loglevel));
+#endif
+}
+
 void __connman_log_cleanup(gboolean backtrace)
 {
 	syslog(LOG_INFO, "Exit");
diff --git a/src/main.c b/src/main.c
index 7090926..f52dab6 100644
--- a/src/main.c
+++ b/src/main.c
@@ -136,6 +136,7 @@ static struct {
 	char *localtime;
 	bool regdom_follows_timezone;
 	char *resolv_conf;
+	char *loglevel;
 } connman_settings  = {
 	.bg_scan = true,
 	.pref_timeservers = NULL,
@@ -173,6 +174,7 @@ static struct {
 	.use_gateways_as_timeservers = false,
 	.localtime = NULL,
 	.resolv_conf = NULL,
+	.loglevel = NULL,
 };
 
 #define CONF_BG_SCAN                    "BackgroundScanning"
@@ -210,6 +212,7 @@ static struct {
 #define CONF_LOCALTIME                  "Localtime"
 #define CONF_REGDOM_FOLLOWS_TIMEZONE    "RegdomFollowsTimezone"
 #define CONF_RESOLV_CONF                "ResolvConf"
+#define CONF_LOGLEVEL                   "LogLevel"
 
 static const char *supported_options[] = {
 	CONF_BG_SCAN,
@@ -247,6 +250,7 @@ static const char *supported_options[] = {
 	CONF_LOCALTIME,
 	CONF_REGDOM_FOLLOWS_TIMEZONE,
 	CONF_RESOLV_CONF,
+	CONF_LOGLEVEL,
 	NULL
 };
 
@@ -850,6 +854,15 @@ static void parse_config(GKeyFile *config, const char *file)
 
 	g_clear_error(&error);
 
+	string = __connman_config_get_string(config, GENERAL_GROUP,
+				CONF_LOGLEVEL, &error);
+	if (!error)
+		connman_settings.loglevel = string;
+	else
+		g_free(string);
+
+	g_clear_error(&error);
+
 	online_check_settings_log();
 }
 
@@ -1051,6 +1064,9 @@ char *connman_setting_get_string(const char *key)
 	if (g_str_equal(key, CONF_ONLINE_CHECK_INTERVAL_STYLE))
 		return connman_settings.online_check_interval_style;
 
+	if (g_str_equal(key, CONF_LOGLEVEL))
+		return connman_settings.loglevel;
+
 	return NULL;
 }
 
@@ -1246,6 +1262,7 @@ int main(int argc, char *argv[])
 	__connman_provider_init();
 	__connman_network_init();
 	__connman_config_init();
+	__connman_log_setloglevel();
 	__connman_device_init(option_device, option_nodevice);
 
 	__connman_ippool_init();
diff --git a/src/main.conf b/src/main.conf
index da1307d..daa4159 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -289,3 +289,7 @@
 # to an interface (in accordance with RFC 5227).
 # Default value is false.
 # AddressConflictDetection = false
+
+# Sets one of 3 loglevels for connmand: info, warn or err
+# Default is info
+# LogLevel = info
-- 
2.51.0

