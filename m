Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD117F
	for <connman@lists.linux.dev>; Fri, 10 Nov 2023 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6147D731FA
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 19:18:08 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 29C227321E
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 19:18:08 -0500 (EST)
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
Subject: [PATCH] iptables: Address unit test regression.
Message-Id: <ABC03FB9-2E73-45C7-8109-0BE545B46E02@nuovations.com>
Date: Thu, 9 Nov 2023 16:18:07 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This addresses a regression in iptables and unit tests introduced
at commit 49d53688ae8f ("Address -Werror=3Dimplicit-fallthrough
compilation errors.") when v1, rather than v2, of the patch for
that commit was integrated.

This commit applies the correct, intended v2 content for the newly-
introduced 'connman_iptables_entry_is_valid' function.
---
 src/iptables.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/src/iptables.c b/src/iptables.c
index 302efcb5..a81a0779 100644
--- a/src/iptables.c
+++ b/src/iptables.c
@@ -1262,14 +1262,9 @@ static void update_hooks(struct connman_iptables =
*table, GList *chain_head,
 static bool connman_iptables_entry_is_valid(
 				const struct connman_iptables_entry =
*new_entry)
 {
-	if (!new_entry ||
-		((new_entry->type !=3D AF_INET) || (new_entry->type !=3D =
AF_INET6)) ||
-		((new_entry->type =3D=3D AF_INET) && !new_entry->entry) =
||
-		((new_entry->type =3D=3D AF_INET6) && =
!new_entry->entry6)) {
-		return false;
-	}
-
-	return true;
+	return (new_entry &&
+			(((new_entry->type =3D=3D AF_INET)  && =
new_entry->entry) ||
+			 ((new_entry->type =3D=3D AF_INET6) && =
new_entry->entry6)));
 }
=20
 static struct connman_iptables_entry *prepare_rule_inclusion(
--=20
2.42.0


