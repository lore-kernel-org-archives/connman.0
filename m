Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C021A18
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 036D1731F4
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 17:59:37 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C1EF2731FE
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 17:59:36 -0400 (EDT)
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
Subject: [PATCH] service: Leverage 'is_connected'.
Message-Id: <7F1AE24F-502C-4A3C-95A8-13602CDB0048@nuovations.com>
Date: Thu, 2 Nov 2023 14:59:35 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

In all instances but one where there are checks to see whether the
IPv4 or IPv6 service state is 'CONNMAN_SERVICE_STATE_READY' or
'CONNMAN_SERVICE_STATE_ONLINE', the 'is_connected' function is used.
This leverages 'is_connected' for the only instance where that was
not the case.
---
 src/service.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 355a5ad9..68d61333 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2726,8 +2726,7 @@ static void append_properties(DBusMessageIter =
*dict, dbus_bool_t limited,
 	connman_dbus_dict_append_array(dict, =
"Nameservers.Configuration",
 				DBUS_TYPE_STRING, append_dnsconfig, =
service);
=20
-	if (service->state =3D=3D CONNMAN_SERVICE_STATE_READY ||
-			service->state =3D=3D =
CONNMAN_SERVICE_STATE_ONLINE)
+	if (is_connected(service->state))
 		list =3D __connman_timeserver_get_all(service);
 	else
 		list =3D NULL;
--=20
2.42.0


