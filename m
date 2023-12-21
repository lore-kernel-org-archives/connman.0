Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4EB66F
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 17F6173203
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:34 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CA9DB7321E
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:33 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 59/60] main: Consolidate logging of online check-related settings.
Date: Thu, 21 Dec 2023 14:35:06 -0800
Message-ID: <20231221223508.2365510-60-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221223508.2365510-1-gerickson@nuovations.com>
References: <20231221223508.2365510-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This consolidates logging, at the info level, of all online
check-related settings to a single place, 'online_check_settings_log'
such that when the 'OnlineCheckMode' is "none", the following is
logged:

    Online check mode "none"

when 'OnlineCheckMode' is "one-shot", the following are logged:

    Online check mode "one-shot"
    Online check IPv4 URL "http://ipv4.connman.net/online/status.html"
    Online check IPv6 URL "http://ipv6.connman.net/online/status.html"
    Online check interval style "geometric"
    Online check interval range [1, 12]
    Online check connect timeout 12100 ms

and when 'OnlineCheckMode' is "continuous the following are logged:

    Online check mode "continuous"
    Online check IPv4 URL "http://ipv4.connman.net/online/status.html"
    Online check IPv6 URL "http://ipv6.connman.net/online/status.html"
    Online check interval style "geometric"
    Online check interval range [1, 12]
    Online check connect timeout 12100 ms
    Online check continuous mode failures threshold 6
    Online check continuous mode successes threshold 6
---
 src/main.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/src/main.c b/src/main.c
index c8d97ee80f03..f8007cb3be65 100644
--- a/src/main.c
+++ b/src/main.c
@@ -379,6 +379,44 @@ static void online_check_mode_set_to_deprecated(void)
 	}
 }
 
+static void online_check_settings_log(void)
+{
+	connman_info("Online check mode \"%s\"",
+				 __connman_service_online_check_mode2string(
+					connman_settings.online_check_mode));
+
+	if (connman_settings.online_check_mode ==
+			CONNMAN_SERVICE_ONLINE_CHECK_MODE_NONE)
+		return;
+
+	connman_info("Online check IPv4 URL \"%s\"",
+		connman_settings.online_check_ipv4_url);
+
+	connman_info("Online check IPv6 URL \"%s\"",
+		connman_settings.online_check_ipv6_url);
+
+	connman_info("Online check interval style \"%s\"",
+		connman_settings.online_check_interval_style);
+
+	connman_info("Online check interval range [%u, %u]",
+		connman_settings.online_check_initial_interval,
+		connman_settings.online_check_max_interval);
+
+	if (connman_settings.online_check_connect_timeout_ms)
+		connman_info("Online check connect timeout %u ms",
+			connman_settings.online_check_connect_timeout_ms);
+
+	if (connman_settings.online_check_mode !=
+			CONNMAN_SERVICE_ONLINE_CHECK_MODE_CONTINUOUS)
+		return;
+
+	connman_info("Online check continuous mode failures threshold %d",
+		connman_settings.online_check_failures_threshold);
+
+	connman_info("Online check continuous mode successes threshold %d",
+		connman_settings.online_check_successes_threshold);
+}
+
 static void parse_config(GKeyFile *config)
 {
 	GError *error = NULL;
@@ -571,8 +609,6 @@ static void parse_config(GKeyFile *config)
 					CONF_ENABLE_ONLINE_CHECK, &error);
 	if (!error) {
 		connman_settings.enable_online_check = boolean;
-		if (!boolean)
-			connman_info("Online check disabled by main config.");
 	}
 
 	g_clear_error(&error);
@@ -622,10 +658,6 @@ static void parse_config(GKeyFile *config)
 				real * 1000;
 	}
 
-	if (connman_settings.online_check_connect_timeout_ms)
-		connman_info("Online check connect timeout %ums",
-			connman_settings.online_check_connect_timeout_ms);
-
 	g_clear_error(&error);
 
 	/* OnlineCheckIPv4URL */
@@ -650,7 +682,6 @@ static void parse_config(GKeyFile *config)
 		connman_settings.online_check_ipv6_url =
 			g_strdup(DEFAULT_ONLINE_CHECK_IPV6_URL);
 
-
 	g_clear_error(&error);
 
 	/* OnlineCheck{Initial,Max}Interval */
@@ -777,6 +808,8 @@ static void parse_config(GKeyFile *config)
 		g_free(string);
 
 	g_clear_error(&error);
+
+	online_check_settings_log();
 }
 
 static int config_init(const char *file)
-- 
2.42.0

