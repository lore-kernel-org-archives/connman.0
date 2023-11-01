Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA727F
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 865CF7328E
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 01:22:41 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03] (unknown [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 48960732D3
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 01:22:41 -0400 (EDT)
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
Subject: [PATCH] Address -Werror=implicit-fallthrough compilation errors.
Message-Id: <B77C1AEA-B348-4E93-BF9D-DBD10518C0F8@nuovations.com>
Date: Tue, 31 Oct 2023 22:22:40 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This addresses -Werror=3Dimplicit-fallthrough compilation errors
surfaced by GCC when --enable-maintainer-mode is asserted
by using an explicit connman_iptables_entry_is_valid function
rather than a copied-and-pasted switch statement with the
inherent implicit fall through behavior.

---
 src/iptables.c | 47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/src/iptables.c b/src/iptables.c
index c48f44e4..bea2dd6a 100644
--- a/src/iptables.c
+++ b/src/iptables.c
@@ -1259,6 +1259,19 @@ static void update_hooks(struct connman_iptables =
*table, GList *chain_head,
 	}
 }
=20
+static bool connman_iptables_entry_is_valid(
+				const struct connman_iptables_entry =
*new_entry)
+{
+	if (!new_entry ||
+		((new_entry->type !=3D AF_INET) || (new_entry->type !=3D =
AF_INET6)) ||
+		((new_entry->type =3D=3D AF_INET) && !new_entry->entry) =
||
+		((new_entry->type =3D=3D AF_INET6) && =
!new_entry->entry6)) {
+		return false;
+	}
+
+	return true;
+}
+
 static struct connman_iptables_entry *prepare_rule_inclusion(
 				struct connman_iptables *table,
 				struct iptables_ip *ip,
@@ -1283,16 +1296,8 @@ static struct connman_iptables_entry =
*prepare_rule_inclusion(
=20
 	new_entry =3D new_rule(ip, target_name, xt_t, xt_rm);
=20
-	switch (new_entry->type) {
-	case AF_INET:
-		if (new_entry->entry)
-			break;
-	case AF_INET6:
-		if (new_entry->entry6)
-			break;
-	default:
+	if (!connman_iptables_entry_is_valid(new_entry))
 		goto err;
-	}
=20
 	update_hooks(table, chain_head, new_entry);
=20
@@ -1337,17 +1342,7 @@ static int iptables_append_rule(struct =
connman_iptables *table,
 	new_entry =3D prepare_rule_inclusion(table, ip, chain_name, =
target_name,
 					xt_t, &builtin, xt_rm, false);
=20
-	if (!new_entry)
-		return -EINVAL;
-
-	switch (new_entry->type) {
-	case AF_INET:
-		if (new_entry->entry)
-			break;
-	case AF_INET6:
-		if (new_entry->entry6)
-			break;
-	default:
+	if (!connman_iptables_entry_is_valid(new_entry)) {
 		ret =3D -EINVAL;
 		goto err;
 	}
@@ -1391,17 +1386,7 @@ static int iptables_insert_rule(struct =
connman_iptables *table,
 	new_entry =3D prepare_rule_inclusion(table, ip, chain_name, =
target_name,
 					xt_t, &builtin, xt_rm, true);
=20
-	if (!new_entry)
-		return -EINVAL;
-
-	switch (new_entry->type) {
-	case AF_INET:
-		if (new_entry->entry)
-			break;
-	case AF_INET6:
-		if (new_entry->entry6)
-			break;
-	default:
+	if (!connman_iptables_entry_is_valid(new_entry)) {
 		ret =3D -EINVAL;
 		goto err;
 	}
--=20
2.42.0


