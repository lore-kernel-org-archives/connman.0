Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D851C13
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:19 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8CB841FE01
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EvUTIX4EjXJnVWrDWp2lr/1xo58pdzbgbaCAWsmwa4I=;
	b=NZ/inRIISKxK9gMzkIHy/LMr6lPr6boIfRlyVllkRyD0AbCPdzkKM5CFPRLGb3ZcPofXkJ
	RgHXV15UVLTwXlXtG6hNsp8cWurL949XPOQp+wI0rP62hIQtgjwOdy+znAeYP80jfFK7ez
	EkG/I4m51g4JEm2wRV+HSlEv6f/AObk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EvUTIX4EjXJnVWrDWp2lr/1xo58pdzbgbaCAWsmwa4I=;
	b=8Vv2blbnLx4LFkTDxjhmu5ABw/VHBYhN3is5MyveJ8T9Ix0829Co5UwC910BB8gQyT/BLv
	Db+LJAHIiaw6D9Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8269C134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id TXPUH21eWmP5BAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:17 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 10/16] dnsproxy: refactor ns_resolv() and forwards_dns_reply()
Date: Thu, 27 Oct 2022 12:32:53 +0200
Message-Id: <20221027103258.29129-11-matthias.gerstner@suse.de>
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

- document function behaviour in comments
- use early exits where possible to reduce indentation levels
- move stack variables into more localized scopes
- reduce some duplicate code in uncompress() calls
- add TODO about likely logical error that could have ramifications
  when fixing.
---
 src/dnsproxy.c | 296 +++++++++++++++++++++++++------------------------
 1 file changed, 153 insertions(+), 143 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index c4f4796c2..b34b952ba 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1591,39 +1591,41 @@ static int cache_update(struct server_data *srv, const unsigned char *msg, size_
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
+	int ttl_left;
+	struct cache_data *data;
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
+	data = type == DNS_TYPE_A ? entry->ipv4 : entry->ipv6;
 
-		if (data) {
-			ttl_left = data->valid_until - time(NULL);
-			entry->hits++;
-		}
+	if (!data)
+		return 0;
 
-		if (data && req->protocol == IPPROTO_TCP) {
+	ttl_left = data->valid_until - time(NULL);
+	entry->hits++;
+
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
@@ -1637,6 +1639,24 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 		}
 	}
 
+	return -EINVAL;
+}
+
+static int ns_resolv(struct server_data *server, struct request_data *req,
+				gpointer request, gpointer name)
+{
+	int sk = -1;
+	const char *lookup = (const char *)name;
+	int err = ns_try_resolv_from_cache(req, request, lookup);
+
+	if (err > 0)
+		/* cache hit */
+		return 1;
+	else if (err != 0)
+		/* error other than cache miss, don't continue */
+		return err;
+
+	/* forward request to real DNS server */
 	sk = g_io_channel_unix_get_fd(server->channel);
 
 	err = sendto(sk, request, req->request_len, MSG_NOSIGNAL,
@@ -1652,51 +1672,52 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
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
+	for (GList *list = server->domains; list; list = list->next) {
+		int domlen, altlen;
 		unsigned char alt[1024];
+		/* TODO: is this a bug? the offset isn't considered here... */
 		struct domain_hdr *hdr = (void *) &alt;
-		int altlen, domlen;
-		size_t offset = protocol_offset(server->protocol);
-
-		domain = list->data;
+		const char *domain = list->data;
+		const size_t offset = protocol_offset(server->protocol);
 
 		if (!domain)
 			continue;
 
 		domlen = strlen(domain) + 1;
+
 		if (domlen < 5)
 			return -EINVAL;
 
-		alt[offset] = req->altid & 0xff;
-		alt[offset + 1] = req->altid >> 8;
+		memcpy(alt + offset, &req->altid, sizeof(req->altid));
 
 		memcpy(alt + offset + 2, request + offset + 2, 10);
 		hdr->qdcount = htons(1);
 
-		altlen = append_query(alt + offset + 12, sizeof(alt) - 12,
+		altlen = append_query(alt + offset + DNS_HEADER_SIZE, sizeof(alt) - DNS_HEADER_SIZE,
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
@@ -1948,94 +1969,87 @@ static int strip_domains(const char *name, char *answers, size_t length)
 	return length;
 }
 
-static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
+static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
 				struct server_data *data)
 {
-	struct domain_hdr *hdr;
+	const size_t offset = protocol_offset(protocol);
 	struct request_data *req;
-	int dns_id, sk, err;
-	size_t offset = protocol_offset(protocol);
-
-	if (reply_len < 0)
-		return -EINVAL;
-	if ((size_t)reply_len < offset + 1)
-		return -EINVAL;
-	if ((size_t)reply_len < sizeof(struct domain_hdr))
-		return -EINVAL;
+	struct domain_hdr *hdr = (void *)(reply + offset);
+	int err, sk;
 
-	hdr = (void *)(reply + offset);
-	dns_id = reply[offset] | reply[offset + 1] << 8;
+	debug("Received %zd bytes (id 0x%04x)", reply_len, hdr->id);
 
-	debug("Received %d bytes (id 0x%04x)", reply_len, dns_id);
+	if (reply_len < sizeof(struct domain_hdr) + offset)
+		return -EINVAL;
 
-	req = find_request(dns_id);
+	req = find_request(hdr->id);
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
+			uint8_t host_len;
+			uint16_t domain_len, dns_type, dns_class;
 			const char *domain;
+			struct qtype_qclass *qtc;
+			const char *eom = reply + reply_len;
+			const uint16_t header_len = offset + DNS_HEADER_SIZE;
+			const uint16_t payload_len = reply_len - header_len;
+			const char *ptr = reply + header_len;
+
+			if (reply_len < header_len)
+				return -EINVAL;
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
-
 			host_len = *ptr;
 			domain = ptr + 1 + host_len;
-			if (domain > eom)
+			if (domain >= eom)
 				return -EINVAL;
 
-			if (host_len > 0)
-				domain_len = strnlen(domain, eom - domain);
+			domain_len = host_len ? strnlen(domain, eom - domain) : 0;
 
 			/*
 			 * If the query type is anything other than A or AAAA,
 			 * then bail out and pass the message as is.
 			 * We only want to deal with IPv4 or IPv6 addresses.
 			 */
-			dns_type_pos = host_len + 1 + domain_len + 1;
-
-			if (ptr + (dns_type_pos + 3) > eom)
+			qtc = (void*)(domain + domain_len + 1);
+			if (((const char*)(qtc + 1)) > eom)
 				return -EINVAL;
-			dns_type = ptr[dns_type_pos] << 8 |
-							ptr[dns_type_pos + 1];
-			dns_class = ptr[dns_type_pos + 2] << 8 |
-							ptr[dns_type_pos + 3];
+
+			dns_type = ntohs(qtc->qtype);
+			dns_class = ntohs(qtc->qclass);
+
+			/* TODO: this condition looks wrong it should be
+			 *  (dns_type != A && dns_type != AAAA) || dns_class != IN)
+			 * however then the behaviour of dnsproxy changes,
+			 * e.g. MX records will be passed back to the client,
+			 * but without adjustment of the appended DNS name. */
 			if (dns_type != DNS_TYPE_A && dns_type != DNS_TYPE_AAAA &&
 					dns_class != DNS_CLASS_IN) {
 				debug("Pass msg dns type %d class %d",
@@ -2057,17 +2071,25 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 			 * case we end up in this branch.
 			 */
 			if (domain_len > 0) {
-				int len = host_len + 1;
-				int new_len, fixed_len;
+				char uncompressed[NS_MAXDNAME];
+				size_t fixed_len;
+				int new_an_len;
+				char *uptr = &uncompressed[0];
 				char *answers;
+				const size_t len = host_len + 1;
+				const uint16_t section_counts[] = {
+					hdr->ancount,
+					hdr->nscount,
+					hdr->arcount
+				};
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
 				memcpy(uptr, ptr, len);
 
 				uptr[len] = '\0'; /* host termination */
@@ -2076,20 +2098,15 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
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
+				ptr = (void*)(qtc + 1);
+				uptr += sizeof(*qtc);
 				answers = uptr;
 				fixed_len = answers - uncompressed;
-				if (ptr + offset > eom)
-					return -EINVAL;
 
 				/*
 				 * We then uncompress the result to buffer
@@ -2099,40 +2116,29 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 				 * and finally additional record info.
 				 */
 
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
-							uptr - answers);
-				if (new_len < 0) {
+				new_an_len = strip_domains(uncompressed, answers,
+							   uptr - answers);
+				if (new_an_len < 0) {
 					debug("Corrupted packet");
 					return -EINVAL;
 				}
@@ -2141,9 +2147,13 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
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
@@ -2151,7 +2161,7 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 
 				memcpy(new_reply, reply, header_len);
 				memcpy(new_reply + header_len, uncompressed,
-					new_len + fixed_len);
+					new_an_len + fixed_len);
 
 				reply = new_reply;
 			}
@@ -2168,7 +2178,7 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 		memcpy(req->resp, reply, reply_len);
 		req->resplen = reply_len;
 
-		cache_update(data, reply, reply_len);
+		cache_update(data, (unsigned char*)reply, reply_len);
 
 		g_free(new_reply);
 	}
@@ -2193,7 +2203,7 @@ out:
 			err = sendto(sk, req->resp, req->resplen, 0,
 				&req->sa, req->sa_len);
 	} else {
-		uint16_t tcp_len = htons(req->resplen - 2);
+		const uint16_t tcp_len = htons(req->resplen - DNS_HEADER_TCP_EXTRA_BYTES);
 		/* correct TCP message length */
 		memcpy(req->resp, &tcp_len, sizeof(tcp_len));
 		sk = req->client_sk;
@@ -2285,7 +2295,7 @@ static gboolean udp_server_event(GIOChannel *channel, GIOCondition condition,
 	len = recv(sk, buf, sizeof(buf), 0);
 
 	if (len > 0) {
-		forward_dns_reply(buf, len, IPPROTO_UDP, data);
+		forward_dns_reply((char*)buf, len, IPPROTO_UDP, data);
 	}
 
 	return TRUE;
@@ -2479,7 +2489,7 @@ hangup:
 			reply->received += bytes_recv;
 		}
 
-		forward_dns_reply(reply->buf, reply->received, IPPROTO_TCP,
+		forward_dns_reply((char*)reply->buf, reply->received, IPPROTO_TCP,
 					server);
 
 		g_free(reply);
-- 
2.37.3

