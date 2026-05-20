Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166D3E9C1C
	for <connman@lists.linux.dev>; Wed, 20 May 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287256; cv=none; b=tBgx7L4VhOhz4JTi1brDrpNghsKX5+HBcWBQkNwbJBKqflo38QRzNZ4r8a3DI6JIxcFQ0aiNQljKsxdNj07jLgEKEZ782HSen4AKRbbDb6ReHnnVop/DR2QKqDw4INAYnLjbmecfjpReCYBt0LDyCuJcA6IAesToJSR66O6oXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287256; c=relaxed/simple;
	bh=7xm5QGT5399XurYpUs2EMgoUpnoBAb0nIvYT3uoKA3s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxdcZEwiVN5+vjVXhpTVzlCOQ9FnCsfkWFpaOJ12y6wbFFDTjBWd7cG2dAduI7T+jiYPZX+FDHXZo1I97SPiOdFzX3UUZFFLpY8P+v2KbkmApr6URv8FB4lVRmA5Ed1GV2PtNEpNp8/Uom8oOZ0bDSVQfvflVQuMXKYsy1Y2wx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=Wi1hpJdZ; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="Wi1hpJdZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=K3jIW32fSJ67r/E1wcr8CqO/b/E9J8yJAmIU2l9u0sA=; b=Wi1hpJdZTJ6g5CqK0nBP75GqNQ
	7jbf8u1K10fhoIQ1TNElywja8wlUVCCiqcvlg8LkmjO/S+lyVnsaUw5jjIZ7jGzE/kukTGL5S3UuJ
	Q5MUGj6sw86dczim5KNsHdXswcYZ7QAUhYW7eU2icefNbK6YqgseSfLgx2+sZOMK8I4eRJ/oYz0IP
	fSMJFjXbVcfGwcZ6Uzg6JtJPppN8ZF80bwfkKdv+2Rz+m83/K/0uc1168ZiWt0CQhDU5sXJYPGFVR
	qlyVcEwsiKTwmdW/KURDC1VToB7JvtzuXH3Q0Skw3fqEUdnRXua8qJhYlsRTuW/1DIMwL2pb+eFhA
	YCqSbd0Q==;
Received: from [2a10:a5c0:37:6500:de2b:9403:4cd1:218c] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wPhGj-002WBi-1E
	for connman@lists.linux.dev;
	Wed, 20 May 2026 16:47:29 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/9] vpn-settings: Add callback for processing configs, support conf.d
Date: Wed, 20 May 2026 16:47:07 +0300
Message-ID: <20260520134720.981315-4-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
References: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
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
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: NEURAL_HAM(0.00); Neural network HAM [-0.952]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: FUZZY_RATELIMITED(0.00); Fuzzy rate limit is reached [rspamd.com]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260520134720.981315-4-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

Reformat init to allow processing of separate config files with a
separate callback for the conf.d support.

Cleanup conf loading.

Support conf.d style setting override by freeing the old ones first.
---
 vpn/main.c         |  5 +--
 vpn/vpn-settings.c | 83 ++++++++++++++++++++++++++++++++--------------
 vpn/vpn.h          |  4 ++-
 3 files changed, 64 insertions(+), 28 deletions(-)

diff --git a/vpn/main.c b/vpn/main.c
index 92c63e20..1965c34b 100644
--- a/vpn/main.c
+++ b/vpn/main.c
@@ -3,6 +3,7 @@
  *  ConnMan VPN daemon
  *
  *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2025  Jolla Mobile Ltd. All right reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -250,9 +251,9 @@ int main(int argc, char *argv[])
 	__connman_dbus_init(conn);
 
 	if (!option_config)
-		__vpn_settings_init(CONFIGMAINFILE);
+		__vpn_settings_init(CONFIGMAINFILE, CONFIGDIR);
 	else
-		__vpn_settings_init(option_config);
+		__vpn_settings_init(option_config, CONFIGDIR);
 
 	__connman_inotify_init();
 	__connman_agent_init();
diff --git a/vpn/vpn-settings.c b/vpn/vpn-settings.c
index e78e5019..78a1bfb2 100644
--- a/vpn/vpn-settings.c
+++ b/vpn/vpn-settings.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
  *  Copyright (C) 2018-2020 Jolla Ltd. All rights reserved.
+ *  Copyright (C) 2025  Jolla Mobile Ltd. All right reserved.
  *  Contact: jussi.laakkonen@jolla.com
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -41,13 +42,7 @@ static struct {
 	char *binary_group;
 	char **binary_supplementary_groups;
 	char **system_binary_users;
-} connman_vpn_settings  = {
-	.timeout_inputreq		= DEFAULT_INPUT_REQUEST_TIMEOUT,
-	.binary_user			= NULL,
-	.binary_group			= NULL,
-	.binary_supplementary_groups	= NULL,
-	.system_binary_users		= NULL,
-};
+} connman_vpn_settings = { 0 };
 
 struct vpn_plugin_data {
 	char *binary_user;
@@ -56,6 +51,7 @@ struct vpn_plugin_data {
 };
 
 GHashTable *plugin_hash = NULL;
+static char *configdir = NULL;
 
 bool vpn_settings_is_system_user(const char *user)
 {
@@ -164,6 +160,8 @@ static char **get_string_list(GKeyFile *config, const char *group,
 static void parse_config(GKeyFile *config, const char *file)
 {
 	const char *group = "General";
+	char **str_list = NULL;
+	char *str = NULL;
 	GError *error = NULL;
 	int timeout;
 
@@ -179,16 +177,29 @@ static void parse_config(GKeyFile *config, const char *file)
 
 	g_clear_error(&error);
 
-	connman_vpn_settings.binary_user = get_string(config, VPN_GROUP,
-						"User");
-	connman_vpn_settings.binary_group = get_string(config, VPN_GROUP,
-						"Group");
-	connman_vpn_settings.binary_supplementary_groups = get_string_list(
-						config, VPN_GROUP,
-						"SupplementaryGroups");
-	connman_vpn_settings.system_binary_users = get_string_list(
-						config, VPN_GROUP,
-						"SystemBinaryUsers");
+	str = get_string(config, VPN_GROUP, "User");
+	if (str) {
+		g_free(connman_vpn_settings.binary_user);
+		connman_vpn_settings.binary_user = str;
+	}
+
+	str = get_string(config, VPN_GROUP, "Group");
+	if (str) {
+		g_free(connman_vpn_settings.binary_group);
+		connman_vpn_settings.binary_group = str;
+	}
+
+	str_list = get_string_list(config, VPN_GROUP, "SupplementaryGroups");
+	if (str_list) {
+		g_strfreev(connman_vpn_settings.binary_supplementary_groups);
+		connman_vpn_settings.binary_supplementary_groups = str_list;
+	}
+
+	str_list = get_string_list(config, VPN_GROUP, "SystemBinaryUsers");
+	if (str_list) {
+		g_strfreev(connman_vpn_settings.system_binary_users);
+		connman_vpn_settings.system_binary_users = str_list;
+	}
 }
 
 struct vpn_plugin_data *vpn_settings_get_vpn_plugin_config(const char *name)
@@ -275,31 +286,50 @@ GKeyFile *__vpn_settings_load_config(const char *file)
 	g_key_file_set_list_separator(keyfile, ',');
 
 	if (!g_key_file_load_from_file(keyfile, file, 0, &err)) {
-		if (err->code != G_FILE_ERROR_NOENT) {
+		if (err->code != G_FILE_ERROR_NOENT)
 			connman_error("Parsing %s failed: %s", file,
 								err->message);
-		}
 
-		g_error_free(err);
 		g_key_file_unref(keyfile);
-		return NULL;
+		keyfile = NULL;
 	}
 
+	g_clear_error(&err);
+
 	return keyfile;
 }
 
-int __vpn_settings_init(const char *file)
+int __vpn_settings_process_config(const char *configfile)
 {
 	GKeyFile *config;
 
-	config = __vpn_settings_load_config(file);
-	parse_config(config, file);
-	if (config)
+	if (!configfile)
+		return -EINVAL;
+
+	DBG("%s", configfile);
+
+	config = __vpn_settings_load_config(configfile);
+	if (config) {
+		parse_config(config, configfile);
 		g_key_file_unref(config);
+	}
 
 	return 0;
 }
 
+int __vpn_settings_init(const char *file, const char *dir)
+{
+	if (!file || !dir)
+		return -EINVAL;
+
+	memset(&connman_vpn_settings, 0, sizeof(connman_vpn_settings));
+	connman_vpn_settings.timeout_inputreq = DEFAULT_INPUT_REQUEST_TIMEOUT;
+
+	configdir = g_build_filename(dir, PLUGIN_CONFIGDIR, NULL);
+
+	return __vpn_settings_process_config(file);
+}
+
 void __vpn_settings_cleanup()
 {
 	g_free(connman_vpn_settings.binary_user);
@@ -307,6 +337,9 @@ void __vpn_settings_cleanup()
 	g_strfreev(connman_vpn_settings.binary_supplementary_groups);
 	g_strfreev(connman_vpn_settings.system_binary_users);
 
+	g_free(configdir);
+	configdir = NULL;
+
 	if (plugin_hash) {
 		g_hash_table_destroy(plugin_hash);
 		plugin_hash = NULL;
diff --git a/vpn/vpn.h b/vpn/vpn.h
index 1f8c8fcd..5e30ea36 100644
--- a/vpn/vpn.h
+++ b/vpn/vpn.h
@@ -3,6 +3,7 @@
  *  ConnMan VPN daemon
  *
  *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2025  Jolla Mobile Ltd. All right reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -114,7 +115,8 @@ char **__vpn_config_get_string_list(GKeyFile *key_file, const char *group_name,
 bool __vpn_config_get_boolean(GKeyFile *key_file, const char *group_name,
 			const char *key, bool default_value);
 
-int __vpn_settings_init(const char *file);
+int __vpn_settings_init(const char *file, const char *dir);
+int __vpn_settings_process_config(const char *configfile);
 void __vpn_settings_cleanup(void);
 GKeyFile *__vpn_settings_load_config(const char *file);
 unsigned int __vpn_settings_get_timeout_inputreq(void);
-- 
2.47.3

