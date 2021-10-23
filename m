Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AD2CA1
	for <connman@lists.linux.dev>; Sat, 23 Oct 2021 21:50:08 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id l13so4093923edi.8
        for <connman@lists.linux.dev>; Sat, 23 Oct 2021 14:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaD46f7HMCzL19xh82NOEs4vrgcc0/CGiDZsyd4E5AA=;
        b=KVABxuRFQYeqsPcDq3YlBBCL5W8+OO+Vgrt12UobvUiqW/fo2YetfdTq3OWb0P4oLl
         s3nTNRj2YotgWpKb5ZRlhRzUHEvhrXZnmLO5U02sjxcJhkAZIrnCVq8tH+9mio4zjuyB
         Z+RR6BIuQVFpWdxcYQzJyskss8LDSTW645N3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaD46f7HMCzL19xh82NOEs4vrgcc0/CGiDZsyd4E5AA=;
        b=egVCrXXIxSwHirOGOPRzXcTbIeDCKW51g54IZ5QDzcIbzrPKAQ+m2QVz6792IRUdfJ
         nFJcqE49vO6FCIFfo2kjUfTf8lFsIMdm9dKABgeQjvpVZbEQ1X2voyVsSPhQyPFq5DFX
         0yUR7n/uUW4wE8RI2gtAJ95AmfLsIirWopoF67B18XZXXHHu39GitYAxqRUfAlTVxhmi
         0E4Vm1Q9jbHeea9fisG8hiKzyb2lAiVF5g/MSzyd569SmTXaQtO+l6sc1697zNVwD3uT
         LDiPmmYe8zWCrfqm9nuAhooqg8w8gBKZcJMSSfNPaetiCrpRJxvuc8QmLYj6Hw55BNmr
         Y3sQ==
X-Gm-Message-State: AOAM53158fnE8yCVKv7fNZPNqB4ksTbA9JStc0+J7hYhxsjHbn2kXXXN
	mUQAAivcVBTfzqmoGUwX/2XFfm5hyC1uiA==
X-Google-Smtp-Source: ABdhPJwojmtcSotIb/yTClQr9HO73+/il6WQeTf9qZUMVkMOzULtffI+5YnK7A1+JGqXpNPQorGXJA==
X-Received: by 2002:aa7:de91:: with SMTP id j17mr11760829edv.335.1635025806488;
        Sat, 23 Oct 2021 14:50:06 -0700 (PDT)
Received: from localhost.localdomain (142-158-13-149.static.cpe.unicatlc.net. [149.13.158.142])
        by smtp.gmail.com with ESMTPSA id v9sm130682ejq.55.2021.10.23.14.50.05
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 14:50:05 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev
Subject: [PATCH] tether: Fix connman_technology_get_wifi_tethering
Date: Sat, 23 Oct 2021 21:49:53 +0000
Message-Id: <20211023214953.5606-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is called from tethering, so the tethering is not
yet enabled. We need to workaround in order to get the right
value

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 src/technology.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/technology.c b/src/technology.c
index 97419150..5c469111 100644
--- a/src/technology.c
+++ b/src/technology.c
@@ -367,19 +367,23 @@ bool connman_technology_get_wifi_tethering(const struct connman_technology *tech
 					const char **ssid, const char **psk,
 					int *freq)
 {
+	bool force = true;
+
 	if (!ssid || !psk)
 		return false;
 
 	*ssid = *psk = NULL;
 
 	/* Workaround for the neard plugin */
-	if (!technology)
+	if (!technology) {
 		technology = technology_find(CONNMAN_SERVICE_TYPE_WIFI);
+		force = false;
+	}
 
 	if (!technology)
 		return false;
 
-	if (!technology->tethering)
+	if (!force && !technology->tethering)
 		return false;
 
 	*ssid = technology->tethering_ident;
-- 
2.25.1

