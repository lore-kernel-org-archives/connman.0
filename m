Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC136AAB
	for <connman@lists.linux.dev>; Wed, 11 Jan 2023 19:08:52 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id jl4so17776865plb.8
        for <connman@lists.linux.dev>; Wed, 11 Jan 2023 11:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2WGHwebJxsz2UF1SV5pEEys8XSF5eH591NVoGRAiJ8=;
        b=DvhABIY9CCsUZmVjxNSQsOt/iuu1DUzum75dCM0HUkUn+BCImpGFkxpPY5MRqh6M1C
         8Df3ifXfoPZ9EzqzFXUxRmyzO36aNPn1LnR859ng+hIyoYMQ3eg1+JHgNJ8DEDbzFuVb
         asI+M5JgS9tO9Znj/30EVaoBgutGTDr8m6tQTXao86u8cTdEspQSLBISnBxIUN4FOQCh
         S6cb4zw41pQPnE/r/op+twfKBHd8ZSmFgws50YqJ8bNTWHGxax90woybmfJer2lpVOwt
         QcBHkJmAgY6tEijBNINDAUpakyq8pcEumVIoF3kH2MLPW0J2davcuWzi5n5MXAcEPWBH
         5vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2WGHwebJxsz2UF1SV5pEEys8XSF5eH591NVoGRAiJ8=;
        b=1DwRgWAppwZzVum4QBYaxgVnS1WVD48pexWrW3l8WN4uRrhy4hhnmgeI4Knf6s27Jz
         RKOq7HbASuup3H7+Q6aIMtlueX9AfpBJd1k2hwxOnXz+lV3GTprxQaUset62BZC/9T8d
         lifOlRHzgvPd6aw9UlAympwpI4f95z1sGrX1c+QIYHqiuN1Ehk7dfI3qUdfylFd7uRxo
         baeHBpDj1ZdlMf2pMFvf/89Tg7Ottl7X/xT7408SnBmCFyQupma2GH6XIGrz0AuTZvSc
         Q9Z3Q1dFmW3GXgLtpYb/9Jqzh8wpmqJEmt1QyeAXYPxEgem3BNKSnDxD4J2b+3djMq0b
         OA/w==
X-Gm-Message-State: AFqh2koQO0LkFB7EBGArdRCAltrB4r0V6fERY2zV66lkbfUZ6te3d3Wq
	djRH+m1UITUNqK8hNjQwqAd8JJhiwZ3pIht+9+e3Lh/M
X-Google-Smtp-Source: AMrXdXsP2FnWM8upuMqUfZ5IS4BbFJKN9neEMAq0AhKHBn97yZCUy2cqbbbrvFjmudpJeFmqw3stQw==
X-Received: by 2002:a17:902:ccd0:b0:188:d405:63c0 with SMTP id z16-20020a170902ccd000b00188d40563c0mr78583511ple.6.1673464131306;
        Wed, 11 Jan 2023 11:08:51 -0800 (PST)
Received: from localhost (172.103.222.8.cable.tpia.cipherkey.com. [172.103.222.8])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902da8100b00192fdd3af5dsm10530104plx.181.2023.01.11.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 11:08:51 -0800 (PST)
From: lists@jade.fyi
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>,
	Jade Lovelace <lists@jade.fyi>
Subject: [PATCH] service: Fix an additional case of autoconnect breakage under iwd
Date: Wed, 11 Jan 2023 14:08:37 -0500
Message-Id: <20230111190837.209460-1-lists@jade.fyi>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <CAFA9we_1LwKgh1Dm7eBT6DwaFPf0f8hxA4O9o2PMsR0ddrxeTA@mail.gmail.com>
References: <CAFA9we_1LwKgh1Dm7eBT6DwaFPf0f8hxA4O9o2PMsR0ddrxeTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jade Lovelace <lists@jade.fyi>

Error flow:
- __connman_service_create_from_network() creates network, but it is not
  favorite since it is not yet saved
- trigger_autoconnect is skipped since !favorite

*** User calls Connect() ***
- iwd plugin gets connect() call
- iwd plugin finds out about new known network and copies the
  autoconnect state of the iwd_network to the iwd_known_network, which
  is false since it was zero initialized and nobody called
  connman_network_set_autoconnect on it.
- 💥 iwd plugin tells iwd to set AutoConnect to false
- service_indicate_state() calls __connman_service_set_favorite(service,
  true)
- nobody tells the iwd plugin about the change in favorite state

This patch calls trigger_autoconnect right at the end there, which will
then propagate the outcome of the favorite state to the iwd plugin. I
think this patch is the right design for the current architecture of the
autoconnect state management, but I think the autoconnect design
probably needs some changes outside the scope of this patch since it is
too easy to make these mistakes.
---
 src/service.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/service.c b/src/service.c
index 079c7a6c..6f31adb3 100644
--- a/src/service.c
+++ b/src/service.c
@@ -156,6 +156,7 @@ static struct connman_ipconfig *create_ip6config(struct connman_service *service
 		int index);
 static void dns_changed(struct connman_service *service);
 static void vpn_auto_connect(void);
+static void trigger_autoconnect(struct connman_service *service);
 
 struct find_data {
 	const char *path;
@@ -5624,6 +5625,9 @@ int __connman_service_set_favorite_delayed(struct connman_service *service,
 	service->favorite = favorite;
 
 	favorite_changed(service);
+	/* If native autoconnect is in use, the favorite state may affect the
+	 * autoconnect state, so it needs to be rerun. */
+	trigger_autoconnect(service);
 
 	if (!delay_ordering) {
 
-- 
2.38.1

