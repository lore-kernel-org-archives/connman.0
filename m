Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBED1F601
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C2A3D7339B
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 19:24:32 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec] (unknown [IPv6:2601:647:5a00:15c1:21dc:c5b4:cac3:3aec])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 92227733AD
	for <connman@lists.linux.dev>; Fri,  3 Nov 2023 19:24:32 -0400 (EDT)
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
Subject: [PATCH 3/3] service: Add documentation to state downgrade-related
 functions.
Date: Fri, 3 Nov 2023 16:24:32 -0700
References: <7581F8B3-D243-4268-B344-FB28A7A15E72@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7581F8B3-D243-4268-B344-FB28A7A15E72@nuovations.com>
Message-Id: <334E2D51-FAFC-4036-AF9C-EC99E62F01D8@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Add documentation to the service state downgrade-related functions,
'service_downgrade_online_state_' and
'service_downgrade_online_state_if_default'.
---
 src/service.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/src/service.c b/src/service.c
index 7817f7fa..75ed9ccd 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5006,6 +5006,23 @@ static bool check_suitable_state(enum =
connman_service_state a,
 	return a =3D=3D b;
 }
=20
+/**
+ *  @brief
+ *    Downgrade the service IPv4 and IPv6 states from "online" to
+ *    "ready".
+ *
+ *  This attempts to downgrade the IPv4 and IPv6 states of the
+ *  specified service to "ready" if they are "online".
+ *
+ *  @param[in,out]  service  A pointer to the mutable service whose =
IPv4
+ *                           and IPv6 states, if
+ *                           #CONNMAN_SERVICE_STATE_ONLINE, are to be
+ *                           downgraded to
+ *                           #CONNMAN_SERVICE_STATE_READY.
+ *
+ *  @sa service_downgrade_online_state_if_default
+ *
+ */
 static void service_downgrade_online_state(struct connman_service =
*service)
 {
 	if (!service)
@@ -5028,6 +5045,26 @@ static void service_downgrade_online_state(struct =
connman_service *service)
 						=
CONNMAN_IPCONFIG_TYPE_IPV6);
 }
=20
+/**
+ *  @brief
+ *    Downgrade the service IPv4 and IPv6 states from "online" to
+ *    "ready" if and only if the service is the default service and it
+ *    is "online".
+ *
+ *  This attempts to downgrade the IPv4 and IPv6 states of the
+ *  specified service to "ready" if and only if the service is the
+ *  default service and its combined service state is "online".
+ *
+ *  @param[in,out]  service  A pointer to the mutable service whose =
IPv4
+ *                           and IPv6 states, if it is the default
+ *                           service and its combined service state is
+ *                           #CONNMAN_SERVICE_STATE_ONLINE, are to be
+ *                           downgraded to
+ *                           #CONNMAN_SERVICE_STATE_READY.
+ *
+ *  @sa service_downgrade_online_state
+ *
+ */
 static void service_downgrade_online_state_if_default(struct =
connman_service *service)
 {
 	struct connman_service *def_service;
--=20
2.42.0

