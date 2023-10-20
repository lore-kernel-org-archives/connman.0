Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766781DA59
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 155E8731B6
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:09:44 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86] (unknown [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CF27273225
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:09:43 -0400 (EDT)
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
Subject: [PATCH] Address scan-build warning in 'get_ipv6_state'.
Message-Id: <CAFEDF00-18C4-4712-807A-370425E6A110@nuovations.com>
Date: Fri, 20 Oct 2023 13:09:42 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This addresses an "assigned value is garbage or undefined
[core.uninitialized.Assign]" warning in 'get_ipv6_state'
identified by clang/LLVM scan-build-11.
---
 src/ipconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 34b1724a..9cd04979 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -346,7 +346,7 @@ static int write_ipv6_conf_value(const char *ifname, =
const char *suffix,
=20
 static bool get_ipv6_state(gchar *ifname)
 {
-	int disabled;
+	int disabled =3D 1;
 	bool enabled =3D false;
=20
 	if (read_ipv6_conf_value(ifname, "disable_ipv6", &disabled) > 0)
--=20
2.42.0


