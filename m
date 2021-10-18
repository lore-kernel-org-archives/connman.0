Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5F2C88
	for <connman@lists.linux.dev>; Mon, 18 Oct 2021 08:16:42 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id v127so7942076wme.5
        for <connman@lists.linux.dev>; Mon, 18 Oct 2021 01:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVU3yXE9RU04kOQuKJfc/vuggM25AEO2OFnzTKd2pkY=;
        b=Dmq3POGkd7JjQq68osORefSOzAiQh+RfYO2ZTDTkJy6t3asmmc7s60FayjaKpnRr2l
         m9A7jmOyBJbMXaPeoGLNYnzHNyXQ6MQ6T43rzV4TRRZrdtSklvfwn7gH6/VvXVKjS7Y/
         qvX3W9MBrucKSJP/CRRfIDsuneXIrqBrw49Nm4OQftqiFwRaS1VADsFGgDrZGuPmBaut
         T9jpFTLptQN8I3NULgbP+JskP3KATjEtZLMOzSKhpFuNbLI5OpQlwYMs24hBPwTaoplK
         zwDVsKY+TpVkvv1A9pacy5iWPvkGp3zJFNM2B+LDMDA5joGvnuKGN9a5dyIUphY92cgd
         Ob+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SVU3yXE9RU04kOQuKJfc/vuggM25AEO2OFnzTKd2pkY=;
        b=bP6CGHQ8j7o0ITqWXXdFD9t8+IwUH5e9Hk/47GQKB4ReVNdqwnsTfSdUvd6r5jqIsi
         CV85czg2PqKKCB2f8flct147dVWr5OKFX/89ad6v3xvMZnzIghBImousTtKMvCUegHaw
         u0S1oyggD49RAZ+sGVBH2pNVm1sOqI6n6ZPCQ3YUUwi3TUkAe23cuhvIcrwboxeRoC/K
         5RWjjIVdcSC3m4AVtvhbRYaKZOef5Twegk3yjSt/7Kczy9DLgdjUqBz/qxpNIbShEFHv
         EiQ/sYr0lV8skMrNIlXW6DtjG2J48wtwL+H7R68ONdWi9dSVnjJX1/EXiiRRAF2mu0o4
         AIug==
X-Gm-Message-State: AOAM531Od+wW9SmO8yEqmuH07047La3wMd8vTaGnF586DTtzmY7vS1tt
	KFnb5Xo0r/RUCWrtZxHHRaSafy1Wdm7jCg==
X-Google-Smtp-Source: ABdhPJx6qG6yovUVuyrdxQ2vJfszSJnZwQpBavhIlph4bwxRU4Myorjee5k4fOeHfirwclG2SIBWVA==
X-Received: by 2002:a05:600c:3546:: with SMTP id i6mr43010332wmq.146.1634545001251;
        Mon, 18 Oct 2021 01:16:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:958:8af0:83c2:ab5b:663:7b6d])
        by smtp.gmail.com with ESMTPSA id q7sm11991500wrs.73.2021.10.18.01.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:16:40 -0700 (PDT)
From: Emmanuel VAUTRIN <emmanuel.vautrin@gmail.com>
X-Google-Original-From: Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
To: connman@lists.linux.dev
Cc: Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
Subject: [PATCH 1/3] build: Cleanup of iwd provision_service_wifi()
Date: Mon, 18 Oct 2021 10:16:00 +0200
Message-Id: <20211018081602.82984-1-Emmanuel.VAUTRIN@cpexterne.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gcc reports with:

 src/config.c: In function 'try_provision_service':
 src/config.c:1421:3: error: 'ssid' may be used uninitialized in this
function [-Werror=maybe-uninitialized]
  1421 |   provision_service_wifi(config, service, network,
       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1422 |        ssid, ssid_len);
       |        ~~~~~~~~~~~~~~~

Removing the useless ssid and ssid_len parameters solves the problem.
---
 src/config.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/config.c b/src/config.c
index 62023b1072da..33fdc7375c15 100644
--- a/src/config.c
+++ b/src/config.c
@@ -1106,8 +1106,7 @@ static char *config_pem_fsid(const char *pem_file)
 
 static void provision_service_wifi(struct connman_config_service *config,
 				struct connman_service *service,
-				struct connman_network *network,
-				const void *ssid, unsigned int ssid_len)
+				struct connman_network *network)
 {
 	if (config->eap)
 		__connman_service_set_string(service, "EAP", config->eap);
@@ -1418,8 +1417,7 @@ static int try_provision_service(struct connman_config_service *config,
 						config->timeservers);
 
 	if (type == CONNMAN_SERVICE_TYPE_WIFI) {
-		provision_service_wifi(config, service, network,
-							ssid, ssid_len);
+		provision_service_wifi(config, service, network);
 	}
 
 	__connman_service_mark_dirty();
-- 
2.25.1

