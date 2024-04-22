Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714D153830
	for <connman@lists.linux.dev>; Mon, 22 Apr 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814689; cv=none; b=FbHUwlV6Gyiqy+u5F/rsXRcOu3n4jALrK2oxkFjhnHYPzVICkbY9UoQgudpPGqbWw0FdfhBr6Ff6x7m20DLZFc7nFyYe3jKsPID6m2uS6bMAlf80+8uQ0bMA4KsBxOfS8u5v1aPbdfucUCYKDBzSVsTSG4iHSsgENHyg1F1gr8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814689; c=relaxed/simple;
	bh=02SX3SHCWlm6DvIvF1d9LEOkwxoRPUvqzkSw10MZWp4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZKCowsTf+FcMCL2UzpHO7yvxt5Muvt5Bw4iwzSVDO5XFl8vTNcjpGrq50Bvqpo12ENExLA4H58QK9ZKnW1CouhWrTIKzC1yGCCb9cVBdeOfb0KB6zB0SiqARdz7mInvHm66+sk+gfzhizpR/xskth4y0fz5LRdErYREh4Bd9AJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRDs5vmt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRDs5vmt"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e8b03fa5e5so33060725ad.1
        for <connman@lists.linux.dev>; Mon, 22 Apr 2024 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713814687; x=1714419487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x0Tn6RsDgT4mz92qQHsFd1b+fd9Bz42DBp00SuWwCJg=;
        b=HRDs5vmtWaOn9qq7LqrQXqf2PeWEalW6wQidtfYmbDHAssrM0YXG7Kz7aLb1ngRPmk
         sOEPh2RUKRsfE2y9+k/cH4s8jfzmYmLhg0kSl/Z/pMV+f2GoFoZpNo4bt9przfsui63t
         YC2dmVb4+Ai6E69/tSLikET7lX4HdEwOpjnRrnIB2zbpXoTMpODmo2gDzO1hHkuBLroD
         A2TWttpJ6CDuMonytxnQUqO3P52E9DcxBGjOvi4ypFZb5521iOXIhmLnGsp3ScswFO7k
         FhsDAih5VoLfbQSYIh6/H8c0oRFg/GXD49QrM7ACY0i9/feZ4q+orFlaPZszfDS7umY4
         V1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713814687; x=1714419487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0Tn6RsDgT4mz92qQHsFd1b+fd9Bz42DBp00SuWwCJg=;
        b=FQBKhCzJIQuqrh/+PeYg3xOsmHWODtnWCurAGKYR20HZ2+ZieGSIkodk8j/1n/Ab5X
         F/Pq/M4FaE9c5WeSAy7kI3lRxATX8MXbui0tk/NDdsPxIrSEIm8Y24gW+8xdlBx5UknB
         ZZGFxelSicBF4KlKdhON4cBbnqOkHQzhV4b0YwCzA6TMnyWdcmaROxIac6cf5iM8Y8Rh
         rSsHToTr+6hUVsxgOXnZwHVeSqMIr9XFBJFywLcX+nIM2A4oOwODrlttSCXXWAPoCzF4
         jaQQadMJnR+jxngw1vhyUfzx3KZxzvfSAzA/pLLk5+yhGpocTSWZhiB77mlHKHHN+yvw
         /ZYg==
X-Forwarded-Encrypted: i=1; AJvYcCWnPp/jHGEbFB/vaxDHKq7V2igZER+3m6itvu+8AHDB7RHjKatmStJgtGIFRZlNm+L9VQqfq7jidclGdNdPQpmVq+CAoWmpZg==
X-Gm-Message-State: AOJu0YxhpeNVF3eCEdRcff8cO0KUYC8Sf3SjVTCkWydxZlAMxpEHEJW2
	fhjKYYSHbr6V2LW4SyPGjJhzMhW1yzUH4EuaJjGfOSIC6bbZxNRY
X-Google-Smtp-Source: AGHT+IHTgIjRE8Tl4QIpRLx0EyBSLMDMj0/suLFkJ5A51AX0r+ER/GSJVCO6q7ABuK9MSR5avqK4Gg==
X-Received: by 2002:a17:903:2685:b0:1e0:dc6e:45d6 with SMTP id jf5-20020a170903268500b001e0dc6e45d6mr12171925plb.60.1713814687453;
        Mon, 22 Apr 2024 12:38:07 -0700 (PDT)
Received: from brian-linux-22-04.localdomain (c-24-5-211-102.hsd1.ca.comcast.net. [24.5.211.102])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b001e290812d49sm8469173plh.226.2024.04.22.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:38:07 -0700 (PDT)
From: Brian Fukano <bfukano@gmail.com>
To: bfukano@gmail.com,
	connman@lists.linux.dev
Subject: [PATCH v2] dnsproxy: Fix cached ttl update
Date: Mon, 22 Apr 2024 12:38:05 -0700
Message-Id: <20240422193805.123689-1-bfukano@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug was exposed after fixing the signedness comparison warnings
found in dnsproxy.c update_cached_ttl() consistently comes up two
bytes short when processing the last record.
---
 src/dnsproxy.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index d4242560..23015f74 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -507,10 +507,8 @@ static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
 	/* if this is a negative reply, we are authoritative */
 	if (answers == 0)
 		hdr->aa = 1;
-	else {
-		const int adj_len = len - 2;
-		update_cached_ttl((unsigned char *)hdr, adj_len, ttl);
-	}
+	else
+		update_cached_ttl((unsigned char *)hdr, dns_len, ttl);
 
 	debug("sk %d id 0x%04x answers %d ptr %p length %zd dns %zd",
 		sk, hdr->id, answers, ptr, len, dns_len);
-- 
2.34.1

