Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24507F
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C9D3C73347
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 00:42:12 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03] (unknown [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8F1F07335B
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 00:42:12 -0400 (EDT)
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
Subject: [PATCH] Address -Werror=old-style-declaration compilation errors.
Message-Id: <BAA7A12F-BC05-41DE-A9F7-ABE3A2E6C9AD@nuovations.com>
Date: Tue, 31 Oct 2023 21:42:11 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This addresses -Werror=3Dold-style-declaration compilation errors =
surfaced
by GCC when --enable-maintainer-mode is asserted.
---
 unit/test-iptables.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-iptables.c b/unit/test-iptables.c
index f08736ea..2d655d38 100644
--- a/unit/test-iptables.c
+++ b/unit/test-iptables.c
@@ -69,13 +69,13 @@ static void set_test_config(enum configtype type)
 #define IP6T_SO_GET_INFO		(IP6T_BASE_CTL)
 #define IP6T_SO_GET_ENTRIES		(IP6T_BASE_CTL + 1)
=20
-int static xt_match_parse(int c, char **argv, int invert, unsigned int =
*flags,
+static int xt_match_parse(int c, char **argv, int invert, unsigned int =
*flags,
 			const void *entry, struct xt_entry_match =
**match)
 {
 	return 0;
 }
=20
-int static xt_target_parse(int c, char **argv, int invert, unsigned int =
*flags,
+static int xt_target_parse(int c, char **argv, int invert, unsigned int =
*flags,
 			const void *entry, struct xt_entry_target =
**targetinfo)
 {
 	return 0;
--=20
2.42.0


