Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411F2CA3
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 09:00:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEF3F5D1A7;
	Tue, 25 Jan 2022 10:00:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643101229; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=JMP0gxZa/HkpWecA+BuqZL+pw2G7FLwXUKRmco8Fz4Q=;
	b=bflxQnfbNkC4aq3baGLn9WCaFwKapFILK/E9MPdYWntL997Esdt+i3Bg80+UqJYLMBjeHv
	KdUk5UPUAiayrcZzxbE3uW1OPN2eeerBfEDVvaO266eJscIqgACshXnkNgMg/h9fo7T4Pa
	UtzNT2nnDepFN6lkpcn6+Diq3frz8fppnJjMIcFUDGtdPzKIY2GDH64AnH/OQObTb0ZJD6
	9jj6yHpz8sDMrkUhtphYeHLACRmz1R9npMRxMrUqOs79YV9kEQUeJHJbocR9ebpz2D1x4w
	5aGeuhLEJO2jW7HQ098g4w6XAAYQAWXx9npEjD7WFzr3SUAvl0zNfjOxD/bh4Q==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 1/5] main: Use g_strdup for online_check_ipv{4,6}_url config
Date: Tue, 25 Jan 2022 10:00:22 +0100
Message-Id: <20220125090026.5108-2-wagi@monom.org>
In-Reply-To: <20220125090026.5108-1-wagi@monom.org>
References: <20220125090026.5108-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

We are using g_free() on ConnMan's exist path, hence we would try to
free non malloc memory.
---
 src/main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index b8c9560af177..e209cf261300 100644
--- a/src/main.c
+++ b/src/main.c
@@ -127,8 +127,8 @@ static struct {
 	.vendor_class_id = NULL,
 	.enable_online_check = true,
 	.enable_online_to_ready_transition = false,
-	.online_check_ipv4_url = DEFAULT_ONLINE_CHECK_IPV4_URL,
-	.online_check_ipv6_url = DEFAULT_ONLINE_CHECK_IPV6_URL,
+	.online_check_ipv4_url = NULL,
+	.online_check_ipv6_url = NULL,
 	.online_check_initial_interval = DEFAULT_ONLINE_CHECK_INITIAL_INTERVAL,
 	.online_check_max_interval = DEFAULT_ONLINE_CHECK_MAX_INTERVAL,
 	.auto_connect_roaming_services = false,
@@ -503,6 +503,9 @@ static void parse_config(GKeyFile *config)
 					CONF_ONLINE_CHECK_IPV4_URL, &error);
 	if (!error)
 		connman_settings.online_check_ipv4_url = string;
+	else
+		connman_settings.online_check_ipv4_url =
+			g_strdup(DEFAULT_ONLINE_CHECK_IPV4_URL);
 
 	g_clear_error(&error);
 
@@ -510,6 +513,10 @@ static void parse_config(GKeyFile *config)
 					CONF_ONLINE_CHECK_IPV6_URL, &error);
 	if (!error)
 		connman_settings.online_check_ipv6_url = string;
+	else
+		connman_settings.online_check_ipv6_url =
+			g_strdup(DEFAULT_ONLINE_CHECK_IPV6_URL);
+
 
 	g_clear_error(&error);
 
-- 
2.34.1

