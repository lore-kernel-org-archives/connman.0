Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D95171649
	for <connman@lists.linux.dev>; Fri,  5 Apr 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336287; cv=none; b=D84yjMTf2E1vLdhI0BJae2zIOFvmhyKHox+VBNsgDrb8i6F+zMlHcLqBC+dpzahRR+sRzfGCzr3ZV69qRtd/ZB4BasIgep1mw2VZqRNCvMGmcyhE5sFzNlyh8sF3epnGcvEy6P1TxQZ4PvvW5aH6RkRHrXKZ24TNiaw0lulqjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336287; c=relaxed/simple;
	bh=kEjJWmTqYQZ5IB2pdBu+aex1e6PhWTXiL5qvPTXfFew=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=OXr1kid0e3D+P5R4K4nMZHmfE3nX4kzee0rdzkMbt9ZHjuPdU0Qi6+EWyinR/HgNS5nZiVd5teJFIo3sCITA0geZBfuZi9JhBCH/fzn3yWwZfF36t645wQXG/6/iRPeKW3L/KZJr5yQz3wo1YwgpU2Zf85IULCooxG2AWewi5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3CSz4tk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3CSz4tk"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a49a4d465aso16658a91.2
        for <connman@lists.linux.dev>; Fri, 05 Apr 2024 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712336285; x=1712941085; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpaUaencYNLsjMXEWQJVkgVxxM4iqw+1/SreYZdlTlc=;
        b=e3CSz4tkJwchNw6T3zuewCbw67SJxqN7iAgrx7vQ8ivW4bOoEIVgFDwfBWkRGK4HsZ
         ZpbqiGjoqPE10HZiq1WAS8K6wLa5VnV98Z+GlK7TCILEZ93c5NAAl6SdGKkmEcnGYSK3
         V7nLYJ7fIQkM1QJR926DQDjM0gKscwPA6CpNv7gKrH4vQdb2kCkKFcKF/n+LOtr793Zc
         MeWKFqmWFsnx9+eNesXGhwY+EnDPKyGr2IgKjBIqzx+Vk1tbWn54YFjieFPLOKGAlNjj
         ajLA1SDsShCOQTvVMiLp+9fStd/34bYHGxM2C3bjNzc16CFqdEHxO/Mn95smueR4KrOf
         nIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712336285; x=1712941085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpaUaencYNLsjMXEWQJVkgVxxM4iqw+1/SreYZdlTlc=;
        b=KUOTZr/Qf7Je54UnxqJiAtxTLzxKsPvDorfyXNCpSQOIfrK9N8UBSAMwA3yJL3KuKs
         gcEGkf/53jAOIV3zZsPAT+wbOqdbzkRoqzfG5CuhvIzqxEZ0KPK90HsLIDGzUmw7oesv
         u1G1JkIf9eGBxF8h8i4gfTeJe8YQYni3V0bp8b9geNwJo3QKyu3dyQPA450j2Z/18IWW
         jpifLnPK9BpvOZ76CdXwmgAPiSywM7pjhxknkk5ode4NLgzxv4eI/q4NJPqKFh3jwqL1
         1TUhfRuEFeOdMYCwMvDW2aOq/L+hU9KUKSasyJkbFM1QITNd311b2Jhko+8+A/Y6LOsg
         WR7g==
X-Forwarded-Encrypted: i=1; AJvYcCWW4UG4mt0r32kqDD4ThgMqy+tnTrnEC8r3ouIURzzx/Z73pita67qmt0R1sDdYFQwWTq1CAd9E9nxGRviRAgu2POzK7EGDLg==
X-Gm-Message-State: AOJu0YwqmQ0ZRAEtxkdqL3RZa15z6LxdcCMrjVh4nHYixYqFyHyFbr0Z
	/ZXkRTWYqI5ezGn/mkI5dQjNjGbcNH4MF/R6eeC8tkmpGxAkaOa9nfDt1TwZOtQ=
X-Google-Smtp-Source: AGHT+IGW7rBuHSvt96t6lwc1rjliO3iyUqljZPlkRRakcvoS+fUfYlSuVqYeNcL0YjI7Th5GouVZDw==
X-Received: by 2002:a17:90b:3e89:b0:2a0:9b66:8e22 with SMTP id rj9-20020a17090b3e8900b002a09b668e22mr1726334pjb.24.1712336285108;
        Fri, 05 Apr 2024 09:58:05 -0700 (PDT)
Received: from brian-linux-22-04.localdomain (c-24-5-211-102.hsd1.ca.comcast.net. [24.5.211.102])
        by smtp.gmail.com with ESMTPSA id fu19-20020a17090ad19300b002a2dbbbb36asm3232261pjb.37.2024.04.05.09.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:58:04 -0700 (PDT)
From: Brian Fukano <bfukano@gmail.com>
To: bfukano@gmail.com,
	connman@lists.linux.dev
Subject: [PATCH v3] dnsproxy: fix signedness warnings
Date: Fri,  5 Apr 2024 09:58:01 -0700
Message-Id: <20240405165801.72338-1-bfukano@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the signdness warnings found in dnsproxy.c
---
 src/dnsproxy.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index d4242560..777f505c 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -424,24 +424,24 @@ static size_t dns_name_length(const unsigned char *buf)
 	return strlen((const char *)buf) + 1;
 }
 
-static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
+static void update_cached_ttl(unsigned char *ptr, size_t len, int new_ttl)
 {
 	size_t name_len;
 	const uint32_t raw_ttl = ntohl((uint32_t)new_ttl);
 
-	if (new_ttl < 0)
+	if (new_ttl < 0 || len < DNS_HEADER_SIZE + DNS_QUESTION_SIZE + 1)
 		return;
 
 	/* skip the header */
 	ptr += DNS_HEADER_SIZE;
 	len -= DNS_HEADER_SIZE;
 
-	if (len < DNS_QUESTION_SIZE + 1)
-		return;
-
 	/* skip the query, which is a name and a struct domain_question */
 	name_len = dns_name_length(ptr);
 
+	if (len < name_len + DNS_QUESTION_SIZE)
+		return;
+
 	ptr += name_len + DNS_QUESTION_SIZE;
 	len -= name_len + DNS_QUESTION_SIZE;
 
@@ -453,10 +453,11 @@ static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
 
 		/* first a name */
 		name_len = dns_name_length(ptr);
+		if (len < name_len)
+			break;
+
 		ptr += name_len;
 		len -= name_len;
-		if (len < 0)
-			break;
 
 		rr = (void*)ptr;
 		if (len < sizeof(*rr))
@@ -468,6 +469,9 @@ static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
 
 		/* skip to the next record */
 		rr_len = sizeof(*rr) + ntohs(rr->rdlen);
+		if (len < rr_len)
+			break;
+
 		ptr += rr_len;
 		len -= rr_len;
 	}
@@ -479,6 +483,7 @@ static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
 {
 	struct domain_hdr *hdr = NULL;
 	int err;
+	size_t bytes_sent;
 	const size_t offset = protocol_offset(protocol);
 	/*
 	 * The cached packet contains always the TCP offset (two bytes)
@@ -508,7 +513,7 @@ static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
 	if (answers == 0)
 		hdr->aa = 1;
 	else {
-		const int adj_len = len - 2;
+		const size_t adj_len = len - 2;
 		update_cached_ttl((unsigned char *)hdr, adj_len, ttl);
 	}
 
@@ -520,7 +525,9 @@ static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
 		connman_error("Cannot send cached DNS response: %s",
 				strerror(errno));
 	}
-	else if (err != len || dns_len != (len - offset))
+
+	bytes_sent = err;
+	if (bytes_sent != len || dns_len != (len - offset))
 		debug("Packet length mismatch, sent %d wanted %zd dns %zd",
 			err, len, dns_len);
 }
@@ -655,8 +662,8 @@ static int append_data(unsigned char *buf, size_t size, const char *data)
 	size_t len;
 
 	while (true) {
-		const char *dot = strchr(data, '.');
-		len = dot ? dot - data : strlen(data);
+		const char *dot = strchrnul(data, '.');
+		len = dot - data;
 
 		if (len == 0)
 			break;
@@ -1063,7 +1070,7 @@ static int parse_response(const unsigned char *buf, size_t buflen,
 	qlen = strlen(question);
 	ptr += qlen + 1; /* skip \0 */
 
-	if ((eptr - ptr) < DNS_QUESTION_SIZE)
+	if (ptr + DNS_QUESTION_SIZE >= eptr)
 		return -EINVAL;
 
 	q = (void *) ptr;
@@ -2031,7 +2038,7 @@ static int dns_reply_fixup_domains(
 	const char *domain;
 
 	/* full header plus at least one byte for the hostname length */
-	if (reply_len < header_len + 1)
+	if (reply_len < header_len + 1U)
 		return -EINVAL;
 
 	section_counts[0] = hdr->ancount;
@@ -2510,6 +2517,7 @@ hangup:
 
 		if (!reply) {
 			uint16_t reply_len;
+			size_t bytes_len;
 
 			bytes_recv = recv(sk, &reply_len, sizeof(reply_len), MSG_PEEK);
 			if (!bytes_recv) {
@@ -2521,7 +2529,10 @@ hangup:
 				connman_error("DNS proxy error %s",
 						strerror(errno));
 				goto hangup;
-			} else if (bytes_recv < sizeof(reply_len))
+			}
+
+			bytes_len = bytes_recv;
+			if (bytes_len < sizeof(reply_len))
 				return TRUE;
 
 			/* the header contains the length of the message
-- 
2.34.1

