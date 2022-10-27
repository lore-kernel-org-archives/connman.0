Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A954186B
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:16 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 919BA1FDFF
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBOfws95xMsxRBw4FqspscRcjqTEU/SR2Oi1EVvMjkU=;
	b=F3AfvBW1/9Rgnc2IengahtWuajHHqaC6p73wxcEZKxNa1tY5M/oKA5D4gcIJSflmQLet+s
	uD7DJbnUVr40DqAeNNLnCgx5srd4zP/NJaaYswjkNQ4+fYRC0IqrndX3gOIjKglfPJCY0d
	C2N71tiRtNkd4tAzCD6gGEKmJNjKIQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBOfws95xMsxRBw4FqspscRcjqTEU/SR2Oi1EVvMjkU=;
	b=bx/GbhHzCz9bWLK9Q6rzHGHzdWH3EaK7zlyibXcy42pMB+XIe78FrdFF08+md9q6yAEAqQ
	CUw/USgayzAMtTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84CFD134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iARqIGpeWmPuBAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:14 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 07/16] dnsproxy: refactoring of cache_update()
Date: Thu, 27 Oct 2022 12:32:50 +0200
Message-Id: <20221027103258.29129-8-matthias.gerstner@suse.de>
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

- move stack variables into more localized scopes
- use const parameters and variables where possible
- use named constants over literal numbers
- simplify some parsing details by using byte order macros or adding
  some comments to make the intentions clearer
---
 src/dnsproxy.c | 142 ++++++++++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 73 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 796b33fc3..c98e04eb6 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -226,6 +226,7 @@ struct domain_rr {
 
 #define DNS_HEADER_SIZE sizeof(struct domain_hdr)
 #define DNS_HEADER_TCP_EXTRA_BYTES 2
+#define DNS_TCP_HEADER_SIZE DNS_HEADER_SIZE + DNS_HEADER_TCP_EXTRA_BYTES
 
 enum dns_type {
 	/* IPv4 address 32-bit */
@@ -1371,22 +1372,26 @@ static int reply_query_type(const unsigned char *msg, int len)
 	return type;
 }
 
-static int cache_update(struct server_data *srv, unsigned char *msg,
-			unsigned int msg_len)
+/*
+ * update the cache with the DNS reply found in msg
+ */
+static int cache_update(struct server_data *srv, const unsigned char *msg, size_t msg_len)
 {
-	size_t offset = protocol_offset(srv->protocol);
-	int err, qlen, ttl = 0;
+	const size_t offset = protocol_offset(srv->protocol);
+	int err, ttl = 0;
+	uint16_t *lenhdr;
+	size_t qlen;
+	bool is_new_entry = false;
 	uint16_t answers = 0, type = 0, class = 0;
 	struct domain_hdr *hdr = (void *)(msg + offset);
-	struct domain_question *q;
+	struct domain_question *q = NULL;
 	struct cache_entry *entry;
 	struct cache_data *data;
 	char question[NS_MAXDNAME + 1];
 	unsigned char response[NS_MAXDNAME + 1];
-	unsigned char *ptr;
-	size_t rsplen;
-	bool new_entry = true;
-	time_t current_time;
+	unsigned char *ptr = NULL;
+	size_t rsplen = sizeof(response) - 1;
+	const time_t current_time = time(NULL);
 
 	if (cache_size >= MAX_CACHE_SIZE) {
 		cache_cleanup();
@@ -1394,8 +1399,6 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 			return 0;
 	}
 
-	current_time = time(NULL);
-
 	/* don't do a cache refresh more than twice a minute */
 	if (next_refresh < current_time) {
 		cache_refresh();
@@ -1411,9 +1414,7 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 	if (!cache)
 		create_cache();
 
-	rsplen = sizeof(response) - 1;
 	question[sizeof(question) - 1] = '\0';
-
 	err = parse_response(msg + offset, msg_len - offset,
 				question, sizeof(question) - 1,
 				&type, &class, &ttl,
@@ -1426,26 +1427,29 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 	 */
 	if ((err == -ENOMSG || err == -ENOBUFS) &&
 			reply_query_type(msg + offset,
-					msg_len - offset) == 28) {
+					msg_len - offset) == DNS_TYPE_AAAA) {
 		entry = g_hash_table_lookup(cache, question);
 		if (entry && entry->ipv4 && !entry->ipv6) {
-			int cache_offset = 0;
+			struct cache_data *data = g_try_new(struct cache_data, 1);
 
-			data = g_try_new(struct cache_data, 1);
 			if (!data)
 				return -ENOMEM;
 			data->inserted = entry->ipv4->inserted;
 			data->type = type;
 			data->answers = ntohs(hdr->ancount);
 			data->timeout = entry->ipv4->timeout;
-			if (srv->protocol == IPPROTO_UDP)
-				cache_offset = 2;
-			data->data_len = msg_len + cache_offset;
-			data->data = ptr = g_malloc(data->data_len);
-			ptr[0] = (data->data_len - 2) / 256;
-			ptr[1] = (data->data_len - 2) - ptr[0] * 256;
-			if (srv->protocol == IPPROTO_UDP)
-				ptr += 2;
+			data->data_len = msg_len +
+				(offset ? 0 : DNS_HEADER_TCP_EXTRA_BYTES);
+			data->data = g_malloc(data->data_len);
+			ptr = data->data;
+			if (srv->protocol == IPPROTO_UDP) {
+				/* add the two bytes length header also for
+				 * UDP responses */
+				lenhdr = (void*)ptr;
+				*lenhdr = htons(data->data_len -
+						DNS_HEADER_TCP_EXTRA_BYTES);
+				ptr += DNS_HEADER_TCP_EXTRA_BYTES;
+			}
 			data->valid_until = entry->ipv4->valid_until;
 			data->cache_until = entry->ipv4->cache_until;
 			memcpy(ptr, msg, msg_len);
@@ -1454,9 +1458,7 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 			 * we will get a "hit" when we serve the response
 			 * out of the cache
 			 */
-			entry->hits--;
-			if (entry->hits < 0)
-				entry->hits = 0;
+			entry->hits = entry->hits ? entry->hits - 1 : 0;
 			return 0;
 		}
 	}
@@ -1464,8 +1466,6 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 	if (err < 0 || ttl == 0)
 		return 0;
 
-	qlen = strlen(question);
-
 	/*
 	 * If the cache contains already data, check if the
 	 * type of the cached data is the same and do not add
@@ -1473,7 +1473,11 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 	 * This is needed so that we can cache both A and AAAA
 	 * records for the same name.
 	 */
+
 	entry = g_hash_table_lookup(cache, question);
+	data = NULL;
+	is_new_entry = !entry;
+
 	if (!entry) {
 		entry = g_try_new(struct cache_entry, 1);
 		if (!entry)
@@ -1490,37 +1494,28 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 		entry->want_refresh = false;
 		entry->hits = 0;
 
-		if (type == 1)
-			entry->ipv4 = data;
-		else
-			entry->ipv6 = data;
 	} else {
-		if (type == 1 && entry->ipv4)
+		if (type == DNS_TYPE_A && entry->ipv4)
 			return 0;
-
-		if (type == 28 && entry->ipv6)
+		else if (type == DNS_TYPE_AAAA && entry->ipv6)
 			return 0;
 
 		data = g_try_new(struct cache_data, 1);
 		if (!data)
 			return -ENOMEM;
 
-		if (type == 1)
-			entry->ipv4 = data;
-		else
-			entry->ipv6 = data;
-
 		/*
 		 * compensate for the hit we'll get for serving
 		 * the response out of the cache
 		 */
-		entry->hits--;
-		if (entry->hits < 0)
-			entry->hits = 0;
-
-		new_entry = false;
+		entry->hits = entry->hits ? entry->hits - 1 : 0;
 	}
 
+	if (type == DNS_TYPE_A)
+		entry->ipv4 = data;
+	else
+		entry->ipv6 = data;
+
 	if (ttl < MIN_CACHE_TTL)
 		ttl = MIN_CACHE_TTL;
 
@@ -1528,14 +1523,21 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 	data->type = type;
 	data->answers = answers;
 	data->timeout = ttl;
+	data->valid_until = current_time + ttl;
+
+	qlen = strlen(question);
 	/*
-	 * The "2" in start of the length is the TCP offset. We allocate it
-	 * here even for UDP packet because it simplifies the sending
-	 * of cached packet.
+	 * We allocate the extra TCP header bytes here even for UDP packet
+	 * because it simplifies the sending of cached packet.
 	 */
-	data->data_len = 2 + 12 + qlen + 1 + 2 + 2 + rsplen;
-	data->data = ptr = g_malloc(data->data_len);
-	data->valid_until = current_time + ttl;
+	data->data_len =  DNS_TCP_HEADER_SIZE + qlen + 1 + 2 + 2 + rsplen;
+	data->data = g_malloc(data->data_len);
+	if (!data->data) {
+		g_free(entry->key);
+		g_free(data);
+		g_free(entry);
+		return -ENOMEM;
+	}
 
 	/*
 	 * Restrict the cached DNS record TTL to some sane value
@@ -1546,45 +1548,39 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 
 	data->cache_until = round_down_ttl(current_time + ttl, ttl);
 
-	if (!data->data) {
-		g_free(entry->key);
-		g_free(data);
-		g_free(entry);
-		return -ENOMEM;
-	}
+	ptr = data->data;
 
 	/*
 	 * We cache the two extra bytes at the start of the message
-	 * in a TCP packet. When sending UDP packet, we skip the first
+	 * in a TCP packet. When sending UDP packet, we pad the first
 	 * two bytes. This way we do not need to know the format
 	 * (UDP/TCP) of the cached message.
 	 */
-	if (srv->protocol == IPPROTO_UDP)
-		memcpy(ptr + 2, msg, offset + 12);
-	else
-		memcpy(ptr, msg, offset + 12);
+	lenhdr = (void*)ptr;
+	*lenhdr = htons(data->data_len - DNS_HEADER_TCP_EXTRA_BYTES);
+	ptr += DNS_HEADER_TCP_EXTRA_BYTES;
 
-	ptr[0] = (data->data_len - 2) / 256;
-	ptr[1] = (data->data_len - 2) - ptr[0] * 256;
-	if (srv->protocol == IPPROTO_UDP)
-		ptr += 2;
+	memcpy(ptr, hdr, DNS_HEADER_SIZE);
+	ptr += DNS_HEADER_SIZE;
 
-	memcpy(ptr + offset + 12, question, qlen + 1); /* copy also the \0 */
+	memcpy(ptr, question, qlen + 1); /* copy also the \0 */
+	ptr += qlen + 1;
 
-	q = (void *) (ptr + offset + 12 + qlen + 1);
+	q = (void *)ptr;
 	q->type = htons(type);
 	q->class = htons(class);
-	memcpy(ptr + offset + 12 + qlen + 1 + sizeof(struct domain_question),
-		response, rsplen);
+	ptr += sizeof(struct domain_question);
+
+	memcpy(ptr, response, rsplen);
 
-	if (new_entry) {
+	if (is_new_entry) {
 		g_hash_table_replace(cache, entry->key, entry);
 		cache_size++;
 	}
 
 	debug("cache %d %squestion \"%s\" type %d ttl %d size %zd packet %u "
 								"dns len %u",
-		cache_size, new_entry ? "new " : "old ",
+		cache_size, is_new_entry ? "new " : "old ",
 		question, type, ttl,
 		sizeof(*entry) + sizeof(*data) + data->data_len + qlen,
 		data->data_len,
-- 
2.37.3

