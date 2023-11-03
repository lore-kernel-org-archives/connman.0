Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460672110F
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4A5507313B
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 16:18:20 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1554E73218
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 16:18:20 -0400 (EDT)
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
Subject: [PATCH 1/2] service: add DBG to 'switch_update_preferred_order'.
Date: Fri, 3 Nov 2023 13:18:19 -0700
References: <570CAA7B-EB14-4E4D-AD37-4E776140A67E@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <570CAA7B-EB14-4E4D-AD37-4E776140A67E@nuovations.com>
Message-Id: <03487066-B823-4E11-BF84-88F5B25AC2F5@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds a DBG statement to 'switch_update_preferred_order' to aid in
debugging the dynamism of service reordering that occurs in a multi-
technology environment with "EnableOnlineToReadyTransition" asserted.
---
 src/service.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/service.c b/src/service.c
index 44aab3c2..072d5a7d 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6227,6 +6227,11 @@ static int service_update_preferred_order(struct =
connman_service *default_servic
 		struct connman_service *new_service,
 		enum connman_service_state new_state)
 {
+	DBG("default_service %p (%s) new_service %p (%s) new_state %d =
(%s)",
+		default_service, =
connman_service_get_identifier(default_service),
+		new_service, =
connman_service_get_identifier(new_service),
+		new_state, state2string(new_state));
+
 	if (!default_service || default_service =3D=3D new_service)
 		return 0;
=20
--=20
2.42.0

