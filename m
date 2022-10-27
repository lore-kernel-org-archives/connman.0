Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126E91C2B
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:23 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80AF622679
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAjvpOQg8Vc6+No7syaYBaEAeBIb5+AHQsMNlFwNLGI=;
	b=1OvOQMtp4rjYwTttrinzZl9T8dlUdsZbpdqSEU/OjsUSW+B5npbLUSNGxh0gG/CzRdYdrk
	0FvqSOkt6gc9+LMC7NcxIEQR9j9b4B7MoZmodVLZ1KI6ay3efGnG9sgTewJTKhouiObGFq
	j8QiRDl+rzXMPTWwfUF3AWxM1NO+Cgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAjvpOQg8Vc6+No7syaYBaEAeBIb5+AHQsMNlFwNLGI=;
	b=Zo0TsI13OVHvLl8ifzkk6HUr4Dtb4SumO0duDiCJ+xLdAXRklwMKsMwH7i+uMsnK5f0ujU
	+hhPr2IvQFtpzdAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 796E0134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Y3GhHXFeWmMLBQAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:21 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 14/16] dnsproxy: fix TCP server reply handling if domain name is appended
Date: Thu, 27 Oct 2022 12:32:57 +0200
Message-Id: <20221027103258.29129-15-matthias.gerstner@suse.de>
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

The code path for TCP if the domain name is attached never worked. There
is a bug in the `hdr` pointer calculation in `ns_resolv`. Furthermore if
the first response from the server is negative or erroneous then the TCP
connection is terminated unconditionally, even if further responses are
pending.

This change splits off the initial part of forward_dns_reply() into a
new lookup_request() function. The information from the request_data
structure is used by the UDP and TCP processing code to determine
whether to keep the request (and TCP connection) around or not.
Furthermore errors in the `alt` message creation are fixed.
---
 src/dnsproxy.c | 106 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 73 insertions(+), 33 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index d31ccd571..5e2df1000 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1703,10 +1703,9 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 	for (GList *list = server->domains; list; list = list->next) {
 		int domlen, altlen;
 		unsigned char alt[1024];
-		/* TODO: is this a bug? the offset isn't considered here... */
-		struct domain_hdr *hdr = (void *) &alt;
 		const char *domain = list->data;
 		const size_t offset = protocol_offset(server->protocol);
+		struct domain_hdr *hdr = (void *) (&alt[0] + offset);
 
 		if (!domain)
 			continue;
@@ -1718,10 +1717,10 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 
 		memcpy(alt + offset, &req->altid, sizeof(req->altid));
 
-		memcpy(alt + offset + 2, request + offset + 2, 10);
+		memcpy(alt + offset + 2, request + offset + 2, DNS_HEADER_SIZE - 2);
 		hdr->qdcount = htons(1);
 
-		altlen = append_query(alt + offset + DNS_HEADER_SIZE, sizeof(alt) - DNS_HEADER_SIZE,
+		altlen = append_query(alt + offset + DNS_HEADER_SIZE, sizeof(alt) - DNS_HEADER_SIZE - offset,
 					name, domain);
 		if (altlen < 0)
 			return -EINVAL;
@@ -2147,31 +2146,41 @@ static int dns_reply_fixup_domains(
 	return reply_len;
 }
 
-static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
-				struct server_data *data)
+static struct request_data* lookup_request(
+		const unsigned char *reply, size_t len, int protocol)
 {
 	const size_t offset = protocol_offset(protocol);
 	struct request_data *req;
 	struct domain_hdr *hdr = (void *)(reply + offset);
-	int err, sk;
 
-	debug("Received %zd bytes (id 0x%04x)", reply_len, hdr->id);
+	debug("Received %zd bytes (id 0x%04x)", len, hdr->id);
 
-	if (reply_len < sizeof(struct domain_hdr) + offset)
-		return -EINVAL;
+	if (len < sizeof(struct domain_hdr) + offset)
+		return NULL;
 
 	req = find_request(hdr->id);
+
 	if (!req)
-		return -EINVAL;
+		return NULL;
 
 	debug("req %p dstid 0x%04x altid 0x%04x rcode %d",
 			req, req->dstid, req->altid, hdr->rcode);
 
+	req->numresp++;
+
+	return req;
+}
+
+static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
+			struct server_data *data, struct request_data *req)
+{
+	const size_t offset = protocol_offset(protocol);
+	struct domain_hdr *hdr = (void *)(reply + offset);
+	int err, sk;
+
 	/* replace with original request ID from our client */
 	hdr->id = req->srcid;
 
-	req->numresp++;
-
 	if (hdr->rcode == ns_r_noerror || !req->resp) {
 		/*
 		 * If the domain name was appended remove it before forwarding
@@ -2248,8 +2257,6 @@ static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
 	else
 		debug("proto %d sent %d bytes to %d", protocol, err, sk);
 
-	destroy_request_data(req);
-
 	return err;
 }
 
@@ -2313,9 +2320,10 @@ static gboolean udp_server_event(GIOChannel *channel, GIOCondition condition,
 							gpointer user_data)
 {
 	unsigned char buf[4096];
-	int sk;
+	int sk, res;
 	ssize_t len;
 	struct server_data *data = user_data;
+	struct request_data *req;
 
 	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		connman_error("Error with UDP server %s", data->server);
@@ -2326,9 +2334,20 @@ static gboolean udp_server_event(GIOChannel *channel, GIOCondition condition,
 	sk = g_io_channel_unix_get_fd(channel);
 	len = recv(sk, buf, sizeof(buf), 0);
 
-	if (len > 0) {
-		forward_dns_reply((char*)buf, len, IPPROTO_UDP, data);
-	}
+	if (len <= 0)
+		return TRUE;
+
+	req = lookup_request(buf, len, IPPROTO_UDP);
+
+	if (!req)
+		/* invalid / corrupt request */
+		return TRUE;
+
+	res = forward_dns_reply((char*)buf, len, IPPROTO_UDP, data, req);
+
+	/* on success or no further responses are expected, destroy the req */
+	if (res == 0 || req->numresp >= req->numserv)
+		destroy_request_data(req);
 
 	return TRUE;
 }
@@ -2336,6 +2355,7 @@ static gboolean udp_server_event(GIOChannel *channel, GIOCondition condition,
 static gboolean tcp_server_event(GIOChannel *channel, GIOCondition condition,
 							gpointer user_data)
 {
+	struct request_data *req;
 	struct server_data *server = user_data;
 	int sk = g_io_channel_unix_get_fd(channel);
 	if (sk == 0)
@@ -2355,8 +2375,8 @@ hangup:
 
 		list = request_list;
 		while (list) {
-			struct request_data *req = list->data;
 			struct domain_hdr *hdr;
+			req = list->data;
 			list = list->next;
 
 			if (req->protocol == IPPROTO_UDP)
@@ -2422,7 +2442,7 @@ hangup:
 		 * need to delete elements while iterating through it */
 		for (GSList *list = request_list; list; ) {
 			int status;
-			struct request_data *req = list->data;
+			req = list->data;
 
 			if (req->protocol == IPPROTO_UDP) {
 				list = list->next;
@@ -2465,6 +2485,7 @@ hangup:
 	} else if (condition & G_IO_IN) {
 		struct partial_reply *reply = server->incoming_reply;
 		int bytes_recv;
+		int res;
 
 		if (!reply) {
 			uint16_t reply_len;
@@ -2479,7 +2500,7 @@ hangup:
 				connman_error("DNS proxy error %s",
 						strerror(errno));
 				goto hangup;
-			} else if (bytes_recv < 2)
+			} else if (bytes_recv < sizeof(reply_len))
 				return TRUE;
 
 			/* the header contains the length of the message
@@ -2493,6 +2514,8 @@ hangup:
 				return TRUE;
 
 			reply->len = reply_len;
+			/* we only peeked the two length bytes, so we have to
+			   receive the complete message below proper. */
 			reply->received = 0;
 
 			server->incoming_reply = reply;
@@ -2515,15 +2538,30 @@ hangup:
 			reply->received += bytes_recv;
 		}
 
-		forward_dns_reply((char*)reply->buf, reply->received, IPPROTO_TCP,
-					server);
+		req = lookup_request(reply->buf, reply->received, IPPROTO_TCP);
+
+		if (!req)
+			/* invalid / corrupt request */
+			return TRUE;
+
+		res = forward_dns_reply((char*)reply->buf, reply->received, IPPROTO_TCP, server, req);
 
 		g_free(reply);
 		server->incoming_reply = NULL;
 
-		destroy_server(server);
+		/* on success or if no further responses are expected close
+		 * connection */
+		if (res == 0 || req->numresp >= req->numserv) {
+			destroy_request_data(req);
+			destroy_server(server);
+			return FALSE;
+		}
 
-		return FALSE;
+		/*
+		 * keep the TCP connection open, there are more
+		 * requests to be answered
+		 */
+		return TRUE;
 	}
 
 	return TRUE;
@@ -3170,7 +3208,7 @@ static bool read_tcp_data(struct tcp_partial_client_data *client,
 	client->buf_end += read_len;
 
 	/* we need at least the message length header */
-	if (client->buf_end < 2)
+	if (client->buf_end < DNS_HEADER_TCP_EXTRA_BYTES)
 		return true;
 
 	msg_len = get_msg_len(client->buf);
@@ -3194,9 +3232,11 @@ read_another:
 
 	debug("client %d all data %zd received", client_sk, msg_len);
 
-	err = parse_request(client->buf + 2, msg_len, query, sizeof(query));
+	err = parse_request(client->buf + DNS_HEADER_TCP_EXTRA_BYTES,
+			msg_len, query, sizeof(query));
 	if (err < 0 || (g_slist_length(server_list) == 0)) {
-		send_response(client_sk, client->buf, msg_len + 2,
+		send_response(client_sk, client->buf,
+			msg_len + DNS_HEADER_TCP_EXTRA_BYTES,
 			NULL, 0, IPPROTO_TCP);
 		return true;
 	}
@@ -3211,12 +3251,12 @@ read_another:
 	req->protocol = IPPROTO_TCP;
 	req->family = client->family;
 
-	hdr = (void*)(client->buf + 2);
+	hdr = (void*)(client->buf + DNS_HEADER_TCP_EXTRA_BYTES);
 
 	memcpy(&req->srcid, &hdr->id, sizeof(req->srcid));
 	req->dstid = get_id();
 	req->altid = get_id();
-	req->request_len = msg_len + 2;
+	req->request_len = msg_len + DNS_HEADER_TCP_EXTRA_BYTES;
 
 	/* replace ID the request for forwarding */
 	memcpy(&hdr->id, &req->dstid, sizeof(hdr->id));
@@ -3300,7 +3340,7 @@ read_another:
 	request_list = g_slist_append(request_list, req);
 
 out:
-	if (client->buf_end > (msg_len + 2)) {
+	if (client->buf_end > (msg_len + DNS_HEADER_TCP_EXTRA_BYTES)) {
 		debug("client %d buf %p -> %p end %d len %d new %zd",
 			client_sk,
 			client->buf + msg_len + 2,
@@ -3524,7 +3564,7 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 		return true;
 	}
 
-	if (recv_len < 2) {
+	if (recv_len < DNS_HEADER_TCP_EXTRA_BYTES) {
 		debug("client %d not enough data to read, waiting", client_sk);
 		client->buf_end += recv_len;
 		return true;
-- 
2.37.3

