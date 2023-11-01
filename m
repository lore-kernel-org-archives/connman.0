Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887A57F
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 73EDA7316E
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 00:34:34 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03] (unknown [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 38282732B3
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 00:34:34 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH] Address -Werror=sign-compare compilation errors.
Message-Id: <6ECC162C-D6EF-4043-B58C-C5225E9910F4@nuovations.com>
Date: Tue, 31 Oct 2023 21:34:33 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This addresses -Werror=3Dsign-compare compilation errors surfaced by =
both
GCC and clang/LLVM when --enable-maintainer-mode is asserted.
---
 src/dnsproxy.c | 14 +++++++-------
 src/iptables.c |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 4ae485f1..03021ba0 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -436,7 +436,7 @@ static void update_cached_ttl(unsigned char *ptr, =
int len, int new_ttl)
 	ptr +=3D DNS_HEADER_SIZE;
 	len -=3D DNS_HEADER_SIZE;
=20
-	if (len < DNS_QUESTION_SIZE + 1)
+	if (len < (int)DNS_QUESTION_SIZE + 1)
 		return;
=20
 	/* skip the query, which is a name and a struct domain_question =
*/
@@ -459,7 +459,7 @@ static void update_cached_ttl(unsigned char *ptr, =
int len, int new_ttl)
 			break;
=20
 		rr =3D (void*)ptr;
-		if (len < sizeof(*rr))
+		if (len < (int)sizeof(*rr))
 			/* incomplete record */
 			break;
=20
@@ -520,7 +520,7 @@ static void send_cached_response(int sk, const =
unsigned char *ptr, size_t len,
 		connman_error("Cannot send cached DNS response: %s",
 				strerror(errno));
 	}
-	else if (err !=3D len || dns_len !=3D (len - offset))
+	else if (err !=3D (int)len || dns_len !=3D (len - offset))
 		debug("Packet length mismatch, sent %d wanted %zd dns =
%zd",
 			err, len, dns_len);
 }
@@ -656,7 +656,7 @@ static int append_data(unsigned char *buf, size_t =
size, const char *data)
=20
 	while (true) {
 		const char *dot =3D strchr(data, '.');
-		len =3D dot ? dot - data : strlen(data);
+		len =3D dot ? (size_t)((ptrdiff_t)(dot - data)) : =
strlen(data);
=20
 		if (len =3D=3D 0)
 			break;
@@ -1063,7 +1063,7 @@ static int parse_response(const unsigned char =
*buf, size_t buflen,
 	qlen =3D strlen(question);
 	ptr +=3D qlen + 1; /* skip \0 */
=20
-	if ((eptr - ptr) < DNS_QUESTION_SIZE)
+	if ((eptr - ptr) < (ptrdiff_t)DNS_QUESTION_SIZE)
 		return -EINVAL;
=20
 	q =3D (void *) ptr;
@@ -2031,7 +2031,7 @@ static int dns_reply_fixup_domains(
 	const char *domain;
=20
 	/* full header plus at least one byte for the hostname length */
-	if (reply_len < header_len + 1)
+	if (reply_len < (size_t)header_len + 1)
 		return -EINVAL;
=20
 	section_counts[0] =3D hdr->ancount;
@@ -2521,7 +2521,7 @@ hangup:
 				connman_error("DNS proxy error %s",
 						strerror(errno));
 				goto hangup;
-			} else if (bytes_recv < sizeof(reply_len))
+			} else if (bytes_recv < (int)sizeof(reply_len))
 				return TRUE;
=20
 			/* the header contains the length of the message
diff --git a/src/iptables.c b/src/iptables.c
index 664b27f1..c48f44e4 100644
--- a/src/iptables.c
+++ b/src/iptables.c
@@ -802,10 +802,10 @@ static void update_targets_reference(struct =
connman_iptables *table,
 			continue;
=20
 		if (is_removing) {
-			if (t->verdict >=3D entry_before->offset)
+			if (t->verdict >=3D (int)entry_before->offset)
 				t->verdict -=3D offset;
 		} else {
-			if (t->verdict > entry_before->offset)
+			if (t->verdict > (int)entry_before->offset)
 				t->verdict +=3D offset;
 		}
 	}
--=20
2.42.0


