Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E2C1C04
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:21 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A42C61FDFF
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=budeJ7Vwke8207y62WnBgs3PmSUoR/hbms68xhiEZHI=;
	b=Rm6UshhRljNNHoO1w/moPBwkE3GvnSdZMIr6Ke67ilWrCYEo9lRfApK/HMH2ZtvfLOfOJL
	Bcrd7LPEC1A7T+2pggyw3VTtxDU0QD1vhqU70RJtyOCeN36qUolys5g6jE0cuilKbk8eU7
	0f2ECIjeHPUGesc7OT+FEvKoQatos9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=budeJ7Vwke8207y62WnBgs3PmSUoR/hbms68xhiEZHI=;
	b=1/6Wh/kOP/NJAaEOryCmTZykPz+idRaQsWjWL3X1G/PhGnEu2vLDi9KSx2XxhdKZJ0GNjP
	LnyjAMWHuPmhqkBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 990F1134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LllZJW9eWmMBBQAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:19 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 12/16] dnsproxy: forward_dns_reply: pull out separate dns_reply_fixup_domains()
Date: Thu, 27 Oct 2022 12:32:55 +0200
Message-Id: <20221027103258.29129-13-matthias.gerstner@suse.de>
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

This should make the code logic a bit clearer and less convoluted.
---
 src/dnsproxy.c | 336 ++++++++++++++++++++++++++-----------------------
 1 file changed, 177 insertions(+), 159 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 23873a381..27a761241 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -47,6 +47,8 @@
 #	define debug(fmt...) do { } while (0)
 #endif
 
+#define NUM_ARRAY_ELEMENTS(a) sizeof(a) / sizeof(a[0])
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 struct domain_hdr {
 	uint16_t id;
@@ -1966,6 +1968,168 @@ static int strip_domains(const char *name, char *answers, size_t length)
 	return length;
 }
 
+/*
+ * Removes domain names from replies, if one has been appended during
+ * forwarding to the real DNS server.
+ *
+ * Returns:
+ * < 0 on error (abort processing reply)
+ * == 0 if the reply should be forwarded unmodified
+ * > 0 returns a new reply buffer in *new_reply on success. The return value
+ * indicates the new length of the data in *new_reply.
+ */
+static int dns_reply_fixup_domains(
+				const char *reply, size_t reply_len,
+				const size_t offset,
+				struct request_data *req,
+				char **new_reply)
+{
+	char uncompressed[NS_MAXDNAME];
+	char *uptr, *answers;
+	size_t fixed_len;
+	int new_an_len;
+	const struct domain_hdr *hdr = (void *)(reply + offset);
+	const char *eom = reply + reply_len;
+	const uint16_t header_len = offset + DNS_HEADER_SIZE;
+	/* full header plus at least one byte for the hostname length */
+	if (reply_len < header_len + 1)
+		return -EINVAL;
+
+	const uint16_t section_counts[] = {
+		hdr->ancount,
+		hdr->nscount,
+		hdr->arcount
+	};
+
+	/*
+	 * length octet of the hostname.
+	 * ->hostname.domain.net
+	 */
+	const char *ptr = reply + header_len;
+	const uint8_t host_len = *ptr;
+	const char *domain = ptr + host_len + 1;
+	if (domain >= eom)
+		return -EINVAL;
+
+	const uint16_t domain_len = host_len ? strnlen(domain, eom - domain) : 0;
+
+	/*
+	 * If the query type is anything other than A or AAAA, then bail out
+	 * and pass the message as is.  We only want to deal with IPv4 or IPv6
+	 * addresses.
+	 */
+	const struct qtype_qclass *qtc = (void*)(domain + domain_len + 1);
+	if (((const char*)(qtc + 1)) > eom)
+		return -EINVAL;
+
+	const uint16_t dns_type = ntohs(qtc->qtype);
+	const uint16_t dns_class = ntohs(qtc->qclass);
+
+	if (domain_len == 0) {
+		/* nothing to do */
+		return 0;
+	}
+
+	/* TODO: This condition looks wrong. It should probably be
+	 *
+	 *  (dns_type != A && dns_type != AAAA) || dns_class != IN
+	 *
+	 * doing so, however, changes the behaviour of dnsproxy, e.g. MX
+	 * records will be passed back to the client, but without the
+	 * adjustment of the appended domain name.
+	 */
+	if (dns_type != DNS_TYPE_A && dns_type != DNS_TYPE_AAAA &&
+			dns_class != DNS_CLASS_IN) {
+		debug("Pass msg dns type %d class %d", dns_type, dns_class);
+		return 0;
+	}
+
+	/*
+	 * Remove the domain name and replace it by the end of reply. Check if
+	 * the domain is really there before trying to copy the data. We also
+	 * need to uncompress the answers if necessary.  The domain_len can be
+	 * 0 because if the original query did not contain a domain name, then
+	 * we are sending two packets, first without the domain name and the
+	 * second packet with domain name.  The append_domain is set to true
+	 * even if we sent the first packet without domain name. In this case
+	 * we end up in this branch.
+	 */
+
+	/* NOTE: length checks up and including to qtype_qclass have already
+	   been done above */
+
+	/*
+	 * First copy host (without domain name) into tmp buffer.
+	 */
+	uptr = &uncompressed[0];
+	memcpy(uptr, ptr, host_len + 1);
+
+	uptr[host_len + 1] = '\0'; /* host termination */
+	uptr += host_len + 2;
+
+	/*
+	 * Copy type and class fields of the question.
+	 */
+	memcpy(uptr, qtc, sizeof(*qtc));
+
+	/*
+	 * ptr points to answers after this
+	 */
+	ptr = (void*)(qtc + 1);
+	uptr += sizeof(*qtc);
+	answers = uptr;
+	fixed_len = answers - uncompressed;
+
+	/*
+	 * We then uncompress the result to buffer so that we can rip off the
+	 * domain name part from the question. First answers, then name server
+	 * (authority) information, and finally additional record info.
+	 */
+
+	for (size_t i = 0; i < NUM_ARRAY_ELEMENTS(section_counts); i++) {
+		ptr = uncompress(ntohs(section_counts[i]), reply + offset, eom,
+				ptr, uncompressed, NS_MAXDNAME, &uptr);
+		if (!ptr) {
+			/* failed to uncompress, pass on as is
+			 * (TODO: good idea?) */
+			return 0;
+		}
+	}
+
+	/*
+	 * The uncompressed buffer now contains an almost valid response.
+	 * Final step is to get rid of the domain name because at least glibc
+	 * gethostbyname() implementation does extra checks and expects to
+	 * find an answer without domain name if we asked a query without
+	 * domain part. Note that glibc getaddrinfo() works differently and
+	 * accepts FQDN in answer
+	 */
+	new_an_len = strip_domains(uncompressed, answers, uptr - answers);
+	if (new_an_len < 0) {
+		debug("Corrupted packet");
+		return -EINVAL;
+	}
+
+	/*
+	 * Because we have now uncompressed the answers we might have to
+	 * create a bigger buffer to hold all that data.
+	 *
+	 * TODO: only create a bigger buffer if actually necessary, pass
+	 * allocation size of input buffer via additional parameter.
+	 */
+
+	reply_len = header_len + new_an_len + fixed_len;
+
+	*new_reply = g_try_malloc(reply_len);
+	if (!*new_reply)
+		return -ENOMEM;
+
+	memcpy(*new_reply, reply, header_len);
+	memcpy(*new_reply + header_len, uncompressed, new_an_len + fixed_len);
+
+	return reply_len;
+}
+
 static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
 				struct server_data *data)
 {
@@ -1992,8 +2156,6 @@ static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
 	req->numresp++;
 
 	if (hdr->rcode == ns_r_noerror || !req->resp) {
-		char *new_reply = NULL;
-
 		/*
 		 * If the domain name was appended remove it before forwarding
 		 * the reply. If there were more than one question, then this
@@ -2004,167 +2166,24 @@ static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
 		 * DNS client tries to resolv hostname without domain part, it
 		 * also expects to get the result without a domain name part.
 		 */
-		if (req->append_domain && ntohs(hdr->qdcount) == 1) {
-			uint8_t host_len;
-			uint16_t domain_len, dns_type, dns_class;
-			const char *domain;
-			struct qtype_qclass *qtc;
-			const char *eom = reply + reply_len;
-			const uint16_t header_len = offset + DNS_HEADER_SIZE;
-			const uint16_t payload_len = reply_len - header_len;
-			const char *ptr = reply + header_len;
-
-			if (reply_len < header_len)
-				return -EINVAL;
-			if (payload_len < 1)
-				return -EINVAL;
-
-			/*
-			 * ptr points to the first char of the hostname.
-			 * ->hostname.domain.net
-			 */
-			host_len = *ptr;
-			domain = ptr + 1 + host_len;
-			if (domain >= eom)
-				return -EINVAL;
-
-			domain_len = host_len ? strnlen(domain, eom - domain) : 0;
-
-			/*
-			 * If the query type is anything other than A or AAAA,
-			 * then bail out and pass the message as is.
-			 * We only want to deal with IPv4 or IPv6 addresses.
-			 */
-			qtc = (void*)(domain + domain_len + 1);
-			if (((const char*)(qtc + 1)) > eom)
-				return -EINVAL;
-
-			dns_type = ntohs(qtc->qtype);
-			dns_class = ntohs(qtc->qclass);
-
-			/* TODO: this condition looks wrong it should be
-			 *  (dns_type != A && dns_type != AAAA) || dns_class != IN)
-			 * however then the behaviour of dnsproxy changes,
-			 * e.g. MX records will be passed back to the client,
-			 * but without adjustment of the appended DNS name. */
-			if (dns_type != DNS_TYPE_A && dns_type != DNS_TYPE_AAAA &&
-					dns_class != DNS_CLASS_IN) {
-				debug("Pass msg dns type %d class %d",
-					dns_type, dns_class);
-				goto pass;
-			}
-
-			/*
-			 * Remove the domain name and replace it by the end
-			 * of reply. Check if the domain is really there
-			 * before trying to copy the data. We also need to
-			 * uncompress the answers if necessary.
-			 * The domain_len can be 0 because if the original
-			 * query did not contain a domain name, then we are
-			 * sending two packets, first without the domain name
-			 * and the second packet with domain name.
-			 * The append_domain is set to true even if we sent
-			 * the first packet without domain name. In this
-			 * case we end up in this branch.
-			 */
-			if (domain_len > 0) {
-				char uncompressed[NS_MAXDNAME];
-				size_t fixed_len;
-				int new_an_len;
-				char *uptr = &uncompressed[0];
-				char *answers;
-				const size_t len = host_len + 1;
-				const uint16_t section_counts[] = {
-					hdr->ancount,
-					hdr->nscount,
-					hdr->arcount
-				};
-
-				/* NOTE: length checks up and including to
-				 * qtype_qclass have already been done above */
-
-				/*
-				 * First copy host (without domain name) into
-				 * tmp buffer.
-				 */
-				memcpy(uptr, ptr, len);
-
-				uptr[len] = '\0'; /* host termination */
-				uptr += len + 1;
-
-				/*
-				 * Copy type and class fields of the question.
-				 */
-				memcpy(uptr, qtc, sizeof(*qtc));
-
-				/*
-				 * ptr points to answers after this
-				 */
-				ptr = (void*)(qtc + 1);
-				uptr += sizeof(*qtc);
-				answers = uptr;
-				fixed_len = answers - uncompressed;
-
-				/*
-				 * We then uncompress the result to buffer
-				 * so that we can rip off the domain name
-				 * part from the question. First answers,
-				 * then name server (authority) information,
-				 * and finally additional record info.
-				 */
-
-				for (size_t i = 0; i < sizeof(section_counts) / sizeof(uint16_t); i++) {
-					ptr = uncompress(ntohs(section_counts[i]),
-							reply + offset, eom,
-							ptr, uncompressed, NS_MAXDNAME,
-							&uptr);
-					if (!ptr)
-						goto out;
-				}
-
-				/*
-				 * The uncompressed buffer now contains an
-				 * almost valid response. Final step is to get
-				 * rid of the domain name because at least
-				 * glibc gethostbyname() implementation does
-				 * extra checks and expects to find an answer
-				 * without domain name if we asked a query
-				 * without domain part. Note that glibc
-				 * getaddrinfo() works differently and accepts
-				 * FQDN in answer
-				 */
-				new_an_len = strip_domains(uncompressed, answers,
-							   uptr - answers);
-				if (new_an_len < 0) {
-					debug("Corrupted packet");
-					return -EINVAL;
-				}
-
-				/*
-				 * Because we have now uncompressed the answers
-				 * we might have to create a bigger buffer to
-				 * hold all that data.
-				 *
-				 * TODO: only create bigger buffer if
-				 * actually necessary, pass allocation size of
-				 * buffer via additional parameter.
-				 */
-
-				reply_len = header_len + new_an_len + fixed_len;
-
-				new_reply = g_try_malloc(reply_len);
-				if (!new_reply)
-					return -ENOMEM;
-
-				memcpy(new_reply, reply, header_len);
-				memcpy(new_reply + header_len, uncompressed,
-					new_an_len + fixed_len);
+		char *new_reply = NULL;
 
+		if (req->append_domain && ntohs(hdr->qdcount) == 1) {
+			const int fixup_res = dns_reply_fixup_domains(
+					reply, reply_len,
+					offset, req, &new_reply);
+			if (fixup_res < 0) {
+				/* error occured */
+				return fixup_res;
+			} else if (fixup_res > 0 && new_reply) {
+				/* new reply length */
+				reply_len = fixup_res;
 				reply = new_reply;
+			} else {
+				/* keep message as is */
 			}
 		}
 
-	pass:
 		g_free(req->resp);
 		req->resplen = 0;
 
@@ -2180,7 +2199,6 @@ static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
 		g_free(new_reply);
 	}
 
-out:
 	if (req->numresp < req->numserv) {
 		if (hdr->rcode > ns_r_noerror) {
 			return -EINVAL;
-- 
2.37.3

