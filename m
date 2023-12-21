Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429C78E64
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 42C6373207
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:18 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 03E1273219
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:17 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 20/60] main: Introduce the 'OnlineCheck{Failures,Successes}Threshold' settings.
Date: Thu, 21 Dec 2023 14:34:27 -0800
Message-ID: <20231221223508.2365510-21-gerickson@nuovations.com>
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

When both "EnableOnlineCheck" and "EnableOnlineToReadyTransition" are
asserted, "OnlineCheckFailuresThreshold" is the number of failed
back-to-back "ready" to "online" HTTP-based Internet reachability
checks that will be allowed before marking a service as "failed" from
a reachability perspective, sorting it at a lower priority than other
services not so marked.

When both "EnableOnlineCheck" and "EnableOnlineToReadyTransition" are
asserted, "OnlineCheckSuccessesThreshold" is the number of successful
back-to-back "ready" to "online" HTTP-based Internet reachability
checks that must be met before clearing a service as "failed" from a
reachability perspective and allowing it to transition to the "online"
state again, allowing it to sort back to a higher priority relative to
other network services.
---
 src/main.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/src/main.c b/src/main.c
index d2ec8296f490..8e47426f2e8c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -56,6 +56,9 @@
 #define DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL 1
 #define DEFAULT_ONLINE_CHECK_MAX_INTERVAL 12
 
+#define DEFAULT_ONLINE_CHECK_FAILURES_THRESHOLD 6
+#define DEFAULT_ONLINE_CHECK_SUCCESSES_THRESHOLD 6
+
 #define ONLINE_CHECK_INTERVAL_STYLE_FIBONACCI "fibonacci"
 #define ONLINE_CHECK_INTERVAL_STYLE_GEOMETRIC "geometric"
 
@@ -114,6 +117,8 @@ static struct {
 	unsigned int online_check_connect_timeout_ms;
 	unsigned int online_check_initial_interval;
 	unsigned int online_check_max_interval;
+	unsigned int online_check_failures_threshold;
+	unsigned int online_check_successes_threshold;
 	char *online_check_interval_style;
 	bool auto_connect_roaming_services;
 	bool acd;
@@ -146,6 +151,10 @@ static struct {
 	.online_check_connect_timeout_ms = DEFAULT_ONLINE_CHECK_CONNECT_TIMEOUT,
 	.online_check_initial_interval = DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL,
 	.online_check_max_interval = DEFAULT_ONLINE_CHECK_MAX_INTERVAL,
+	.online_check_failures_threshold =
+		DEFAULT_ONLINE_CHECK_FAILURES_THRESHOLD,
+	.online_check_successes_threshold =
+		DEFAULT_ONLINE_CHECK_SUCCESSES_THRESHOLD,
 	.online_check_interval_style = NULL,
 	.auto_connect_roaming_services = false,
 	.acd = false,
@@ -178,6 +187,8 @@ static struct {
 #define CONF_ONLINE_CHECK_CONNECT_TIMEOUT "OnlineCheckConnectTimeout"
 #define CONF_ONLINE_CHECK_INITIAL_INTERVAL "OnlineCheckInitialInterval"
 #define CONF_ONLINE_CHECK_MAX_INTERVAL     "OnlineCheckMaxInterval"
+#define CONF_ONLINE_CHECK_FAILURES_THRESHOLD "OnlineCheckFailuresThreshold"
+#define CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD "OnlineCheckSuccessesThreshold"
 #define CONF_ONLINE_CHECK_INTERVAL_STYLE "OnlineCheckIntervalStyle"
 #define CONF_AUTO_CONNECT_ROAMING_SERVICES "AutoConnectRoamingServices"
 #define CONF_ACD                        "AddressConflictDetection"
@@ -211,6 +222,8 @@ static const char *supported_options[] = {
 	CONF_ONLINE_CHECK_CONNECT_TIMEOUT,
 	CONF_ONLINE_CHECK_INITIAL_INTERVAL,
 	CONF_ONLINE_CHECK_MAX_INTERVAL,
+	CONF_ONLINE_CHECK_FAILURES_THRESHOLD,
+	CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD,
 	CONF_ONLINE_CHECK_INTERVAL_STYLE,
 	CONF_AUTO_CONNECT_ROAMING_SERVICES,
 	CONF_ACD,
@@ -604,6 +617,38 @@ static void parse_config(GKeyFile *config)
 			DEFAULT_ONLINE_CHECK_MAX_INTERVAL;
 	}
 
+	/* OnlineCheckFailuresThreshold */
+
+	integer = g_key_file_get_integer(config, "General",
+			CONF_ONLINE_CHECK_FAILURES_THRESHOLD, &error);
+	if (!error && integer >= 0)
+		connman_settings.online_check_failures_threshold = integer;
+
+	if (connman_settings.online_check_failures_threshold < 1) {
+		connman_warn("Incorrect online check failures threshold [%d]",
+			connman_settings.online_check_failures_threshold);
+		connman_settings.online_check_failures_threshold =
+			DEFAULT_ONLINE_CHECK_FAILURES_THRESHOLD;
+	}
+
+	g_clear_error(&error);
+
+	/* OnlineCheckSuccessesThreshold */
+
+	integer = g_key_file_get_integer(config, "General",
+			CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD, &error);
+	if (!error && integer >= 0)
+		connman_settings.online_check_successes_threshold = integer;
+
+	if (connman_settings.online_check_successes_threshold < 1) {
+		connman_warn("Incorrect online check successes threshold [%d]",
+			connman_settings.online_check_successes_threshold);
+		connman_settings.online_check_successes_threshold =
+			DEFAULT_ONLINE_CHECK_SUCCESSES_THRESHOLD;
+	}
+
+	g_clear_error(&error);
+
 	string = __connman_config_get_string(config, "General",
 					CONF_ONLINE_CHECK_INTERVAL_STYLE, &error);
 	if (!error) {
@@ -921,6 +966,12 @@ unsigned int connman_setting_get_uint(const char *key)
 	if (g_str_equal(key, CONF_ONLINE_CHECK_MAX_INTERVAL))
 		return connman_settings.online_check_max_interval;
 
+	if (g_str_equal(key, CONF_ONLINE_CHECK_FAILURES_THRESHOLD))
+		return connman_settings.online_check_failures_threshold;
+
+	if (g_str_equal(key, CONF_ONLINE_CHECK_SUCCESSES_THRESHOLD))
+		return connman_settings.online_check_successes_threshold;
+
 	return 0;
 }
 
-- 
2.42.0

