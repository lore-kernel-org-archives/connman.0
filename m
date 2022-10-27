Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307C1C29
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:22 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95AE32266F
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cbNvx7RYZL3YBXUla3PyzQNi8GgFeSWyUi+kho0+JA=;
	b=YBOcpiOhZQADjXLuKz8X28Ccn2NEr1ZJk/LhSrdQjl/irLs+IstcRlQYKTI/xmM0JA4Mgx
	daWhOPS39lQhK3F5dY5dvH5mTSMQl6i4gUr54GsLDNGruFEui9OZ/k0k+0Gjb7Me0sU/VS
	av3GMvZbw1vjOCEkjwHRQdnQuwszkN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cbNvx7RYZL3YBXUla3PyzQNi8GgFeSWyUi+kho0+JA=;
	b=jqOzTiB7vYyk0p+c/ZRjX/TJb6+oklzZiGqsZBRM/S4YmPxpsplmY92Q6x90UYFO4GxEKL
	0f+dVAk2H/LUnJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88992134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gG5VIXBeWmMFBQAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:20 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 13/16] dnsproxy: finish first full pass of refactoring the compilation unit
Date: Thu, 27 Oct 2022 12:32:56 +0200
Message-Id: <20221027103258.29129-14-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221027103258.29129-1-matthias.gerstner@suse.de>
References: <20221027103258.29129-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

- make variable declarations more local, if possible
- use more const variables where suitable
- more harmonized use of integer types (especially use size_t for buffer lengths)
- avoid duplicate or difficult to read code portions
---
 src/dnsproxy.c | 457 ++++++++++++++++++++++---------------------------
 1 file changed, 208 insertions(+), 249 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 27a761241..d31ccd571 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -242,7 +242,8 @@ enum dns_type {
 };
 
 enum dns_class {
-	DNS_CLASS_IN = ns_c_in
+	DNS_CLASS_IN = ns_c_in,
+	DNS_CLASS_ANY = ns_c_any /* only valid for QCLASS fields */
 };
 
 static int cache_size;
@@ -284,6 +285,31 @@ static size_t protocol_offset(int protocol)
 	}
 }
 
+static const char* protocol_label(int protocol)
+{
+	switch(protocol) {
+	case IPPROTO_UDP:
+		return "UDP";
+	case IPPROTO_TCP:
+		return "TCP";
+	default:
+		return "BAD_PROTOCOL";
+	}
+}
+
+static int socket_type(int protocol, int extra_flags)
+{
+	switch (protocol) {
+	case IPPROTO_UDP:
+		return SOCK_DGRAM | extra_flags;
+	case IPPROTO_TCP:
+		return SOCK_STREAM | extra_flags;
+	default:
+		/* this should never happen */
+		abort();
+	}
+}
+
 /*
  * There is a power and efficiency benefit to have entries
  * in our cache expire at the same time. To this extend,
@@ -443,33 +469,24 @@ static void update_cached_ttl(unsigned char *ptr, int len, int new_ttl)
 	}
 }
 
-static void send_cached_response(int sk, unsigned char *ptr, int len,
+static void send_cached_response(int sk, const unsigned char *ptr, size_t len,
 				const struct sockaddr *to, socklen_t tolen,
 				int protocol, int id, uint16_t answers, int ttl)
 {
 	struct domain_hdr *hdr = NULL;
-	int offset, dns_len, err;
-
+	int err;
+	const size_t offset = protocol_offset(protocol);
 	/*
 	 * The cached packet contains always the TCP offset (two bytes)
 	 * so skip them for UDP.
 	 */
-	switch (protocol) {
-	case IPPROTO_UDP:
-		ptr += 2;
-		len -= 2;
-		dns_len = len;
-		offset = 0;
-		break;
-	case IPPROTO_TCP:
-		offset = 2;
-		dns_len = ptr[0] * 256 + ptr[1];
-		break;
-	default:
-		return;
-	}
+	const size_t skip_bytes = offset ? 0 : DNS_HEADER_TCP_EXTRA_BYTES;
+	ptr += skip_bytes;
+	len -= skip_bytes;
+	const size_t dns_len = protocol == IPPROTO_UDP ? len : ntohs(*((uint16_t*)ptr));
+
 
-	if (len < 12)
+	if (len < DNS_HEADER_SIZE)
 		return;
 
 	hdr = (void *) (ptr + offset);
@@ -489,7 +506,7 @@ static void send_cached_response(int sk, unsigned char *ptr, int len,
 		update_cached_ttl((unsigned char *)hdr, adj_len, ttl);
 	}
 
-	debug("sk %d id 0x%04x answers %d ptr %p length %d dns %d",
+	debug("sk %d id 0x%04x answers %d ptr %p length %zd dns %zd",
 		sk, hdr->id, answers, ptr, len, dns_len);
 
 	err = sendto(sk, ptr, len, MSG_NOSIGNAL, to, tolen);
@@ -498,7 +515,7 @@ static void send_cached_response(int sk, unsigned char *ptr, int len,
 				strerror(errno));
 	}
 	else if (err != len || dns_len != (len - offset))
-		debug("Packet length mismatch, sent %d wanted %d dns %d",
+		debug("Packet length mismatch, sent %d wanted %zd dns %zd",
 			err, len, dns_len);
 }
 
@@ -2319,10 +2336,8 @@ static gboolean udp_server_event(GIOChannel *channel, GIOCondition condition,
 static gboolean tcp_server_event(GIOChannel *channel, GIOCondition condition,
 							gpointer user_data)
 {
-	int sk;
 	struct server_data *server = user_data;
-
-	sk = g_io_channel_unix_get_fd(channel);
+	int sk = g_io_channel_unix_get_fd(channel);
 	if (sk == 0)
 		return FALSE;
 
@@ -2346,8 +2361,7 @@ hangup:
 
 			if (req->protocol == IPPROTO_UDP)
 				continue;
-
-			if (!req->request)
+			else if (!req->request)
 				continue;
 
 			/*
@@ -2358,7 +2372,7 @@ hangup:
 			if (req->numserv && --(req->numserv))
 				continue;
 
-			hdr = (void *) (req->request + 2);
+			hdr = (void *)(req->request + DNS_HEADER_TCP_EXTRA_BYTES);
 			hdr->id = req->srcid;
 			send_response(req->client_sk, req->request,
 				req->request_len, NULL, 0, IPPROTO_TCP);
@@ -2372,17 +2386,14 @@ hangup:
 	}
 
 	if ((condition & G_IO_OUT) && !server->connected) {
-		GSList *list;
-		GList *domains;
 		bool no_request_sent = true;
-		struct server_data *udp_server;
-
-		udp_server = find_server(server->index, server->server,
-								IPPROTO_UDP);
+		struct server_data *udp_server = find_server(
+				server->index, server->server,
+				IPPROTO_UDP);
 		if (udp_server) {
-			for (domains = udp_server->domains; domains;
+			for (GList *domains = udp_server->domains; domains;
 						domains = domains->next) {
-				char *dom = domains->data;
+				const char *dom = domains->data;
 
 				debug("Adding domain %s to %s",
 						dom, server->server);
@@ -2407,9 +2418,11 @@ hangup:
 		server->connected = true;
 		server_list = g_slist_append(server_list, server);
 
-		for (list = request_list; list; ) {
-			struct request_data *req = list->data;
+		/* don't advance the list in the for loop, because we might
+		 * need to delete elements while iterating through it */
+		for (GSList *list = request_list; list; ) {
 			int status;
+			struct request_data *req = list->data;
 
 			if (req->protocol == IPPROTO_UDP) {
 				list = list->next;
@@ -2429,9 +2442,7 @@ hangup:
 				request_list = g_slist_remove(request_list, req);
 				destroy_request_data(req);
 				continue;
-			}
-
-			if (status < 0) {
+			} else if (status < 0) {
 				list = list->next;
 				continue;
 			}
@@ -2456,10 +2467,9 @@ hangup:
 		int bytes_recv;
 
 		if (!reply) {
-			unsigned char reply_len_buf[2];
 			uint16_t reply_len;
 
-			bytes_recv = recv(sk, reply_len_buf, 2, MSG_PEEK);
+			bytes_recv = recv(sk, &reply_len, sizeof(reply_len), MSG_PEEK);
 			if (!bytes_recv) {
 				goto hangup;
 			} else if (bytes_recv < 0) {
@@ -2472,8 +2482,9 @@ hangup:
 			} else if (bytes_recv < 2)
 				return TRUE;
 
-			reply_len = reply_len_buf[1] | reply_len_buf[0] << 8;
-			reply_len += 2;
+			/* the header contains the length of the message
+			 * excluding the two length bytes */
+			reply_len = ntohs(reply_len) + DNS_HEADER_TCP_EXTRA_BYTES;
 
 			debug("TCP reply %d bytes from %d", reply_len, sk);
 
@@ -2534,15 +2545,15 @@ static gboolean tcp_idle_timeout(gpointer user_data)
 
 static int server_create_socket(struct server_data *data)
 {
-	int sk, err;
+	int err;
 	char *interface;
+	int sk = socket(data->server_addr->sa_family,
+		data->protocol == IPPROTO_TCP ? SOCK_STREAM : SOCK_DGRAM,
+		data->protocol);
 
 	debug("index %d server %s proto %d", data->index,
 					data->server, data->protocol);
 
-	sk = socket(data->server_addr->sa_family,
-		data->protocol == IPPROTO_TCP ? SOCK_STREAM : SOCK_DGRAM,
-		data->protocol);
 	if (sk < 0) {
 		err = errno;
 		connman_error("Failed to create server %s socket",
@@ -2613,9 +2624,7 @@ static int server_create_socket(struct server_data *data)
 
 static void enable_fallback(bool enable)
 {
-	GSList *list;
-
-	for (list = server_list; list; list = list->next) {
+	for (GSList *list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
 
 		if (data->index != -1)
@@ -2634,13 +2643,12 @@ static struct server_data *create_server(int index,
 					const char *domain, const char *server,
 					int protocol)
 {
-	struct server_data *data;
+	struct server_data *data = g_try_new0(struct server_data, 1);
 	struct addrinfo hints, *rp;
 	int ret;
 
 	DBG("index %d server %s", index, server);
 
-	data = g_try_new0(struct server_data, 1);
 	if (!data) {
 		connman_error("Failed to allocate server %s data", server);
 		return NULL;
@@ -2653,20 +2661,7 @@ static struct server_data *create_server(int index,
 	data->protocol = protocol;
 
 	memset(&hints, 0, sizeof(hints));
-
-	switch (protocol) {
-	case IPPROTO_UDP:
-		hints.ai_socktype = SOCK_DGRAM;
-		break;
-
-	case IPPROTO_TCP:
-		hints.ai_socktype = SOCK_STREAM;
-		break;
-
-	default:
-		destroy_server(data);
-		return NULL;
-	}
+	hints.ai_socktype = socket_type(protocol, 0);
 	hints.ai_family = AF_UNSPEC;
 	hints.ai_flags = AI_NUMERICSERV | AI_NUMERICHOST;
 
@@ -2729,9 +2724,7 @@ static struct server_data *create_server(int index,
 static bool resolv(struct request_data *req,
 				gpointer request, gpointer name)
 {
-	GSList *list;
-
-	for (list = server_list; list; list = list->next) {
+	for (GSList *list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
 
 		if (data->protocol == IPPROTO_TCP) {
@@ -2760,26 +2753,22 @@ static bool resolv(struct request_data *req,
 
 static void update_domain(int index, const char *domain, bool append)
 {
-	GSList *list;
-
 	DBG("index %d domain %s", index, domain);
 
 	if (!domain)
 		return;
 
-	for (list = server_list; list; list = list->next) {
+	for (GSList *list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
-		GList *dom_list;
 		char *dom = NULL;
 		bool dom_found = false;
 
 		if (data->index < 0)
 			continue;
-
-		if (data->index != index)
+		else if (data->index != index)
 			continue;
 
-		for (dom_list = data->domains; dom_list;
+		for (GList *dom_list = data->domains; dom_list;
 				dom_list = dom_list->next) {
 			dom = dom_list->data;
 
@@ -2812,9 +2801,7 @@ static void remove_domain(int index, const char *domain)
 
 static void flush_requests(struct server_data *server)
 {
-	GSList *list;
-
-	list = request_list;
+	GSList *list = request_list;
 	while (list) {
 		struct request_data *req = list->data;
 
@@ -2842,22 +2829,20 @@ int __connman_dnsproxy_append(int index, const char *domain,
 							const char *server)
 {
 	struct server_data *data;
-
 	DBG("index %d server %s", index, server);
 
-	if (!server && !domain)
-		return -EINVAL;
-
 	if (!server) {
-		append_domain(index, domain);
-
-		return 0;
+		if (!domain) {
+			return -EINVAL;
+		} else {
+			append_domain(index, domain);
+			return 0;
+		}
 	}
 
 	if (g_str_equal(server, "127.0.0.1"))
 		return -ENODEV;
-
-	if (g_str_equal(server, "::1"))
+	else if (g_str_equal(server, "::1"))
 		return -ENODEV;
 
 	data = find_server(index, server, IPPROTO_UDP);
@@ -2877,16 +2862,13 @@ int __connman_dnsproxy_append(int index, const char *domain,
 
 static void remove_server(int index, const char *server, int protocol)
 {
-	struct server_data *data;
-	GSList *list;
-
-	data = find_server(index, server, protocol);
+	struct server_data *data = find_server(index, server, protocol);
 	if (!data)
 		return;
 
 	destroy_server(data);
 
-	for (list = server_list; list; list = list->next) {
+	for (GSList *list = server_list; list; list = list->next) {
 		data = list->data;
 
 		if (data->index != -1 && data->enabled == true)
@@ -2901,19 +2883,18 @@ int __connman_dnsproxy_remove(int index, const char *domain,
 {
 	DBG("index %d server %s", index, server);
 
-	if (!server && !domain)
-		return -EINVAL;
-
 	if (!server) {
-		remove_domain(index, domain);
-
-		return 0;
+		if (!domain) {
+			return -EINVAL;
+		} else {
+			remove_domain(index, domain);
+			return 0;
+		}
 	}
 
 	if (g_str_equal(server, "127.0.0.1"))
 		return -ENODEV;
-
-	if (g_str_equal(server, "::1"))
+	else if (g_str_equal(server, "::1"))
 		return -ENODEV;
 
 	remove_server(index, server, IPPROTO_UDP);
@@ -2924,11 +2905,9 @@ int __connman_dnsproxy_remove(int index, const char *domain,
 
 static void dnsproxy_offline_mode(bool enabled)
 {
-	GSList *list;
-
 	DBG("enabled %d", enabled);
 
-	for (list = server_list; list; list = list->next) {
+	for (GSList *list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
 
 		if (!enabled) {
@@ -2946,10 +2925,8 @@ static void dnsproxy_offline_mode(bool enabled)
 
 static void dnsproxy_default_changed(struct connman_service *service)
 {
-	bool server_enabled = false;
-	GSList *list;
-	int index;
-	int vpn_index;
+	bool any_server_enabled = false;
+	int index, vpn_index;
 
 	DBG("service %p", service);
 
@@ -2973,13 +2950,13 @@ static void dnsproxy_default_changed(struct connman_service *service)
 	 */
 	vpn_index = __connman_connection_get_vpn_index(index);
 
-	for (list = server_list; list; list = list->next) {
+	for (GSList *list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
 
 		if (data->index == index) {
 			DBG("Enabling DNS server %s", data->server);
 			data->enabled = true;
-			server_enabled = true;
+			any_server_enabled = true;
 		} else if (data->index == vpn_index) {
 			DBG("Enabling DNS server of VPN %s", data->server);
 			data->enabled = true;
@@ -2989,7 +2966,7 @@ static void dnsproxy_default_changed(struct connman_service *service)
 		}
 	}
 
-	if (!server_enabled)
+	if (!any_server_enabled)
 		enable_fallback(true);
 
 	cache_refresh();
@@ -3037,47 +3014,59 @@ static const struct connman_notifier dnsproxy_notifier = {
 	.service_state_changed	= dnsproxy_service_state_changed,
 };
 
-static const unsigned char opt_edns0_type[2] = { 0x00, 0x29 };
-
+/*
+ * Parses the given request buffer. `buf´ is expected to be the start of the
+ * domain_hdr structure i.e. the TCP length header is not handled by this
+ * function.
+ * Returns the ascii string dot representation of the query in `name´, which
+ * must be able to hold `size´ bytes.
+ *
+ * Returns < 0 on error (errno) or zero on success.
+ */
 static int parse_request(unsigned char *buf, size_t len,
-					char *name, unsigned int size)
+					char *name, size_t size)
 {
+	static const unsigned char OPT_EDNS0_TYPE[2] = { 0x00, 0x29 };
 	struct domain_hdr *hdr = (void *) buf;
-	uint16_t qdcount = ntohs(hdr->qdcount);
-	uint16_t ancount = ntohs(hdr->ancount);
-	uint16_t nscount = ntohs(hdr->nscount);
-	uint16_t arcount = ntohs(hdr->arcount);
-	unsigned char *ptr;
-	unsigned int remain, used = 0;
-
-	if (len < sizeof(*hdr) + sizeof(struct qtype_qclass) ||
-			hdr->qr || qdcount != 1 || ancount || nscount) {
-		DBG("Dropped DNS request qr %d with len %zd qdcount %d "
-			"ancount %d nscount %d", hdr->qr, len, qdcount, ancount,
-			nscount);
+	uint16_t qdcount, ancount, nscount, arcount;
+	unsigned char *ptr = buf + sizeof(struct domain_hdr);
+	size_t remain = len - sizeof(struct domain_hdr);
+	size_t used = 0;
 
+	if (len < sizeof(*hdr) + sizeof(struct qtype_qclass)) {
+		DBG("Dropped DNS request with short length %zd", len);
 		return -EINVAL;
 	}
 
 	if (!name || !size)
 		return -EINVAL;
 
+	qdcount = ntohs(hdr->qdcount);
+	ancount = ntohs(hdr->ancount);
+	nscount = ntohs(hdr->nscount);
+	arcount = ntohs(hdr->arcount);
+
+	if (hdr->qr || qdcount != 1 || ancount || nscount) {
+		DBG("Dropped DNS request with bad flags/counts qr %d "
+			"with len %zd qdcount %d ancount %d nscount %d",
+			hdr->qr, len, qdcount, ancount, nscount);
+
+		return -EINVAL;
+	}
+
 	debug("id 0x%04x qr %d opcode %d qdcount %d arcount %d",
 					hdr->id, hdr->qr, hdr->opcode,
 							qdcount, arcount);
 
 	name[0] = '\0';
 
-	ptr = buf + sizeof(struct domain_hdr);
-	remain = len - sizeof(struct domain_hdr);
-
+	/* parse DNS query string into `name' out parameter */
 	while (remain > 0) {
 		uint8_t label_len = *ptr;
 
 		if (label_len == 0x00) {
-			uint8_t class;
-			struct qtype_qclass *q =
-				(struct qtype_qclass *)(ptr + 1);
+			struct qtype_qclass *q = (struct qtype_qclass *)(ptr + 1);
+			uint16_t class;
 
 			if (remain < sizeof(*q)) {
 				DBG("Dropped malformed DNS query");
@@ -3085,7 +3074,7 @@ static int parse_request(unsigned char *buf, size_t len,
 			}
 
 			class = ntohs(q->qclass);
-			if (class != 1 && class != 255) {
+			if (class != DNS_CLASS_IN && class != DNS_CLASS_ANY) {
 				DBG("Dropped non-IN DNS class %d", class);
 				return -EINVAL;
 			}
@@ -3102,18 +3091,17 @@ static int parse_request(unsigned char *buf, size_t len,
 		strcat(name, ".");
 
 		used += label_len + 1;
-
 		ptr += label_len + 1;
 		remain -= label_len + 1;
 	}
 
 	if (arcount && remain >= sizeof(struct domain_rr) + 1 && !ptr[0] &&
-		ptr[1] == opt_edns0_type[0] && ptr[2] == opt_edns0_type[1]) {
+		ptr[1] == OPT_EDNS0_TYPE[0] && ptr[2] == OPT_EDNS0_TYPE[1]) {
 		struct domain_rr *edns0 = (struct domain_rr *)(ptr + 1);
 
 		DBG("EDNS0 buffer size %u", ntohs(edns0->class));
 	} else if (!arcount && remain) {
-		DBG("DNS request with %d garbage bytes", remain);
+		DBG("DNS request with %zd garbage bytes", remain);
 	}
 
 	debug("query %s", name);
@@ -3150,7 +3138,7 @@ static void client_reset(struct tcp_partial_client_data *client)
 	client->buf_end = 0;
 }
 
-static unsigned int get_msg_len(unsigned char *buf)
+static size_t get_msg_len(const unsigned char *buf)
 {
 	return buf[0]<<8 | buf[1];
 }
@@ -3161,15 +3149,14 @@ static bool read_tcp_data(struct tcp_partial_client_data *client,
 {
 	char query[TCP_MAX_BUF_LEN];
 	struct request_data *req;
-	int client_sk, err;
-	unsigned int msg_len;
-	GSList *list;
+	struct domain_hdr *hdr;
+	int client_sk = g_io_channel_unix_get_fd(client->channel);
+	int err;
+	size_t msg_len;
 	bool waiting_for_connect = false;
 	uint16_t qtype = 0;
 	struct cache_entry *entry;
 
-	client_sk = g_io_channel_unix_get_fd(client->channel);
-
 	if (read_len == 0) {
 		debug("client %d closed, pending %d bytes",
 			client_sk, client->buf_end);
@@ -3182,32 +3169,32 @@ static bool read_tcp_data(struct tcp_partial_client_data *client,
 
 	client->buf_end += read_len;
 
+	/* we need at least the message length header */
 	if (client->buf_end < 2)
 		return true;
 
 	msg_len = get_msg_len(client->buf);
 	if (msg_len > TCP_MAX_BUF_LEN) {
-		debug("client %d sent too much data %d", client_sk, msg_len);
+		debug("client %d sent too much data %zd", client_sk, msg_len);
 		g_hash_table_remove(partial_tcp_req_table,
 					GINT_TO_POINTER(client_sk));
 		return false;
 	}
 
 read_another:
-	debug("client %d msg len %d end %d past end %d", client_sk, msg_len,
+	debug("client %d msg len %zd end %d past end %zd", client_sk, msg_len,
 		client->buf_end, client->buf_end - (msg_len + 2));
 
 	if (client->buf_end < (msg_len + 2)) {
-		debug("client %d still missing %d bytes",
+		debug("client %d still missing %zd bytes",
 			client_sk,
 			msg_len + 2 - client->buf_end);
 		return true;
 	}
 
-	debug("client %d all data %d received", client_sk, msg_len);
+	debug("client %d all data %zd received", client_sk, msg_len);
 
-	err = parse_request(client->buf + 2, msg_len,
-			query, sizeof(query));
+	err = parse_request(client->buf + 2, msg_len, query, sizeof(query));
 	if (err < 0 || (g_slist_length(server_list) == 0)) {
 		send_response(client_sk, client->buf, msg_len + 2,
 			NULL, 0, IPPROTO_TCP);
@@ -3224,13 +3211,15 @@ read_another:
 	req->protocol = IPPROTO_TCP;
 	req->family = client->family;
 
-	req->srcid = client->buf[2] | (client->buf[3] << 8);
+	hdr = (void*)(client->buf + 2);
+
+	memcpy(&req->srcid, &hdr->id, sizeof(req->srcid));
 	req->dstid = get_id();
 	req->altid = get_id();
 	req->request_len = msg_len + 2;
 
-	client->buf[2] = req->dstid & 0xff;
-	client->buf[3] = req->dstid >> 8;
+	/* replace ID the request for forwarding */
+	memcpy(&hdr->id, &req->dstid, sizeof(hdr->id));
 
 	req->numserv = 0;
 	req->ifdata = client->ifdata;
@@ -3242,17 +3231,12 @@ read_another:
 	 */
 	entry = cache_check(client->buf, &qtype, IPPROTO_TCP);
 	if (entry) {
-		int ttl_left = 0;
-		struct cache_data *data;
-
-		debug("cache hit %s type %s", query, qtype == 1 ? "A" : "AAAA");
-		if (qtype == 1)
-			data = entry->ipv4;
-		else
-			data = entry->ipv6;
+		debug("cache hit %s type %s", query, qtype == DNS_TYPE_A ? "A" : "AAAA");
+		struct cache_data *data = qtype == DNS_TYPE_A ?
+			entry->ipv4 : entry->ipv6;
 
 		if (data) {
-			ttl_left = data->valid_until - time(NULL);
+			int ttl_left = data->valid_until - time(NULL);
 			entry->hits++;
 
 			send_cached_response(client_sk, data->data,
@@ -3265,7 +3249,7 @@ read_another:
 			debug("data missing, ignoring cache for this query");
 	}
 
-	for (list = server_list; list; list = list->next) {
+	for (GSList *list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
 
 		if (data->protocol != IPPROTO_UDP || !data->enabled)
@@ -3317,7 +3301,7 @@ read_another:
 
 out:
 	if (client->buf_end > (msg_len + 2)) {
-		debug("client %d buf %p -> %p end %d len %d new %d",
+		debug("client %d buf %p -> %p end %d len %d new %zd",
 			client_sk,
 			client->buf + msg_len + 2,
 			client->buf, client->buf_end,
@@ -3333,7 +3317,7 @@ out:
 		 */
 		msg_len = get_msg_len(client->buf);
 		if ((msg_len + 2) == client->buf_end) {
-			debug("client %d reading another %d bytes", client_sk,
+			debug("client %d reading another %zd bytes", client_sk,
 								msg_len + 2);
 			goto read_another;
 		}
@@ -3359,15 +3343,7 @@ static gboolean tcp_client_event(GIOChannel *channel, GIOCondition condition,
 				gpointer user_data)
 {
 	struct tcp_partial_client_data *client = user_data;
-	struct sockaddr_in6 client_addr6;
-	socklen_t client_addr6_len = sizeof(client_addr6);
-	struct sockaddr_in client_addr4;
-	socklen_t client_addr4_len = sizeof(client_addr4);
-	void *client_addr;
-	socklen_t *client_addr_len;
-	int len, client_sk;
-
-	client_sk = g_io_channel_unix_get_fd(channel);
+	int client_sk = g_io_channel_unix_get_fd(channel);
 
 	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		g_hash_table_remove(partial_tcp_req_table,
@@ -3377,6 +3353,13 @@ static gboolean tcp_client_event(GIOChannel *channel, GIOCondition condition,
 		return FALSE;
 	}
 
+	struct sockaddr_in6 client_addr6;
+	socklen_t client_addr6_len = sizeof(client_addr6);
+	struct sockaddr_in client_addr4;
+	socklen_t client_addr4_len = sizeof(client_addr4);
+	void *client_addr;
+	socklen_t *client_addr_len;
+
 	switch (client->family) {
 	case AF_INET:
 		client_addr = &client_addr4;
@@ -3393,7 +3376,7 @@ static gboolean tcp_client_event(GIOChannel *channel, GIOCondition condition,
 		return FALSE;
 	}
 
-	len = recvfrom(client_sk, client->buf + client->buf_end,
+	const int len = recvfrom(client_sk, client->buf + client->buf_end,
 			TCP_MAX_BUF_LEN - client->buf_end, 0,
 			client_addr, client_addr_len);
 	if (len < 0) {
@@ -3413,9 +3396,7 @@ static gboolean tcp_client_event(GIOChannel *channel, GIOCondition condition,
 static gboolean client_timeout(gpointer user_data)
 {
 	struct tcp_partial_client_data *client = user_data;
-	int sock;
-
-	sock = g_io_channel_unix_get_fd(client->channel);
+	int sock = g_io_channel_unix_get_fd(client->channel);
 
 	debug("client %d timeout pending %d bytes", sock, client->buf_end);
 
@@ -3428,8 +3409,12 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 				struct listener_data *ifdata, int family,
 				guint *listener_watch)
 {
-	int sk, client_sk, len;
-	unsigned int msg_len;
+	int sk = -1, client_sk = -1;
+	int recv_len;
+	size_t msg_len;
+	fd_set readfds;
+	struct timeval tv = {.tv_sec = 0, .tv_usec = 0};
+
 	struct tcp_partial_client_data *client;
 	struct sockaddr_in6 client_addr6;
 	socklen_t client_addr6_len = sizeof(client_addr6);
@@ -3437,8 +3422,6 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 	socklen_t client_addr4_len = sizeof(client_addr4);
 	void *client_addr;
 	socklen_t *client_addr_len;
-	struct timeval tv;
-	fd_set readfds;
 
 	debug("condition 0x%02x channel %p ifdata %p family %d",
 		condition, channel, ifdata, family);
@@ -3463,29 +3446,27 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 		client_addr_len = &client_addr6_len;
 	}
 
-	tv.tv_sec = tv.tv_usec = 0;
 	FD_ZERO(&readfds);
 	FD_SET(sk, &readfds);
 
+	/* TODO: check select return code */
 	select(sk + 1, &readfds, NULL, NULL, &tv);
-	if (FD_ISSET(sk, &readfds)) {
-		client_sk = accept(sk, client_addr, client_addr_len);
-		debug("client %d accepted", client_sk);
-	} else {
+	if (!FD_ISSET(sk, &readfds)) {
 		debug("No data to read from master %d, waiting.", sk);
 		return true;
 	}
 
+	client_sk = accept(sk, client_addr, client_addr_len);
 	if (client_sk < 0) {
 		connman_error("Accept failure on TCP listener");
 		*listener_watch = 0;
 		return false;
 	}
+	debug("client %d accepted", client_sk);
 
 	fcntl(client_sk, F_SETFL, O_NONBLOCK);
 
-	client = g_hash_table_lookup(partial_tcp_req_table,
-					GINT_TO_POINTER(client_sk));
+	client = g_hash_table_lookup(partial_tcp_req_table, GINT_TO_POINTER(client_sk));
 	if (!client) {
 		client = g_try_new0(struct tcp_partial_client_data, 1);
 		if (!client) {
@@ -3529,8 +3510,8 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 	 * proceed normally, otherwise read the bits until everything
 	 * is received or timeout occurs.
 	 */
-	len = recv(client_sk, client->buf, TCP_MAX_BUF_LEN, 0);
-	if (len < 0) {
+	recv_len = recv(client_sk, client->buf, TCP_MAX_BUF_LEN, 0);
+	if (recv_len < 0) {
 		if (errno == EAGAIN || errno == EWOULDBLOCK) {
 			debug("client %d no data to read, waiting", client_sk);
 			return true;
@@ -3543,15 +3524,15 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 		return true;
 	}
 
-	if (len < 2) {
+	if (recv_len < 2) {
 		debug("client %d not enough data to read, waiting", client_sk);
-		client->buf_end += len;
+		client->buf_end += recv_len;
 		return true;
 	}
 
 	msg_len = get_msg_len(client->buf);
 	if (msg_len > TCP_MAX_BUF_LEN) {
-		debug("client %d invalid message length %u ignoring packet",
+		debug("client %d invalid message length %zd ignoring packet",
 			client_sk, msg_len);
 		g_hash_table_remove(partial_tcp_req_table,
 					GINT_TO_POINTER(client_sk));
@@ -3562,15 +3543,15 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 	 * The packet length bytes do not contain the total message length,
 	 * that is the reason to -2 below.
 	 */
-	if (msg_len != (unsigned int)(len - 2)) {
-		debug("client %d sent %d bytes but expecting %u pending %d",
-			client_sk, len, msg_len + 2, msg_len + 2 - len);
+	if (msg_len != (size_t)(recv_len - DNS_HEADER_TCP_EXTRA_BYTES)) {
+		debug("client %d sent %d bytes but expecting %zd pending %zd",
+			client_sk, recv_len, msg_len + 2, msg_len + 2 - recv_len);
 
-		client->buf_end += len;
+		client->buf_end += recv_len;
 		return true;
 	}
 
-	return read_tcp_data(client, client_addr, *client_addr_len, len);
+	return read_tcp_data(client, client_addr, *client_addr_len, recv_len);
 }
 
 static gboolean tcp4_listener_event(GIOChannel *channel, GIOCondition condition,
@@ -3597,14 +3578,16 @@ static bool udp_listener_event(GIOChannel *channel, GIOCondition condition,
 {
 	unsigned char buf[768];
 	char query[512];
-	struct request_data *req;
+	struct request_data *req = NULL;
+	struct domain_hdr *hdr = NULL;
+	int sk = -1, err, len;
+
 	struct sockaddr_in6 client_addr6;
 	socklen_t client_addr6_len = sizeof(client_addr6);
 	struct sockaddr_in client_addr4;
 	socklen_t client_addr4_len = sizeof(client_addr4);
 	void *client_addr;
 	socklen_t *client_addr_len;
-	int sk, err, len;
 
 	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		connman_error("Error with UDP listener channel");
@@ -3612,8 +3595,6 @@ static bool udp_listener_event(GIOChannel *channel, GIOCondition condition,
 		return false;
 	}
 
-	sk = g_io_channel_unix_get_fd(channel);
-
 	if (family == AF_INET) {
 		client_addr = &client_addr4;
 		client_addr_len = &client_addr4_len;
@@ -3623,6 +3604,7 @@ static bool udp_listener_event(GIOChannel *channel, GIOCondition condition,
 	}
 
 	memset(client_addr, 0, *client_addr_len);
+	sk = g_io_channel_unix_get_fd(channel);
 	len = recvfrom(sk, buf, sizeof(buf), 0, client_addr, client_addr_len);
 	if (len < 2)
 		return true;
@@ -3646,13 +3628,14 @@ static bool udp_listener_event(GIOChannel *channel, GIOCondition condition,
 	req->protocol = IPPROTO_UDP;
 	req->family = family;
 
-	req->srcid = buf[0] | (buf[1] << 8);
+	hdr = (void*)buf;
+
+	req->srcid = hdr->id;
 	req->dstid = get_id();
 	req->altid = get_id();
 	req->request_len = len;
 
-	buf[0] = req->dstid & 0xff;
-	buf[1] = req->dstid >> 8;
+	hdr->id = req->dstid;
 
 	req->numserv = 0;
 	req->ifdata = ifdata;
@@ -3693,42 +3676,26 @@ static gboolean udp6_listener_event(GIOChannel *channel, GIOCondition condition,
 
 static GIOChannel *get_listener(int family, int protocol, int index)
 {
-	GIOChannel *channel;
-	const char *proto;
+	GIOChannel *channel = NULL;
 	union {
 		struct sockaddr sa;
 		struct sockaddr_in6 sin6;
 		struct sockaddr_in sin;
 	} s;
 	socklen_t slen;
-	int sk, type;
+	const char *proto = protocol_label(protocol);
+	const int type = socket_type(protocol, SOCK_CLOEXEC);
 	char *interface;
+	int sk = socket(family, type, protocol);
 
 	debug("family %d protocol %d index %d", family, protocol, index);
 
-	switch (protocol) {
-	case IPPROTO_UDP:
-		proto = "UDP";
-		type = SOCK_DGRAM | SOCK_CLOEXEC;
-		break;
-
-	case IPPROTO_TCP:
-		proto = "TCP";
-		type = SOCK_STREAM | SOCK_CLOEXEC;
-		break;
-
-	default:
-		return NULL;
-	}
-
-	sk = socket(family, type, protocol);
-	if (sk < 0 && family == AF_INET6 && errno == EAFNOSUPPORT) {
-		connman_error("No IPv6 support");
-		return NULL;
-	}
-
 	if (sk < 0) {
-		connman_error("Failed to create %s listener socket", proto);
+		if (family == AF_INET6 && errno == EAFNOSUPPORT) {
+			connman_error("No IPv6 support");
+		} else {
+			connman_error("Failed to create %s listener socket", proto);
+		}
 		return NULL;
 	}
 
@@ -3787,7 +3754,6 @@ static GIOChannel *get_listener(int family, int protocol, int index)
 	}
 
 	if (protocol == IPPROTO_TCP) {
-
 		if (listen(sk, 10) < 0) {
 			connman_error("Failed to listen on TCP socket %d/%s",
 				-errno, strerror(errno));
@@ -3901,9 +3867,7 @@ static void destroy_tcp_listener(struct listener_data *ifdata)
 
 static int create_listener(struct listener_data *ifdata)
 {
-	int err, index;
-
-	err = create_dns_listener(IPPROTO_UDP, ifdata);
+	int err = create_dns_listener(IPPROTO_UDP, ifdata);
 	if ((err & UDP_FAILED) == UDP_FAILED)
 		return -EIO;
 
@@ -3913,7 +3877,7 @@ static int create_listener(struct listener_data *ifdata)
 		return -EIO;
 	}
 
-	index = connman_inet_ifindex("lo");
+	int index = connman_inet_ifindex("lo");
 	if (ifdata->index == index) {
 		if ((err & IPv6_FAILED) != IPv6_FAILED)
 			__connman_resolvfile_append(index, NULL, "::1");
@@ -3927,16 +3891,14 @@ static int create_listener(struct listener_data *ifdata)
 
 static void destroy_listener(struct listener_data *ifdata)
 {
-	int index;
-	GSList *list;
+	int index = connman_inet_ifindex("lo");
 
-	index = connman_inet_ifindex("lo");
 	if (ifdata->index == index) {
 		__connman_resolvfile_remove(index, NULL, "127.0.0.1");
 		__connman_resolvfile_remove(index, NULL, "::1");
 	}
 
-	for (list = request_list; list; list = list->next) {
+	for (GSList *list = request_list; list; list = list->next) {
 		struct request_data *req = list->data;
 
 		debug("Dropping request (id 0x%04x -> 0x%04x)",
@@ -3997,7 +3959,6 @@ int __connman_dnsproxy_add_listener(int index)
 void __connman_dnsproxy_remove_listener(int index)
 {
 	struct listener_data *ifdata;
-
 	DBG("index %d", index);
 
 	if (!listener_table)
@@ -4050,17 +4011,15 @@ int __connman_dnsproxy_init(void)
 		return err;
 
 	err = connman_notifier_register(&dnsproxy_notifier);
-	if (err < 0)
-		goto destroy;
-
-	return 0;
+	if (err < 0) {
+		__connman_dnsproxy_remove_listener(index);
+		g_hash_table_destroy(listener_table);
+		g_hash_table_destroy(partial_tcp_req_table);
 
-destroy:
-	__connman_dnsproxy_remove_listener(index);
-	g_hash_table_destroy(listener_table);
-	g_hash_table_destroy(partial_tcp_req_table);
+		return err;
+	}
 
-	return err;
+	return 0;
 }
 
 int __connman_dnsproxy_set_mdns(int index, bool enabled)
-- 
2.37.3

