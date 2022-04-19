Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27FDED7
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:48 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA46C1F755
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1650365142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7O7llVl+ipFQ2BKRbaY/fi4tS33n8+AWtE8Ojl7KP7o=;
	b=dOhvurc/HvWwMpStFGxqM17CjSQ481Eni6RU8zwt7js1+DI03C68UsMPmzuKOxpMK78jkC
	nsi9zfvmqI1TGrCU1w0Au+xosPuAY6RDpEnG50RCRC22q8/M8rZOeFtjorAq+HeKpwdaV7
	h0evGwN8zrUTh9P5QxaP1hCgQ1Kl7Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1650365142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7O7llVl+ipFQ2BKRbaY/fi4tS33n8+AWtE8Ojl7KP7o=;
	b=8XNSrpgQrgbayFy4aRKLRNessVeeTTpq2ElntTssWrXEc0CkgpzM/E+t/N/HuBOGr7tx0v
	Nq2YkMH5c26I4lDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4A93139BE
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XeH9L9aSXmLpOAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:42 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 09/12] dnsproxy: uncompress: replace unnecessary goto with return statements
Date: Tue, 19 Apr 2022 12:34:58 +0200
Message-Id: <20220419103501.30553-10-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419103501.30553-1-matthias.gerstner@suse.de>
References: <20220419103501.30553-1-matthias.gerstner@suse.de>
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
index 4b834d2f0..78855e27d 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1752,7 +1752,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 		if (!convert_label(start, end, ptr, name, NS_MAXLABEL,
 					&pos, &comp_pos))
-			goto out;
+			return NULL;
 
 		/*
 		 * Copy the uncompressed resource record, type, class and \0 to
@@ -1761,7 +1761,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 		ulen = strlen(name) + 1;
 		if ((uptr + ulen) > uncomp_end)
-			goto out;
+			return NULL;
 		memcpy(uptr, name, ulen);
 
 		debug("pos %d ulen %d left %d name %s", pos, ulen,
@@ -1777,7 +1777,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 		 */
 		if ((uptr + NS_RRFIXEDSZ) > uncomp_end) {
 			debug("uncompressed data too large for buffer");
-			goto out;
+			return NULL;
 		}
 		memcpy(uptr, ptr, NS_RRFIXEDSZ);
 
@@ -1785,7 +1785,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 		dns_class = uptr[2] << 8 | uptr[3];
 
 		if (dns_class != DNS_CLASS_IN)
-			goto out;
+			return NULL;
 
 		ptr += NS_RRFIXEDSZ;
 		uptr += NS_RRFIXEDSZ;
@@ -1799,7 +1799,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			uptr[-2] = comp_pos << 8;
 			uptr[-1] = comp_pos & 0xff;
@@ -1812,7 +1812,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 			if ((ptr + dlen) > end || (uptr + dlen) > uncomp_end) {
 				debug("data len %d too long", dlen);
-				goto out;
+				return NULL;
 			}
 
 			memcpy(uptr, ptr, dlen);
@@ -1827,7 +1827,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			total_len += comp_pos;
 			len_ptr = &uptr[-2];
@@ -1838,7 +1838,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			total_len += comp_pos;
 			ptr += pos;
@@ -1851,7 +1851,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			 */
 			if ((uptr + 20) > uncomp_end || (ptr + 20) > end) {
 				debug("soa record too long");
-				goto out;
+				return NULL;
 			}
 			memcpy(uptr, ptr, 20);
 			uptr += 20;
@@ -1869,9 +1869,6 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 	}
 
 	return ptr;
-
-out:
-	return NULL;
 }
 
 /*
-- 
2.35.1

