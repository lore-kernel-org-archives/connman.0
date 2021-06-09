Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2270
	for <connman@lists.linux.dev>; Wed,  9 Jun 2021 07:59:58 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id A7E33500517;
	Wed,  9 Jun 2021 09:59:56 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 729E85002C0;
	Wed,  9 Jun 2021 09:59:56 +0200 (CEST)
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Valery Kashcheev <v.kascheev@omp.ru>
Subject: [PATCH] dnsproxy: Check the length of buffers before memcpy
Date: Wed,  9 Jun 2021 09:59:35 +0200
Message-Id: <20210609075935.21746-1-wagi@monom.org>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valery Kashcheev <v.kascheev@omp.ru>

Fix using a stack-based buffer overflow attack by checking the length of
the ptr and uptr buffers.

Fix debug message output.

Fixes: CVE-2021-33833
---
 src/dnsproxy.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index de52df5ad0a0..38dbdd71e425 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1788,17 +1788,15 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 		 * tmp buffer.
 		 */
 
-		debug("pos %d ulen %d left %d name %s", pos, ulen,
-			(int)(uncomp_len - (uptr - uncompressed)), uptr);
-
-		ulen = strlen(name);
-		if ((uptr + ulen + 1) > uncomp_end) {
+		ulen = strlen(name) + 1;
+		if ((uptr + ulen) > uncomp_end)
 			goto out;
-		}
-		strncpy(uptr, name, uncomp_len - (uptr - uncompressed));
+		strncpy(uptr, name, ulen);
+
+		debug("pos %d ulen %d left %d name %s", pos, ulen,
+			(int)(uncomp_end - (uptr + ulen)), uptr);
 
 		uptr += ulen;
-		*uptr++ = '\0';
 
 		ptr += pos;
 
@@ -1841,7 +1839,7 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 		} else if (dns_type == ns_t_a || dns_type == ns_t_aaaa) {
 			dlen = uptr[-2] << 8 | uptr[-1];
 
-			if (ptr + dlen > end) {
+			if ((ptr + dlen) > end || (uptr + dlen) > uncomp_end) {
 				debug("data len %d too long", dlen);
 				goto out;
 			}
@@ -1880,6 +1878,10 @@ static char *uncompress(int16_t field_count, char *start, char *end,
 			 * refresh interval, retry interval, expiration
 			 * limit and minimum ttl). They are 20 bytes long.
 			 */
+			if ((uptr + 20) > uncomp_end || (ptr + 20) > end) {
+				debug("soa record too long");
+				goto out;
+			}
 			memcpy(uptr, ptr, 20);
 			uptr += 20;
 			ptr += 20;
-- 
2.31.1
