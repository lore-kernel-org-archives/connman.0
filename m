Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A792591
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:03 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 49DD7207CA
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666082876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoEpcP25hVezSidIBJWQ5Ug7+mnPTkbOOZWjT/AcAR0=;
	b=iEzmGfQcTwg9GvpwcLbhz7zKyth5yHvtjqF4u+EtjAgsojuGjOEh8v4OK2hmkix7H/zVCl
	VkfWDvJa/ntQdvobfVynCckfqi6RI48nL8j3ovs19vLBF+uYzh1addzShZQaVmOwa1eFdF
	PUGvMd3ipaB5KQKyCUmKeWTKqV2Vs5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666082876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoEpcP25hVezSidIBJWQ5Ug7+mnPTkbOOZWjT/AcAR0=;
	b=EmhXO+3Ko7CPwu5TbegR+ukuYtBxVWbEov4ACb/5pId0PTJ+4bz4GyJZzidsxpIKVQFxFJ
	SuOpVoLnhTYk/WCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42D9E139D2
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lxpNEDxoTmOOcAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:56 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 04/16] dnsproxy: refactoring of update_cached_ttl() and append_data()
Date: Tue, 18 Oct 2022 10:47:34 +0200
Message-Id: <20221018084746.21959-5-matthias.gerstner@suse.de>
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

- use size_t for sizes and lengths where possible
- use named constants in favor of literal numbers
- more localized variable declarations
- prefer byte order macros over explicit byte operations
- add some comments and use early exits to simplify the code
---
 src/dnsproxy.c | 137 ++++++++++++++++++++++++-------------------------
 1 file changed, 66 insertions(+), 71 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index d38ecffdc..b5fe660f6 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -391,52 +391,49 @@ static size_t dns_name_length(const unsigned char *buf)
 	return strlen((const char *)buf) + 1;
 }
 
-static void update_cached_ttl(unsigned char *buf, int len, int new_ttl)
+static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
 {
-	unsigned char *c;
-	uint16_t w;
-	int l;
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
+	size_t name_len = dns_name_length(ptr);
+
+	ptr += name_len + sizeof(struct domain_question);
+	len -= name_len + sizeof(struct domain_question);;
+
+	const uint32_t raw_ttl = ntohl((uint32_t)new_ttl);
+	struct domain_rr *rr = NULL;
 
 	/* now we get the answer records */
 
 	while (len > 0) {
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
+		size_t rr_len = sizeof(*rr) + ntohs(rr->rdlen);
+		ptr += rr_len;
+		len -= rr_len;
 	}
 }
 
@@ -620,59 +617,57 @@ out:
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
+	debug("query %s domain %s", query, domain);
 
-		*ptr = tmp - domain;
-		memcpy(ptr + 1, domain, tmp - domain);
-		ptr += tmp - domain + 1;
+	size_t left_size = size;
+	int res = append_data(buf, left_size, query);
+	if (res < 0)
+		return -1;
+	left_size -= res;
 
-		domain = tmp + 1;
-	}
+	res = append_data(buf + res, left_size, domain);
+	if (res < 0)
+		return -1;
+	left_size -= res;
 
-	*ptr++ = 0x00;
+	if (left_size == 0)
+		return -1;
 
-	return ptr - buf;
+	const size_t added = size - left_size;
+	*(buf + added) = 0x00;
+
+	return added;
 }
 
 static bool cache_check_is_valid(struct cache_data *data, time_t current_time)
-- 
2.37.3

