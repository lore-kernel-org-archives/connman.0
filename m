Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D6649
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:37 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 624891FE1C
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654864415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BR/aqvvTnJByMjudjChZl3oFyELpyE6Tn5A6BiAMps=;
	b=k+s9RHHBJIgtiXk7z8H8ngV92VBs/iuQMFuBSqv/KU8e6CvTkyuNniVGMf7tCO4zLnn4ld
	ZdbDXTflnPJqmo4hP/J924P5GJ0O4cSahg0UQPCs0nQWe+p3Cz377/eUE4jJyIPIezbBMn
	6/LrpADAuD3AdejfehY7r6xvZj9DP5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654864415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9BR/aqvvTnJByMjudjChZl3oFyELpyE6Tn5A6BiAMps=;
	b=T9qfQh9IoeH89Xcc9pftq5tq/h+QHpHG//Jlk4GiS2TZKAttXil6InYZWMq5lU07u0UB3v
	I6pvp2ZYdf4eVRCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C111139ED
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UFt3Fh86o2KGMgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:35 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 09/16] dnsproxy: refactor ns_resolv() and forwards_dns_reply()
Date: Fri, 10 Jun 2022 14:33:16 +0200
Message-Id: <20220610123323.8974-10-matthias.gerstner@suse.de>
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

- document function behaviour in comments
- use early exits where possible to reduce indentation levels
- move stack variables into more localized scopes
- reduce some duplicate code in uncompress() calls
- add TODO about likely logical error that could have ramifications
  when fixing.
---
 src/dnsproxy.c | 304 +++++++++++++++++++++++++------------------------
 1 file changed, 153 insertions(+), 151 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index fa517e1be..d76cb0d2e 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1571,39 +1571,40 @@ static int cache_update(struct server_data *srv, const char *msg, size_t msg_len
 	return 0;
 }
 
-static int ns_resolv(struct server_data *server, struct request_data *req,
-				gpointer request, gpointer name)
+/*
+ * attempts to answer the given request from cached replies.
+ *
+ * returns:
+ * > 0 on cache hit (answer is already sent out to client)
+ * == 0 on cache miss
+ * < 0 on error condition (errno)
+ */
+static int ns_try_resolv_from_cache(
+		struct request_data *req, gpointer request, const char *lookup)
 {
-	GList *list;
-	int sk, err;
 	uint16_t type = 0;
-	char *dot, *lookup = (char *) name;
-	struct cache_entry *entry;
+	struct cache_entry *entry = cache_check(request, &type, req->protocol);
+	if (!entry)
+		return 0;
 
-	entry = cache_check(request, &type, req->protocol);
-	if (entry) {
-		int ttl_left = 0;
-		struct cache_data *data;
+	debug("cache hit %s type %s", lookup, type == 1 ? "A" : "AAAA");
 
-		debug("cache hit %s type %s", lookup, type == 1 ? "A" : "AAAA");
-		if (type == 1)
-			data = entry->ipv4;
-		else
-			data = entry->ipv6;
+	const struct cache_data *data = type == DNS_TYPE_A ?
+						entry->ipv4 : entry->ipv6;
 
-		if (data) {
-			ttl_left = data->valid_until - time(NULL);
-			entry->hits++;
-		}
+	if (!data)
+		return 0;
+
+	int ttl_left = data->valid_until - time(NULL);
+	entry->hits++;
 
-		if (data && req->protocol == IPPROTO_TCP) {
+	switch(req->protocol) {
+		case IPPROTO_TCP:
 			send_cached_response(req->client_sk, data->data,
 					data->data_len, NULL, 0, IPPROTO_TCP,
 					req->srcid, data->answers, ttl_left);
 			return 1;
-		}
-
-		if (data && req->protocol == IPPROTO_UDP) {
+		case IPPROTO_UDP: {
 			int udp_sk = get_req_udp_socket(req);
 
 			if (udp_sk < 0)
@@ -1617,7 +1618,24 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 		}
 	}
 
-	sk = g_io_channel_unix_get_fd(server->channel);
+	return -EINVAL;
+}
+
+static int ns_resolv(struct server_data *server, struct request_data *req,
+				gpointer request, gpointer name)
+{
+	const char *lookup = (const char *)name;
+
+	int err = ns_try_resolv_from_cache(req, request, lookup);
+	if (err > 0)
+		/* cache hit */
+		return 1;
+	else if (err != 0)
+		/* error other than cache miss, don't continue */
+		return err;
+
+	/* forward request to real DNS server */
+	int sk = g_io_channel_unix_get_fd(server->channel);
 
 	err = sendto(sk, request, req->request_len, MSG_NOSIGNAL,
 			server->server_addr, server->server_addr_len);
@@ -1632,51 +1650,50 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 	req->numserv++;
 
 	/* If we have more than one dot, we don't add domains */
-	dot = strchr(lookup, '.');
-	if (dot && dot != lookup + strlen(lookup) - 1)
-		return 0;
+	{
+		const char *dot = strchr(lookup, '.');
+		if (dot && dot != lookup + strlen(lookup) - 1)
+			return 0;
+	}
 
 	if (server->domains && server->domains->data)
 		req->append_domain = true;
 
-	for (list = server->domains; list; list = list->next) {
-		char *domain;
-		unsigned char alt[1024];
-		struct domain_hdr *hdr = (void *) &alt;
-		int altlen, domlen;
-		size_t offset = protocol_offset(server->protocol);
-
-		domain = list->data;
-
+	for (GList *list = server->domains; list; list = list->next) {
+		const char *domain = list->data;
 		if (!domain)
 			continue;
 
-		domlen = strlen(domain) + 1;
+		const int domlen = strlen(domain) + 1;
 		if (domlen < 5)
 			return -EINVAL;
 
-		alt[offset] = req->altid & 0xff;
-		alt[offset + 1] = req->altid >> 8;
+		const size_t offset = protocol_offset(server->protocol);
+		unsigned char alt[1024];
+		/* TODO: is this a bug? the offset isn't considered here... */
+		struct domain_hdr *hdr = (void *) &alt;
+
+		memcpy(alt + offset, &req->altid, sizeof(req->altid));
 
 		memcpy(alt + offset + 2, request + offset + 2, 10);
 		hdr->qdcount = htons(1);
 
-		altlen = append_query(alt + offset + 12, sizeof(alt) - 12,
+		int altlen = append_query(alt + offset + DNS_HEADER_SIZE, sizeof(alt) - DNS_HEADER_SIZE,
 					name, domain);
 		if (altlen < 0)
 			return -EINVAL;
 
-		altlen += 12;
+		altlen += DNS_HEADER_SIZE;
+		altlen += offset;
 
-		memcpy(alt + offset + altlen,
-			request + offset + altlen - domlen,
-				req->request_len - altlen - offset + domlen);
+		memcpy(alt + altlen,
+			request + altlen - domlen,
+			req->request_len - altlen + domlen);
 
 		if (server->protocol == IPPROTO_TCP) {
-			int req_len = req->request_len + domlen - 2;
-
-			alt[0] = (req_len >> 8) & 0xff;
-			alt[1] = req_len & 0xff;
+			uint16_t req_len = req->request_len + domlen - DNS_HEADER_TCP_EXTRA_BYTES;
+			uint16_t *len_hdr = (void*)alt;
+			*len_hdr = htons(req_len);
 		}
 
 		debug("req %p dstid 0x%04x altid 0x%04x", req, req->dstid,
@@ -1925,94 +1942,83 @@ static int strip_domains(const char *name, char *answers, size_t length)
 	return length;
 }
 
-static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
+static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
 				struct server_data *data)
 {
-	struct domain_hdr *hdr;
-	struct request_data *req;
-	int dns_id, sk, err;
-	size_t offset = protocol_offset(protocol);
-
-	if (reply_len < 0)
-		return -EINVAL;
-	if ((size_t)reply_len < offset + 1)
-		return -EINVAL;
-	if ((size_t)reply_len < sizeof(struct domain_hdr))
-		return -EINVAL;
+	const size_t offset = protocol_offset(protocol);
+	struct domain_hdr *hdr = (void *)(reply + offset);
 
-	hdr = (void *)(reply + offset);
-	dns_id = reply[offset] | reply[offset + 1] << 8;
+	debug("Received %zd bytes (id 0x%04x)", reply_len, hdr->id);
 
-	debug("Received %d bytes (id 0x%04x)", reply_len, dns_id);
+	if (reply_len < sizeof(struct domain_hdr) + offset)
+		return -EINVAL;
 
-	req = find_request(dns_id);
+	struct request_data *req = find_request(hdr->id);
 	if (!req)
 		return -EINVAL;
 
 	debug("req %p dstid 0x%04x altid 0x%04x rcode %d",
 			req, req->dstid, req->altid, hdr->rcode);
 
-	reply[offset] = req->srcid & 0xff;
-	reply[offset + 1] = req->srcid >> 8;
+	/* replace with original request ID from our client */
+	hdr->id = req->srcid;
 
 	req->numresp++;
 
 	if (hdr->rcode == ns_r_noerror || !req->resp) {
-		unsigned char *new_reply = NULL;
+		char *new_reply = NULL;
 
 		/*
-		 * If the domain name was append
-		 * remove it before forwarding the reply.
-		 * If there were more than one question, then this
-		 * domain name ripping can be hairy so avoid that
-		 * and bail out in that that case.
+		 * If the domain name was appended remove it before forwarding
+		 * the reply. If there were more than one question, then this
+		 * domain name ripping can be hairy so avoid that and bail out
+		 * in that that case.
 		 *
-		 * The reason we are doing this magic is that if the
-		 * user's DNS client tries to resolv hostname without
-		 * domain part, it also expects to get the result without
-		 * a domain name part.
+		 * The reason we are doing this magic is that if the user's
+		 * DNS client tries to resolv hostname without domain part, it
+		 * also expects to get the result without a domain name part.
 		 */
 		if (req->append_domain && ntohs(hdr->qdcount) == 1) {
-			uint16_t domain_len = 0;
-			uint16_t header_len, payload_len;
-			uint16_t dns_type, dns_class;
-			uint8_t host_len, dns_type_pos;
-			char uncompressed[NS_MAXDNAME], *uptr;
-			const char *ptr, *eom = (char *)reply + reply_len;
-			const char *domain;
+			const char *eom = reply + reply_len;
+			const uint16_t header_len = offset + DNS_HEADER_SIZE;
+			if (reply_len < header_len)
+				return -EINVAL;
+			const uint16_t payload_len = reply_len - header_len;
+			if (payload_len < 1)
+				return -EINVAL;
 
 			/*
 			 * ptr points to the first char of the hostname.
 			 * ->hostname.domain.net
 			 */
-			header_len = offset + sizeof(struct domain_hdr);
-			if (reply_len < header_len)
-				return -EINVAL;
-			payload_len = reply_len - header_len;
-
-			ptr = (char *)reply + header_len;
+			const char *ptr = reply + header_len;
 
-			host_len = *ptr;
-			domain = ptr + 1 + host_len;
-			if (domain > eom)
+			const uint8_t host_len = *ptr;
+			const char *domain = ptr + 1 + host_len;
+			if (domain >= eom)
 				return -EINVAL;
 
-			if (host_len > 0)
-				domain_len = strnlen(domain, eom - domain);
+			const uint16_t domain_len = host_len ?
+				strnlen(domain, eom - domain) : 0;
 
 			/*
 			 * If the query type is anything other than A or AAAA,
 			 * then bail out and pass the message as is.
 			 * We only want to deal with IPv4 or IPv6 addresses.
 			 */
-			dns_type_pos = host_len + 1 + domain_len + 1;
-
-			if (ptr + (dns_type_pos + 3) > eom)
+			const struct qtype_qclass *qtc =
+				(void*)(domain + domain_len + 1);
+			if (((const char*)(qtc + 1)) > eom)
 				return -EINVAL;
-			dns_type = ptr[dns_type_pos] << 8 |
-							ptr[dns_type_pos + 1];
-			dns_class = ptr[dns_type_pos + 2] << 8 |
-							ptr[dns_type_pos + 3];
+
+			const uint16_t dns_type = ntohs(qtc->qtype);
+			const uint16_t dns_class = ntohs(qtc->qclass);
+
+			/* TODO: this condition looks wrong it should be
+			 *  (dns_type != A && dns_type != AAAA) || dns_class != IN)
+			 * however then the behaviour of dnsproxy changes,
+			 * e.g. MX records will be passed back to the client,
+			 * but without adjustment of the appended DNS name. */
 			if (dns_type != DNS_TYPE_A && dns_type != DNS_TYPE_AAAA &&
 					dns_class != DNS_CLASS_IN) {
 				debug("Pass msg dns type %d class %d",
@@ -2034,17 +2040,17 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 			 * case we end up in this branch.
 			 */
 			if (domain_len > 0) {
-				int len = host_len + 1;
-				int new_len, fixed_len;
-				char *answers;
+				char uncompressed[NS_MAXDNAME];
+				const size_t len = host_len + 1;
+
+				/* NOTE: length checks up and including to
+				 * qtype_qclass have already been done above */
 
-				if (len > payload_len)
-					return -EINVAL;
 				/*
 				 * First copy host (without domain name) into
 				 * tmp buffer.
 				 */
-				uptr = &uncompressed[0];
+				char *uptr = &uncompressed[0];
 				memcpy(uptr, ptr, len);
 
 				uptr[len] = '\0'; /* host termination */
@@ -2053,20 +2059,15 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 				/*
 				 * Copy type and class fields of the question.
 				 */
-				ptr += len + domain_len + 1;
-				if (ptr + NS_QFIXEDSZ > eom)
-					return -EINVAL;
-				memcpy(uptr, ptr, NS_QFIXEDSZ);
+				memcpy(uptr, qtc, sizeof(*qtc));
 
 				/*
 				 * ptr points to answers after this
 				 */
-				ptr += NS_QFIXEDSZ;
-				uptr += NS_QFIXEDSZ;
-				answers = uptr;
-				fixed_len = answers - uncompressed;
-				if (ptr + offset > eom)
-					return -EINVAL;
+				ptr = (void*)(qtc + 1);
+				uptr += sizeof(*qtc);
+				char *answers = uptr;
+				const size_t fixed_len = answers - uncompressed;
 
 				/*
 				 * We then uncompress the result to buffer
@@ -2075,41 +2076,36 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 				 * then name server (authority) information,
 				 * and finally additional record info.
 				 */
-
-				ptr = uncompress(ntohs(hdr->ancount),
-						(char *)reply + offset, eom,
-						ptr, uncompressed, NS_MAXDNAME,
-						&uptr);
-				if (!ptr)
-					goto out;
-
-				ptr = uncompress(ntohs(hdr->nscount),
-						(char *)reply + offset, eom,
-						ptr, uncompressed, NS_MAXDNAME,
-						&uptr);
-				if (!ptr)
-					goto out;
-
-				ptr = uncompress(ntohs(hdr->arcount),
-						(char *)reply + offset, eom,
-						ptr, uncompressed, NS_MAXDNAME,
-						&uptr);
-				if (!ptr)
-					goto out;
+				const uint16_t section_counts[] = {
+					hdr->ancount,
+					hdr->nscount,
+					hdr->arcount
+				};
+
+				for (size_t i = 0; i < sizeof(section_counts) / sizeof(uint16_t); i++) {
+					ptr = uncompress(ntohs(section_counts[i]),
+							reply + offset, eom,
+							ptr, uncompressed, NS_MAXDNAME,
+							&uptr);
+					if (!ptr)
+						goto out;
+				}
 
 				/*
-				 * The uncompressed buffer now contains almost
-				 * valid response. Final step is to get rid of
-				 * the domain name because at least glibc
-				 * gethostbyname() implementation does extra
-				 * checks and expects to find an answer without
-				 * domain name if we asked a query without
-				 * domain part. Note that glibc getaddrinfo()
-				 * works differently and accepts FQDN in answer
+				 * The uncompressed buffer now contains an
+				 * almost valid response. Final step is to get
+				 * rid of the domain name because at least
+				 * glibc gethostbyname() implementation does
+				 * extra checks and expects to find an answer
+				 * without domain name if we asked a query
+				 * without domain part. Note that glibc
+				 * getaddrinfo() works differently and accepts
+				 * FQDN in answer
 				 */
-				new_len = strip_domains(uncompressed, answers,
+				const int new_an_len = strip_domains(
+							uncompressed, answers,
 							uptr - answers);
-				if (new_len < 0) {
+				if (new_an_len < 0) {
 					debug("Corrupted packet");
 					return -EINVAL;
 				}
@@ -2118,9 +2114,13 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 				 * Because we have now uncompressed the answers
 				 * we might have to create a bigger buffer to
 				 * hold all that data.
+				 *
+				 * TODO: only create bigger buffer if
+				 * actually necessary, pass allocation size of
+				 * buffer via additional parameter.
 				 */
 
-				reply_len = header_len + new_len + fixed_len;
+				reply_len = header_len + new_an_len + fixed_len;
 
 				new_reply = g_try_malloc(reply_len);
 				if (!new_reply)
@@ -2128,7 +2128,7 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 
 				memcpy(new_reply, reply, header_len);
 				memcpy(new_reply + header_len, uncompressed,
-					new_len + fixed_len);
+					new_an_len + fixed_len);
 
 				reply = new_reply;
 			}
@@ -2161,6 +2161,8 @@ out:
 
 	request_list = g_slist_remove(request_list, req);
 
+	int err, sk;
+
 	if (protocol == IPPROTO_UDP) {
 		sk = get_req_udp_socket(req);
 		if (sk < 0) {
@@ -2170,7 +2172,7 @@ out:
 			err = sendto(sk, req->resp, req->resplen, 0,
 				&req->sa, req->sa_len);
 	} else {
-		uint16_t tcp_len = htons(req->resplen - 2);
+		const uint16_t tcp_len = htons(req->resplen - DNS_HEADER_TCP_EXTRA_BYTES);
 		/* correct TCP message length */
 		memcpy(req->resp, &tcp_len, sizeof(tcp_len));
 		sk = req->client_sk;
-- 
2.35.1

