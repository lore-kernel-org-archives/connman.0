Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70582874
	for <connman@lists.linux.dev>; Fri,  9 Feb 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501714; cv=none; b=kCEZ/Bt8pTpBo+mcihB7vdG2m6WyxeA5/RSCFdC0CenvzhdJzwPSp5sKev0JSvL0xZdbLac7fUD0N45vzkb3guwfhgixxxP0EKJqtalp09lGpLgj4y6WPhT4YUZTDUb6Bxy1Mut7pMz/HxYmLIoNLtk7m00MBBMQDSXNr8MM5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501714; c=relaxed/simple;
	bh=NalmVxU50t40fC0p/sJRXsZNWbbpQvaWfK0Rr89zlt0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=NvlNKFtxmKYeALXbnNBrBvrzX3sTgVzL+g3+UQ/XhddUEVLmhypI5AnVFq5oasLk6/C/ygepNhtcs3mfPqZo5+p20iaTliQ4qLZGbbu/STBPLlPxwOqxHYZfXbCtIaCAo828ApSz0w2Q4RsP1qb5JFBgKNcggE7+NfyueAgcA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0XvHios; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0XvHios"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d76671e5a4so10091705ad.0
        for <connman@lists.linux.dev>; Fri, 09 Feb 2024 10:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707501711; x=1708106511; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=F05dl5AUOlU5NpbINCRV3aHPMeOCcqkNSAAz2XkT4R8=;
        b=N0XvHiosSwK0jXBO2v2veuua37FXH8Jxzm8Ji37g1Se+RWG39l9eTFKO3wpk3OtuEq
         t/dZMnn+GtJ9nAsopN/UsOhQO++bnGs44eVytV9F2Wb7MoFXODYjwelbbotvwt4bFyMB
         x0tWxnlhRT8pxr530JkRH8NHessOZC2n2sSCG5TsW9SY1MfwBdN5+ZLWo1A/xpNTjJ8z
         /Cmh06rGeAE57OyhVH0S1tSQNrWMS+HwAEuVgTHuWRkmmkE8+j+abjYBIDInIyGINbGA
         eibK4HUQdKCD8R9c391oEWBgRTA/nU/BeBQiZF49JQNS/6hCZl98KMIo7MS+3iYL4mmQ
         vLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707501711; x=1708106511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F05dl5AUOlU5NpbINCRV3aHPMeOCcqkNSAAz2XkT4R8=;
        b=FNHELKdzg+RqGtN0xgTn7dMZ4sKOoNJ1439ZZv992rXI14X6EhBta6ffugiO1jwR84
         NzdUJCjFKbkND/lj9h0QOpaJTM+m1Ou7AWSlGma8YWbUM0LJ0duz0/sIzam/6tY6DGSh
         fC8uUbHPMPLLtnzWMjdybO4RvuAWXA1OWlYq2PIVQ6f63JHEWFvu6FLUUBEYhZpuu3m5
         c11hOfYFFNCnRy9Tb2dVezOtugq9C02WSol50TvGb4XrQpmMs6hPP2FDe4iiAtUSaXMt
         bvbV1yuDcLe+xQmBR/+GKIEePf1tElbxbJjDAz2N7S2As5/OIVqAjf3NGMkfYUbTV6Om
         XDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC7mTaAlDwpjaxefVv+NngCzx2ACJ60aWEE2mL86crBgZSH/20+k7SoODkhyZ/X8iDsqBoL0QwxF/GdEpewO1Ydq+xWgEaGg==
X-Gm-Message-State: AOJu0YyTtOZ3o7r8OQWX1J3RDndPVXuBt0Iv4ADBlH+L7ekOrG0bCkTn
	hIT3k6dFevFCIsaiOt56F1NS+WDWkvreycc6zha3ocWyU/rz/cRb
X-Google-Smtp-Source: AGHT+IEDSZE7za+PYO8hZB4kZ24r8sHqTqtLVaW4AMb2xx17jolR3dXQS+sD73CRkYGT6asR+sXcfw==
X-Received: by 2002:a17:903:1249:b0:1d9:8bb5:7497 with SMTP id u9-20020a170903124900b001d98bb57497mr2853100plh.40.1707501711019;
        Fri, 09 Feb 2024 10:01:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdCGEHGMH7t3k09ZMApLVByrCY8PAZNORveN99Vf8LChpPF+44jqkjn7F4rMffYPFDA65PGt8aZcmn80++mTdozLgXx4vPJg==
Received: from brian-linux-22-04.localdomain (c-24-5-211-102.hsd1.ca.comcast.net. [24.5.211.102])
        by smtp.gmail.com with ESMTPSA id o17-20020a17090323d100b001d8dd636705sm1781281plh.190.2024.02.09.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:01:50 -0800 (PST)
From: Brian Fukano <bfukano@gmail.com>
To: bfukano@gmail.com,
	connman@lists.linux.dev
Subject: [PATCH] dnsproxy: fix signedness warnings
Date: Fri,  9 Feb 2024 10:01:48 -0800
Message-Id: <20240209180148.19443-1-bfukano@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the signdness warnings in dnsproxy.c
---
 src/dnsproxy.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index d4242560..72e77f96 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -436,7 +436,7 @@ static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
 	ptr += DNS_HEADER_SIZE;
 	len -= DNS_HEADER_SIZE;
 
-	if (len < DNS_QUESTION_SIZE + 1)
+	if (len < 0 || (unsigned int)len < DNS_QUESTION_SIZE + 1)
 		return;
 
 	/* skip the query, which is a name and a struct domain_question */
@@ -459,7 +459,7 @@ static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
 			break;
 
 		rr = (void*)ptr;
-		if (len < sizeof(*rr))
+		if ((unsigned int)len < sizeof(*rr))
 			/* incomplete record */
 			break;
 
@@ -520,7 +520,7 @@ static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
 		connman_error("Cannot send cached DNS response: %s",
 				strerror(errno));
 	}
-	else if (err != len || dns_len != (len - offset))
+	else if ((unsigned int)err != len || dns_len != (len - offset))
 		debug("Packet length mismatch, sent %d wanted %zd dns %zd",
 			err, len, dns_len);
 }
@@ -656,7 +656,7 @@ static int append_data(unsigned char *buf, size_t size, const char *data)
 
 	while (true) {
 		const char *dot = strchr(data, '.');
-		len = dot ? dot - data : strlen(data);
+		len = dot ? (unsigned int)(dot - data) : strlen(data);
 
 		if (len == 0)
 			break;
@@ -1063,7 +1063,7 @@ static int parse_response(const unsigned char *buf, size_t buflen,
 	qlen = strlen(question);
 	ptr += qlen + 1; /* skip \0 */
 
-	if ((eptr - ptr) < DNS_QUESTION_SIZE)
+	if ((unsigned int)(eptr - ptr) < DNS_QUESTION_SIZE)
 		return -EINVAL;
 
 	q = (void *) ptr;
@@ -2031,7 +2031,7 @@ static int dns_reply_fixup_domains(
 	const char *domain;
 
 	/* full header plus at least one byte for the hostname length */
-	if (reply_len < header_len + 1)
+	if (reply_len < (unsigned int)(header_len + 1))
 		return -EINVAL;
 
 	section_counts[0] = hdr->ancount;
@@ -2521,7 +2521,7 @@ hangup:
 				connman_error("DNS proxy error %s",
 						strerror(errno));
 				goto hangup;
-			} else if (bytes_recv < sizeof(reply_len))
+			} else if ((unsigned int)bytes_recv < sizeof(reply_len))
 				return TRUE;
 
 			/* the header contains the length of the message
-- 
2.34.1

