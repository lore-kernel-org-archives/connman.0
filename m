Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD61C16
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:24 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A4741F8C6
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKFu0KHD5Pvv8/UcCEIasT1H1m6t7EBW+L+t0zfS314=;
	b=v46ndRbFAD1HuqfRpjAOqso4puzKxRG5oJUGr8K5SOJOaLiHWMY13WLqfhqtftamv8KRpD
	UDlX8f/G/tS1a+DRSfm5IOrGT45e44qP3z5TgTMcYmxAMWESGn3x0meVMWy2yxC7/hIQVR
	1H10Cs75GjDzPLWCxy6JV7efjzeCmCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKFu0KHD5Pvv8/UcCEIasT1H1m6t7EBW+L+t0zfS314=;
	b=Do2bKkjy9+GLc+TvHDGVK52QSXFwEvSlQAlyln3N6hKje8vGE+rgQPwUEKpFYzs0Qu/Nio
	cOa5K8ouuGFpHVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 704C7134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vwtkG3JeWmMQBQAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:22 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 15/16] dnsproxy: harmonize use of sizeof() for message size calculations
Date: Thu, 27 Oct 2022 12:32:58 +0200
Message-Id: <20221027103258.29129-16-matthias.gerstner@suse.de>
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

---
 src/dnsproxy.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 5e2df1000..f0ecd1b28 100644
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
@@ -432,14 +435,14 @@ static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
 	ptr += DNS_HEADER_SIZE;
 	len -= DNS_HEADER_SIZE;
 
-	if (len < sizeof(struct domain_question) + 1)
+	if (len < DNS_QUESTION_SIZE + 1)
 		return;
 
 	/* skip the query, which is a name and a struct domain_question */
 	name_len = dns_name_length(ptr);
 
-	ptr += name_len + sizeof(struct domain_question);
-	len -= name_len + sizeof(struct domain_question);;
+	ptr += name_len + DNS_QUESTION_SIZE;
+	len -= name_len + DNS_QUESTION_SIZE;
 
 	/* now we get the answer records */
 
@@ -973,10 +976,10 @@ static int parse_rr(const unsigned char *buf, const unsigned char *start,
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
@@ -1049,7 +1052,7 @@ static int parse_response(const unsigned char *buf, size_t buflen,
 	qlen = strlen(question);
 	ptr += qlen + 1; /* skip \0 */
 
-	if ((eptr - ptr) < sizeof(struct domain_question))
+	if ((eptr - ptr) < DNS_QUESTION_SIZE)
 		return -EINVAL;
 
 	q = (void *) ptr;
@@ -1059,7 +1062,7 @@ static int parse_response(const unsigned char *buf, size_t buflen,
 	if (qtype != DNS_TYPE_A && qtype != DNS_TYPE_AAAA)
 		return -ENOMSG;
 
-	ptr += sizeof(struct domain_question); /* advance to answers section */
+	ptr += DNS_QUESTION_SIZE; /* advance to answers section */
 
 	ancount = ntohs(hdr->ancount);
 	qclass = ntohs(q->class);
@@ -1588,7 +1591,7 @@ static int cache_update(struct server_data *srv, const unsigned char *msg, size_
 	q = (void *)ptr;
 	q->type = htons(type);
 	q->class = htons(class);
-	ptr += sizeof(struct domain_question);
+	ptr += DNS_QUESTION_SIZE;
 
 	memcpy(ptr, response, rsplen);
 
@@ -2155,7 +2158,7 @@ static struct request_data* lookup_request(
 
 	debug("Received %zd bytes (id 0x%04x)", len, hdr->id);
 
-	if (len < sizeof(struct domain_hdr) + offset)
+	if (len < DNS_HEADER_SIZE + offset)
 		return NULL;
 
 	req = find_request(hdr->id);
@@ -3067,11 +3070,11 @@ static int parse_request(unsigned char *buf, size_t len,
 	static const unsigned char OPT_EDNS0_TYPE[2] = { 0x00, 0x29 };
 	struct domain_hdr *hdr = (void *) buf;
 	uint16_t qdcount, ancount, nscount, arcount;
-	unsigned char *ptr = buf + sizeof(struct domain_hdr);
-	size_t remain = len - sizeof(struct domain_hdr);
+	unsigned char *ptr = buf + DNS_HEADER_SIZE;
+	size_t remain = len - DNS_HEADER_SIZE;
 	size_t used = 0;
 
-	if (len < sizeof(*hdr) + sizeof(struct qtype_qclass)) {
+	if (len < DNS_HEADER_SIZE + DNS_QTYPE_QCLASS_SIZE) {
 		DBG("Dropped DNS request with short length %zd", len);
 		return -EINVAL;
 	}
@@ -3133,7 +3136,7 @@ static int parse_request(unsigned char *buf, size_t len,
 		remain -= label_len + 1;
 	}
 
-	if (arcount && remain >= sizeof(struct domain_rr) + 1 && !ptr[0] &&
+	if (arcount && remain >= DNS_RR_SIZE + 1 && !ptr[0] &&
 		ptr[1] == OPT_EDNS0_TYPE[0] && ptr[2] == OPT_EDNS0_TYPE[1]) {
 		struct domain_rr *edns0 = (struct domain_rr *)(ptr + 1);
 
-- 
2.37.3

