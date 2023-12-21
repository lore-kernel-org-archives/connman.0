Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E924EB64A
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5C6E07324D
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:59 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1E64773250
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:59 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 58/60] main: Add comments tags for online check-related settings.
Date: Wed, 20 Dec 2023 22:17:21 -0800
Message-ID: <20231221061734.2344286-59-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221061734.2344286-1-gerickson@nuovations.com>
References: <20231221061734.2344286-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

At this point, there are a sufficient number of settings in
'parse_config' that it is easy to lose track of where the block for
one settings handler ends and the next begins.

This adds comment tags for online check-related settings to make it
easy, at a glance, to see where the block for each is.
---
 src/main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 97ed3ed744b1..c8d97ee80f03 100644
--- a/src/main.c
+++ b/src/main.c
@@ -565,6 +565,8 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
+	/* EnableOnlineCheck */
+
 	boolean = __connman_config_get_bool(config, "General",
 					CONF_ENABLE_ONLINE_CHECK, &error);
 	if (!error) {
@@ -575,6 +577,8 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
+	/* EnableOnlineToReadyTransition */
+
 	boolean = __connman_config_get_bool(config, "General",
 			CONF_ENABLE_ONLINE_TO_READY_TRANSITION, &error);
 	if (!error) {
@@ -603,7 +607,7 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
-	/* OnlineCheckConnecTimeout */
+	/* OnlineCheckConnectTimeout */
 
 	real = g_key_file_get_double(config, "General",
 			CONF_ONLINE_CHECK_CONNECT_TIMEOUT, &error);
@@ -624,6 +628,8 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
+	/* OnlineCheckIPv4URL */
+
 	string = __connman_config_get_string(config, "General",
 					CONF_ONLINE_CHECK_IPV4_URL, &error);
 	if (!error)
@@ -634,6 +640,8 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
+	/* OnlineCheckIPv6URL */
+
 	string = __connman_config_get_string(config, "General",
 					CONF_ONLINE_CHECK_IPV6_URL, &error);
 	if (!error)
@@ -645,6 +653,8 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
+	/* OnlineCheck{Initial,Max}Interval */
+
 	integer = g_key_file_get_integer(config, "General",
 			CONF_ONLINE_CHECK_INITIAL_INTERVAL, &error);
 	if (!error && integer >= 0)
@@ -703,6 +713,8 @@ static void parse_config(GKeyFile *config)
 
 	g_clear_error(&error);
 
+	/* OnlineCheckIntervalStyle */
+
 	string = __connman_config_get_string(config, "General",
 					CONF_ONLINE_CHECK_INTERVAL_STYLE, &error);
 	if (!error) {
-- 
2.42.0

