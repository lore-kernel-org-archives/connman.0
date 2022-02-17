Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02B1FD3
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:27 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B842521991
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1645097485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3zpCLbM3i2e+74JX5+NfZrM0gh0mRAEsdMKljRareg=;
	b=K8+BOpex4Ah3A8TUgQ4ZH+AuhqLESIghkIqKaFb6r54dg2vNH83L43tzP5Zhw7Wv84NQDm
	Q1mBSPU8bANM6e2zUKNj5w/w6GqaXgiH72WptWZicfoUdnIKLJb2iCDh1pmejk07bpdFCd
	Fscg4T7nWlMpb4fIrrF19XtIFciWqOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1645097485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3zpCLbM3i2e+74JX5+NfZrM0gh0mRAEsdMKljRareg=;
	b=WYbsslcPAkdFkOwLn3x1XC4FDxCdheFNA8PtGRq+T48aHkDydjJD29JWbPPnnAn9UT6p6Y
	aVTQMK+2sXlhbRDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C27013BBF
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id tsjtJA0yDmJFXgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:25 +0000
From: matthias.gerstner@suse.de
To: connman@lists.linux.dev
Subject: [PATCH 3/7] dnsproxy: protocol_offset: remove error return case and return size_t
Date: Thu, 17 Feb 2022 12:31:09 +0100
Message-Id: <20220217113113.24088-4-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217113113.24088-1-matthias.gerstner@suse.de>
References: <20220217113113.24088-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthias Gerstner <matthias.gerstner@suse.de>

There is never any socket created that is not UDP or TCP, so this error
should never occur unless some memory corruption or similar occured.
Therefore `abort()` on unexpected values instead.

This simplifies the calling code since the error case no longer needs to
be covered (which can also be dangerous when forgotten, because then
negative error codes are used in calculations).
---
 src/dnsproxy.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index b195f447..d04057fa 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -233,7 +233,7 @@ static guint16 get_id(void)
 	return rand;
 }
 
-static int protocol_offset(int protocol)
+static size_t protocol_offset(int protocol)
 {
 	switch (protocol) {
 	case IPPROTO_UDP:
@@ -243,9 +243,9 @@ static int protocol_offset(int protocol)
 		return 2;
 
 	default:
-		return -EINVAL;
+		// this should never happen
+		abort();
 	}
-
 }
 
 /*
@@ -480,13 +480,11 @@ static void send_response(int sk, unsigned char *buf, size_t len,
 				int protocol)
 {
 	struct domain_hdr *hdr;
-	int err, offset = protocol_offset(protocol);
+	int err;
+	size_t offset = protocol_offset(protocol);
 
 	debug("sk %d", sk);
 
-	if (offset < 0)
-		return;
-
 	if (len < sizeof(*hdr) + offset)
 		return;
 
@@ -802,16 +800,12 @@ static struct cache_entry *cache_check(gpointer request, int *qtype, int proto)
 	struct cache_entry *entry;
 	struct domain_question *q;
 	uint16_t type;
-	int offset, proto_offset;
+	int offset;
 
 	if (!request)
 		return NULL;
 
-	proto_offset = protocol_offset(proto);
-	if (proto_offset < 0)
-		return NULL;
-
-	question = request + proto_offset + 12;
+	question = request + protocol_offset(proto) + 12;
 
 	offset = strlen(question) + 1;
 	q = (void *) (question + offset);
@@ -1383,7 +1377,7 @@ static int reply_query_type(unsigned char *msg, int len)
 static int cache_update(struct server_data *srv, unsigned char *msg,
 			unsigned int msg_len)
 {
-	int offset = protocol_offset(srv->protocol);
+	size_t offset = protocol_offset(srv->protocol);
 	int err, qlen, ttl = 0;
 	uint16_t answers = 0, type = 0, class = 0;
 	struct domain_hdr *hdr = (void *)(msg + offset);
@@ -1411,10 +1405,7 @@ static int cache_update(struct server_data *srv, unsigned char *msg,
 		next_refresh = current_time + 30;
 	}
 
-	if (offset < 0)
-		return 0;
-
-	debug("offset %d hdr %p msg %p rcode %d", offset, hdr, msg, hdr->rcode);
+	debug("offset %zd hdr %p msg %p rcode %d", offset, hdr, msg, hdr->rcode);
 
 	/* Continue only if response code is 0 (=ok) */
 	if (hdr->rcode != ns_r_noerror)
@@ -1678,17 +1669,14 @@ static int ns_resolv(struct server_data *server, struct request_data *req,
 		char *domain;
 		unsigned char alt[1024];
 		struct domain_hdr *hdr = (void *) &alt;
-		int altlen, domlen, offset;
+		int altlen, domlen;
+		size_t offset = protocol_offset(server->protocol);
 
 		domain = list->data;
 
 		if (!domain)
 			continue;
 
-		offset = protocol_offset(server->protocol);
-		if (offset < 0)
-			return offset;
-
 		domlen = strlen(domain) + 1;
 		if (domlen < 5)
 			return -EINVAL;
@@ -1947,13 +1935,12 @@ static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
 {
 	struct domain_hdr *hdr;
 	struct request_data *req;
-	int dns_id, sk, err, offset = protocol_offset(protocol);
+	int dns_id, sk, err;
+	size_t offset = protocol_offset(protocol);
 
-	if (offset < 0)
-		return offset;
 	if (reply_len < 0)
 		return -EINVAL;
-	if (reply_len < offset + 1)
+	if ((size_t)reply_len < offset + 1)
 		return -EINVAL;
 	if ((size_t)reply_len < sizeof(struct domain_hdr))
 		return -EINVAL;
-- 
2.34.1

