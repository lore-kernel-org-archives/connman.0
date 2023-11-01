Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76C1C290
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7E53073171
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 19:10:11 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 414667335B
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 19:10:11 -0400 (EDT)
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
Subject: [PATCH v2] Leverage 'connman_service_get_identifier' in DBG calls.
Date: Wed, 1 Nov 2023 16:10:10 -0700
References: <524C84BA-DC40-4292-A8DE-BA45E9E18DA6@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <524C84BA-DC40-4292-A8DE-BA45E9E18DA6@nuovations.com>
Message-Id: <FCD706D1-6338-4ABF-9D72-A167C034F7C9@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages 'connman_service_get_identifier' in DBG calls rather
than re-creating the same logic from 'connman_service_get_identifier'
in those same calls.
---
 src/service.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 78a000bc..5795026b 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4358,7 +4358,7 @@ static gboolean run_vpn_auto_connect(gpointer =
data) {
 		is_connected(def_service->state))) {
=20
 		DBG("stopped, default service %s connected %d",
-			def_service ? def_service->identifier : "NULL",
+			connman_service_get_identifier(def_service),
 			def_service ? is_connected(def_service->state) : =
-1);
 		goto out;
 	}
@@ -6483,7 +6483,7 @@ int =
__connman_service_ipconfig_indicate_state(struct connman_service =
*service,
 		return -EALREADY;
=20
 	DBG("service %p (%s) old state %d (%s) new state %d (%s) type %d =
(%s)",
-		service, service ? service->identifier : NULL,
+		service, connman_service_get_identifier(service),
 		old_state, state2string(old_state),
 		new_state, state2string(new_state),
 		type, __connman_ipconfig_type2string(type));
--=20
2.42.0=
