Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB74210C
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:38 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2B61FE21
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654864417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbSBBthcHkjrCBTc5CA0cP1LTn3lTPg0X2RrGkq0+uU=;
	b=LBwjZa1m51gt4NZYlp6YCgyJqIWdOlIOLnwZXoMCJuazEWz/aOKRi/E1sDo07T9HyALVCJ
	z8BSGPootuL4VJw12ebixNgAXLhtEEXVyFkbe91SoUlQHjff9jALbyv2vbSdwhfZOhgC8n
	Le6APYcxRegx5DC66ncA+jLm+uiN+Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654864417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JbSBBthcHkjrCBTc5CA0cP1LTn3lTPg0X2RrGkq0+uU=;
	b=R6r5RQpz/4j12ylIod2OZrzR4/9LoLTMuYg1w6VU22JsfYzhRgW3ZljjI5e272qWPnxq6L
	29zAj3QUOQIb48Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06FCA139ED
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 5JyxASE6o2KSMgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:37 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 13/16] dnsproxy: fix TCP server reply handling if domain name is appended
Date: Fri, 10 Jun 2022 14:33:20 +0200
Message-Id: <20220610123323.8974-14-matthias.gerstner@suse.de>
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
 src/dnsproxy.c | 98 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 30 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 758337ec2..1371cbe36 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1688,15 +1688,14 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 
 		const size_t offset = protocol_offset(server->protocol);
 		unsigned char alt[1024];
-		/* TODO: is this a bug? the offset isn't considered here... */
-		struct domain_hdr *hdr = (void *) &alt;
+		struct domain_hdr *hdr = (void *) (&alt[0] + offset);
 
 		memcpy(alt + offset, &req->altid, sizeof(req->altid));
 
-		memcpy(alt + offset + 2, request + offset + 2, 10);
+		memcpy(alt + offset + 2, request + offset + 2, DNS_HEADER_SIZE - 2);
 		hdr->qdcount = htons(1);
 
-		int altlen = append_query(alt + offset + DNS_HEADER_SIZE, sizeof(alt) - DNS_HEADER_SIZE,
+		int altlen = append_query(alt + offset + DNS_HEADER_SIZE, sizeof(alt) - DNS_HEADER_SIZE - offset,
 					name, domain);
 		if (altlen < 0)
 			return -EINVAL;
@@ -2118,29 +2117,39 @@ static int dns_reply_fixup_domains(
 	return reply_len;
 }
 
-static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
-				struct server_data *data)
+static struct request_data* lookup_request(
+		const char *reply, size_t len, int protocol)
 {
 	const size_t offset = protocol_offset(protocol);
 	struct domain_hdr *hdr = (void *)(reply + offset);
 
-	debug("Received %zd bytes (id 0x%04x)", reply_len, hdr->id);
+	debug("Received %zd bytes (id 0x%04x)", len, hdr->id);
 
-	if (reply_len < sizeof(struct domain_hdr) + offset)
-		return -EINVAL;
+	if (len < sizeof(struct domain_hdr) + offset)
+		return NULL;
 
 	struct request_data *req = find_request(hdr->id);
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
+
 	/* replace with original request ID from our client */
 	hdr->id = req->srcid;
 
-	req->numresp++;
-
 	if (hdr->rcode == ns_r_noerror || !req->resp) {
 		/*
 		 * If the domain name was appended remove it before forwarding
@@ -2219,8 +2228,6 @@ static int forward_dns_reply(char *reply, size_t reply_len, int protocol,
 	else
 		debug("proto %d sent %d bytes to %d", protocol, err, sk);
 
-	destroy_request_data(req);
-
 	return err;
 }
 
@@ -2295,9 +2302,20 @@ static gboolean udp_server_event(GIOChannel *channel, GIOCondition condition,
 	int sk = g_io_channel_unix_get_fd(channel);
 	ssize_t len = recv(sk, buf, sizeof(buf), 0);
 
-	if (len > 0) {
-		forward_dns_reply(buf, len, IPPROTO_UDP, data);
-	}
+	if (len <= 0)
+		return TRUE;
+
+	struct request_data *req = lookup_request(buf, len, IPPROTO_UDP);
+
+	if (!req)
+		/* invalid / corrupt request */
+		return TRUE;
+
+	const int res = forward_dns_reply(buf, len, IPPROTO_UDP, data, req);
+
+	/* on success or no further responses are expected, destroy the req */
+	if (res == 0 || req->numresp >= req->numserv)
+		destroy_request_data(req);
 
 	return TRUE;
 }
@@ -2448,7 +2466,7 @@ hangup:
 				connman_error("DNS proxy error %s",
 						strerror(errno));
 				goto hangup;
-			} else if (bytes_recv < 2)
+			} else if (bytes_recv < sizeof(reply_len))
 				return TRUE;
 
 			/* the header contains the length of the message
@@ -2462,6 +2480,8 @@ hangup:
 				return TRUE;
 
 			reply->len = reply_len;
+			/* we only peeked the two length bytes, so we have to
+			   receive the complete message below proper. */
 			reply->received = 0;
 
 			server->incoming_reply = reply;
@@ -2484,15 +2504,32 @@ hangup:
 			reply->received += bytes_recv;
 		}
 
-		forward_dns_reply(reply->buf, reply->received, IPPROTO_TCP,
-					server);
+		struct request_data *req = lookup_request(
+				reply->buf, reply->received, IPPROTO_TCP);
+
+		if (!req)
+			/* invalid / corrupt request */
+			return TRUE;
+
+		const int res = forward_dns_reply(
+			reply->buf, reply->received, IPPROTO_TCP, server, req);
 
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
@@ -3122,7 +3159,7 @@ static bool read_tcp_data(struct tcp_partial_client_data *client,
 	client->buf_end += read_len;
 
 	/* we need at least the message length header */
-	if (client->buf_end < 2)
+	if (client->buf_end < DNS_HEADER_TCP_EXTRA_BYTES)
 		return true;
 
 	size_t msg_len = get_msg_len(client->buf);
@@ -3146,10 +3183,11 @@ read_another:
 
 	debug("client %d all data %zd received", client_sk, msg_len);
 
-	const int err = parse_request(client->buf + 2, msg_len,
-			query, sizeof(query));
+	const int err = parse_request(client->buf + DNS_HEADER_TCP_EXTRA_BYTES,
+			msg_len, query, sizeof(query));
 	if (err < 0 || (g_slist_length(server_list) == 0)) {
-		send_response(client_sk, client->buf, msg_len + 2,
+		send_response(client_sk, client->buf,
+			msg_len + DNS_HEADER_TCP_EXTRA_BYTES,
 			NULL, 0, IPPROTO_TCP);
 		return true;
 	}
@@ -3164,12 +3202,12 @@ read_another:
 	req->protocol = IPPROTO_TCP;
 	req->family = client->family;
 
-	struct domain_hdr *hdr = (void*)(client->buf + 2);
+	struct domain_hdr *hdr = (void*)(client->buf + DNS_HEADER_TCP_EXTRA_BYTES);
 
 	memcpy(&req->srcid, &hdr->id, sizeof(req->srcid));
 	req->dstid = get_id();
 	req->altid = get_id();
-	req->request_len = msg_len + 2;
+	req->request_len = msg_len + DNS_HEADER_TCP_EXTRA_BYTES;
 
 	/* replace ID the request for forwarding */
 	memcpy(&hdr->id, &req->dstid, sizeof(hdr->id));
@@ -3256,7 +3294,7 @@ read_another:
 	request_list = g_slist_append(request_list, req);
 
 out:
-	if (client->buf_end > (msg_len + 2)) {
+	if (client->buf_end > (msg_len + DNS_HEADER_TCP_EXTRA_BYTES)) {
 		debug("client %d buf %p -> %p end %d len %d new %zd",
 			client_sk,
 			client->buf + msg_len + 2,
@@ -3476,7 +3514,7 @@ static bool tcp_listener_event(GIOChannel *channel, GIOCondition condition,
 		return true;
 	}
 
-	if (len < 2) {
+	if (len < DNS_HEADER_TCP_EXTRA_BYTES) {
 		debug("client %d not enough data to read, waiting", client_sk);
 		client->buf_end += len;
 		return true;
-- 
2.35.1

