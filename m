Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1A187C
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:17 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6708722679
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzXmq0lRgvBDxvEVPWtcqeW1ry5NErHa9cvXFjwQO6M=;
	b=fLz4HE6hjL3QFL7tEeVaWVR/y5j26HILW208yYlL6P3u/4+mo+XMk50ZusnhK1/uZSAI3e
	u3OkKHNPZQ8lFzdF/bsDSq2kLlBmqgLlC9NpozPBv6zXxmr1ORMj6Jq3qI04TIRZMvmJ0P
	zsGT1SH/Pcvs1XjXn3jdXkGPtvIVxnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzXmq0lRgvBDxvEVPWtcqeW1ry5NErHa9cvXFjwQO6M=;
	b=YN+skrg8wUHCacTAddvtVxQg9n9MMnQXu/IL055KmM48T+oeh/JFEGweqXZnwgNDjiEwBf
	YOWaSYR3MQa72oBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EE2C134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id rvclF2xeWmP3BAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:16 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 09/16] dnsproxy: refactor and document strip_domains() to make it less confusing
Date: Thu, 27 Oct 2022 12:32:52 +0200
Message-Id: <20221027103258.29129-10-matthias.gerstner@suse.de>
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

---
 src/dnsproxy.c | 61 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index d32fbd6db..c4f4796c2 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1882,45 +1882,70 @@ out:
 	return NULL;
 }
 
-static int strip_domains(char *name, char *answers, int maxlen)
+/*
+ * removes the qualified domain name part from the given answer sections
+ * starting at 'answers', consisting of 'length' bytes.
+ *
+ * 'name' points the start of the unqualified host label including the leading
+ * length octet.
+ *
+ * returns the new (possibly shorter) length of remaining payload in the
+ * answers buffer, or a negative (errno) value to indicate error conditions.
+ */
+static int strip_domains(const char *name, char *answers, size_t length)
 {
 	uint16_t data_len;
+	struct domain_rr *rr;
+	/* length of the name label including the length header octet */
 	const size_t name_len = strlen(name);
-	const char *start = answers, *end = answers + maxlen;
+	const char *end = answers + length;
 
-	while (maxlen > 0) {
+	while (answers < end) {
 		char *ptr = strstr(answers, name);
 		if (ptr) {
 			char *domain = ptr + name_len;
 
+			/* this now points to the domain part length octet. */
 			if (*domain) {
+				/*
+				 * length of the rest of the labels up to the
+				 * null label (zero byte).
+				 */
 				const size_t domain_len = strlen(domain);
+				char *remaining = domain + domain_len;
 
-				memmove(answers + name_len,
-					domain + domain_len,
-					end - (domain + domain_len));
+				/*
+				 * now shift the rest of the answer sections
+				 * to the left to get rid of the domain label
+				 * part
+				 */
+				memmove(ptr + name_len,
+					remaining,
+					end - remaining);
 
 				end -= domain_len;
-				maxlen -= domain_len;
+				length -= domain_len;
 			}
-		} else {
-			ptr = answers;
 		}
 
-		answers += strlen(answers) + 1;
-		answers += 2 + 2 + 4;  /* skip type, class and ttl fields */
-
-		data_len = answers[0] << 8 | answers[1];
-		answers += 2; /* skip the length field */
+		/* skip to the next answer section */
 
-		if (answers + data_len > end)
+		/* the labels up to the root null label */
+		answers += strlen(answers) + 1;
+		/* the fixed part of the RR */
+		rr = (void*)answers;
+		if (answers + sizeof(*rr) > end)
 			return -EINVAL;
-
+		data_len = htons(rr->rdlen);
+		/* skip the rest of the RR */
+		answers += sizeof(*rr);
 		answers += data_len;
-		maxlen -= answers - ptr;
 	}
 
-	return end - start;
+	if (answers > end)
+		return -EINVAL;
+
+	return length;
 }
 
 static int forward_dns_reply(unsigned char *reply, int reply_len, int protocol,
-- 
2.37.3

