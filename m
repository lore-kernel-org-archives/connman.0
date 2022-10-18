Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C62591
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:13 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA2BF20629
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666082891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oX8suDEitCqh0OzWj5axkhW5VrbOoeRn+D2LaXqGlsA=;
	b=FAtk40dOhOqPpQdfY0GcsSH/QsGMMBHUDNXtazCEkONzLQ07jE/38BdFoK+EWTDNcCkPAy
	me/r3B4XCB1AesCGImI+efZAC+qOxI7oEQmW0/ad5GUdD6rS0XdZcKNMXzdJpzlTD9GdH/
	XiCzdCRIQBcAYG8eenRBGI3z/WsrMho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666082891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oX8suDEitCqh0OzWj5axkhW5VrbOoeRn+D2LaXqGlsA=;
	b=R2mBpJfopDsKfpUeT3+lx2OLzZlFOwvyQgM0t816XHGgyTyIWG1ibfvEs3YehAm4HZ7hNc
	F4xPgi35vVlUrXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A378D139D2
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id q1HkJ0toTmPDcAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:11 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 16/16] dnsproxy: fix compiler warnings (differing signedness, empty format string)
Date: Tue, 18 Oct 2022 10:47:46 +0200
Message-Id: <20221018084746.21959-17-matthias.gerstner@suse.de>
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

There are some invocations of functions with implicit casts from
signed/unsigned char or vice versa. This has been inconsisent in the
beginning and future refactoring should choose a harmonized data type
for message buffers, maybe something like `uint8_t*`.
---
 src/dnsproxy.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 9ab4a6742..5d6e69cf6 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1362,10 +1362,10 @@ static void cache_refresh(void)
 	g_hash_table_foreach(cache, cache_refresh_iterator, NULL);
 }
 
-static int reply_query_type(const unsigned char *msg, int len)
+static int reply_query_type(const char *msg, size_t len)
 {
 	/* skip the header */
-	const unsigned char *c = msg + DNS_HEADER_SIZE;
+	const unsigned char *c = (const unsigned char*)msg + DNS_HEADER_SIZE;
 	len -= DNS_HEADER_SIZE;
 
 	if (len < 0)
@@ -1416,7 +1416,8 @@ static int cache_update(struct server_data *srv, const char *msg, size_t msg_len
 	question[sizeof(question) - 1] = '\0';
 	int ttl = 0;
 	uint16_t answers = 0, type = 0, class = 0;
-	const int err = parse_response(msg + offset, msg_len - offset,
+	const int err = parse_response(
+				(unsigned char*)(msg + offset), msg_len - offset,
 				question, sizeof(question) - 1,
 				&type, &class, &ttl,
 				response, &rsplen, &answers);
@@ -2293,7 +2294,7 @@ static void destroy_server(struct server_data *server)
 static gboolean udp_server_event(GIOChannel *channel, GIOCondition condition,
 							gpointer user_data)
 {
-	unsigned char buf[4096];
+	char buf[4096];
 	struct server_data *data = user_data;
 
 	if (condition & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
@@ -2508,14 +2509,14 @@ hangup:
 		}
 
 		struct request_data *req = lookup_request(
-				reply->buf, reply->received, IPPROTO_TCP);
+				(const char*)reply->buf, reply->received, IPPROTO_TCP);
 
 		if (!req)
 			/* invalid / corrupt request */
 			return TRUE;
 
 		const int res = forward_dns_reply(
-			reply->buf, reply->received, IPPROTO_TCP, server, req);
+			(char*)reply->buf, reply->received, IPPROTO_TCP, server, req);
 
 		g_free(reply);
 		server->incoming_reply = NULL;
@@ -2542,7 +2543,7 @@ static gboolean tcp_idle_timeout(gpointer user_data)
 {
 	struct server_data *server = user_data;
 
-	debug("");
+	debug("\n");
 
 	if (!server)
 		return FALSE;
-- 
2.37.3

