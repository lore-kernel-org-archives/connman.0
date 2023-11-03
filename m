Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D9180
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C54BC73156
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 20:13:10 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8FD03731E8
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 20:13:10 -0400 (EDT)
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
Subject: [PATCH 1/2] service: Add default service introspection function.
Date: Thu, 2 Nov 2023 17:13:10 -0700
References: <6FD25675-87BF-4532-A9C9-49E606AC65C5@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <6FD25675-87BF-4532-A9C9-49E606AC65C5@nuovations.com>
Message-Id: <65D8752A-1839-40EA-8F89-953BC412CF35@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds an introspection function to determine whether the specified
service is the default service (that is, the service with the default
route).
---
 src/service.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/service.c b/src/service.c
index 85f541ee..95933b8e 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1687,6 +1687,31 @@ struct connman_service =
*connman_service_get_default(void)
 	return service;
 }
=20
+/**
+ *  @brief
+ *    Determine whether the specified service is the default service.
+ *
+ *  This determines whether the specified service is the default
+ *  service (that is, the service with the default route).
+ *
+ *  @param[in]  service  A pointer to the immutable service for which
+ *                       to determine whether it is the default
+ *                       network service.
+ *  @returns
+ *    True if the specified service is the default network service;
+ *    otherwise, false.
+ *
+ *  @sa connman_service_get_default
+ *
+ */
+static bool connman_service_is_default(const struct connman_service =
*service)
+{
+	if (!service)
+		return false;
+
+	return connman_service_get_default() =3D=3D service;
+}
+
 /**
  *  @brief
  *    Determine whether the specified network interface index belongs
--=20
2.42.0

