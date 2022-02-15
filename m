Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5651376
	for <connman@lists.linux.dev>; Tue, 15 Feb 2022 10:27:09 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id l8so6754911pls.7
        for <connman@lists.linux.dev>; Tue, 15 Feb 2022 02:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfVLPhMoZbIoLaVLewd895Ib/TSyExB6Ug0IDnL3nX0=;
        b=YB/Q324QYK7TIslKPTKgM3t2mxDJJAHtYaZBKx3SWFPfqfULJ1QotBbU7H8xR5jCRB
         ayMuzX8RRFHxOFgedzezvErDA0xECV9KdE4yQfJ5/fRA4SjXZiR4wyFbgl7Znd2GNzo/
         JVJa+E3C5fxjx8sMyDUPzd9uExdUrlhzwCbX8YfAMcLgmgk2PT/3sTDdJ679sGp/a2EP
         53H6FbiJvYwNYXqbz90BQG0FyP5wtfRqbO/j8OWbiXrq91zZ+q+zEFVDEfqXyoRNIfjy
         Ex0OCvapLgI7iVtgNnUMjPyCHqCqaacEsJvyIaMpxXyNUrnpHcTEnfz3KAZrzlhbTp+r
         Nm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfVLPhMoZbIoLaVLewd895Ib/TSyExB6Ug0IDnL3nX0=;
        b=Zr75tH44VqG0327tjcObt8MvfT+cHC1fRIhmqb6mCJXae0tqKk7VJ180FuV8L26MXS
         /pcWzgbCnI0YvWBF4BPLhNSkuPBmdEMUZ/K4ZXm2LOe8ATNzLAnWPYgrft7vSCUWrqYq
         36adArRxkouOb72HGyPQBVy8D7Cx+KGV/Bu4/vVse6WJ2pc99HUP9A3EbpKL0/C2dGY5
         FqwSykiE7rNuzkyFrFHd4t/euYvcJxDauq5UIvfVSUWS1qRjz7A7owdqtjwgWSdtm2m7
         7V7YGpE8oSY7vOaif3RY1rIzRxr8vclTouTjFxRFEWk9oyeqoh2bZUfDhEVulGgr1MIN
         +V7g==
X-Gm-Message-State: AOAM530TvAHV/LrLykxMFAKoeBN3sLliKGqEmPIEk+d2mBz+1fRfRJAF
	WN2tiZgMnNp75Bjf0jRiQzo=
X-Google-Smtp-Source: ABdhPJzuMANLncapguezyV/PJay0dOVLAW/e85p5/HwkyMsmlnfuOpR7VifE9nZaxnA9d2hK1VM0EA==
X-Received: by 2002:a17:90a:3844:b0:1b8:d7a1:3647 with SMTP id l4-20020a17090a384400b001b8d7a13647mr3511436pjf.153.1644920828436;
        Tue, 15 Feb 2022 02:27:08 -0800 (PST)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id u18sm40378537pfk.14.2022.02.15.02.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 02:27:07 -0800 (PST)
From: Jonathan Liu <net147@gmail.com>
To: connman@lists.linux.dev
Cc: Jonathan Liu <net147@gmail.com>
Subject: [WIP PATCH v2] iwd: Fix disabling tethering not working for brcmfmac
Date: Tue, 15 Feb 2022 21:26:38 +1100
Message-Id: <20220215102638.599189-1-net147@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Broadcom BCM4356 chipset with brcmfmac driver, changing from AP mode
to station mode returns -EBUSY if the wireless interface is a member of
a bridge.

To resolve the issue, the wireless interface is removed from the tether
bridge before changing the mode rather than after.

Fixes: 648ed549f0ac ("iwd: Add support for tethering")
---
 plugins/iwd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index ac3d1e17..25b9544d 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -745,6 +745,7 @@ static void tech_disable_tethering_cb(const DBusError *error, void *user_data)
 		goto out;
 	}
 
+	connman_technology_tethering_notify(cbd->tech, false);
 	iwdap = g_hash_table_lookup(access_points, iwdd->path);
 	if (!iwdap) {
 		DBG("%s no ap object found", iwdd->path);
@@ -756,11 +757,6 @@ static void tech_disable_tethering_cb(const DBusError *error, void *user_data)
 	iwdap->bridge = NULL;
 	iwdap->tech = NULL;
 
-	if (!connman_inet_remove_from_bridge(cbd->index, cbd->bridge))
-		goto out;
-
-	connman_technology_tethering_notify(cbd->tech, false);
-
 	if (!g_dbus_proxy_method_call(iwdap->proxy, "Stop",
 					NULL, tech_ap_stop_cb, cbd, NULL)) {
 		connman_warn("iwd ap %s could not stop AccessPoint mode: %s",
@@ -787,6 +783,9 @@ static int cm_change_tethering(struct iwd_device *iwdd,
 	if (index < 0)
 		return -ENODEV;
 
+	if (!enabled && connman_inet_remove_from_bridge(index, bridge))
+		return -EIO;
+
 	cbd = g_new(struct tech_cb_data, 1);
 	cbd->iwdd = iwdd;
 	cbd->path = g_strdup(iwdd->path);
-- 
2.35.1

