Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50E33FF
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:09 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF3152081B
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666082884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kyusjDuMwKJZ+j7BBQpLOuBRrVoYOPA9o8gUwtobOY=;
	b=Kaj1ISMyZE4qYLwW9Vt190iiKXJqVeh0FQqwUl4dCMj6gp7EIwNuGY1ohb12t20o8Lsh8A
	+Kd/hrzFv126y1JOgM4o9dtXauVaQ/laUIxE/oqlQ2LzUFK/ocRGgxTxTXAPMPVf0ltSSW
	Ek2HwRXIbMSmq9vA6esgF2RFXkmHRIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666082884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kyusjDuMwKJZ+j7BBQpLOuBRrVoYOPA9o8gUwtobOY=;
	b=RzCCUticiEESarv+h9jzu40bSc+PNjTDTAnToxdG6YxE/UzVHBtrcJkFzhHpTS4aYBQyut
	ld9b0NO5IMR/RtAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7DC1139D2
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1XasNERoTmO0cAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:04 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 14/16] dnsproxy: harmonize use of sizeof() for message size calculations
Date: Tue, 18 Oct 2022 10:47:44 +0200
Message-Id: <20221018084746.21959-15-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018084746.21959-1-matthias.gerstner@suse.de>
References: <20221018084746.21959-1-matthias.gerstner@suse.de>
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
index 05b15f9c5..d375c10f5 100644
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
@@ -961,10 +964,10 @@ static int parse_rr(const unsigned char *buf, const unsigned char *start,
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
@@ -1034,7 +1037,7 @@ static int parse_response(const unsigned char *buf, size_t buflen,
 	qlen = strlen(question);
 	ptr += qlen + 1; /* skip \0 */
 
-	if ((eptr - ptr) < sizeof(struct domain_question))
+	if ((eptr - ptr) < DNS_QUESTION_SIZE)
 		return -EINVAL;
 
 	const struct domain_question *q = (void *) ptr;
@@ -1044,7 +1047,7 @@ static int parse_response(const unsigned char *buf, size_t buflen,
 	if (qtype != DNS_TYPE_A && qtype != DNS_TYPE_AAAA)
 		return -ENOMSG;
 
-	ptr += sizeof(struct domain_question); /* advance to answers section */
+	ptr += DNS_QUESTION_SIZE; /* advance to answers section */
 
 	int err = -ENOMSG;
 	const uint16_t ancount = ntohs(hdr->ancount);
@@ -1566,7 +1569,7 @@ static int cache_update(struct server_data *srv, const char *msg, size_t msg_len
 	struct domain_question *q = (void *)ptr;
 	q->type = htons(type);
 	q->class = htons(class);
-	ptr += sizeof(struct domain_question);
+	ptr += DNS_QUESTION_SIZE;
 
 	memcpy(ptr, response, rsplen);
 
@@ -2124,7 +2127,7 @@ static struct request_data* lookup_request(
 
 	debug("Received %zd bytes (id 0x%04x)", len, hdr->id);
 
-	if (len < sizeof(struct domain_hdr) + offset)
+	if (len < DNS_HEADER_SIZE + offset)
 		return NULL;
 
 	struct request_data *req = find_request(hdr->id);
@@ -3024,7 +3027,7 @@ static int parse_request(unsigned char *buf, size_t len,
 {
 	static const unsigned char opt_edns0_type[2] = { 0x00, 0x29 };
 	struct domain_hdr *hdr = (void *) buf;
-	if (len < sizeof(*hdr) + sizeof(struct qtype_qclass)) {
+	if (len < DNS_HEADER_SIZE + DNS_QTYPE_QCLASS_SIZE) {
 		DBG("Dropped DNS request with short length %zd", len);
 		return -EINVAL;
 	}
@@ -3051,8 +3054,8 @@ static int parse_request(unsigned char *buf, size_t len,
 
 	name[0] = '\0';
 
-	unsigned char *ptr = buf + sizeof(struct domain_hdr);
-	size_t remain = len - sizeof(struct domain_hdr);
+	unsigned char *ptr = buf + DNS_HEADER_SIZE;
+	size_t remain = len - DNS_HEADER_SIZE;
 	size_t used = 0;
 
 	/* parse DNS query string into `name' out parameter */
@@ -3090,7 +3093,7 @@ static int parse_request(unsigned char *buf, size_t len,
 		remain -= label_len + 1;
 	}
 
-	if (arcount && remain >= sizeof(struct domain_rr) + 1 && !ptr[0] &&
+	if (arcount && remain >= DNS_RR_SIZE + 1 && !ptr[0] &&
 		ptr[1] == opt_edns0_type[0] && ptr[2] == opt_edns0_type[1]) {
 		struct domain_rr *edns0 = (struct domain_rr *)(ptr + 1);
 
-- 
2.37.3

