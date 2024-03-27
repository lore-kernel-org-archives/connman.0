Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F314F138
	for <connman@lists.linux.dev>; Wed, 27 Mar 2024 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566754; cv=none; b=iE8HaGfkFDliJXqLw3OxQGVD+znWLWQ35yWJzpqsn9PcgJweuJiY1R2cC0L1Hm8kQfiHAmolb277nq3nwykG+4PI6mHwtWCDwY0zczKG/3ymkEwnuY/48cdhMv8ejqQlVEQuF/xYo9226zktkSY/O+/bgJZzhErqHMcTUQuz790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566754; c=relaxed/simple;
	bh=do6QptmGEIfjCclWvTWxmR4S0GqhrWv4LfRZXBzfMJk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sIWALb6s4Mc15S7EqVwLNTF+gDPWI4WEvqBQx4X0HkmX4eluhG0ZfeF2j3LpnrCpoyvMORfq8LQNNc3YGs2UdpGID4YsJTUIaWneU29lxLlW/HxQ7TxnhIqs6M38OI9PkIuP5PuRAb3OYk/2siRal88dPB3cW9Xcu7e9Q9XDAgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbXoGY+2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbXoGY+2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29fb7e52731so154504a91.2
        for <connman@lists.linux.dev>; Wed, 27 Mar 2024 12:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566752; x=1712171552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gS2roPtKK3n16nMvNAa7i1KoK8BqFds9P8cn/fzHkU=;
        b=kbXoGY+2cGZikTKymTEDrzQijVo66vLJCNOEE3iAxnWfSVh3saxMHHqZKNHHBczE9Q
         Q8Akt8Yr6OrBDR4ow9hBHX7LgQxqpSZmZqQz9Mvi3WA4v3IEUP5l4KIzhfSTgDYEHTTT
         63OjJ+qRJ2BHro8AgdskxkQrNGYHadbEyH81twns5t1KdjvRjYOa/i65c3GeqDATzChl
         zS36btI9nEplXmTZEwWHYqd20oGQYa1UyE5hoaVz0V1Nre+Giziq5zfc3FeaBjpFdMHH
         cdtxCNpu5yqufKLTpwl4IT9r4SZxnQYhW3ASN9aSTD6Vin/0wQ7Y2gGAHpSYcigS6W15
         HJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566752; x=1712171552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gS2roPtKK3n16nMvNAa7i1KoK8BqFds9P8cn/fzHkU=;
        b=JmXEhMy2Q1N17wXPNmSe5EH5W6gfQwkjGySG9PbIlkC/7/4znhZILVIKanIyiSknXJ
         JZI2mgHHCSKCgb5mIoTNil+tv1P9c5mqKH+MZwK69xKH4nqb7ktWIzy3G2yZDxxYFE50
         pvxx+cOu5i3hCr/UnkqudA9gxvSP92vgoEJ5nMTLQ/vjmF2JQTl0/9wFOHekjAedBwan
         eZ03ZxT0NThuMiS+EtY3LcGxjCatqQo2QKZvn4wxaxRoDer9w9d1LUE/4+n6MajjQjKf
         8v7/7KhOuLjBvIBaQ0ZP1ptX2OWBXGelxA+HzgO4ECjBXtB5yc6AoZp/apT67olYeqYu
         9v6g==
X-Forwarded-Encrypted: i=1; AJvYcCXit/de06ZEoODtbJZh3APAgQlNSIWx+TIrVDDanaU6U7U/a2ndUEIYV6bPylRG8EBNW06cIcoKCFFV4C7VLzKqFOCtHQ8n3A==
X-Gm-Message-State: AOJu0Yxu7D+MdPak15b+Rp6DxsWuotGHE23IQ8F7yD/TlQIl96AzNiIS
	YL5010xyvDIvfNRYaFBmnYxVopJT9rIPKnUpY9ZrMUoUnw2HLyGuo2jmJvV+hNI=
X-Google-Smtp-Source: AGHT+IEGOF2T8yEMM624wpHQZ27VSj/p9Ka00BzK6rUwAtHSVGPjUNOHmW8HzavIBNY6Nd6CynQ02w==
X-Received: by 2002:a17:90a:b283:b0:2a0:2bf4:d13a with SMTP id c3-20020a17090ab28300b002a02bf4d13amr529368pjr.40.1711566752210;
        Wed, 27 Mar 2024 12:12:32 -0700 (PDT)
Received: from brian-linux-22-04.localdomain (c-24-5-211-102.hsd1.ca.comcast.net. [24.5.211.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a17090aa51400b0029c7743cb33sm2076691pjq.40.2024.03.27.12.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 12:12:31 -0700 (PDT)
From: Brian Fukano <bfukano@gmail.com>
To: bfukano@gmail.com,
	connman@lists.linux.dev
Subject: [PATCH v2] dnsproxy: fix signedness warnings
Date: Wed, 27 Mar 2024 12:12:29 -0700
Message-Id: <20240327191229.248942-1-bfukano@gmail.com>
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
 src/dnsproxy.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index d4242560..a25fde35 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -417,30 +417,30 @@ static void refresh_dns_entry(struct cache_entry *entry, char *name)
 		entry->hits = 0;
 }
 
-static size_t dns_name_length(const unsigned char *buf)
+static size_t dns_name_length(const unsigned char *buf, size_t len)
 {
 	if ((buf[0] & NS_CMPRSFLGS) == NS_CMPRSFLGS) /* compressed name */
 		return 2;
-	return strlen((const char *)buf) + 1;
+	return strnlen((const char *)buf, len) + 1;
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
-	name_len = dns_name_length(ptr);
+	name_len = dns_name_length(ptr, len);
+
+	if (len < name_len + DNS_QUESTION_SIZE)
+		return;
 
 	ptr += name_len + DNS_QUESTION_SIZE;
 	len -= name_len + DNS_QUESTION_SIZE;
@@ -452,11 +452,12 @@ static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
 		size_t rr_len;
 
 		/* first a name */
-		name_len = dns_name_length(ptr);
+		name_len = dns_name_length(ptr, len);
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
@@ -507,8 +511,8 @@ static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
 	/* if this is a negative reply, we are authoritative */
 	if (answers == 0)
 		hdr->aa = 1;
-	else {
-		const int adj_len = len - 2;
+	else if (len > 2){
+		const size_t adj_len = len - 2;
 		update_cached_ttl((unsigned char *)hdr, adj_len, ttl);
 	}
 
@@ -520,7 +524,9 @@ static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
 		connman_error("Cannot send cached DNS response: %s",
 				strerror(errno));
 	}
-	else if (err != len || dns_len != (len - offset))
+
+	size_t bytes_sent = err;
+	if (bytes_sent != len || dns_len != (len - offset))
 		debug("Packet length mismatch, sent %d wanted %zd dns %zd",
 			err, len, dns_len);
 }
@@ -655,8 +661,8 @@ static int append_data(unsigned char *buf, size_t size, const char *data)
 	size_t len;
 
 	while (true) {
-		const char *dot = strchr(data, '.');
-		len = dot ? dot - data : strlen(data);
+		const char *dot = strchrnul(data, '.');
+		len = dot - data;
 
 		if (len == 0)
 			break;
@@ -1063,7 +1069,7 @@ static int parse_response(const unsigned char *buf, size_t buflen,
 	qlen = strlen(question);
 	ptr += qlen + 1; /* skip \0 */
 
-	if ((eptr - ptr) < DNS_QUESTION_SIZE)
+	if (ptr + DNS_QUESTION_SIZE >= eptr)
 		return -EINVAL;
 
 	q = (void *) ptr;
@@ -1398,7 +1404,7 @@ static int reply_query_type(const unsigned char *msg, int len)
 		return 0;
 
 	/* now the query, which is a name and 2 16 bit words for type and class */
-	c += dns_name_length(c);
+	c += dns_name_length(c, len);
 
 	type = c[0] << 8 | c[1];
 
@@ -2031,7 +2037,7 @@ static int dns_reply_fixup_domains(
 	const char *domain;
 
 	/* full header plus at least one byte for the hostname length */
-	if (reply_len < header_len + 1)
+	if (reply_len < header_len + 1U)
 		return -EINVAL;
 
 	section_counts[0] = hdr->ancount;
@@ -2510,6 +2516,7 @@ hangup:
 
 		if (!reply) {
 			uint16_t reply_len;
+			size_t bytes_len;
 
 			bytes_recv = recv(sk, &reply_len, sizeof(reply_len), MSG_PEEK);
 			if (!bytes_recv) {
@@ -2521,7 +2528,10 @@ hangup:
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

