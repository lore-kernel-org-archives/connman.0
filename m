Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B364A
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:38 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D14D91FE1E
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654864415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjCckPpzn7CZOiGhWohz13NosB6G31XwtcT2s+iMgMA=;
	b=y9CpO67kDzvx8uOFE3MkZOaFu/6xPxvTNUWq6pe6R9y+4FWAJ3EZyH6Jhk3guBkVt/is3l
	hphHWhGXjt2rBf4YRJPOuowtMWwmptDCaa9FCSISuyGme72mHZwwKVebwbbmBVjtApQuOq
	GQ+UkEBoK6Z8/tScR/iaPsHl/6bDvqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654864415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjCckPpzn7CZOiGhWohz13NosB6G31XwtcT2s+iMgMA=;
	b=qIncrJBn9TZFl2ACCw0IxDQzYKzil++8iErwcZ/f4o/QrxEE7vz6TZk/iy5AS4ewMU5dgs
	OexdrUy3JGHDuZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA43A139ED
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4+5eMR86o2KJMgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:35 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 10/16] dnsproxy: uncompress: replace unnecessary goto with return statements
Date: Fri, 10 Jun 2022 14:33:17 +0200
Message-Id: <20220610123323.8974-11-matthias.gerstner@suse.de>
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

---
 src/dnsproxy.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index d76cb0d2e..f88e501f1 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1756,7 +1756,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 		if (!convert_label(start, end, ptr, name, NS_MAXLABEL,
 					&pos, &comp_pos))
-			goto out;
+			return NULL;
 
 		/*
 		 * Copy the uncompressed resource record, type, class and \0 to
@@ -1765,7 +1765,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 		ulen = strlen(name) + 1;
 		if ((uptr + ulen) > uncomp_end)
-			goto out;
+			return NULL;
 		memcpy(uptr, name, ulen);
 
 		debug("pos %d ulen %d left %d name %s", pos, ulen,
@@ -1781,7 +1781,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 		 */
 		if ((uptr + NS_RRFIXEDSZ) > uncomp_end) {
 			debug("uncompressed data too large for buffer");
-			goto out;
+			return NULL;
 		}
 		memcpy(uptr, ptr, NS_RRFIXEDSZ);
 
@@ -1789,7 +1789,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 		dns_class = uptr[2] << 8 | uptr[3];
 
 		if (dns_class != DNS_CLASS_IN)
-			goto out;
+			return NULL;
 
 		ptr += NS_RRFIXEDSZ;
 		uptr += NS_RRFIXEDSZ;
@@ -1803,7 +1803,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			uptr[-2] = comp_pos << 8;
 			uptr[-1] = comp_pos & 0xff;
@@ -1816,7 +1816,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 			if ((ptr + dlen) > end || (uptr + dlen) > uncomp_end) {
 				debug("data len %d too long", dlen);
-				goto out;
+				return NULL;
 			}
 
 			memcpy(uptr, ptr, dlen);
@@ -1831,7 +1831,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			total_len += comp_pos;
 			len_ptr = &uptr[-2];
@@ -1842,7 +1842,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			total_len += comp_pos;
 			ptr += pos;
@@ -1855,7 +1855,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			 */
 			if ((uptr + 20) > uncomp_end || (ptr + 20) > end) {
 				debug("soa record too long");
-				goto out;
+				return NULL;
 			}
 			memcpy(uptr, ptr, 20);
 			uptr += 20;
@@ -1873,9 +1873,6 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 	}
 
 	return ptr;
-
-out:
-	return NULL;
 }
 
 /*
-- 
2.35.1

