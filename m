Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5111E4A1
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7774F73206
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:34 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 398417321D
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:34 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 60/60] main: Add deprecation warnings for 'EnableOnlineCheck' and 'EnableOnlineToReadyTransition'.
Date: Thu, 21 Dec 2023 14:35:07 -0800
Message-ID: <20231221223508.2365510-61-gerickson@nuovations.com>
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

This adds deprecation warning log messages for 'EnableOnlineCheck' and
'EnableOnlineToReadyTransition' with guidance to transition to
'OnlineCheckMode'.
---
 src/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/main.c b/src/main.c
index f8007cb3be65..241c713d7980 100644
--- a/src/main.c
+++ b/src/main.c
@@ -608,6 +608,10 @@ static void parse_config(GKeyFile *config)
 	boolean = __connman_config_get_bool(config, "General",
 					CONF_ENABLE_ONLINE_CHECK, &error);
 	if (!error) {
+		connman_warn("\"%s\" is deprecated; use \"%s\" instead.",
+			CONF_ENABLE_ONLINE_CHECK,
+			CONF_ONLINE_CHECK_MODE);
+
 		connman_settings.enable_online_check = boolean;
 	}
 
@@ -618,6 +622,10 @@ static void parse_config(GKeyFile *config)
 	boolean = __connman_config_get_bool(config, "General",
 			CONF_ENABLE_ONLINE_TO_READY_TRANSITION, &error);
 	if (!error) {
+		connman_warn("\"%s\" is deprecated; use \"%s\" instead.",
+			CONF_ENABLE_ONLINE_TO_READY_TRANSITION,
+			CONF_ONLINE_CHECK_MODE);
+
 		connman_settings.enable_online_to_ready_transition = boolean;
 	}
 
-- 
2.42.0

