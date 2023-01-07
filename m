Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B279DA
	for <connman@lists.linux.dev>; Sat,  7 Jan 2023 21:50:37 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id bp44so5193437qtb.0
        for <connman@lists.linux.dev>; Sat, 07 Jan 2023 13:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkyShVAJOJfhtKXxSepWjSR7votavdSTsRAhtNhlelg=;
        b=Xa3RZHDrk2jghsZShJ902Ac9UUrj5hr+H1R84FXQ7grKDq8XV7NgBYiMbLQZcqLkpR
         zE34kVEL3f2WWfoTTqv2tzICVlUDQOjpPzuMHeDvknUAn69TLOT7bbaLAChTlR57icYv
         HaERPMkru+hpSbO6ce0o7utmSYZt5TbVi8jCADKqqDydv30E0eaXQJjEwfcbaurH1CB1
         ECjFQOU9mq1Pht0NnZqj6s4rYkzIpfR7Jl06+0nTfWuTFMTAjzDi4X5eKKWB07jZi3NA
         FGLYO8QYCDdddClD62Wy0xd50WrjGQB6G8EVLNFxJ1vugmLlYeemWwh+ieOAUWhlHd00
         zplg==
X-Gm-Message-State: AFqh2ko/XOzh48wAbI5W6ehHuEUtAl9bnitit4dFWKYxXtB3Iz44d56z
	mMS/+Zg4NYUZwIb3h/JKJHMHEQuRmzHH02qf6cHwTvWZ
X-Google-Smtp-Source: AMrXdXs7MbewqiLvSw+249XH7f0igNBod4X7DVDiQNJNaoapk3ZXnHk6WjVFksq9dQCVs2saLqWpaA==
X-Received: by 2002:ac8:520c:0:b0:3a8:1079:b844 with SMTP id r12-20020ac8520c000000b003a81079b844mr78975912qtn.46.1673128236289;
        Sat, 07 Jan 2023 13:50:36 -0800 (PST)
Received: from localhost ([45.42.73.38])
        by smtp.gmail.com with ESMTPSA id do14-20020a05620a2b0e00b006f8665f483fsm2714248qkb.85.2023.01.07.13.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 13:50:36 -0800 (PST)
From: lists@jade.fyi
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>,
	Jade Lovelace <lists@jade.fyi>
Subject: [PATCH 2/3] plugins/iwd: Fix typo in create_known_network name
Date: Sat,  7 Jan 2023 16:50:22 -0500
Message-Id: <20230107215023.8288-3-lists@jade.fyi>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230107215023.8288-1-lists@jade.fyi>
References: <20230107215023.8288-1-lists@jade.fyi>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jade Lovelace <lists@jade.fyi>

Signed-off-by: Jade Lovelace <lists@jade.fyi>
---
 plugins/iwd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index 5593fa74..9d437b3d 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -1714,7 +1714,7 @@ static void init_auto_connect(struct iwd_known_network *iwdkn)
 	}
 }
 
-static void create_know_network(GDBusProxy *proxy)
+static void create_known_network(GDBusProxy *proxy)
 {
 	const char *path = g_dbus_proxy_get_path(proxy);
 	struct iwd_known_network *iwdkn;
@@ -1825,7 +1825,7 @@ static void object_added(GDBusProxy *proxy, void *user_data)
 	else if (!strcmp(interface, IWD_NETWORK_INTERFACE))
 		create_network(proxy);
 	else if (!strcmp(interface, IWD_KNOWN_NETWORK_INTERFACE))
-		create_know_network(proxy);
+		create_known_network(proxy);
 	else if (!strcmp(interface, IWD_STATION_INTERFACE))
 		create_station(proxy);
 	else if (!strcmp(interface, IWD_AP_INTERFACE))
-- 
2.38.1

