Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B11865
	for <connman@lists.linux.dev>; Mon, 11 Apr 2022 16:59:17 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id c12-20020a17090a020c00b001cba1ebb20cso363038pjc.0
        for <connman@lists.linux.dev>; Mon, 11 Apr 2022 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=density.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+nuXO7oTaQKif0dkJga8x+dlljFCQ7jV+FGs/ZsU20=;
        b=CRysm/kuU/Bfd86YsuQYwqAgoyelnjXqo6N7wVH/YE8J0ccCuHAI6LG70ZPq5B4Nnp
         nZLgyznK4DdzEO4abFR80pK2EyCc9ySp1jgVhlMh0As0+tW7apBCR234vcByMXntBNKP
         20DubyodxJcJA1Wx5MaXqJf6Wh2s7/LryfYDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+nuXO7oTaQKif0dkJga8x+dlljFCQ7jV+FGs/ZsU20=;
        b=OWrsLvnJES9cFQ27SjxktKFCONWCeDn4xuMwAqUh5rplJvHnACrJhV/LnoG8jrER3J
         XLGzwQYS6CXoTH8MzEyY+C+fE/MSaM64ZmYjUkQwMuEH2ydMCuZAAAywX07uX2UEfClL
         tVbS8PTW8UwEyUKjtX9iy6SfEI62tivNzkPxEar8e/aLpw8BhQ7LoSbuKKxNfnanpL2v
         XG6cVXQVSrhJGnfMfNAz5FD3jnL+0geH7d18HsPrX1GAnxtMPD3YUOYA9e0dbtLsoezP
         8MmeCHyo8BKlY1Nw9xNPK+Jw4j+c2rBce3VBnhrobhapoqnDx7QkNtzfGrUo46OITHGr
         ISpg==
X-Gm-Message-State: AOAM530qflxt6PtBxbvdXGgjEj+uD4P7cNrm807AegmlspESxPgMbij0
	DsRKT37xJmm297c0MfiOA0zswaaKvz3oKg==
X-Google-Smtp-Source: ABdhPJycr7hrWUimbk5fp61MOqIl67l6mZ3dXae9ipvLV5W/A6cBKHfRh/7RE0rExjz+EDS1dT9LRQ==
X-Received: by 2002:a17:902:f686:b0:158:618c:5fa with SMTP id l6-20020a170902f68600b00158618c05famr6396805plg.16.1649696355995;
        Mon, 11 Apr 2022 09:59:15 -0700 (PDT)
Received: from ubuntu.home (96-19-96-19-98-42.cpe.sparklight.net. [96.19.98.42])
        by smtp.gmail.com with ESMTPSA id f14-20020a63380e000000b0038253c4d5casm276251pga.36.2022.04.11.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 09:59:15 -0700 (PDT)
From: Ryan Smith <ryan.smith@density.io>
To: connman@lists.linux.dev
Cc: Ryan Smith <ryan.smith@density.io>
Subject: [PATCH v1] dnsproxy: fix debug logging
Date: Mon, 11 Apr 2022 10:58:21 -0600
Message-Id: <20220411165821.501633-1-ryan.smith@density.io>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes the debug logging by compilation unit just as it
is done with all of the other files in src/.
---
 src/dnsproxy.c | 157 ++++++++++++++++++++++++-------------------------
 1 file changed, 78 insertions(+), 79 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 22730047..5589feeb 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -40,8 +40,7 @@
 #include <glib.h>
 
 #include "connman.h"
-
-#define debug(fmt...) do { } while (0)
+#include "connman/log.h"
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 struct domain_hdr {
@@ -290,7 +289,7 @@ static struct server_data *find_server(int index,
 {
 	GSList *list;
 
-	debug("index %d server %s proto %d", index, server, protocol);
+	DBG("index %d server %s proto %d", index, server, protocol);
 
 	for (list = server_list; list; list = list->next) {
 		struct server_data *data = list->data;
@@ -341,14 +340,14 @@ static void refresh_dns_entry(struct cache_entry *entry, char *name)
 	}
 
 	if (!entry->ipv4) {
-		debug("Refreshing A record for %s", name);
+		DBG("Refreshing A record for %s", name);
 		g_resolv_lookup_hostname(ipv4_resolve, name,
 					dummy_resolve_func, NULL);
 		age = 4;
 	}
 
 	if (!entry->ipv6) {
-		debug("Refreshing AAAA record for %s", name);
+		DBG("Refreshing AAAA record for %s", name);
 		g_resolv_lookup_hostname(ipv6_resolve, name,
 					dummy_resolve_func, NULL);
 		age = 4;
@@ -460,7 +459,7 @@ static void send_cached_response(int sk, unsigned char *buf, int len,
 	else
 		update_cached_ttl((unsigned char *)hdr, adj_len, ttl);
 
-	debug("sk %d id 0x%04x answers %d ptr %p length %d dns %d",
+	DBG("sk %d id 0x%04x answers %d ptr %p length %d dns %d",
 		sk, hdr->id, answers, ptr, len, dns_len);
 
 	err = sendto(sk, ptr, len, MSG_NOSIGNAL, to, tolen);
@@ -472,7 +471,7 @@ static void send_cached_response(int sk, unsigned char *buf, int len,
 
 	if (err != len || (dns_len != (len - 2) && protocol == IPPROTO_TCP) ||
 				(dns_len != len && protocol == IPPROTO_UDP))
-		debug("Packet length mismatch, sent %d wanted %d dns %d",
+		DBG("Packet length mismatch, sent %d wanted %d dns %d",
 			err, len, dns_len);
 }
 
@@ -484,7 +483,7 @@ static void send_response(int sk, unsigned char *buf, size_t len,
 	int err;
 	size_t offset = protocol_offset(protocol);
 
-	debug("sk %d", sk);
+	DBG("sk %d", sk);
 
 	if (len < sizeof(*hdr) + offset)
 		return;
@@ -495,7 +494,7 @@ static void send_response(int sk, unsigned char *buf, size_t len,
 		buf[1] = sizeof(*hdr);
 	}
 
-	debug("id 0x%04x qr %d opcode %d", hdr->id, hdr->qr, hdr->opcode);
+	DBG("id 0x%04x qr %d opcode %d", hdr->id, hdr->qr, hdr->opcode);
 
 	hdr->qr = 1;
 	hdr->rcode = ns_r_servfail;
@@ -548,7 +547,7 @@ static gboolean request_timeout(gpointer user_data)
 	if (!req)
 		return FALSE;
 
-	debug("id 0x%04x", req->srcid);
+	DBG("id 0x%04x", req->srcid);
 
 	request_list = g_slist_remove(request_list, req);
 
@@ -590,7 +589,7 @@ static gboolean request_timeout(gpointer user_data)
 	 * if we get a request timeout from server.
 	 */
 	if (req->protocol == IPPROTO_TCP) {
-		debug("client %d removed", req->client_sk);
+		DBG("client %d removed", req->client_sk);
 		g_hash_table_remove(partial_tcp_req_table,
 				GINT_TO_POINTER(req->client_sk));
 	}
@@ -608,7 +607,7 @@ static int append_query(unsigned char *buf, unsigned int size,
 	unsigned char *ptr = buf;
 	int len;
 
-	debug("query %s domain %s", query, domain);
+	DBG("query %s domain %s", query, domain);
 
 	while (query) {
 		const char *tmp;
@@ -678,7 +677,7 @@ static void cache_enforce_validity(struct cache_entry *entry)
 
 	if (!cache_check_is_valid(entry->ipv4, current_time)
 							&& entry->ipv4) {
-		debug("cache timeout \"%s\" type A", entry->key);
+		DBG("cache timeout \"%s\" type A", entry->key);
 		g_free(entry->ipv4->data);
 		g_free(entry->ipv4);
 		entry->ipv4 = NULL;
@@ -687,7 +686,7 @@ static void cache_enforce_validity(struct cache_entry *entry)
 
 	if (!cache_check_is_valid(entry->ipv6, current_time)
 							&& entry->ipv6) {
-		debug("cache timeout \"%s\" type AAAA", entry->key);
+		DBG("cache timeout \"%s\" type AAAA", entry->key);
 		g_free(entry->ipv6->data);
 		g_free(entry->ipv6);
 		entry->ipv6 = NULL;
@@ -712,7 +711,7 @@ static uint16_t cache_check_validity(char *question, uint16_t type,
 	switch (type) {
 	case 1:		/* IPv4 */
 		if (!cache_check_is_valid(entry->ipv4, current_time)) {
-			debug("cache %s \"%s\" type A", entry->ipv4 ?
+			DBG("cache %s \"%s\" type A", entry->ipv4 ?
 					"timeout" : "entry missing", question);
 
 			if (want_refresh)
@@ -731,7 +730,7 @@ static uint16_t cache_check_validity(char *question, uint16_t type,
 
 	case 28:	/* IPv6 */
 		if (!cache_check_is_valid(entry->ipv6, current_time)) {
-			debug("cache %s \"%s\" type AAAA", entry->ipv6 ?
+			DBG("cache %s \"%s\" type AAAA", entry->ipv6 ?
 					"timeout" : "entry missing", question);
 
 			if (want_refresh)
@@ -777,7 +776,7 @@ static gboolean try_remove_cache(gpointer user_data)
 	cache_timer = 0;
 
 	if (__sync_fetch_and_sub(&cache_refcount, 1) == 1) {
-		debug("No cache users, removing it.");
+		DBG("No cache users, removing it.");
 
 		g_hash_table_destroy(cache);
 		cache = NULL;
@@ -990,7 +989,7 @@ static int parse_response(unsigned char *buf, int buflen,
 	if (buflen < 12)
 		return -EINVAL;
 
-	debug("qr %d qdcount %d", hdr->qr, qdcount);
+	DBG("qr %d qdcount %d", hdr->qr, qdcount);
 
 	/* We currently only cache responses where question count is 1 */
 	if (hdr->qr != 1 || qdcount != 1)
@@ -1236,7 +1235,7 @@ static void cache_cleanup(void)
 		count = g_hash_table_foreach_remove(cache, cache_check_entry,
 						&data);
 	}
-	debug("removed %d in the first pass", count);
+	DBG("removed %d in the first pass", count);
 
 	/*
 	 * In the second pass, if the first pass turned up blank,
@@ -1300,7 +1299,7 @@ static gboolean cache_invalidate_entry(gpointer key, gpointer value,
  */
 static void cache_invalidate(void)
 {
-	debug("Invalidating the DNS cache %p", cache);
+	DBG("Invalidating the DNS cache %p", cache);
 
 	if (!cache)
 		return;
@@ -1332,7 +1331,7 @@ static void cache_refresh_entry(struct cache_entry *entry)
 			*c = '.';
 			c += jump + 1;
 		}
-		debug("Refreshing %s\n", dns_name);
+		DBG("Refreshing %s\n", dns_name);
 		/* then refresh the hostname */
 		refresh_dns_entry(entry, &dns_name[1]);
 	}
@@ -1406,7 +1405,7 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 		next_refresh = current_time + 30;
 	}
 
-	debug("offset %zd hdr %p msg %p rcode %d", offset, hdr, msg, hdr->rcode);
+	DBG("offset %zd hdr %p msg %p rcode %d", offset, hdr, msg, hdr->rcode);
 
 	/* Continue only if response code is 0 (=ok) */
 	if (hdr->rcode != ns_r_noerror)
@@ -1586,7 +1585,7 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 		cache_size++;
 	}
 
-	debug("cache %d %squestion \"%s\" type %d ttl %d size %zd packet %u "
+	DBG("cache %d %squestion \"%s\" type %d ttl %d size %zd packet %u "
 								"dns len %u",
 		cache_size, new_entry ? "new " : "old ",
 		question, type, ttl,
@@ -1612,7 +1611,7 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 		int ttl_left = 0;
 		struct cache_data *data;
 
-		debug("cache hit %s type %s", lookup, type == 1 ? "A" : "AAAA");
+		DBG("cache hit %s type %s", lookup, type == 1 ? "A" : "AAAA");
 		if (type == 1)
 			data = entry->ipv4;
 		else
@@ -1649,7 +1648,7 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 	err = sendto(sk, request, req->request_len, MSG_NOSIGNAL,
 			server->server_addr, server->server_addr_len);
 	if (err < 0) {
-		debug("Cannot send message to server %s sock %d "
+		DBG("Cannot send message to server %s sock %d "
 			"protocol %d (%s/%d)",
 			server->server, sk, server->protocol,
 			strerror(errno), errno);
@@ -1706,7 +1705,7 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 			alt[1] = req_len & 0xff;
 		}
 
-		debug("req %p dstid 0x%04x altid 0x%04x", req, req->dstid,
+		DBG("req %p dstid 0x%04x altid 0x%04x", req, req->dstid,
 				req->altid);
 
 		err = send(sk, alt, req->request_len + domlen, MSG_NOSIGNAL);
@@ -1728,7 +1727,7 @@ static char *convert_label(char *start, char *end, char *ptr, char *uptr,
 	pos = dn_expand((u_char *)start, (u_char *)end, (u_char *)ptr,
 			name, NS_MAXLABEL);
 	if (pos < 0) {
-		debug("uncompress error [%d/%s]", errno, strerror(errno));
+		DBG("uncompress error [%d/%s]", errno, strerror(errno));
 		goto out;
 	}
 
@@ -1738,7 +1737,7 @@ static char *convert_label(char *start, char *end, char *ptr, char *uptr,
 	 */
 	comp_pos = dn_comp(name, (u_char *)uptr, remaining_len, NULL, NULL);
 	if (comp_pos < 0) {
-		debug("compress error [%d/%s]", errno, strerror(errno));
+		DBG("compress error [%d/%s]", errno, strerror(errno));
 		goto out;
 	}
 
@@ -1758,7 +1757,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 	char *uptr = *uncompressed_ptr; /* position in result buffer */
 	char * const uncomp_end = uncompressed + uncomp_len - 1;
 
-	debug("count %d ptr %p end %p uptr %p", field_count, ptr, end, uptr);
+	DBG("count %d ptr %p end %p uptr %p", field_count, ptr, end, uptr);
 
 	while (field_count-- > 0 && ptr < end) {
 		int dlen;		/* data field length */
@@ -1782,7 +1781,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 			goto out;
 		memcpy(uptr, name, ulen);
 
-		debug("pos %d ulen %d left %d name %s", pos, ulen,
+		DBG("pos %d ulen %d left %d name %s", pos, ulen,
 			(int)(uncomp_end - (uptr + ulen)), uptr);
 
 		uptr += ulen;
@@ -1794,7 +1793,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 		 * ttl, address length and the address)
 		 */
 		if ((uptr + NS_RRFIXEDSZ) > uncomp_end) {
-			debug("uncompressed data too large for buffer");
+			DBG("uncompressed data too large for buffer");
 			goto out;
 		}
 		memcpy(uptr, ptr, NS_RRFIXEDSZ);
@@ -1829,7 +1828,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 			dlen = uptr[-2] << 8 | uptr[-1];
 
 			if ((ptr + dlen) > end || (uptr + dlen) > uncomp_end) {
-				debug("data len %d too long", dlen);
+				DBG("data len %d too long", dlen);
 				goto out;
 			}
 
@@ -1868,7 +1867,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 			 * limit and minimum ttl). They are 20 bytes long.
 			 */
 			if ((uptr + 20) > uncomp_end || (ptr + 20) > end) {
-				debug("soa record too long");
+				DBG("soa record too long");
 				goto out;
 			}
 			memcpy(uptr, ptr, 20);
@@ -1949,13 +1948,13 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 	hdr = (void *)(reply + offset);
 	dns_id = reply[offset] | reply[offset + 1] << 8;
 
-	debug("Received %d bytes (id 0x%04x)", reply_len, dns_id);
+	DBG("Received %d bytes (id 0x%04x)", reply_len, dns_id);
 
 	req = find_request(dns_id);
 	if (!req)
 		return -EINVAL;
 
-	debug("req %p dstid 0x%04x altid 0x%04x rcode %d",
+	DBG("req %p dstid 0x%04x altid 0x%04x rcode %d",
 			req, req->dstid, req->altid, hdr->rcode);
 
 	reply[offset] = req->srcid & 0xff;
@@ -2021,7 +2020,7 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 							ptr[dns_type_pos + 3];
 			if (dns_type != ns_t_a && dns_type != ns_t_aaaa &&
 					dns_class != ns_c_in) {
-				debug("Pass msg dns type %d class %d",
+				DBG("Pass msg dns type %d class %d",
 					dns_type, dns_class);
 				goto pass;
 			}
@@ -2116,7 +2115,7 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 				new_len = strip_domains(uncompressed, answers,
 							uptr - answers);
 				if (new_len < 0) {
-					debug("Corrupted packet");
+					DBG("Corrupted packet");
 					return -EINVAL;
 				}
 
@@ -2184,10 +2183,10 @@ out:
 	}
 
 	if (err < 0)
-		debug("Cannot send msg, sk %d proto %d errno %d/%s", sk,
+		DBG("Cannot send msg, sk %d proto %d errno %d/%s", sk,
 			protocol, errno, strerror(errno));
 	else
-		debug("proto %d sent %d bytes to %d", protocol, err, sk);
+		DBG("proto %d sent %d bytes to %d", protocol, err, sk);
 
 	destroy_request_data(req);
 
@@ -2196,7 +2195,7 @@ out:
 
 static void server_destroy_socket(struct server_data *data)
 {
-	debug("index %d server %s proto %d", data->index,
+	DBG("index %d server %s proto %d", data->index,
 					data->server, data->protocol);
 
 	if (data->watch > 0) {
@@ -2221,7 +2220,7 @@ static void server_destroy_socket(struct server_data *data)
 
 static void destroy_server(struct server_data *server)
 {
-	debug("index %d server %s sock %d", server->index, server->server,
+	DBG("index %d server %s sock %d", server->index, server->server,
 			server->channel ?
 			g_io_channel_unix_get_fd(server->channel): -1);
 
@@ -2229,7 +2228,7 @@ static void destroy_server(struct server_data *server)
 	server_destroy_socket(server);
 
 	if (server->protocol == IPPROTO_UDP && server->enabled)
-		debug("Removing DNS server %s", server->server);
+		DBG("Removing DNS server %s", server->server);
 
 	g_free(server->server);
 	g_list_free_full(server->domains, g_free);
@@ -2285,7 +2284,7 @@ static gboolean tcp_server_event(GIOChannel *channel, GIOCondition condition,
 	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		GSList *list;
 hangup:
-		debug("TCP server channel closed, sk %d", sk);
+		DBG("TCP server channel closed, sk %d", sk);
 
 		/*
 		 * Discard any partial response which is buffered; better
@@ -2340,7 +2339,7 @@ hangup:
 						domains = domains->next) {
 				char *dom = domains->data;
 
-				debug("Adding domain %s to %s",
+				DBG("Adding domain %s to %s",
 						dom, server->server);
 
 				server->domains = g_list_append(server->domains,
@@ -2372,7 +2371,7 @@ hangup:
 				continue;
 			}
 
-			debug("Sending req %s over TCP", (char *)req->name);
+			DBG("Sending req %s over TCP", (char *)req->name);
 
 			status = ns_resolv(server, req,
 						req->request, req->name);
@@ -2431,7 +2430,7 @@ hangup:
 			reply_len = reply_len_buf[1] | reply_len_buf[0] << 8;
 			reply_len += 2;
 
-			debug("TCP reply %d bytes from %d", reply_len, sk);
+			DBG("TCP reply %d bytes from %d", reply_len, sk);
 
 			reply = g_try_malloc(sizeof(*reply) + reply_len + 2);
 			if (!reply)
@@ -2478,7 +2477,7 @@ static gboolean tcp_idle_timeout(gpointer user_data)
 {
 	struct server_data *server = user_data;
 
-	debug("");
+	DBG("");
 
 	if (!server)
 		return FALSE;
@@ -2493,7 +2492,7 @@ static int server_create_socket(struct server_data *data)
 	int sk, err;
 	char *interface;
 
-	debug("index %d server %s proto %d", data->index,
+	DBG("index %d server %s proto %d", data->index,
 					data->server, data->protocol);
 
 	sk = socket(data->server_addr->sa_family,
@@ -2507,7 +2506,7 @@ static int server_create_socket(struct server_data *data)
 		return -err;
 	}
 
-	debug("sk %d", sk);
+	DBG("sk %d", sk);
 
 	interface = connman_inet_ifname(data->index);
 	if (interface) {
@@ -2695,7 +2694,7 @@ static bool resolv(struct request_data *req,
 			continue;
 		}
 
-		debug("server %s enabled %d", data->server, data->enabled);
+		DBG("server %s enabled %d", data->server, data->enabled);
 
 		if (!data->enabled)
 			continue;
@@ -3018,7 +3017,7 @@ static int parse_request(unsigned char *buf, size_t len,
 	if (!name || !size)
 		return -EINVAL;
 
-	debug("id 0x%04x qr %d opcode %d qdcount %d arcount %d",
+	DBG("id 0x%04x qr %d opcode %d qdcount %d arcount %d",
 					hdr->id, hdr->qr, hdr->opcode,
 							qdcount, arcount);
 
@@ -3072,7 +3071,7 @@ static int parse_request(unsigned char *buf, size_t len,
 		DBG("DNS request with %d garbage bytes", remain);
 	}
 
-	debug("query %s", name);
+	DBG("query %s", name);
 
 	return 0;
 }
@@ -3083,7 +3082,7 @@ static void client_reset(struct tcp_partial_client_data *client)
 		return;
 
 	if (client->channel) {
-		debug("client %d closing",
+		DBG("client %d closing",
 			g_io_channel_unix_get_fd(client->channel));
 
 		g_io_channel_unref(client->channel);
@@ -3127,14 +3126,14 @@ static bool read_tcp_data(struct tcp_partial_client_data *client,
 	client_sk = g_io_channel_unix_get_fd(client->channel);
 
 	if (read_len == 0) {
-		debug("client %d closed, pending %d bytes",
+		DBG("client %d closed, pending %d bytes",
 			client_sk, client->buf_end);
 		g_hash_table_remove(partial_tcp_req_table,
 					GINT_TO_POINTER(client_sk));
 		return false;
 	}
 
-	debug("client %d received %d bytes", client_sk, read_len);
+	DBG("client %d received %d bytes", client_sk, read_len);
 
 	client->buf_end += read_len;
 
@@ -3143,24 +3142,24 @@ static bool read_tcp_data(struct tcp_partial_client_data *client,
 
 	msg_len = get_msg_len(client->buf);
 	if (msg_len > TCP_MAX_BUF_LEN) {
-		debug("client %d sent too much data %d", client_sk, msg_len);
+		DBG("client %d sent too much data %d", client_sk, msg_len);
 		g_hash_table_remove(partial_tcp_req_table,
 					GINT_TO_POINTER(client_sk));
 		return false;
 	}
 
 read_another:
-	debug("client %d msg len %d end %d past end %d", client_sk, msg_len,
+	DBG("client %d msg len %d end %d past end %d", client_sk, msg_len,
 		client->buf_end, client->buf_end - (msg_len + 2));
 
 	if (client->buf_end < (msg_len + 2)) {
-		debug("client %d still missing %d bytes",
+		DBG("client %d still missing %d bytes",
 			client_sk,
 			msg_len + 2 - client->buf_end);
 		return true;
 	}
 
-	debug("client %d all data %d received", client_sk, msg_len);
+	DBG("client %d all data %d received", client_sk, msg_len);
 
 	err = parse_request(client->buf + 2, msg_len,
 			query, sizeof(query));
@@ -3201,7 +3200,7 @@ read_another:
 		int ttl_left = 0;
 		struct cache_data *data;
 
-		debug("cache hit %s type %s", query, qtype == 1 ? "A" : "AAAA");
+		DBG("cache hit %s type %s", query, qtype == 1 ? "A" : "AAAA");
 		if (qtype == 1)
 			data = entry->ipv4;
 		else
@@ -3218,7 +3217,7 @@ read_another:
 			g_free(req);
 			goto out;
 		} else
-			debug("data missing, ignoring cache for this query");
+			DBG("data missing, ignoring cache for this query");
 	}
 
 	for (list = server_list; list; list = list->next) {
@@ -3273,7 +3272,7 @@ read_another:
 
 out:
 	if (client->buf_end > (msg_len + 2)) {
-		debug("client %d buf %p -> %p end %d len %d new %d",
+		DBG("client %d buf %p -> %p end %d len %d new %d",
 			client_sk,
 			client->buf + msg_len + 2,
 			client->buf, client->buf_end,
@@ -3289,12 +3288,12 @@ out:
 		 */
 		msg_len = get_msg_len(client->buf);
 		if ((msg_len + 2) == client->buf_end) {
-			debug("client %d reading another %d bytes", client_sk,
+			DBG("client %d reading another %d bytes", client_sk,
 								msg_len + 2);
 			goto read_another;
 		}
 	} else {
-		debug("client %d clearing reading buffer", client_sk);
+		DBG("client %d clearing reading buffer", client_sk);
 
 		client->buf_end = 0;
 		memset(client->buf, 0, TCP_MAX_BUF_LEN);
@@ -3356,7 +3355,7 @@ static gboolean tcp_client_event(GIOChannel *channel, GIOCondition condition,
 		if (errno == EAGAIN || errno == EWOULDBLOCK)
 			return TRUE;
 
-		debug("client %d cannot read errno %d/%s", client_sk, -errno,
+		DBG("client %d cannot read errno %d/%s", client_sk, -errno,
 			strerror(errno));
 		g_hash_table_remove(partial_tcp_req_table,
 					GINT_TO_POINTER(client_sk));
@@ -3373,7 +3372,7 @@ static gboolean client_timeout(gpointer user_data)
 
 	sock = g_io_channel_unix_get_fd(client->channel);
 
-	debug("client %d timeout pending %d bytes", sock, client->buf_end);
+	DBG("client %d timeout pending %d bytes", sock, client->buf_end);
 
 	g_hash_table_remove(partial_tcp_req_table, GINT_TO_POINTER(sock));
 
@@ -3396,7 +3395,7 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 	struct timeval tv;
 	fd_set readfds;
 
-	debug("condition 0x%02x channel %p ifdata %p family %d",
+	DBG("condition 0x%02x channel %p ifdata %p family %d",
 		condition, channel, ifdata, family);
 
 	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
@@ -3426,9 +3425,9 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 	select(sk + 1, &readfds, NULL, NULL, &tv);
 	if (FD_ISSET(sk, &readfds)) {
 		client_sk = accept(sk, client_addr, client_addr_len);
-		debug("client %d accepted", client_sk);
+		DBG("client %d accepted", client_sk);
 	} else {
-		debug("No data to read from master %d, waiting.", sk);
+		DBG("No data to read from master %d, waiting.", sk);
 		return true;
 	}
 
@@ -3462,9 +3461,9 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 
 		client->ifdata = ifdata;
 
-		debug("client %d created %p", client_sk, client);
+		DBG("client %d created %p", client_sk, client);
 	} else {
-		debug("client %d already exists %p", client_sk, client);
+		DBG("client %d already exists %p", client_sk, client);
 	}
 
 	if (!client->buf) {
@@ -3488,11 +3487,11 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 	len = recv(client_sk, client->buf, TCP_MAX_BUF_LEN, 0);
 	if (len < 0) {
 		if (errno == EAGAIN || errno == EWOULDBLOCK) {
-			debug("client %d no data to read, waiting", client_sk);
+			DBG("client %d no data to read, waiting", client_sk);
 			return true;
 		}
 
-		debug("client %d cannot read errno %d/%s", client_sk, -errno,
+		DBG("client %d cannot read errno %d/%s", client_sk, -errno,
 			strerror(errno));
 		g_hash_table_remove(partial_tcp_req_table,
 					GINT_TO_POINTER(client_sk));
@@ -3500,14 +3499,14 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 	}
 
 	if (len < 2) {
-		debug("client %d not enough data to read, waiting", client_sk);
+		DBG("client %d not enough data to read, waiting", client_sk);
 		client->buf_end += len;
 		return true;
 	}
 
 	msg_len = get_msg_len(client->buf);
 	if (msg_len > TCP_MAX_BUF_LEN) {
-		debug("client %d invalid message length %u ignoring packet",
+		DBG("client %d invalid message length %u ignoring packet",
 			client_sk, msg_len);
 		g_hash_table_remove(partial_tcp_req_table,
 					GINT_TO_POINTER(client_sk));
@@ -3519,7 +3518,7 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 	 * that is the reason to -2 below.
 	 */
 	if (msg_len != (unsigned int)(len - 2)) {
-		debug("client %d sent %d bytes but expecting %u pending %d",
+		DBG("client %d sent %d bytes but expecting %u pending %d",
 			client_sk, len, msg_len + 2, msg_len + 2 - len);
 
 		client->buf_end += len;
@@ -3583,7 +3582,7 @@ static bool udp_listener_event(GIOChannel *channel, GIOCondition condition,
 	if (len < 2)
 		return true;
 
-	debug("Received %d bytes (id 0x%04x)", len, buf[0] | buf[1] << 8);
+	DBG("Received %d bytes (id 0x%04x)", len, buf[0] | buf[1] << 8);
 
 	err = parse_request(buf, len, query, sizeof(query));
 	if (err < 0 || (g_slist_length(server_list) == 0)) {
@@ -3660,7 +3659,7 @@ static GIOChannel *get_listener(int family, int protocol, int index)
 	int sk, type;
 	char *interface;
 
-	debug("family %d protocol %d index %d", family, protocol, index);
+	DBG("family %d protocol %d index %d", family, protocol, index);
 
 	switch (protocol) {
 	case IPPROTO_UDP:
@@ -3895,7 +3894,7 @@ static void destroy_listener(struct listener_data *ifdata)
 	for (list = request_list; list; list = list->next) {
 		struct request_data *req = list->data;
 
-		debug("Dropping request (id 0x%04x -> 0x%04x)",
+		DBG("Dropping request (id 0x%04x -> 0x%04x)",
 						req->srcid, req->dstid);
 		destroy_request_data(req);
 		list->data = NULL;
-- 
2.25.1

