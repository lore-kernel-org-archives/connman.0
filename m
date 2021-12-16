Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D778173
	for <connman@lists.linux.dev>; Thu, 16 Dec 2021 10:23:18 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id i12so18590929wmq.4
        for <connman@lists.linux.dev>; Thu, 16 Dec 2021 02:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDO81eVUnK7aH3R0lXtjF0dOA3QqjWhbdMn/37ZMym8=;
        b=flbfv55LAYCsiMScjBUiXq/tcZ+6ZDBVShQ1YRo/DooeOjNgiam6XZkOQt90RH50mJ
         1wgP7NHIxkxmGz33nZI3c8OCS4EBxVr8knWa/aDezA9EoMuXSDkBkM7X6vJNzybqFmRD
         SHgCGHpBmyc90pzOS4r+GdPVE9532Amipurm0524OKrR7pZdzR5QD15KABrcCFYXI8q7
         Tcp0t0CtIsanK1VdhCTUKFa9nA5TgPBt4gs4IhVHkeciX/NdDSz1npIM4a7Pb8E9BTm3
         EUkd30vUWLJAcVlILqL4VG3540xo2nQ3tWy23BtX9X0IQ3Ngrr8TZAB5gJeaDg+Hms6S
         DXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDO81eVUnK7aH3R0lXtjF0dOA3QqjWhbdMn/37ZMym8=;
        b=ECYDG5lltiFqADHn5Q0ya4fB5NBIzKlgbf+95agjYiIA/FbLhz4SsKSLIBfIPrrykk
         fPuAzwOPXdnYpSbW7b909TFrUusL8AKjc/Gu+Qagk8kR3/jrcMbqnapc4UNpWnmw/r4H
         +UOuWoxxZbmzMFmIF7wZ5aY28GnPQWQ636EiZ5Mn57oZV/9nTNtFlz0c7InYiSWBs2rc
         gMpWcP2ejyN+EG0RekJzo2ZU7OLmIskXO0OQK6acwZr/BVStm4VwBwjpxI80rkz8HIoH
         DBKscTeDWe/DOfGAA/Pznv2pIdiFelJCLZxTla2dOutwydz7Ugc16ZDwZ+U2PzhUQ4P4
         aGbA==
X-Gm-Message-State: AOAM533MB6SZLlhDVsT3DLPmUVNSf5IFeTtgaS6Dgqz8UW3C8GSyrGnv
	xZtx1CW0i2jQDhM1onZdFRrD7w4udLF4KA==
X-Google-Smtp-Source: ABdhPJzCvoI9dJnHniJQrPjQMkdKpDeESX3U1qu9EWXummIqbtJv3YdqVLleKPnv+RfYKE/8eRRZ1A==
X-Received: by 2002:a1c:f217:: with SMTP id s23mr4280779wmc.70.1639650196714;
        Thu, 16 Dec 2021 02:23:16 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:958:8af0:83c2:ab5b:663:7b6d])
        by smtp.gmail.com with ESMTPSA id m36sm4217997wms.25.2021.12.16.02.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 02:23:16 -0800 (PST)
From: Emmanuel VAUTRIN <emmanuel.vautrin@gmail.com>
X-Google-Original-From: Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
To: connman@lists.linux.dev
Cc: Emmanuel VAUTRIN <Emmanuel.VAUTRIN@cpexterne.org>
Subject: [PATCH] service: Fix native connection with wrong passphrase
Date: Thu, 16 Dec 2021 11:22:49 +0100
Message-Id: <20211216102249.502964-1-Emmanuel.VAUTRIN@cpexterne.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a native connection fails with a wrong passphrase, the user still
needs to be informed, via the agent.
However, in this case, the associated service is automatically
disconnected, canceling the pending agent requests.
The invalid key error shall be reported before this cancellation.

Commit b9a0a039ccc5 ("service: Report errors to user in native mode")
---
 src/service.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/service.c b/src/service.c
index 9141b85dbe9c..202816ae8980 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6023,6 +6023,11 @@ static int service_indicate_state(struct connman_service *service)
 		break;
 
 	case CONNMAN_SERVICE_STATE_IDLE:
+		if (old_state == CONNMAN_SERVICE_STATE_FAILURE && 
+	service->connect_reason == CONNMAN_SERVICE_CONNECT_REASON_NATIVE &&
+	service->error == CONNMAN_SERVICE_ERROR_INVALID_KEY)
+		report_error_cb(service, false, NULL);
+
 		if (old_state != CONNMAN_SERVICE_STATE_DISCONNECT)
 			__connman_service_disconnect(service);
 
-- 
2.25.1

