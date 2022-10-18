Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAB2599
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:08 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68C18207F9
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666082881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrJx0B0KuETEUJYrVKZzpOuCKsKFHc17znHloc/Ux60=;
	b=NJcm4DhvaDhK/IAtBVYBMuNfVzdcFxXLWbxYethaebkHvI1pVMrMo7jKAXVbNx3JgIs3WS
	MxwUxga8JoMgpB/hzSvde+LawCuFFlrRXdEnt9BXulzvjC99eBAQS9hq1H884CnkoKHzm/
	k3mEs4pC7cM08g+w9fk6u1obyYWDM4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666082881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrJx0B0KuETEUJYrVKZzpOuCKsKFHc17znHloc/Ux60=;
	b=Z4eSgebGrY/XS4MfOeVohBYHNkh+rvkoS5+jGWDLV/m7ys6ns5R9vJAENdF+RTgoBlDOvX
	/9o3STxNuc2EyuCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62791139D2
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id oVYHGEFoTmOfcAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:01 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 10/16] dnsproxy: uncompress: replace unnecessary goto with return statements
Date: Tue, 18 Oct 2022 10:47:40 +0200
Message-Id: <20221018084746.21959-11-matthias.gerstner@suse.de>
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

---
 src/dnsproxy.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 500e12ad9..129fd28ff 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1755,7 +1755,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 		if (!convert_label(start, end, ptr, name, NS_MAXLABEL,
 					&pos, &comp_pos))
-			goto out;
+			return NULL;
 
 		/*
 		 * Copy the uncompressed resource record, type, class and \0 to
@@ -1764,7 +1764,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 		ulen = strlen(name) + 1;
 		if ((uptr + ulen) > uncomp_end)
-			goto out;
+			return NULL;
 		memcpy(uptr, name, ulen);
 
 		debug("pos %d ulen %d left %d name %s", pos, ulen,
@@ -1780,7 +1780,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 		 */
 		if ((uptr + NS_RRFIXEDSZ) > uncomp_end) {
 			debug("uncompressed data too large for buffer");
-			goto out;
+			return NULL;
 		}
 		memcpy(uptr, ptr, NS_RRFIXEDSZ);
 
@@ -1788,7 +1788,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 		dns_class = uptr[2] << 8 | uptr[3];
 
 		if (dns_class != DNS_CLASS_IN)
-			goto out;
+			return NULL;
 
 		ptr += NS_RRFIXEDSZ;
 		uptr += NS_RRFIXEDSZ;
@@ -1802,7 +1802,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			uptr[-2] = comp_pos << 8;
 			uptr[-1] = comp_pos & 0xff;
@@ -1815,7 +1815,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 
 			if ((ptr + dlen) > end || (uptr + dlen) > uncomp_end) {
 				debug("data len %d too long", dlen);
-				goto out;
+				return NULL;
 			}
 
 			memcpy(uptr, ptr, dlen);
@@ -1830,7 +1830,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			total_len += comp_pos;
 			len_ptr = &uptr[-2];
@@ -1841,7 +1841,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			if (!convert_label(start, end, ptr, uptr,
 					uncomp_len - (uptr - uncompressed),
 						&pos, &comp_pos))
-				goto out;
+				return NULL;
 
 			total_len += comp_pos;
 			ptr += pos;
@@ -1854,7 +1854,7 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 			 */
 			if ((uptr + 20) > uncomp_end || (ptr + 20) > end) {
 				debug("soa record too long");
-				goto out;
+				return NULL;
 			}
 			memcpy(uptr, ptr, 20);
 			uptr += 20;
@@ -1872,9 +1872,6 @@ static const char* uncompress(int16_t field_count, const char *start, const char
 	}
 
 	return ptr;
-
-out:
-	return NULL;
 }
 
 /*
-- 
2.37.3

