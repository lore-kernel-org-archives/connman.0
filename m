Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B91C1758
	for <connman@lists.linux.dev>; Mon, 18 Nov 2024 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947629; cv=none; b=f589azhFeEpUdQb+Q56XWetuueohzPMGH8nn4eOTDg8ZlajxKqxgVjTutFo7ja9xjiNTVG9adCoR205oMa4aaSmOaokIYqe9wO7QRtw345M3i6gtL/C73KHyHbYEWoEv7cuV/4bgeQOddqpXKEKNkb3RIT6GGImoG6cVM8YD5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947629; c=relaxed/simple;
	bh=FIq2UWkbmrYqu7y+sPWTI9jU3VK5apbW1JlhALBQBms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VI7Wrug0A4+1G29xJDQLjye9DQuuvw9kZ1cpf4+stJDQbcSfayOWlkVU7cQrZ2/GFtza/Cd73SQHo9QqpesZ/QIow5wpCdM1LMy7dKiRtAHoFoj6hueRn2qMQbbND6EAPVaPcWHYKRUMIl30G/KSM/Sewm5z0hh+LS6Yp8+qqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDtrXxNH; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDtrXxNH"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e602994635so1803324b6e.0
        for <connman@lists.linux.dev>; Mon, 18 Nov 2024 08:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947627; x=1732552427; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WGtx4uMHnbW+zKKHJGLRPJGEhjVHdyunWaN0qy1W9Uc=;
        b=MDtrXxNHSe8Vnqlw/U+S0w5JguUsWPFU9uhtaLOqnH93CW2WqXZmGP393uVycJhn5x
         HR9nteVTV/unpreTbHyvlop8mrF9C2AYTIuvth6fZh7gSZVWa+3zL0jynJ1kojpgl5ah
         7zFA7RGeKdIJV0KCaLZhAfv7sFNlRVIa/kWDVAl1/rX93EtVjDtke0saYVX7Uh/pWy8N
         pLgf7zfVON+qYD79IIM3vjOof6Nvr5kMvdZSnAwyVcBCelXHi0pYGqkjvxmTXbWV2wRb
         2IMBE1NYmeqLkB/P8dlW9HQoXB9wSkd8BSlqaXuZ4jASkcJTdwn2XT4I01T11+qdEmL0
         bnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947627; x=1732552427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGtx4uMHnbW+zKKHJGLRPJGEhjVHdyunWaN0qy1W9Uc=;
        b=aW4hs7JA4eJWNx3HoWd2Z9OPUL2iitQFBAS0zj8OsstfjSl0OU9s6oPy2LjeqBwkB0
         iuQzekKzpkUEh4Gdx6ToISdLsGTikaYG5wyqoU6PUIDdcTlgDMv+exQ9tS+HET6/oNTh
         kLXlIGmHkdxnzMEaoO/OmMfF05q7PXyj4rjFiu2xgmqa3yGwSvbA1Q8mD2uYr7C5LDZn
         T3MKWwe3VVnO7qzDigKfvvRUAznxPyOLWYGrQDhMlMhuaWV+vc+j4JmHvi5WtfVtLuW/
         zYn2VnyMN6xSPvb54ufYOeHUNRZbvpo5PAy6fWfEwUcFHwzkjznVqjESj+jRJ6oyxIPv
         kt7w==
X-Gm-Message-State: AOJu0YwwaN5DqM55aq69TNTUNXdnfBI4co0yHiwK73uUnF8JcDLgn4T3
	+5a7B2o2wlrx+K+NqsBiwULcnOhZWQSGg7ovxq9nI18Gv40CM8e49PMo+Q==
X-Google-Smtp-Source: AGHT+IHDDgX+cyWuzJTZyqEP17aJOthHMmhuP4XoHXeLF/zPh/om1560oX+cggwejzd0AI5TtWwwjw==
X-Received: by 2002:a05:6808:148b:b0:3e7:b698:e93e with SMTP id 5614622812f47-3e7bc7a0063mr10428810b6e.1.1731947627186;
        Mon, 18 Nov 2024 08:33:47 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd95696sm2946952b6e.54.2024.11.18.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:33:46 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] treewide: Fix typo in ARPHRD_PHONET_PIPE
Date: Mon, 18 Nov 2024 10:33:31 -0600
Message-ID: <20241118163344.57123-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was spelled as 'ARPHDR', but should be 'ARPHRD'
---
 src/rtnl.c     | 8 ++++----
 vpn/vpn-rtnl.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/rtnl.c b/src/rtnl.c
index 64ba6086404e..d49ea4d445f4 100644
--- a/src/rtnl.c
+++ b/src/rtnl.c
@@ -42,8 +42,8 @@
 
 #include "connman.h"
 
-#ifndef ARPHDR_PHONET_PIPE
-#define ARPHDR_PHONET_PIPE (821)
+#ifndef ARPHRD_PHONET_PIPE
+#define ARPHRD_PHONET_PIPE (821)
 #endif
 
 #define print(arg...) do { if (0) connman_info(arg); } while (0)
@@ -448,7 +448,7 @@ static void process_newlink(unsigned short type, int index, unsigned flags,
 	switch (type) {
 	case ARPHRD_ETHER:
 	case ARPHRD_LOOPBACK:
-	case ARPHDR_PHONET_PIPE:
+	case ARPHRD_PHONET_PIPE:
 	case ARPHRD_PPP:
 	case ARPHRD_NONE:
 		__connman_ipconfig_newlink(index, type, flags,
@@ -536,7 +536,7 @@ static void process_dellink(unsigned short type, int index, unsigned flags,
 	switch (type) {
 	case ARPHRD_ETHER:
 	case ARPHRD_LOOPBACK:
-	case ARPHDR_PHONET_PIPE:
+	case ARPHRD_PHONET_PIPE:
 	case ARPHRD_PPP:
 	case ARPHRD_NONE:
 		__connman_ipconfig_dellink(index, &stats);
diff --git a/vpn/vpn-rtnl.c b/vpn/vpn-rtnl.c
index a6b078586f25..b62e58a89d5d 100644
--- a/vpn/vpn-rtnl.c
+++ b/vpn/vpn-rtnl.c
@@ -46,8 +46,8 @@
 
 #include "vpn-rtnl.h"
 
-#ifndef ARPHDR_PHONET_PIPE
-#define ARPHDR_PHONET_PIPE (821)
+#ifndef ARPHRD_PHONET_PIPE
+#define ARPHRD_PHONET_PIPE (821)
 #endif
 
 #define print(arg...) do { if (0) connman_info(arg); } while (0)
@@ -239,7 +239,7 @@ static void process_newlink(unsigned short type, int index, unsigned flags,
 	switch (type) {
 	case ARPHRD_ETHER:
 	case ARPHRD_LOOPBACK:
-	case ARPHDR_PHONET_PIPE:
+	case ARPHRD_PHONET_PIPE:
 	case ARPHRD_NONE:
 		__vpn_ipconfig_newlink(index, type, flags,
 							str, mtu, &stats);
-- 
2.47.0

