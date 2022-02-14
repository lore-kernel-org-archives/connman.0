Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F00627
	for <connman@lists.linux.dev>; Mon, 14 Feb 2022 02:14:16 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id p6so9206431plf.10
        for <connman@lists.linux.dev>; Sun, 13 Feb 2022 18:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMq7qOpX3uObn7Lv5QByoKn+lW2Eqg8T0bj49PLvFAQ=;
        b=GIOCo9uRYDZItCd7QtsquVfMBHsuagBvtUJf0paJVE9mH8nTrsQoTPzh2tu2+WB7OB
         i8vDmsYXCJqLgtFEQhI64xJb4nD0LQr2DlVTlZWqssCaxCljoQnZMa7TRHsNJNx/NWmi
         6a/XPYhXtkUzD5dPYVjocSZE7pXWsLEqatUSqmL/zcBt2v32ZQYgYWAzxNASA5x1Ckxv
         Vd0hTtFREKGvdKUDt/bhSN8IqeaNOchrJ95TRfU6D67jONwOWUcKWSZrVPM5mKWpFSmr
         MrIV3EO+g7RqsTBRtOyMgCIrPsCaYGQ1eUnjEODqYsSnwff4wAuhj3Vh544gVU5XCWBZ
         DaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMq7qOpX3uObn7Lv5QByoKn+lW2Eqg8T0bj49PLvFAQ=;
        b=bXcbjXb2/yvh+BFN0hZF9/zA1WFJ08iq1zN2nRax+6yyiAbbYxy73OaUpNY05vKrLu
         nzHuYVgUDK50FEL23yWNxOkXcMrce9m1y09/s0oPhYy9haZB0FiHH9LJ6pqhesn0Dc+8
         Ya29OnjUPsiHgGJvB7jvSEmpigAvHdbNd58C+lhgKg//IwGSDdTEi5YHcJm7aAhBGqfv
         g6ndfHhztncE8yBGYnrxuMeaiIp+wtVVQzjMVKQBOsLkLdS3oTGkdCVHYMqwWhVHpy5k
         gmUN54KSzXQXK2x4KM3AEQcB4Y2HTlPE3sXb6QNVIpO9t0+kSRSmtxpouqx5y/YvgNgi
         xC6A==
X-Gm-Message-State: AOAM532+iMjAE4cljgXtpv+P8lFv/Q/pSHWJTZsZY0FMaVBMJuk1NHKI
	RhsnmUM5opIkkmKJVvDHRPc=
X-Google-Smtp-Source: ABdhPJwAANIzAog5b7KdocfVNiQ/sELqE/qM2krac6bi4s95EcNGpQpHPI0Qbp/P/v2VdIPr4JDMyA==
X-Received: by 2002:a17:902:ec82:: with SMTP id x2mr12081967plg.139.1644804855772;
        Sun, 13 Feb 2022 18:14:15 -0800 (PST)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id s10sm35618743pfu.186.2022.02.13.18.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 18:14:15 -0800 (PST)
From: Jonathan Liu <net147@gmail.com>
To: connman@lists.linux.dev
Cc: Jonathan Liu <net147@gmail.com>
Subject: [PATCH] iwd: Use same signal strength calculation as wpa_supplicant
Date: Mon, 14 Feb 2022 13:13:57 +1100
Message-Id: <20220214021357.522946-1-net147@gmail.com>
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

