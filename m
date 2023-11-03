Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5291F601
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id D0C057338B
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 19:24:24 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 99483733AE
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 19:24:24 -0400 (EDT)
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
Subject: [PATCH 2/3] service: Rename 'apply_relevant_default_downgrade'.
Date: Fri, 3 Nov 2023 16:24:24 -0700
References: <7581F8B3-D243-4268-B344-FB28A7A15E72@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7581F8B3-D243-4268-B344-FB28A7A15E72@nuovations.com>
Message-Id: <96583A31-56DF-468E-B697-E46D83C07D6A@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This renames 'apply_relevant_default_downgrade' to
'service_downgrade_online_state_if_default'. This function does one
thing and one thing only: downgrades the IPv4 and IPv6 configuration
state from "online" to "ready" if and only if the specified service is
the default service (that is, has the default route) and its states are
"online". The revised name more clearly indicates that role and the
action of the function, is less ambiguous, and aligns with the newly-
renamed 'service_downgrade_online_state', which it, in turn, calls.
---
 src/service.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index badbdb3f..7817f7fa 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5028,7 +5028,7 @@ static void service_downgrade_online_state(struct =
connman_service *service)
 						=
CONNMAN_IPCONFIG_TYPE_IPV6);
 }
=20
-static void apply_relevant_default_downgrade(struct connman_service =
*service)
+static void service_downgrade_online_state_if_default(struct =
connman_service *service)
 {
 	struct connman_service *def_service;
=20
@@ -5081,7 +5081,8 @@ static void switch_service_order(struct =
connman_service *demoted_service,
 		connman_service_get_identifier(promoted_service),
 		connman_service_is_default(promoted_service));
=20
-	apply_relevant_default_downgrade(demoted_service);
+	service_downgrade_online_state_if_default(demoted_service);
+
 	src =3D g_list_find(service_list, promoted_service);
 	dst =3D g_list_find(service_list, demoted_service);
=20
--=20
2.42.0

