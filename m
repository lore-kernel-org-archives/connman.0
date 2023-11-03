Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99A180
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2441273191
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 20:13:16 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E140273236
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 20:13:15 -0400 (EDT)
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
Subject: [PATCH 2/2] service: add DBG to 'switch_default_service'.
Date: Thu, 2 Nov 2023 17:13:15 -0700
References: <6FD25675-87BF-4532-A9C9-49E606AC65C5@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <6FD25675-87BF-4532-A9C9-49E606AC65C5@nuovations.com>
Message-Id: <823B156E-3F96-45AB-A6C2-FE3089610965@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a DBG statement to 'switch_default_service' which
leverages the newly-added 'connman_service_is_default' service
default introspection function since, in the fullness of time,
neither of the service arguments are guaranteed to be the
default service.
---
 src/service.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/service.c b/src/service.c
index 95933b8e..5e23b8dd 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4915,6 +4915,14 @@ static void switch_default_service(struct =
connman_service *default_service,
 	struct connman_service *service;
 	GList *src, *dst;
=20
+	DBG("default_service %p (%s) default %u downgrade_service %p =
(%s) default %u",
+		default_service,
+		connman_service_get_identifier(default_service),
+		connman_service_is_default(default_service),
+		downgrade_service,
+		connman_service_get_identifier(downgrade_service),
+		connman_service_is_default(downgrade_service));
+
 	apply_relevant_default_downgrade(default_service);
 	src =3D g_list_find(service_list, downgrade_service);
 	dst =3D g_list_find(service_list, default_service);
--=20
2.42.0

