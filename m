Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3B38A
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 01:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CBE03731BA
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 21:16:06 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 96B9A73202
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 21:16:06 -0400 (EDT)
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
Subject: [PATCH] Address memory leak in '__connman_service_timeserver_remove'.
Message-Id: <BCE23F3F-84F5-4CAE-9F88-13A0FD4765D5@nuovations.com>
Date: Thu, 19 Oct 2023 18:16:05 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This addresses a potential memory leak of memory pointed to by 'servers'
identifed by clang/LLVM scan-build-11.
---
 src/service.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 06d02322..6c179921 100644
--- a/src/service.c
+++ b/src/service.c
@@ -3044,8 +3044,10 @@ int __connman_service_timeserver_remove(struct =
connman_service *service,
 	for (i =3D 0, j =3D 0; i < len; i++) {
 		if (g_strcmp0(service->timeservers[i], timeserver) !=3D =
0) {
 			servers[j] =3D =
g_strdup(service->timeservers[i]);
-			if (!servers[j])
+			if (!servers[j]) {
+				g_strfreev(servers);
 				return -ENOMEM;
+			}
 			j++;
 		}
 	}
--=20
2.32.0


