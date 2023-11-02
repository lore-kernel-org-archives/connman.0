Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9D224D2
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 5601573225
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 19:23:06 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1DFE873233
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 19:23:06 -0400 (EDT)
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
Subject: [PATCH] Leverage 'connman_service_get_identifier' in 
 'default_changed' DBG.
Message-Id: <D1539454-13B0-4650-986C-ED334D1CE8CA@nuovations.com>
Date: Thu, 2 Nov 2023 16:23:05 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages 'connman_service_get_identifier' in the 'default_changed'
DBG call rather than re-creating the same logic from
'connman_service_get_identifier' in that same call.
---
 src/service.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index 919621b9..950d22cb 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1724,9 +1724,9 @@ static void default_changed(void)
 	if (service =3D=3D current_default)
 		return;
=20
-	DBG("current default %p %s", current_default,
-		current_default ? current_default->identifier : "");
-	DBG("new default %p %s", service, service ? service->identifier =
: "");
+	DBG("current default %p (%s)", current_default,
+		connman_service_get_identifier(current_default));
+	DBG("new default %p (%s)", service, =
connman_service_get_identifier(service));
=20
 	__connman_service_timeserver_changed(current_default, NULL);
=20
--=20
2.42.0


