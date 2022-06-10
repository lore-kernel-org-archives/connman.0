Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B0643
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:34 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED8FD1FD3A
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654864412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6o99+uEWDLBPg7PmC1/6CAoDZlp3V3Xpf+sCPlZTmbs=;
	b=W6TPNuPD2OnEIRWWHJQnRioKhVdBAhUr1aRPpM2eZTIvVOebXFtuqWQOASMytgYNgcgBgm
	eVxQRDD3TSkIjBjqhYLZs02W1ZC9iMMcuGvP3O9JJQk2eG95A3qc+Od+KzlEh7apHOP51X
	GMMWO48GS2vNEUqgcEGUcTU4CEbPj2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654864412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6o99+uEWDLBPg7PmC1/6CAoDZlp3V3Xpf+sCPlZTmbs=;
	b=Ix6pepw0t9Kl074MC0FCSq3WqVt1zGAwMEvb6NKCecuCIaPU5NPaSJV780/xrm7xPw1RJO
	yUEawkmug5khHuAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4B61139ED
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cLvSNxw6o2J3MgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:32 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 03/16] dnsproxy: first bits of refactoring data types, global variables, simpler functions
Date: Fri, 10 Jun 2022 14:33:10 +0200
Message-Id: <20220610123323.8974-4-matthias.gerstner@suse.de>
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

- move all type declarations to the top of the unit to have them all in
  one place, same for global variables
- introduce enums for having more descriptive identifiers for some of
  the DNS header constants
- remove unnecessary zero initializations for global variables
- move variable declarations into more local scopes where possible (e.g.
  in for loops). Shorter lifetimes of variables can make the code more
  easy to follow.
- avoid some repetitive code sequences like `cache_free_ipv4()` by
  moving them into separate functions
- use const variables in parameters where possible to make certain
  guarantees of function calls more clear and avoid erroneous
  assignments.
---
 src/dnsproxy.c | 478 +++++++++++++++++++++++--------------------------
 1 file changed, 227 insertions(+), 251 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 458694e60..b733ac78d 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -176,11 +176,17 @@ struct cache_data {
 struct cache_entry {
 	char *key;
 	bool want_refresh;
-	int hits;
+	size_t hits;
 	struct cache_data *ipv4;
 	struct cache_data *ipv6;
 };
 
+struct cache_timeout {
+	time_t current_time;
+	time_t max_timeout;
+	bool try_harder;
+};
+
 struct domain_question {
 	uint16_t type;
 	uint16_t class;
@@ -218,21 +224,43 @@ struct domain_rr {
  */
 #define MAX_CACHE_SIZE 256
 
+#define DNS_HEADER_SIZE sizeof(struct domain_hdr)
+#define DNS_HEADER_TCP_EXTRA_BYTES 2
+
+enum dns_type {
+	/* IPv4 address 32-bit */
+	DNS_TYPE_A = ns_t_a,
+	/* IPv6 address 128-bit */
+	DNS_TYPE_AAAA = ns_t_aaaa,
+	/* alias to another name */
+	DNS_TYPE_CNAME = ns_t_cname,
+	/* start of a zone of authority */
+	DNS_TYPE_SOA = ns_t_soa
+};
+
+enum dns_class {
+	DNS_CLASS_IN = ns_c_in
+};
+
 static int cache_size;
 static GHashTable *cache;
 static int cache_refcount;
-static GSList *server_list = NULL;
-static GSList *request_list = NULL;
-static GHashTable *listener_table = NULL;
+static GSList *server_list;
+static GSList *request_list;
+static GHashTable *listener_table;
 static time_t next_refresh;
 static GHashTable *partial_tcp_req_table;
-static guint cache_timer = 0;
+static guint cache_timer;
 static in_port_t dns_listen_port = 53;
+/* we can keep using the same resolve's */
+static GResolv *ipv4_resolve;
+static GResolv *ipv6_resolve;
 
 static guint16 get_id(void)
 {
 	uint64_t rand;
 
+	/* TODO: return code is ignored, should we rather abort() on error? */
 	__connman_util_get_random(&rand);
 
 	return rand;
@@ -245,7 +273,7 @@ static size_t protocol_offset(int protocol)
 		return 0;
 
 	case IPPROTO_TCP:
-		return 2;
+		return DNS_HEADER_TCP_EXTRA_BYTES;
 
 	default:
 		/* this should never happen */
@@ -276,9 +304,7 @@ static time_t round_down_ttl(time_t end_time, int ttl)
 
 static struct request_data *find_request(guint16 id)
 {
-	GSList *list;
-
-	for (list = request_list; list; list = list->next) {
+	for (GSList *list = request_list; list; list = list->next) {
 		struct request_data *req = list->data;
 
 		if (req->dstid == id || req->altid == id)
@@ -292,11 +318,9 @@ static struct server_data *find_server(int index,
 					const char *server,
 						int protocol)
 {
-	GSList *list;
-
 	debug("index %d server %s proto %d", index, server, protocol);
 
-	for (list = server_list; list; list = list->next) {
+	for (GSList *list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
 
 		if (index < 0 && data->index < 0 &&
@@ -317,10 +341,6 @@ static struct server_data *find_server(int index,
 	return NULL;
 }
 
-/* we can keep using the same resolve's */
-static GResolv *ipv4_resolve;
-static GResolv *ipv6_resolve;
-
 static void dummy_resolve_func(GResolvResultStatus status,
 					char **results, gpointer user_data)
 {
@@ -330,8 +350,6 @@ static void dummy_resolve_func(GResolvResultStatus status,
  * Refresh a DNS entry, but also age the hit count a bit */
 static void refresh_dns_entry(struct cache_entry *entry, char *name)
 {
-	int age = 1;
-
 	if (!ipv4_resolve) {
 		ipv4_resolve = g_resolv_new(0);
 		g_resolv_set_address_family(ipv4_resolve, AF_INET);
@@ -344,6 +362,8 @@ static void refresh_dns_entry(struct cache_entry *entry, char *name)
 		g_resolv_add_nameserver(ipv6_resolve, "::1", 53, 0);
 	}
 
+	int age = 1;
+
 	if (!entry->ipv4) {
 		debug("Refreshing A record for %s", name);
 		g_resolv_lookup_hostname(ipv4_resolve, name,
@@ -358,16 +378,17 @@ static void refresh_dns_entry(struct cache_entry *entry, char *name)
 		age = 4;
 	}
 
-	entry->hits -= age;
-	if (entry->hits < 0)
+	if (entry->hits > age)
+		entry->hits -= age;
+	else
 		entry->hits = 0;
 }
 
-static int dns_name_length(unsigned char *buf)
+static size_t dns_name_length(const unsigned char *buf)
 {
 	if ((buf[0] & NS_CMPRSFLGS) == NS_CMPRSFLGS) /* compressed name */
 		return 2;
-	return strlen((char *)buf) + 1;
+	return strlen((const char *)buf) + 1;
 }
 
 static void update_cached_ttl(unsigned char *buf, int len, int new_ttl)
@@ -419,13 +440,11 @@ static void update_cached_ttl(unsigned char *buf, int len, int new_ttl)
 	}
 }
 
-static void send_cached_response(int sk, unsigned char *buf, int len,
+static void send_cached_response(int sk, unsigned char *ptr, int len,
 				const struct sockaddr *to, socklen_t tolen,
 				int protocol, int id, uint16_t answers, int ttl)
 {
-	struct domain_hdr *hdr;
-	unsigned char *ptr = buf;
-	int err, offset, dns_len, adj_len = len - 2;
+	int offset, dns_len;
 
 	/*
 	 * The cached packet contains always the TCP offset (two bytes)
@@ -449,7 +468,7 @@ static void send_cached_response(int sk, unsigned char *buf, int len,
 	if (len < 12)
 		return;
 
-	hdr = (void *) (ptr + offset);
+	struct domain_hdr *hdr = (void *) (ptr + offset);
 
 	hdr->id = id;
 	hdr->qr = 1;
@@ -461,42 +480,40 @@ static void send_cached_response(int sk, unsigned char *buf, int len,
 	/* if this is a negative reply, we are authoritative */
 	if (answers == 0)
 		hdr->aa = 1;
-	else
+	else {
+		const int adj_len = len - 2;
 		update_cached_ttl((unsigned char *)hdr, adj_len, ttl);
+	}
 
 	debug("sk %d id 0x%04x answers %d ptr %p length %d dns %d",
 		sk, hdr->id, answers, ptr, len, dns_len);
 
-	err = sendto(sk, ptr, len, MSG_NOSIGNAL, to, tolen);
-	if (err < 0) {
+	const int res = sendto(sk, ptr, len, MSG_NOSIGNAL, to, tolen);
+	if (res < 0) {
 		connman_error("Cannot send cached DNS response: %s",
 				strerror(errno));
-		return;
 	}
-
-	if (err != len || (dns_len != (len - 2) && protocol == IPPROTO_TCP) ||
-				(dns_len != len && protocol == IPPROTO_UDP))
+	else if (res != len || dns_len != (len - offset))
 		debug("Packet length mismatch, sent %d wanted %d dns %d",
-			err, len, dns_len);
+			res, len, dns_len);
 }
 
 static void send_response(int sk, unsigned char *buf, size_t len,
 				const struct sockaddr *to, socklen_t tolen,
 				int protocol)
 {
-	struct domain_hdr *hdr;
-	int err;
-	size_t offset = protocol_offset(protocol);
+	const size_t offset = protocol_offset(protocol);
+	const size_t send_size = DNS_HEADER_SIZE + offset;
 
 	debug("sk %d", sk);
 
-	if (len < sizeof(*hdr) + offset)
+	if (len < send_size)
 		return;
 
-	hdr = (void *) (buf + offset);
+	struct domain_hdr *hdr = (void *) (buf + offset);
 	if (offset) {
 		buf[0] = 0;
-		buf[1] = sizeof(*hdr);
+		buf[1] = DNS_HEADER_SIZE;
 	}
 
 	debug("id 0x%04x qr %d opcode %d", hdr->id, hdr->qr, hdr->opcode);
@@ -509,11 +526,10 @@ static void send_response(int sk, unsigned char *buf, size_t len,
 	hdr->nscount = 0;
 	hdr->arcount = 0;
 
-	err = sendto(sk, buf, sizeof(*hdr) + offset, MSG_NOSIGNAL, to, tolen);
+	const int err = sendto(sk, buf, send_size, MSG_NOSIGNAL, to, tolen);
 	if (err < 0) {
 		connman_error("Failed to send DNS response to %d: %s",
 				sk, strerror(errno));
-		return;
 	}
 }
 
@@ -546,8 +562,6 @@ static void destroy_request_data(struct request_data *req)
 static gboolean request_timeout(gpointer user_data)
 {
 	struct request_data *req = user_data;
-	struct sockaddr *sa;
-	int sk;
 
 	if (!req)
 		return FALSE;
@@ -556,13 +570,18 @@ static gboolean request_timeout(gpointer user_data)
 
 	request_list = g_slist_remove(request_list, req);
 
+	struct sockaddr *sa;
+	int sk = -1;
+
 	if (req->protocol == IPPROTO_UDP) {
 		sk = get_req_udp_socket(req);
 		sa = &req->sa;
 	} else if (req->protocol == IPPROTO_TCP) {
 		sk = req->client_sk;
 		sa = NULL;
-	} else
+	}
+
+	if (sk < 0)
 		goto out;
 
 	if (req->resplen > 0 && req->resp) {
@@ -571,22 +590,18 @@ static gboolean request_timeout(gpointer user_data)
 		 * "not found" result), so send that back to client instead
 		 * of more fatal server failed error.
 		 */
-		if (sk >= 0)
-			sendto(sk, req->resp, req->resplen, MSG_NOSIGNAL,
-				sa, req->sa_len);
+		sendto(sk, req->resp, req->resplen, MSG_NOSIGNAL,
+			sa, req->sa_len);
 
 	} else if (req->request) {
 		/*
 		 * There was not reply from server at all.
 		 */
-		struct domain_hdr *hdr;
-
-		hdr = (void *)(req->request + protocol_offset(req->protocol));
+		struct domain_hdr *hdr = (void *)(req->request + protocol_offset(req->protocol));
 		hdr->id = req->srcid;
 
-		if (sk >= 0)
-			send_response(sk, req->request, req->request_len,
-				sa, req->sa_len, req->protocol);
+		send_response(sk, req->request, req->request_len,
+			sa, req->sa_len, req->protocol);
 	}
 
 	/*
@@ -661,18 +676,36 @@ static int append_query(unsigned char *buf, unsigned int size,
 	return ptr - buf;
 }
 
-static bool cache_check_is_valid(struct cache_data *data,
-				time_t current_time)
+static bool cache_check_is_valid(struct cache_data *data, time_t current_time)
 {
 	if (!data)
 		return false;
-
-	if (data->cache_until < current_time)
+	else if (data->cache_until < current_time)
 		return false;
 
 	return true;
 }
 
+static void cache_free_ipv4(struct cache_entry *entry)
+{
+	if (!entry->ipv4)
+		return;
+
+	g_free(entry->ipv4->data);
+	g_free(entry->ipv4);
+	entry->ipv4 = NULL;
+}
+
+static void cache_free_ipv6(struct cache_entry *entry)
+{
+	if (!entry->ipv6)
+		return;
+
+	g_free(entry->ipv6->data);
+	g_free(entry->ipv6);
+	entry->ipv6 = NULL;
+}
+
 /*
  * remove stale cached entries so that they can be refreshed
  */
@@ -680,76 +713,64 @@ static void cache_enforce_validity(struct cache_entry *entry)
 {
 	time_t current_time = time(NULL);
 
-	if (!cache_check_is_valid(entry->ipv4, current_time)
-							&& entry->ipv4) {
+	if (entry->ipv4 && !cache_check_is_valid(entry->ipv4, current_time)) {
 		debug("cache timeout \"%s\" type A", entry->key);
-		g_free(entry->ipv4->data);
-		g_free(entry->ipv4);
-		entry->ipv4 = NULL;
-
+		cache_free_ipv4(entry);
 	}
 
-	if (!cache_check_is_valid(entry->ipv6, current_time)
-							&& entry->ipv6) {
+	if (entry->ipv6 && !cache_check_is_valid(entry->ipv6, current_time)) {
 		debug("cache timeout \"%s\" type AAAA", entry->key);
-		g_free(entry->ipv6->data);
-		g_free(entry->ipv6);
-		entry->ipv6 = NULL;
+		cache_free_ipv6(entry);
 	}
 }
 
-static uint16_t cache_check_validity(char *question, uint16_t type,
+static bool cache_check_validity(const char *question, uint16_t type,
 				struct cache_entry *entry)
 {
-	time_t current_time = time(NULL);
-	bool want_refresh = false;
-
-	/*
-	 * if we have a popular entry, we want a refresh instead of
-	 * total destruction of the entry.
-	 */
-	if (entry->hits > 2)
-		want_refresh = true;
-
 	cache_enforce_validity(entry);
 
-	switch (type) {
-	case 1:		/* IPv4 */
-		if (!cache_check_is_valid(entry->ipv4, current_time)) {
-			debug("cache %s \"%s\" type A", entry->ipv4 ?
-					"timeout" : "entry missing", question);
+	struct cache_data *cached_ip = NULL, *other_ip = NULL;
 
-			if (want_refresh)
-				entry->want_refresh = true;
+	switch (type) {
+	case DNS_TYPE_A: /* IPv4 */
+		cached_ip = entry->ipv4;
+		other_ip = entry->ipv6;
+		break;
 
-			/*
-			 * We do not remove cache entry if there is still
-			 * valid IPv6 entry found in the cache.
-			 */
-			if (!cache_check_is_valid(entry->ipv6, current_time) && !want_refresh) {
-				g_hash_table_remove(cache, question);
-				type = 0;
-			}
-		}
+	case DNS_TYPE_AAAA: /* IPv6 */
+		cached_ip = entry->ipv6;
+		other_ip = entry->ipv4;
 		break;
+	default:
+		return false;
+	}
 
-	case 28:	/* IPv6 */
-		if (!cache_check_is_valid(entry->ipv6, current_time)) {
-			debug("cache %s \"%s\" type AAAA", entry->ipv6 ?
-					"timeout" : "entry missing", question);
+	const time_t current_time = time(NULL);
+	/*
+	 * if we have a popular entry, we want a refresh instead of
+	 * total destruction of the entry.
+	 */
+	const bool want_refresh = entry->hits > 2 ? true : false;
 
-			if (want_refresh)
-				entry->want_refresh = true;
+	if (!cache_check_is_valid(cached_ip, current_time)) {
+		debug("cache %s \"%s\" type %s",
+				cached_ip ?  "timeout" : "entry missing",
+				question,
+				cached_ip == entry->ipv4 ? "A" : "AAAA");
 
-			if (!cache_check_is_valid(entry->ipv4, current_time) && !want_refresh) {
-				g_hash_table_remove(cache, question);
-				type = 0;
-			}
+		if (want_refresh)
+			entry->want_refresh = true;
+		/*
+		 * We do not remove cache entry if there is still a
+		 * valid entry for another IP version found in the cache.
+		 */
+		else if (!cache_check_is_valid(other_ip, current_time)) {
+			g_hash_table_remove(cache, question);
+			return false;
 		}
-		break;
 	}
 
-	return type;
+	return true;
 }
 
 static void cache_element_destroy(gpointer value)
@@ -759,19 +780,13 @@ static void cache_element_destroy(gpointer value)
 	if (!entry)
 		return;
 
-	if (entry->ipv4) {
-		g_free(entry->ipv4->data);
-		g_free(entry->ipv4);
-	}
-
-	if (entry->ipv6) {
-		g_free(entry->ipv6->data);
-		g_free(entry->ipv6);
-	}
+	cache_free_ipv4(entry);
+	cache_free_ipv6(entry);
 
 	g_free(entry->key);
 	g_free(entry);
 
+	/* TODO: this would be a worrying condition. Does this ever happen? */
 	if (--cache_size < 0)
 		cache_size = 0;
 }
@@ -785,6 +800,7 @@ static gboolean try_remove_cache(gpointer user_data)
 
 		g_hash_table_destroy(cache);
 		cache = NULL;
+		cache_size = 0;
 	}
 
 	return FALSE;
@@ -792,32 +808,27 @@ static gboolean try_remove_cache(gpointer user_data)
 
 static void create_cache(void)
 {
-	if (__sync_fetch_and_add(&cache_refcount, 1) == 0)
+	if (__sync_fetch_and_add(&cache_refcount, 1) == 0) {
 		cache = g_hash_table_new_full(g_str_hash,
 					g_str_equal,
 					NULL,
 					cache_element_destroy);
+		cache_size = 0;
+	}
 }
 
-static struct cache_entry *cache_check(gpointer request, int *qtype, int proto)
+static struct cache_entry *cache_check(gpointer request, uint16_t *qtype, int proto)
 {
-	char *question;
-	struct cache_entry *entry;
-	struct domain_question *q;
-	uint16_t type;
-	int offset;
-
 	if (!request)
 		return NULL;
 
-	question = request + protocol_offset(proto) + 12;
-
-	offset = strlen(question) + 1;
-	q = (void *) (question + offset);
-	type = ntohs(q->type);
+	const char *question = request + protocol_offset(proto) + DNS_HEADER_SIZE;
+	const size_t offset = strlen(question) + 1;
+	const struct domain_question *q = (void *) (question + offset);
+	const uint16_t type = ntohs(q->type);
 
 	/* We only cache either A (1) or AAAA (28) requests */
-	if (type != 1 && type != 28)
+	if (type != DNS_TYPE_A && type != DNS_TYPE_AAAA)
 		return NULL;
 
 	if (!cache) {
@@ -825,12 +836,11 @@ static struct cache_entry *cache_check(gpointer request, int *qtype, int proto)
 		return NULL;
 	}
 
-	entry = g_hash_table_lookup(cache, question);
+	struct cache_entry *entry = g_hash_table_lookup(cache, question);
 	if (!entry)
 		return NULL;
 
-	type = cache_check_validity(question, type, entry);
-	if (type == 0)
+	if (!cache_check_validity(question, type, entry))
 		return NULL;
 
 	*qtype = type;
@@ -845,20 +855,19 @@ static struct cache_entry *cache_check(gpointer request, int *qtype, int proto)
  * format so that we can cache the wire format string directly.
  */
 static int get_name(int counter,
-		unsigned char *pkt, unsigned char *start, unsigned char *max,
+		const unsigned char *pkt, const unsigned char *start, const unsigned char *max,
 		unsigned char *output, int output_max, int *output_len,
-		unsigned char **end, char *name, size_t max_name, int *name_len)
+		const unsigned char **end, char *name, size_t max_name, int *name_len)
 {
-	unsigned char *p;
 
 	/* Limit recursion to 10 (this means up to 10 labels in domain name) */
 	if (counter > 10)
 		return -EINVAL;
 
-	p = start;
+	const unsigned char *p = start;
 	while (*p) {
 		if ((*p & NS_CMPRSFLGS) == NS_CMPRSFLGS) {
-			uint16_t offset = (*p & 0x3F) * 256 + *(p + 1);
+			const uint16_t offset = (*p & 0x3F) * 256 + *(p + 1);
 
 			if (offset >= max - pkt)
 				return -ENOBUFS;
@@ -874,11 +883,9 @@ static int get_name(int counter,
 
 			if (pkt + label_len > max)
 				return -ENOBUFS;
-
-			if (*output_len > output_max)
+			else if (*output_len > output_max)
 				return -ENOBUFS;
-
-			if ((*name_len + 1 + label_len + 1) > max_name)
+			else if ((*name_len + 1 + label_len + 1) > max_name)
 				return -ENOBUFS;
 
 			/*
@@ -907,28 +914,28 @@ static int get_name(int counter,
 	return 0;
 }
 
-static int parse_rr(unsigned char *buf, unsigned char *start,
-			unsigned char *max,
+static int parse_rr(const unsigned char *buf, const unsigned char *start,
+			const unsigned char *max,
 			unsigned char *response, unsigned int *response_size,
-			uint16_t *type, uint16_t *class, int *ttl, int *rdlen,
-			unsigned char **end,
+			uint16_t *type, uint16_t *class, int *ttl, uint16_t *rdlen,
+			const unsigned char **end,
 			char *name, size_t max_name)
 {
-	struct domain_rr *rr;
-	int err, offset;
 	int name_len = 0, output_len = 0, max_rsp = *response_size;
 
-	err = get_name(0, buf, start, max, response, max_rsp,
+	{
+		int err = get_name(0, buf, start, max, response, max_rsp,
 			&output_len, end, name, max_name, &name_len);
-	if (err < 0)
-		return err;
+		if (err < 0)
+			return err;
+	}
 
-	offset = output_len;
+	size_t offset = output_len;
 
-	if ((unsigned int) offset > *response_size)
+	if (offset > *response_size)
 		return -ENOBUFS;
 
-	rr = (void *) (*end);
+	struct domain_rr *rr = (void *) (*end);
 
 	if (!rr)
 		return -EINVAL;
@@ -946,26 +953,23 @@ static int parse_rr(unsigned char *buf, unsigned char *start,
 	offset += sizeof(struct domain_rr);
 	*end += sizeof(struct domain_rr);
 
-	if ((unsigned int) (offset + *rdlen) > *response_size)
+	if ((offset + *rdlen) > *response_size)
 		return -ENOBUFS;
 
 	memcpy(response + offset, *end, *rdlen);
 
 	*end += *rdlen;
-
 	*response_size = offset + *rdlen;
 
 	return 0;
 }
 
-static bool check_alias(GSList *aliases, char *name)
+static bool check_alias(GSList *aliases, const char *name)
 {
-	GSList *list;
-
 	if (aliases) {
-		for (list = aliases; list; list = list->next) {
-			int len = strlen((char *)list->data);
-			if (strncmp((char *)list->data, name, len) == 0)
+		for (GSList *list = aliases; list; list = list->next) {
+			const char *cmpname = (const char*)list->data;
+			if (strncmp(cmpname, name, NS_MAXDNAME) == 0)
 				return true;
 		}
 	}
@@ -981,12 +985,12 @@ static int parse_response(unsigned char *buf, int buflen,
 {
 	struct domain_hdr *hdr = (void *) buf;
 	struct domain_question *q;
-	unsigned char *ptr;
+	const unsigned char *ptr;
 	uint16_t qdcount = ntohs(hdr->qdcount);
 	uint16_t ancount = ntohs(hdr->ancount);
 	int err, i;
 	uint16_t qtype, qclass;
-	unsigned char *next = NULL;
+	const unsigned char *next = NULL;
 	unsigned int maxlen = *response_len;
 	GSList *aliases = NULL, *list;
 	char name[NS_MAXDNAME + 1];
@@ -1040,7 +1044,8 @@ static int parse_response(unsigned char *buf, int buflen,
 		 */
 		unsigned char rsp[NS_MAXCDNAME];
 		unsigned int rsp_len = sizeof(rsp) - 1;
-		int ret, rdlen;
+		int ret;
+		uint16_t rdlen;
 
 		memset(rsp, 0, sizeof(rsp));
 
@@ -1099,7 +1104,7 @@ static int parse_response(unsigned char *buf, int buflen,
 			 * question. We need to find the real A/AAAA record
 			 * of the alias and cache that.
 			 */
-			unsigned char *end = NULL;
+			const unsigned char *end = NULL;
 			int name_len = 0, output_len = 0;
 
 			memset(rsp, 0, sizeof(rsp));
@@ -1171,18 +1176,12 @@ out:
 	return err;
 }
 
-struct cache_timeout {
-	time_t current_time;
-	int max_timeout;
-	int try_harder;
-};
-
 static gboolean cache_check_entry(gpointer key, gpointer value,
 					gpointer user_data)
 {
 	struct cache_timeout *data = user_data;
 	struct cache_entry *entry = value;
-	int max_timeout;
+	time_t max_timeout;
 
 	/* Scale the number of hits by half as part of cache aging */
 
@@ -1223,14 +1222,14 @@ static gboolean cache_check_entry(gpointer key, gpointer value,
 
 static void cache_cleanup(void)
 {
-	static int max_timeout;
-	struct cache_timeout data;
+	static time_t max_timeout;
+	struct cache_timeout data = {
+		.current_time = time(NULL),
+		.max_timeout = 0,
+		.try_harder = false
+	};
 	int count = 0;
 
-	data.current_time = time(NULL);
-	data.max_timeout = 0;
-	data.try_harder = 0;
-
 	/*
 	 * In the first pass, we only remove entries that have timed out.
 	 * We use a cache of the first time to expire to do this only
@@ -1247,7 +1246,7 @@ static void cache_cleanup(void)
 	 * we also expire entries with a low hit count,
 	 * while aging the hit count at the same time.
 	 */
-	data.try_harder = 1;
+	data.try_harder = true;
 	if (count == 0)
 		count = g_hash_table_foreach_remove(cache, cache_check_entry,
 						&data);
@@ -1277,23 +1276,11 @@ static gboolean cache_invalidate_entry(gpointer key, gpointer value,
 		entry->want_refresh = true;
 
 	/* delete the cached data */
-	if (entry->ipv4) {
-		g_free(entry->ipv4->data);
-		g_free(entry->ipv4);
-		entry->ipv4 = NULL;
-	}
-
-	if (entry->ipv6) {
-		g_free(entry->ipv6->data);
-		g_free(entry->ipv6);
-		entry->ipv6 = NULL;
-	}
+	cache_free_ipv4(entry);
+	cache_free_ipv6(entry);
 
 	/* keep the entry if we want it refreshed, delete it otherwise */
-	if (entry->want_refresh)
-		return FALSE;
-	else
-		return TRUE;
+	return entry->want_refresh ? FALSE : TRUE;
 }
 
 /*
@@ -1314,25 +1301,22 @@ static void cache_invalidate(void)
 
 static void cache_refresh_entry(struct cache_entry *entry)
 {
-
 	cache_enforce_validity(entry);
 
-	if (entry->hits > 2 && !entry->ipv4)
-		entry->want_refresh = true;
-	if (entry->hits > 2 && !entry->ipv6)
+	if (entry->hits > 2 && (!entry->ipv4 || !entry->ipv6))
 		entry->want_refresh = true;
 
 	if (entry->want_refresh) {
-		char *c;
-		char dns_name[NS_MAXDNAME + 1];
 		entry->want_refresh = false;
 
+		char dns_name[NS_MAXDNAME + 1];
 		/* turn a DNS name into a hostname with dots */
 		strncpy(dns_name, entry->key, NS_MAXDNAME);
-		c = dns_name;
-		while (c && *c) {
-			int jump;
-			jump = *c;
+		char *c = dns_name;
+		while (*c) {
+			/* fetch the size of the current component and replace
+			   it by a dot */
+			int jump = *c;
 			*c = '.';
 			c += jump + 1;
 		}
@@ -1358,23 +1342,19 @@ static void cache_refresh(void)
 	g_hash_table_foreach(cache, cache_refresh_iterator, NULL);
 }
 
-static int reply_query_type(unsigned char *msg, int len)
+static int reply_query_type(const unsigned char *msg, int len)
 {
-	unsigned char *c;
-	int l;
-	int type;
-
 	/* skip the header */
-	c = msg + sizeof(struct domain_hdr);
-	len -= sizeof(struct domain_hdr);
+	const unsigned char *c = msg + DNS_HEADER_SIZE;
+	len -= DNS_HEADER_SIZE;
 
 	if (len < 0)
 		return 0;
 
-	/* now the query, which is a name and 2 16 bit words */
-	l = dns_name_length(c);
-	c += l;
-	type = c[0] << 8 | c[1];
+	/* now the query, which is a name and 2 16 bit words for type and class */
+	c += dns_name_length(c);
+
+	int type = c[0] << 8 | c[1];
 
 	return type;
 }
@@ -1607,7 +1587,8 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 				gpointer request, gpointer name)
 {
 	GList *list;
-	int sk, err, type = 0;
+	int sk, err;
+	uint16_t type = 0;
 	char *dot, *lookup = (char *) name;
 	struct cache_entry *entry;
 
@@ -1723,40 +1704,36 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 	return 0;
 }
 
-static char *convert_label(char *start, char *end, char *ptr, char *uptr,
+static bool convert_label(const char *start, const char *end, const char *ptr, char *uptr,
 			int remaining_len, int *used_comp, int *used_uncomp)
 {
-	int pos, comp_pos;
 	char name[NS_MAXLABEL];
 
-	pos = dn_expand((u_char *)start, (u_char *)end, (u_char *)ptr,
+	const int pos = dn_expand((const u_char *)start, (const u_char *)end, (const u_char *)ptr,
 			name, NS_MAXLABEL);
 	if (pos < 0) {
 		debug("uncompress error [%d/%s]", errno, strerror(errno));
-		goto out;
+		return false;
 	}
 
 	/*
 	 * We need to compress back the name so that we get back to internal
 	 * label presentation.
 	 */
-	comp_pos = dn_comp(name, (u_char *)uptr, remaining_len, NULL, NULL);
+	const int comp_pos = dn_comp(name, (u_char *)uptr, remaining_len, NULL, NULL);
 	if (comp_pos < 0) {
 		debug("compress error [%d/%s]", errno, strerror(errno));
-		goto out;
+		return false;
 	}
 
 	*used_comp = pos;
 	*used_uncomp = comp_pos;
 
-	return ptr;
-
-out:
-	return NULL;
+	return true;
 }
 
-static char *uncompress(int16_t field_count, char *start, char *end,
-			char *ptr, char *uncompressed, int uncomp_len,
+static const char* uncompress(int16_t field_count, const char *start, const char *end,
+			const char *ptr, char *uncompressed, int uncomp_len,
 			char **uncompressed_ptr)
 {
 	char *uptr = *uncompressed_ptr; /* position in result buffer */
@@ -1806,7 +1783,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 		dns_type = uptr[0] << 8 | uptr[1];
 		dns_class = uptr[2] << 8 | uptr[3];
 
-		if (dns_class != ns_c_in)
+		if (dns_class != DNS_CLASS_IN)
 			goto out;
 
 		ptr += NS_RRFIXEDSZ;
@@ -1817,7 +1794,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 		 * Typically this portion is also compressed
 		 * so we need to uncompress it also when necessary.
 		 */
-		if (dns_type == ns_t_cname) {
+		if (dns_type == DNS_TYPE_CNAME) {
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
@@ -1829,7 +1806,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 			uptr += comp_pos;
 			ptr += pos;
 
-		} else if (dns_type == ns_t_a || dns_type == ns_t_aaaa) {
+		} else if (dns_type == DNS_TYPE_A || dns_type == DNS_TYPE_AAAA) {
 			dlen = uptr[-2] << 8 | uptr[-1];
 
 			if ((ptr + dlen) > end || (uptr + dlen) > uncomp_end) {
@@ -1841,7 +1818,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 			uptr += dlen;
 			ptr += dlen;
 
-		} else if (dns_type == ns_t_soa) {
+		} else if (dns_type == DNS_TYPE_SOA) {
 			int total_len = 0;
 			char *len_ptr;
 
@@ -1898,17 +1875,16 @@ out:
 
 static int strip_domains(char *name, char *answers, int maxlen)
 {
-	uint16_t data_len;
-	int name_len = strlen(name);
-	char *ptr, *start = answers, *end = answers + maxlen;
+	const size_t name_len = strlen(name);
+	const char *start = answers, *end = answers + maxlen;
 
 	while (maxlen > 0) {
-		ptr = strstr(answers, name);
+		char *ptr = strstr(answers, name);
 		if (ptr) {
 			char *domain = ptr + name_len;
 
 			if (*domain) {
-				int domain_len = strlen(domain);
+				const size_t domain_len = strlen(domain);
 
 				memmove(answers + name_len,
 					domain + domain_len,
@@ -1922,7 +1898,7 @@ static int strip_domains(char *name, char *answers, int maxlen)
 		answers += strlen(answers) + 1;
 		answers += 2 + 2 + 4;  /* skip type, class and ttl fields */
 
-		data_len = answers[0] << 8 | answers[1];
+		uint16_t data_len = answers[0] << 8 | answers[1];
 		answers += 2; /* skip the length field */
 
 		if (answers + data_len > end)
@@ -1988,8 +1964,8 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 			uint16_t dns_type, dns_class;
 			uint8_t host_len, dns_type_pos;
 			char uncompressed[NS_MAXDNAME], *uptr;
-			char *ptr, *eom = (char *)reply + reply_len;
-			char *domain;
+			const char *ptr, *eom = (char *)reply + reply_len;
+			const char *domain;
 
 			/*
 			 * ptr points to the first char of the hostname.
@@ -2023,8 +1999,8 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 							ptr[dns_type_pos + 1];
 			dns_class = ptr[dns_type_pos + 2] << 8 |
 							ptr[dns_type_pos + 3];
-			if (dns_type != ns_t_a && dns_type != ns_t_aaaa &&
-					dns_class != ns_c_in) {
+			if (dns_type != DNS_TYPE_A && dns_type != DNS_TYPE_AAAA &&
+					dns_class != DNS_CLASS_IN) {
 				debug("Pass msg dns type %d class %d",
 					dns_type, dns_class);
 				goto pass;
@@ -2258,7 +2234,6 @@ static gboolean udp_server_event(GIOChannel *channel, GIOCondition condition,
 							gpointer user_data)
 {
 	unsigned char buf[4096];
-	int sk, len;
 	struct server_data *data = user_data;
 
 	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
@@ -2267,11 +2242,12 @@ static gboolean udp_server_event(GIOChannel *channel, GIOCondition condition,
 		return FALSE;
 	}
 
-	sk = g_io_channel_unix_get_fd(channel);
-
-	len = recv(sk, buf, sizeof(buf), 0);
+	int sk = g_io_channel_unix_get_fd(channel);
+	ssize_t len = recv(sk, buf, sizeof(buf), 0);
 
-	forward_dns_reply(buf, len, IPPROTO_UDP, data);
+	if (len > 0) {
+		forward_dns_reply(buf, len, IPPROTO_UDP, data);
+	}
 
 	return TRUE;
 }
@@ -3125,7 +3101,7 @@ static bool read_tcp_data(struct tcp_partial_client_data *client,
 	unsigned int msg_len;
 	GSList *list;
 	bool waiting_for_connect = false;
-	int qtype = 0;
+	uint16_t qtype = 0;
 	struct cache_entry *entry;
 
 	client_sk = g_io_channel_unix_get_fd(client->channel);
-- 
2.35.1

