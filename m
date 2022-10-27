Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8251E1C29
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:20 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B97D21FDFE
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mqmArD7F+Jn66IKMyPoHv77P8695ISpJ/pyHoYSf4w=;
	b=ioNNc0rfaiplO6U7f7x1KZvxmMpwZsVUm3/nPCwFVBEK4UOWGcb5RVnDtPMdSN+hhck0i7
	dOhplirHzZiKuqidFeRyTUmJZ+z+FemWCsrJ0bJCVkW+jwdTJKVzozEl9REG7v6qB6FKGH
	s1Ks38lxNxQw1ZehXZoDLHWchHnjrso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mqmArD7F+Jn66IKMyPoHv77P8695ISpJ/pyHoYSf4w=;
	b=mKYHfYev5cUzmrGNU5VT3IhRAgroom5a15wTIOL/0aKLoybuUCNKqK28mXeZpf3OJWd5nq
	3u0BFWhPdcxFIHBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A64BB134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7SqYKGheWmPjBAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:12 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 05/16] dnsproxy: refactoring of update_cached_ttl() and append_data()
Date: Thu, 27 Oct 2022 12:32:48 +0200
Message-Id: <20221027103258.29129-6-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221027103258.29129-1-matthias.gerstner@suse.de>
References: <20221027103258.29129-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- use size_t for sizes and lengths where possible
- use named constants in favor of literal numbers
- more localized variable declarations
- prefer byte order macros over explicit byte operations
- add some comments and use early exits to simplify the code
---
 src/dnsproxy.c | 143 +++++++++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 02fb3c78c..5ba68b52f 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -391,52 +391,52 @@ static size_t dns_name_length(const unsigned char *buf)
 	return strlen((const char *)buf) + 1;
 }
 
-static void update_cached_ttl(unsigned char *buf, int len, int new_ttl)
+static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
 {
-	unsigned char *c;
-	uint16_t w;
-	int l;
+	size_t name_len;
+	const uint32_t raw_ttl = ntohl((uint32_t)new_ttl);
+
+	if (new_ttl < 0)
+		return;
 
 	/* skip the header */
-	c = buf + 12;
-	len -= 12;
+	ptr += DNS_HEADER_SIZE;
+	len -= DNS_HEADER_SIZE;
+
+	if (len < sizeof(struct domain_question) + 1)
+		return;
 
-	/* skip the query, which is a name and 2 16 bit words */
-	l = dns_name_length(c);
-	c += l;
-	len -= l;
-	c += 4;
-	len -= 4;
+	/* skip the query, which is a name and a struct domain_question */
+	name_len = dns_name_length(ptr);
+
+	ptr += name_len + sizeof(struct domain_question);
+	len -= name_len + sizeof(struct domain_question);;
 
 	/* now we get the answer records */
 
 	while (len > 0) {
+		struct domain_rr *rr = NULL;
+		size_t rr_len;
+
 		/* first a name */
-		l = dns_name_length(c);
-		c += l;
-		len -= l;
-		if (len < 0)
-			break;
-		/* then type + class, 2 bytes each */
-		c += 4;
-		len -= 4;
+		name_len = dns_name_length(ptr);
+		ptr += name_len;
+		len -= name_len;
 		if (len < 0)
 			break;
 
-		/* now the 4 byte TTL field */
-		c[0] = new_ttl >> 24 & 0xff;
-		c[1] = new_ttl >> 16 & 0xff;
-		c[2] = new_ttl >> 8 & 0xff;
-		c[3] = new_ttl & 0xff;
-		c += 4;
-		len -= 4;
-		if (len < 0)
+		rr = (void*)ptr;
+		if (len < sizeof(*rr))
+			/* incomplete record */
 			break;
 
-		/* now the 2 byte rdlen field */
-		w = c[0] << 8 | c[1];
-		c += w + 2;
-		len -= w + 2;
+		/* update the TTL field */
+		memcpy(&rr->ttl, &raw_ttl, sizeof(raw_ttl));
+
+		/* skip to the next record */
+		rr_len = sizeof(*rr) + ntohs(rr->rdlen);
+		ptr += rr_len;
+		len -= rr_len;
 	}
 }
 
@@ -623,59 +623,60 @@ out:
 	return FALSE;
 }
 
-static int append_query(unsigned char *buf, unsigned int size,
-				const char *query, const char *domain)
+static int append_data(unsigned char *buf, size_t size, const char *data)
 {
 	unsigned char *ptr = buf;
-	int len;
-
-	debug("query %s domain %s", query, domain);
+	size_t len;
 
-	while (query) {
-		const char *tmp;
+	while (true) {
+		const char *dot = strchr(data, '.');
+		len = dot ? dot - data : strlen(data);
 
-		tmp = strchr(query, '.');
-		if (!tmp) {
-			len = strlen(query);
-			if (len == 0)
-				break;
-			*ptr = len;
-			memcpy(ptr + 1, query, len);
-			ptr += len + 1;
+		if (len == 0)
 			break;
-		}
+		else if (size < len + 1)
+			return -1;
 
-		*ptr = tmp - query;
-		memcpy(ptr + 1, query, tmp - query);
-		ptr += tmp - query + 1;
+		*ptr = len;
+		memcpy(ptr + 1, data, len);
+		ptr += len + 1;
+		size -= len + 1;
 
-		query = tmp + 1;
+		if (!dot)
+			break;
+
+		data = dot + 1;
 	}
 
-	while (domain) {
-		const char *tmp;
+	return ptr - buf;
+}
 
-		tmp = strchr(domain, '.');
-		if (!tmp) {
-			len = strlen(domain);
-			if (len == 0)
-				break;
-			*ptr = len;
-			memcpy(ptr + 1, domain, len);
-			ptr += len + 1;
-			break;
-		}
+static int append_query(unsigned char *buf, size_t size,
+				const char *query, const char *domain)
+{
+	size_t added;
+	size_t left_size = size;
+	int res;
 
-		*ptr = tmp - domain;
-		memcpy(ptr + 1, domain, tmp - domain);
-		ptr += tmp - domain + 1;
+	debug("query %s domain %s", query, domain);
 
-		domain = tmp + 1;
-	}
+	res = append_data(buf, left_size, query);
+	if (res < 0)
+		return -1;
+	left_size -= res;
+
+	res = append_data(buf + res, left_size, domain);
+	if (res < 0)
+		return -1;
+	left_size -= res;
+
+	if (left_size == 0)
+		return -1;
 
-	*ptr++ = 0x00;
+	added = size - left_size;
+	*(buf + added) = 0x00;
 
-	return ptr - buf;
+	return added;
 }
 
 static bool cache_check_is_valid(struct cache_data *data, time_t current_time)
-- 
2.37.3

