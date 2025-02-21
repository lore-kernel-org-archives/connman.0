Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7121E091
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153455; cv=none; b=YLG0gd3nbwTehaY61y2rtoeKCatvfVl4VV0cmbbGHGO8utV+RCDTsFqQs6jJ0G3glgf9ywHjGDxZioCuOT5t9/V1uxgaijB8SP8RBlxO4yVGmHI6vbqP8PsFK8BT+JW9XTEtOlkWZPFKfff4vqNco6RsNeTdwWo199QcLgYNSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153455; c=relaxed/simple;
	bh=RwlMZT+hHfT+7Y6xOv9bRTsCA5Yw2ZySP6eLE1dvMHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Lfv8aMIzfxjKxaZDHnQs6KLRX83T7bKU+GXRq+FQMKoYZJ8eobTg5G3ROoVtFaXFOdd7DAaBI39MDD0I1FPMQwPBZn8Q0Iw+rAi6MknKdDWk138La/em8vJ9fgKMs5+FEJADEphfHVD8c3uxKVwK9CbMzZEmDYhY9RUHEP6hLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=UeuLvjOH; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="UeuLvjOH"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B7C5F1649CB
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:32 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 6FC0F126356
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:32 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/1 RESEND] main: Log configuration file used rather than 'MAINFILE'.
Date: Fri, 21 Feb 2025 07:57:31 -0800
Message-ID: <20250221155731.760102-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=8ozL0kHMrbqSmvotmyVJ3swxBZc2qT2Lqr6vQYA+Qvw=; b=UeuLvjOHsdHVk3HksiuosrK3TgfAaVXKNRzmqRR2r0LpfPJqLQZHTbplHGZhXUROy1xwrK1oB2R1uyNbiFBIHTSIZWiyFfh/YLjQH3gT204954jL09tUkP6EuuV9pbu3fTa1+i/wEzoK3OOMV8KS/Yvn2J+hOH9BTtqw3/YpooSzfmiz54OVjUSS2UV19hpU2qBYf0Q35k3njMbZRYYQxzKpj6rUwhW/3vmRd5eduV6+axZjvKcXClj5s1lFaSDfgT/CjOTGhms2kBZ6YNlxIASIvScnbmmylUo3bhJtnBgj7Vln5eYfANaHG6hJh9WlXoLhAvaJROze2W35mB+Gvw==
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

