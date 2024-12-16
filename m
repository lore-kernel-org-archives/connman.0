Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857D1D54F4
	for <connman@lists.linux.dev>; Mon, 16 Dec 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382615; cv=none; b=h5zeiosAMuSj81OMOtU6jbGIOMl/gzRAPRdXVp7a6L885rDbZQ2JFxOvts+CXYtUgwFFBbJQwK4RVK9GcYE6j2/+JAzikxxMYQRaJN/w5PH1GcwTVgoSrLmZt7kPcgYjxo463XLOIYi4/LnycBfibGI39yY+ALqoGTw6u+A/Cg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382615; c=relaxed/simple;
	bh=RwlMZT+hHfT+7Y6xOv9bRTsCA5Yw2ZySP6eLE1dvMHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SYpfoY4KtafhvNS2uKverM/RvQkNSJebnisrddlSaLKuOGdZOId+f3vCC7ETZIRfRHDRGciLARl4Fi/Y6HDx36hmK5tFmWWEf7c6uNl/zIQkxWoALo1qrNatdrY1TsvA/f+f0byQSoypx0MPGKPWSOtju8dHo5HCRdwiu6re1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=ksNO40kj; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="ksNO40kj"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E37D0164B37
	for <connman@lists.linux.dev>; Mon, 16 Dec 2024 15:56:44 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D64C4124F35
	for <connman@lists.linux.dev>; Mon, 16 Dec 2024 15:56:42 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/1] main: Log configuration file used rather than 'MAINFILE'.
Date: Mon, 16 Dec 2024 12:56:36 -0800
Message-ID: <20241216205636.2143336-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=8ozL0kHMrbqSmvotmyVJ3swxBZc2qT2Lqr6vQYA+Qvw=; b=ksNO40kjiIqojRpakOewBJhiWiOz43OxzZPobWD9b+M9hMZgMY6HysmPCM/3czVu14nJYTz1EuaOry9wfRNhkB9ctkbS6EYViUKiFslL206q6LFnIWcOsdAuA7/pLbTEitr2hqp4e4zOrdxLKNKoq9jk5spJF6WAWZLo0ErNKAcfNcSinai/6yozGBj+SVL/68MZi7bgeXdaws/349CA0z9DxOrKbyKtqjl0lP5M/YqswmUQMQ6nBI8RaJSBwJVZgDEWC/qfhjMS6JvfBtEj0daZO/ibeYHcmS4lZv7X3WF8I5Fndxnlf0C6ojxXGasjjJ5tIGd6Lzn2Cd+hb/2wFQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

When using the -c <FILE> or --config=<FILE> command line options,
Connection Manager warning-level log and DBG messages incorrectly
report 'main.conf' rather than the actually configuration file being
used.

This corrects this by passing the actual configuration file path,
whether the default or specified via '-c' or '--config', through to
both 'check_config' and 'parse_config'.
---
 src/main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/main.c b/src/main.c
index f5da979b0366..31a9f90a55bc 100644
--- a/src/main.c
+++ b/src/main.c
@@ -312,12 +312,12 @@ static char **parse_fallback_nameservers(char **nameservers, gsize len)
 	return servers;
 }
 
-static void check_config(GKeyFile *config)
+static void check_config(GKeyFile *config, const char *file)
 {
 	char **keys;
 	int j;
 
-	if (!config)
+	if (!config || !file)
 		return;
 
 	keys = g_key_file_get_groups(config, NULL);
@@ -325,7 +325,7 @@ static void check_config(GKeyFile *config)
 	for (j = 0; keys && keys[j]; j++) {
 		if (g_strcmp0(keys[j], GENERAL_GROUP) != 0)
 			connman_warn("Unknown group %s in %s",
-						keys[j], MAINFILE);
+						keys[j], file);
 	}
 
 	g_strfreev(keys);
@@ -345,7 +345,7 @@ static void check_config(GKeyFile *config)
 		}
 		if (!found && !supported_options[i])
 			connman_warn("Unknown option %s in %s",
-						keys[j], MAINFILE);
+						keys[j], file);
 	}
 
 	g_strfreev(keys);
@@ -419,7 +419,7 @@ static void online_check_settings_log(void)
 		connman_settings.online_check_successes_threshold);
 }
 
-static void parse_config(GKeyFile *config)
+static void parse_config(GKeyFile *config, const char *file)
 {
 	GError *error = NULL;
 	bool boolean;
@@ -432,7 +432,7 @@ static void parse_config(GKeyFile *config)
 	int integer;
 	double real;
 
-	if (!config) {
+	if (!config || !file) {
 		connman_settings.auto_connect =
 			parse_service_types(default_auto_connect,
 					CONF_ARRAY_SIZE(default_auto_connect));
@@ -450,7 +450,7 @@ static void parse_config(GKeyFile *config)
 		return;
 	}
 
-	DBG("parsing %s", MAINFILE);
+	DBG("parsing %s", file);
 
 	boolean = g_key_file_get_boolean(config, GENERAL_GROUP,
 						CONF_BG_SCAN, &error);
@@ -828,8 +828,8 @@ static int config_init(const char *file)
 	GKeyFile *config;
 
 	config = load_config(file);
-	check_config(config);
-	parse_config(config);
+	check_config(config, file);
+	parse_config(config, file);
 	if (config)
 		g_key_file_free(config);
 
-- 
2.45.0

