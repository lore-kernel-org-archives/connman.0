Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780081376
	for <connman@lists.linux.dev>; Tue, 15 Feb 2022 10:19:55 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id e17so14585474pfv.5
        for <connman@lists.linux.dev>; Tue, 15 Feb 2022 02:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XrDRdi0J39IQpcMHO93UCKXLzGURUy6Q5+rqkFaTzVc=;
        b=DbVhbQIOIGoHgFP0RVw2OAQPGASmq4Jz3Wisn6lZ1d1rdCG2MCAYpRB9ezL23Tne8V
         QqnqNn49DcbMt7DEovwMoCb2XAnxcNkCRKLQEBPvOGMufSaRdwShrynyO14YIsEVqLK+
         qlLSOUUOrdTovedVSLXcPN2ueegdxz4+FgDL32uBLwkRIHt1lsRSNBYq6eB+2cd0yqFp
         acO/szo6PiSRscTFsPBGbD33lSL4PLQEn86yj9iXDj5z6L3gVsAExmPeUhwmG7b96tJC
         G4Alr5ODDoBwqJbt/mMELudPcE0Y59cv2WE2s4u0EQ1zhgbFhE7r4Kb83PYIqF4sRQmW
         hSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XrDRdi0J39IQpcMHO93UCKXLzGURUy6Q5+rqkFaTzVc=;
        b=JI6EbSNNb0tVeOAJsDMprtjxTiWettECXLpV2Apd5vYuC/ATEq8H2yGEx7124B9C21
         wdYTAAg1WoPXeiDfe5lBOEmG0lxNriv1O/tbgL1uODRi2VtzXu3AIu4ph3Vjm20JMAn5
         pKJHLrwldE6oRkHPrZNAu2WXvMUGi4ArfOxX5rTf4OJtLJ6Qk5rZ8mGn0rzVuPT5I153
         doD0unydHq8awtkw5di70rDehntOE48dor0CYQK1z/8Sv9biYNOYVGiWjYe8Wl6rybw3
         Gi8rG+sAJRPuwVbb4p8AwF2vFud40Ti9CtOeTv7WE/kbPhEAPpbWNYuKg6foPqDv65Iu
         762w==
X-Gm-Message-State: AOAM531v1uNDlfcqRsYoJ5Hql7q9uMyabkiG2CkARncFnNgr290Ce5Vd
	GixOAFPwhMMC70l2RkWQKQrkE+GpjWmk9A==
X-Google-Smtp-Source: ABdhPJzUu0W8/820SW5PljooH8WLd/bvl6YjpU8v6n/48wkbw7YoiF/d/3sgAiO7u5JyJncCpNIPog==
X-Received: by 2002:aa7:9e85:: with SMTP id p5mr3638352pfq.84.1644920394608;
        Tue, 15 Feb 2022 02:19:54 -0800 (PST)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id hk3sm12565690pjb.12.2022.02.15.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 02:19:54 -0800 (PST)
From: Jonathan Liu <net147@gmail.com>
To: connman@lists.linux.dev
Cc: Jonathan Liu <net147@gmail.com>
Subject: [PATCH v2] iwd: Use same signal strength calculation as wpa_supplicant
Date: Tue, 15 Feb 2022 21:19:40 +1100
Message-Id: <20220215101940.598839-1-net147@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the signal strength reported by connman being lower when using iwd
compared to wpa_supplicant.

In the wifi plugin for wpa_supplicant, the signal strength is calculated
as follows:
strength = 120 + g_supplicant_network_get_signal(supplicant_network);
if (strength > 100)
    strength = 100;

The g_supplicant_network_get_signal() function returns the signal
strength in dBm. This means the signal strength calculation in connman
for wpa_supplicant treats -20 dBm or higher as 100% signal strength.

The iwd plugin is changed to use the same calculation but as iwd returns
returns the signal strength as 100 * dBm, it needs to be divided by 100
to get the same dBm value as wpa_supplicant.
---
 plugins/iwd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/iwd.c b/plugins/iwd.c
index ac3d1e17..2a245fe2 100644
--- a/plugins/iwd.c
+++ b/plugins/iwd.c
@@ -1128,7 +1128,9 @@ static unsigned char calculate_strength(int strength)
 	 * ConnMan expects it in the range from 100 (strongest) to 0
 	 * (weakest).
 	 */
-	res = (unsigned char)((strength + 10000) / 100);
+	res = (unsigned char)(120 + strength / 100);
+	if (res > 100)
+		res = 100;
 
 	return res;
 }
-- 
2.35.1

