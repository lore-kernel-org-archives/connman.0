Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B016AB3
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9B0647336D
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 16:42:17 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0] (unknown [IPv6:2601:647:5a00:15c1:fd9d:6537:8c7d:2c0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6714F7337A
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 16:42:17 -0400 (EDT)
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
Subject: [PATCH] Return the '<null>' string if the service is null.
Message-Id: <CA922092-2F05-488E-8FFC-7051323CEE85@nuovations.com>
Date: Thu, 19 Oct 2023 13:42:16 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This returns the '<null>' string from 'connman_service_get_identifer' if
the service is null. Unfortunately, not all C Standard Libraries on all
platforms cope well with a literal null and the '%s' format specifier.
---
 src/service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 06d02322..78a000bc 100644
--- a/src/service.c
+++ b/src/service.c
@@ -7296,7 +7296,7 @@ struct connman_service =
*__connman_service_lookup_from_index(int index)
=20
 const char *connman_service_get_identifier(struct connman_service =
*service)
 {
-	return service ? service->identifier : NULL;
+	return service ? service->identifier : "<null>";
 }
=20
 const char *__connman_service_get_path(struct connman_service *service)
--=20
2.32.0
