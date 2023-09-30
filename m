Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047F199A9
	for <connman@lists.linux.dev>; Sat, 30 Sep 2023 22:27:05 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1e0ee4e777bso2455249fac.3
        for <connman@lists.linux.dev>; Sat, 30 Sep 2023 15:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696112824; x=1696717624; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KouvtJAGo/D95rlXuLp3bsyqh+iMAT2tMo4De8TZC4=;
        b=ULqJbP9MpComDn5ZO9a4tKIMYATmlyvyWGgfDljCffSa/85jGK6DcRs11YcLyuc4SE
         Rk3se/SDBFokO9MaIPZPJegnqwhYyLsSIpalhoS74Y9iB1TKkRb+H3oJR9sAk3/hvbB3
         qgpt/sef7gQlWUCZt40/0y/XUx7O51tCboRTC+I0Wmzwkc5MGV/IRoZp3t1Fppaq3w9S
         Rg1RqcTvoCYpVIPtDio5wRBFWptxBYlHDeOBKE/jsr8TcgiTjwj1Ky2KWgxFFOaLIYdv
         pDo2Exh8NgR4ji2uSPW4kZcGY2aFYr4tIHu1n/JsI4J/aBbLE2Hq2nUXj1Zovw7wD/vV
         Ww0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696112824; x=1696717624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KouvtJAGo/D95rlXuLp3bsyqh+iMAT2tMo4De8TZC4=;
        b=oR80p6Ww/pcEZj4OHhse0nLTr7LRnkZ029TCtBFlA6aOzhcFRKtamRbZ+h6VDrvBC7
         nE7be5UVlllX4KvXvws98asrCcZ8lQYXcHFHA3BPpbVj90HXoqLozkEYhshpJzdHtsj+
         sg6b7oM91O3A8ch97++ZgcSHGJi8NCVHcZrD3PCz+5SC4YR2xFaqrwh8NtckpHAncazu
         JWSPPcS5SQEWSLY6fjqkwFSbSYGVkqAfEFbC8XCZ1U/ttg3AmyE7rNia6rQUCafN4q3A
         olPQ0mvec0N27MZ2NNTv/KygBW8Gg2J4fsPhEH/qvnmbPIWe4bOT0pF6vEWWj32/bs4x
         7gFw==
X-Gm-Message-State: AOJu0YyNPOPa3G8p+s7Sxb3WXnQNqvde5UIJTL+NOvv1uDnu/8DfWLYB
	DSTvzauROLrTn1ADNJueW1IDYWzTQgc=
X-Google-Smtp-Source: AGHT+IFNIUjgTvSDuaPjfo11fel5p/annFavTahDNfyEj0inTVN1twaYVfWw0nuuaY7Lq8sUfhIiWg==
X-Received: by 2002:a05:6870:470a:b0:1d6:3d31:fb4b with SMTP id b10-20020a056870470a00b001d63d31fb4bmr9192111oaq.24.1696112824465;
        Sat, 30 Sep 2023 15:27:04 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm2328360oal.1.2023.09.30.15.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 15:27:03 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/6] network: Remove unused functions
Date: Sat, 30 Sep 2023 17:25:53 -0500
Message-ID: <20230930222615.654178-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230930222615.654178-1-denkenz@gmail.com>
References: <20230930222615.654178-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

connman_network_set_wifi_channel and connman_network_get_wifi_channel
functions were never used.  Get rid of them.
---
 include/network.h |  3 ---
 src/network.c     | 14 --------------
 2 files changed, 17 deletions(-)

diff --git a/include/network.h b/include/network.h
index 5bca62ad..e831e75e 100644
--- a/include/network.h
+++ b/include/network.h
@@ -129,9 +129,6 @@ uint8_t connman_network_get_strength(struct connman_network *network);
 int connman_network_set_frequency(struct connman_network *network,
 					uint16_t frequency);
 uint16_t connman_network_get_frequency(struct connman_network *network);
-int connman_network_set_wifi_channel(struct connman_network *network,
-					uint16_t channel);
-uint16_t connman_network_get_wifi_channel(struct connman_network *network);
 int connman_network_set_autoconnect(struct connman_network *network,
 				bool autoconnect);
 
diff --git a/src/network.c b/src/network.c
index e3e02d16..e7a2572d 100644
--- a/src/network.c
+++ b/src/network.c
@@ -87,7 +87,6 @@ struct connman_network {
 		void *ssid;
 		int ssid_len;
 		char *mode;
-		unsigned short channel;
 		char *security;
 		char *passphrase;
 		char *eap;
@@ -2119,14 +2118,6 @@ uint16_t connman_network_get_frequency(struct connman_network *network)
 	return network->frequency;
 }
 
-int connman_network_set_wifi_channel(struct connman_network *network,
-						uint16_t channel)
-{
-	network->wifi.channel = channel;
-
-	return 0;
-}
-
 int connman_network_set_autoconnect(struct connman_network *network,
 				bool autoconnect)
 {
@@ -2142,11 +2133,6 @@ bool __connman_network_native_autoconnect(struct connman_network *network)
 	return true;
 }
 
-uint16_t connman_network_get_wifi_channel(struct connman_network *network)
-{
-	return network->wifi.channel;
-}
-
 /**
  * connman_network_set_string:
  * @network: network structure
-- 
2.42.0

