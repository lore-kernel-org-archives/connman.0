Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2041F7F
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0C9C073365
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 00:55:07 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03] (unknown [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C8F0273373
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 00:55:06 -0400 (EDT)
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
Subject: [PATCH] Address -Werror=unused-but-set-parameter compilation errors.
Message-Id: <28C6849C-16CE-4125-8FA9-B1F2CA52D733@nuovations.com>
Date: Tue, 31 Oct 2023 21:55:05 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This addresses -Werror=3Dunused-but-set-parameter compilation errors
surfaced by GCC when --enable-maintainer-mode is asserted.
---
 unit/test-iptables.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/unit/test-iptables.c b/unit/test-iptables.c
index 2d655d38..a96d8679 100644
--- a/unit/test-iptables.c
+++ b/unit/test-iptables.c
@@ -210,8 +210,6 @@ void xtables_option_mfcall(struct xtables_match *m)
 	if (test_config_type & TEST_CONFIG_MFCALL_FAIL)
 		call_error("xtables_option_mfcall");
=20
-	m =3D &xt_match;
-
 	return;
 }
=20
@@ -222,8 +220,6 @@ void xtables_option_tfcall(struct xtables_target *t)
 	if (test_config_type & TEST_CONFIG_TFCALL_FAIL)
 		call_error("xtables_option_tfcall");
=20
-	t =3D &xt_target;
-
 	return;
 }
=20
@@ -235,8 +231,6 @@ void xtables_option_mpcall(unsigned int c, char =
**argv, bool invert,
 	if (test_config_type & TEST_CONFIG_MPCALL_FAIL)
 		call_error("xtables_option_mpcall");
=20
-	m =3D &xt_match;
-
 	return;
 }
=20
@@ -248,8 +242,6 @@ void xtables_option_tpcall(unsigned int c, char =
**argv, bool invert,
 	if (test_config_type & TEST_CONFIG_TPCALL_FAIL)
 		call_error("xtables_option_tpcall");
=20
-	t =3D &xt_target;
-
 	return;
 }
=20
--=20
2.42.0


