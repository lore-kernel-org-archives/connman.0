Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24302ED9
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:52:02 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C06661F750
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1650365140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N83nJBa4yGBOcMPj1J3gMbvn+YwvpAL7ZgSPBxOjzN0=;
	b=dB11I+KDUOqtcSpa24JRNQNuCziTPRrMzG0WyAOh9luS5hSD0r1kX021dYU58mKUKyCQV5
	1ebXQelQgZzTsliiwEZDIV2d3DqLlo5RCAb5hsavfZjzfLXkOMSXUvrE5eGU1gqXxY5cXl
	fIVPJv4A38JMPSlyYNIFr11Wwekvhi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1650365140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N83nJBa4yGBOcMPj1J3gMbvn+YwvpAL7ZgSPBxOjzN0=;
	b=sXF/oR8QckDDM3xWVy9Q0EIWYaWBxdh1hXGOdhhyDwoQUxJDSSgi8sXxrN4QSWwjn6u7Lv
	zfr1AUwpj0u1j7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B84EE139BE
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Lkr4LNSSXmLfOAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:40 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 04/12] dnsproxy: refactor parse_response()
Date: Tue, 19 Apr 2022 12:34:53 +0200
Message-Id: <20220419103501.30553-5-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419103501.30553-1-matthias.gerstner@suse.de>
References: <20220419103501.30553-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dnsproxy.c | 123 +++++++++++++++++++++++++------------------------
 1 file changed, 63 insertions(+), 60 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 1b464a5fb..92ea1615f 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -907,7 +907,7 @@ static int get_name(int counter,
 
 static int parse_rr(const unsigned char *buf, const unsigned char *start,
 			const unsigned char *max,
-			unsigned char *response, unsigned int *response_size,
+			unsigned char *response, size_t *response_size,
 			uint16_t *type, uint16_t *class, int *ttl, uint16_t *rdlen,
 			const unsigned char **end,
 			char *name, size_t max_name)
@@ -968,55 +968,67 @@ static bool check_alias(GSList *aliases, const char *name)
 	return false;
 }
 
-static int parse_response(unsigned char *buf, int buflen,
-			char *question, int qlen,
+/*
+ * Parses the DNS response packet found in 'buf' consisting of 'buflen' bytes.
+ *
+ * The parsed question label, response type and class, ttl and number of
+ * answer sections are output parameters. The response output buffer will
+ * receive all matching resource records to be cached.
+ *
+ * Return value is < 0 on error (negative errno) or zero on success.
+ */
+static int parse_response(const unsigned char *buf, size_t buflen,
+			char *question, size_t qlen,
 			uint16_t *type, uint16_t *class, int *ttl,
-			unsigned char *response, unsigned int *response_len,
+			unsigned char *response, size_t *response_len,
 			uint16_t *answers)
 {
-	struct domain_hdr *hdr = (void *) buf;
-	struct domain_question *q;
-	const unsigned char *ptr;
-	uint16_t qdcount = ntohs(hdr->qdcount);
-	uint16_t ancount = ntohs(hdr->ancount);
-	int err, i;
-	uint16_t qtype, qclass;
-	const unsigned char *next = NULL;
-	unsigned int maxlen = *response_len;
-	GSList *aliases = NULL, *list;
-	char name[NS_MAXDNAME + 1];
-
-	if (buflen < 12)
+	const size_t maxlen = *response_len;
+	*response_len = 0;
+	*answers = 0;
+
+	if (buflen < DNS_HEADER_SIZE)
 		return -EINVAL;
 
-	debug("qr %d qdcount %d", hdr->qr, qdcount);
+	struct domain_hdr *hdr = (void *) buf;
 
-	/* We currently only cache responses where question count is 1 */
-	if (hdr->qr != 1 || qdcount != 1)
-		return -EINVAL;
+	{
+		const uint16_t qdcount = ntohs(hdr->qdcount);
+		debug("qr %d qdcount %d", hdr->qr, qdcount);
 
-	ptr = buf + sizeof(struct domain_hdr);
+		/* We currently only cache responses where question count is 1 */
+		if (hdr->qr != 1 || qdcount != 1)
+			return -EINVAL;
+	}
 
-	strncpy(question, (char *) ptr, qlen);
+	const unsigned char *ptr = buf + DNS_HEADER_SIZE;
+	const unsigned char *eptr = buf + buflen;
+
+	/*
+	 * NOTE: currently the *caller* ensures that the `question' buffer is
+	 * always zero terminated.
+	 */
+	strncpy(question, (const char *) ptr, MIN(qlen, buflen - DNS_HEADER_SIZE));
 	qlen = strlen(question);
 	ptr += qlen + 1; /* skip \0 */
 
-	q = (void *) ptr;
-	qtype = ntohs(q->type);
+	if ((eptr - ptr) < sizeof(struct domain_question))
+		return -EINVAL;
+
+	const struct domain_question *q = (void *) ptr;
+	const uint16_t qtype = ntohs(q->type);
 
 	/* We cache only A and AAAA records */
-	if (qtype != 1 && qtype != 28)
+	if (qtype != DNS_TYPE_A && qtype != DNS_TYPE_AAAA)
 		return -ENOMSG;
 
-	qclass = ntohs(q->class);
+	ptr += sizeof(struct domain_question); /* advance to answers section */
 
-	ptr += 2 + 2; /* ptr points now to answers */
-
-	err = -ENOMSG;
-	*response_len = 0;
-	*answers = 0;
-
-	memset(name, 0, sizeof(name));
+	int err = -ENOMSG;
+	const uint16_t ancount = ntohs(hdr->ancount);
+	const uint16_t qclass = ntohs(q->class);
+	char name[NS_MAXDNAME + 1] = {0};
+	GSList *aliases = NULL;
 
 	/*
 	 * We have a bunch of answers (like A, AAAA, CNAME etc) to
@@ -1024,7 +1036,7 @@ static int parse_response(unsigned char *buf, int buflen,
 	 * resource records. Only A and AAAA records are cached, all
 	 * the other records in answers are skipped.
 	 */
-	for (i = 0; i < ancount; i++) {
+	for (uint16_t i = 0; i < ancount; i++) {
 		/*
 		 * Get one address at a time to this buffer.
 		 * The max size of the answer is
@@ -1032,24 +1044,27 @@ static int parse_response(unsigned char *buf, int buflen,
 		 *   4 (ttl) + 2 (rdlen) + addr (16 or 4) = 28
 		 * for A or AAAA record.
 		 * For CNAME the size can be bigger.
+		 * TODO: why are we using the MAXCDNAME constant as buffer
+		 * size then?
 		 */
-		unsigned char rsp[NS_MAXCDNAME];
-		unsigned int rsp_len = sizeof(rsp) - 1;
-		int ret;
+		unsigned char rsp[NS_MAXCDNAME] = {0};
+		size_t rsp_len = sizeof(rsp) - 1;
+		const unsigned char *next = NULL;
 		uint16_t rdlen;
 
-		memset(rsp, 0, sizeof(rsp));
-
-		ret = parse_rr(buf, ptr, buf + buflen, rsp, &rsp_len,
+		int ret = parse_rr(buf, ptr, buf + buflen, rsp, &rsp_len,
 			type, class, ttl, &rdlen, &next, name,
 			sizeof(name) - 1);
 		if (ret != 0) {
 			err = ret;
-			goto out;
+			break;
 		}
 
+		/* set pointer to the next RR for the next iteration */
+		ptr = next;
+
 		/*
-		 * Now rsp contains compressed or uncompressed resource
+		 * Now rsp contains a compressed or an uncompressed resource
 		 * record. Next we check if this record answers the question.
 		 * The name var contains the uncompressed label.
 		 * One tricky bit is the CNAME records as they alias
@@ -1061,8 +1076,6 @@ static int parse_response(unsigned char *buf, int buflen,
 		 * looking for.
 		 */
 		if (*class != qclass) {
-			ptr = next;
-			next = NULL;
 			continue;
 		}
 
@@ -1087,7 +1100,7 @@ static int parse_response(unsigned char *buf, int buflen,
 		 * address of ipv6.l.google.com. For caching purposes this
 		 * should not cause any issues.
 		 */
-		if (*type == 5 && strncmp(question, name, qlen) == 0) {
+		if (*type == DNS_TYPE_CNAME && strncmp(question, name, qlen) == 0) {
 			/*
 			 * So now the alias answered the question. This is
 			 * not very useful from caching point of view as
@@ -1111,8 +1124,6 @@ static int parse_response(unsigned char *buf, int buflen,
 					name, sizeof(name) - 1, &name_len);
 			if (ret != 0) {
 				/* just ignore the error at this point */
-				ptr = next;
-				next = NULL;
 				continue;
 			}
 
@@ -1124,12 +1135,8 @@ static int parse_response(unsigned char *buf, int buflen,
 			 */
 			aliases = g_slist_prepend(aliases, g_strdup(name));
 
-			ptr = next;
-			next = NULL;
 			continue;
-		}
-
-		if (*type == qtype) {
+		} else if (*type == qtype) {
 			/*
 			 * We found correct type (A or AAAA)
 			 */
@@ -1146,7 +1153,7 @@ static int parse_response(unsigned char *buf, int buflen,
 				 */
 				if (*response_len + rsp_len > maxlen) {
 					err = -ENOBUFS;
-					goto out;
+					break;
 				}
 				memcpy(response + *response_len, rsp, rsp_len);
 				*response_len += rsp_len;
@@ -1154,13 +1161,9 @@ static int parse_response(unsigned char *buf, int buflen,
 				err = 0;
 			}
 		}
-
-		ptr = next;
-		next = NULL;
 	}
 
-out:
-	for (list = aliases; list; list = list->next)
+	for (GSList *list = aliases; list; list = list->next)
 		g_free(list->data);
 	g_slist_free(aliases);
 
@@ -1363,7 +1366,7 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 	char question[NS_MAXDNAME + 1];
 	unsigned char response[NS_MAXDNAME + 1];
 	unsigned char *ptr;
-	unsigned int rsplen;
+	size_t rsplen;
 	bool new_entry = true;
 	time_t current_time;
 
-- 
2.35.1

