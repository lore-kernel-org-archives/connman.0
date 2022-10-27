Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BE31C32
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:21 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD96B22676
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jd2fQcme8rwWGy7AwSyXWQvkCKP1u7SxYDhKA3T2gyQ=;
	b=tSojoOl4/sgC+s9JXEE3Tve0eCRzTHlkt/vyv2aNQP5myJo9DYHDeJGL8LcPBqlPPLR01n
	rBA7S46GifmDsqACR2jDEquTFfwbCGz/kLuvk7NOGxqcZwJNj4D+hjc4ilpt00lqPc44Co
	tZnq9f7Q78A2vAKA9XSUxzZXoWzT0uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jd2fQcme8rwWGy7AwSyXWQvkCKP1u7SxYDhKA3T2gyQ=;
	b=otOk5QXCsdZN9qw333DwMoASRx8sKqHZrGnwTFbGkM2pkHwHL82WEc0oyDFx5TUOsIazs1
	Ld9ubqImSGjJl1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3E17134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Lnz/J25eWmP/BAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:18 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 11/16] dnsproxy: uncompress: replace unnecessary goto with return statements
Date: Thu, 27 Oct 2022 12:32:54 +0200
Message-Id: <20221027103258.29129-12-matthias.gerstner@suse.de>
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
 src/dnsproxy.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index b34b952ba..23873a381 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1781,7 +1781,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 		if (!convert_label(start, end, ptr, name, NS_MAXLABEL,
 					&pos, &comp_pos))
-			goto out;
+			return NULL;
 
 		/*
 		 * Copy the uncompressed resource record, type, class and \0 to
@@ -1790,7 +1790,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 		ulen = strlen(name) + 1;
 		if ((uptr + ulen) > uncomp_end)
-			goto out;
+			return NULL;
 		memcpy(uptr, name, ulen);
 
 		debug("pos %d ulen %d left %d name %s", pos, ulen,
@@ -1806,7 +1806,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 		 */
 		if ((uptr + NS_RRFIXEDSZ) > uncomp_end) {
 			debug("uncompressed data too large for buffer");
-			goto out;
+			return NULL;
 		}
 		memcpy(uptr, ptr, NS_RRFIXEDSZ);
 
@@ -1814,7 +1814,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 		dns_class = uptr[2] << 8 | uptr[3];
 
 		if (dns_class != DNS_CLASS_IN)
-			goto out;
+			return NULL;
 
 		ptr += NS_RRFIXEDSZ;
 		uptr += NS_RRFIXEDSZ;
@@ -1828,7 +1828,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			uptr[-2] = comp_pos << 8;
 			uptr[-1] = comp_pos & 0xff;
@@ -1841,7 +1841,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 			if ((ptr + dlen) > end || (uptr + dlen) > uncomp_end) {
 				debug("data len %d too long", dlen);
-				goto out;
+				return NULL;
 			}
 
 			memcpy(uptr, ptr, dlen);
@@ -1856,7 +1856,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			total_len += comp_pos;
 			len_ptr = &uptr[-2];
@@ -1867,7 +1867,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			total_len += comp_pos;
 			ptr += pos;
@@ -1880,7 +1880,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			 */
 			if ((uptr + 20) > uncomp_end || (ptr + 20) > end) {
 				debug("soa record too long");
-				goto out;
+				return NULL;
 			}
 			memcpy(uptr, ptr, 20);
 			uptr += 20;
@@ -1898,9 +1898,6 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 	}
 
 	return ptr;
-
-out:
-	return NULL;
 }
 
 /*
-- 
2.37.3

