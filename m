Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC102119
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:39 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A41A220EF
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654864417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feZi6f2SW49My4PGCBrnqRdZ+c3TO/H/KJZitoDXQSk=;
	b=Nf4BfXWFHIpNrrcD3ZusYxezjZODifjZYanlQt9U33ONHyYhmx+8g80JhMGinFMfExv14+
	lbzCNi+rEnM2313URxs5VU9OPKnxIfPf+Tujw8Q6kG1mMJsxOpJy6nSw3ztkUFxMwzrEDf
	c96+D3KKdvXpK2AiioQJ8C/R4Jht1xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654864417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feZi6f2SW49My4PGCBrnqRdZ+c3TO/H/KJZitoDXQSk=;
	b=xtup9qyThrOg4Ff2EYwgTiFNqFccd4TG0yiu28kS9nEmYoN5YIy6V5nGwD9Nkb7fI78AjB
	vXzfZFf1w1eCTDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72D46139ED
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +s1kGyE6o2KUMgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:37 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 14/16] dnsproxy: harmonize use of sizeof() for message size calculations
Date: Fri, 10 Jun 2022 14:33:21 +0200
Message-Id: <20220610123323.8974-15-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610123323.8974-1-matthias.gerstner@suse.de>
References: <20220610123323.8974-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dnsproxy.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 1371cbe36..e3f768da8 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -229,6 +229,9 @@ struct domain_rr {
 #define DNS_HEADER_SIZE sizeof(struct domain_hdr)
 #define DNS_HEADER_TCP_EXTRA_BYTES 2
 #define DNS_TCP_HEADER_SIZE DNS_HEADER_SIZE + DNS_HEADER_TCP_EXTRA_BYTES
+#define DNS_QUESTION_SIZE sizeof(struct domain_question)
+#define DNS_RR_SIZE sizeof(struct domain_rr)
+#define DNS_QTYPE_QCLASS_SIZE sizeof(struct qtype_qclass)
 
 enum dns_type {
 	/* IPv4 address 32-bit */
@@ -429,14 +432,14 @@ static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
 	ptr += DNS_HEADER_SIZE;
 	len -= DNS_HEADER_SIZE;
 
-	if (len < sizeof(struct domain_question) + 1)
+	if (len < DNS_QUESTION_SIZE + 1)
 		return;
 
 	/* skip the query, which is a name and a struct domain_question */
 	size_t name_len = dns_name_length(ptr);
 
-	ptr += name_len + sizeof(struct domain_question);
-	len -= name_len + sizeof(struct domain_question);;
+	ptr += name_len + DNS_QUESTION_SIZE;
+	len -= name_len + DNS_QUESTION_SIZE;
 
 	const uint32_t raw_ttl = ntohl((uint32_t)new_ttl);
 	struct domain_rr *rr = NULL;
@@ -962,10 +965,10 @@ static int parse_rr(const unsigned char *buf, const unsigned char *start,
 	if (*ttl < 0)
 		return -EINVAL;
 
-	memcpy(response + offset, *end, sizeof(struct domain_rr));
+	memcpy(response + offset, *end, DNS_RR_SIZE);
 
-	offset += sizeof(struct domain_rr);
-	*end += sizeof(struct domain_rr);
+	offset += DNS_RR_SIZE;
+	*end += DNS_RR_SIZE;
 
 	if ((offset + *rdlen) > *response_size)
 		return -ENOBUFS;
@@ -1035,7 +1038,7 @@ static int parse_response(const unsigned char *buf, size_t buflen,
 	qlen = strlen(question);
 	ptr += qlen + 1; /* skip \0 */
 
-	if ((eptr - ptr) < sizeof(struct domain_question))
+	if ((eptr - ptr) < DNS_QUESTION_SIZE)
 		return -EINVAL;
 
 	const struct domain_question *q = (void *) ptr;
@@ -1045,7 +1048,7 @@ static int parse_response(const unsigned char *buf, size_t buflen,
 	if (qtype != DNS_TYPE_A && qtype != DNS_TYPE_AAAA)
 		return -ENOMSG;
 
-	ptr += sizeof(struct domain_question); /* advance to answers section */
+	ptr += DNS_QUESTION_SIZE; /* advance to answers section */
 
 	int err = -ENOMSG;
 	const uint16_t ancount = ntohs(hdr->ancount);
@@ -1567,7 +1570,7 @@ static int cache_update(struct server_data *srv, const char *msg, size_t msg_len
 	struct domain_question *q = (void *)ptr;
 	q->type = htons(type);
 	q->class = htons(class);
-	ptr += sizeof(struct domain_question);
+	ptr += DNS_QUESTION_SIZE;
 
 	memcpy(ptr, response, rsplen);
 
@@ -2125,7 +2128,7 @@ static struct request_data* lookup_request(
 
 	debug("Received %zd bytes (id 0x%04x)", len, hdr->id);
 
-	if (len < sizeof(struct domain_hdr) + offset)
+	if (len < DNS_HEADER_SIZE + offset)
 		return NULL;
 
 	struct request_data *req = find_request(hdr->id);
@@ -3025,7 +3028,7 @@ static int parse_request(unsigned char *buf, size_t len,
 {
 	static const unsigned char opt_edns0_type[2] = { 0x00, 0x29 };
 	struct domain_hdr *hdr = (void *) buf;
-	if (len < sizeof(*hdr) + sizeof(struct qtype_qclass)) {
+	if (len < DNS_HEADER_SIZE + DNS_QTYPE_QCLASS_SIZE) {
 		DBG("Dropped DNS request with short length %zd", len);
 		return -EINVAL;
 	}
@@ -3052,8 +3055,8 @@ static int parse_request(unsigned char *buf, size_t len,
 
 	name[0] = '\0';
 
-	unsigned char *ptr = buf + sizeof(struct domain_hdr);
-	size_t remain = len - sizeof(struct domain_hdr);
+	unsigned char *ptr = buf + DNS_HEADER_SIZE;
+	size_t remain = len - DNS_HEADER_SIZE;
 	size_t used = 0;
 
 	/* parse DNS query string into `name' out parameter */
@@ -3091,7 +3094,7 @@ static int parse_request(unsigned char *buf, size_t len,
 		remain -= label_len + 1;
 	}
 
-	if (arcount && remain >= sizeof(struct domain_rr) + 1 && !ptr[0] &&
+	if (arcount && remain >= DNS_RR_SIZE + 1 && !ptr[0] &&
 		ptr[1] == opt_edns0_type[0] && ptr[2] == opt_edns0_type[1]) {
 		struct domain_rr *edns0 = (struct domain_rr *)(ptr + 1);
 
-- 
2.35.1

