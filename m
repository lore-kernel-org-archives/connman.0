Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16619440
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id EEAC47316C
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 18:46:49 -0400 (EDT)
Received: from [192.168.1.128] (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BFBC77317A
	for <connman@lists.linux.dev>; Thu, 19 Oct 2023 18:46:49 -0400 (EDT)
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
Subject: [PATCH] Move online check settings initialization to service init.
Message-Id: <63D885EB-FBE7-4C5B-BEA7-84288CF076DA@nuovations.com>
Date: Thu, 19 Oct 2023 15:46:48 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

The connman settings "EnableOnlineToReadyTransition",
"OnlineCheckInitialInterval", and "OnlineCheckMaxInterval" do not vary
across calls to 'start_online_check'. Consequently, they can be read
and set once in '__connman_service_init'.
---
 src/service.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/service.c b/src/service.c
index 06d02322..55932efc 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1460,12 +1460,6 @@ static void start_online_check(struct =
connman_service *service,
 			"Default service remains in READY state.");
 		return;
 	}
-	enable_online_to_ready_transition =3D
-		=
connman_setting_get_bool("EnableOnlineToReadyTransition");
-	online_check_initial_interval =3D
-		connman_setting_get_uint("OnlineCheckInitialInterval");
-	online_check_max_interval =3D
-		connman_setting_get_uint("OnlineCheckMaxInterval");
=20
 	if (type =3D=3D CONNMAN_IPCONFIG_TYPE_IPV6 || =
check_proxy_setup(service)) {
 		cancel_online_check(service);
@@ -7842,6 +7836,13 @@ int __connman_service_init(void)
=20
 	remove_unprovisioned_services();
=20
+	enable_online_to_ready_transition =3D
+		=
connman_setting_get_bool("EnableOnlineToReadyTransition");
+	online_check_initial_interval =3D
+		connman_setting_get_uint("OnlineCheckInitialInterval");
+	online_check_max_interval =3D
+		connman_setting_get_uint("OnlineCheckMaxInterval");
+
 	return 0;
 }
=20
--=20
2.32.0


