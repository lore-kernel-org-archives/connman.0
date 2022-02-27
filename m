Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3E4A91
	for <connman@lists.linux.dev>; Sun, 27 Feb 2022 17:16:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DDF425D1B9;
	Sun, 27 Feb 2022 18:15:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1645982156; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Ll+IVND1VppAs8Ehz7iyqljYNCyAMsp39gYlv/Rkjb0=;
	b=mjwCTxW0tiBj6t5kEU+IjwZvFZcxL+sHROfTl5AbEGODZQ0+eF9Dm4fGNiOJJ5WYPIXmTh
	oNG0AD5gsLYANNqTAj/X9E5UQdA/iG8xh89ziMrzeCh8Gp2w76tIVoMHQ5pksLxjh1nf4z
	4DqM+k1EMgYwXMddUST+lTRJIMNf6DFYJbGseYO23iTeorZG0q3N+b4t4IeGpdxLdkNf9k
	vlCQhxL9tm0vv+etONgMYbLSQCvSjAECuX+0DoIRmg5iBUAg9cSYFVq+hnohC0m8Po0pT0
	yaZZt6tJmcmH674IgCPlAYk2kl6gVixLEi6ys4zT5qwdPQ7U15a6SdjZ5H+YXA==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: daniel antoine <univac55@gmail.com>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH] main: Set default online check URL also when no config provided
Date: Sun, 27 Feb 2022 18:15:49 +0100
Message-Id: <20220227171549.32664-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

We need to set the default URL also when no config exist.

Reported by: Daniel Antoine <univac55@gmail.com>

Fixes: 9d7e55f40e80 ("wispr: Add online check url config options")
---
 src/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index e209cf261300..bf6ccad5fc08 100644
--- a/src/main.c
+++ b/src/main.c
@@ -318,11 +318,17 @@ static void parse_config(GKeyFile *config)
 
 	if (!config) {
 		connman_settings.auto_connect =
-			parse_service_types(default_auto_connect, CONF_ARRAY_SIZE(default_auto_connect));
+			parse_service_types(default_auto_connect,
+					CONF_ARRAY_SIZE(default_auto_connect));
 		connman_settings.favorite_techs =
-			parse_service_types(default_favorite_techs, CONF_ARRAY_SIZE(default_favorite_techs));
+			parse_service_types(default_favorite_techs,
+					CONF_ARRAY_SIZE(default_favorite_techs));
 		connman_settings.blacklisted_interfaces =
 			g_strdupv(default_blacklist);
+		connman_settings.online_check_ipv4_url =
+			g_strdup(DEFAULT_ONLINE_CHECK_IPV4_URL);
+		connman_settings.online_check_ipv6_url =
+			g_strdup(DEFAULT_ONLINE_CHECK_IPV6_URL);
 		return;
 	}
 
-- 
2.35.1

