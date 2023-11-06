Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640D2D048
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8485E7321A
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 17:08:04 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd] (unknown [IPv6:2601:647:5a00:15c1:2c74:ca40:c8df:2dcd])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5200373398
	for <connman@lists.linux.dev>; Mon,  6 Nov 2023 17:08:04 -0500 (EST)
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
Subject: [PATCH 1/3] service: Add 'service_ipconfig_downgrade_online_state'.
Date: Mon, 6 Nov 2023 14:08:04 -0800
References: <817264F4-7F97-42ED-86CC-8A0B7495F482@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <817264F4-7F97-42ED-86CC-8A0B7495F482@nuovations.com>
Message-Id: <997C63F7-7D44-4FC0-83B0-4DE5FFC78C5E@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This introduces the function 'service_ipconfig_downgrade_online_state'
which attempts to downgrade the specified IP configuration state of the
specified service to "ready" if it is "online".
---
 src/service.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/src/service.c b/src/service.c
index dc9fa3ac..b76bbaeb 100644
--- a/src/service.c
+++ b/src/service.c
@@ -5252,6 +5252,57 @@ static bool check_suitable_state(enum =
connman_service_state a,
 	return a =3D=3D b;
 }
=20
+/**
+ *  @brief
+ *    Downgrade the service IP configuration state from "online" to
+ *    "ready".
+ *
+ *  This attempts to downgrade the specified IP configuration state of
+ *  the specified service to "ready" if it is "online".
+ *
+ *  @param[in,out]  service  A pointer to the mutable service whose IP
+ *                           configuration state, if
+ *                           #CONNMAN_SERVICE_STATE_ONLINE, is to be
+ *                           downgraded to
+ *                           #CONNMAN_SERVICE_STATE_READY.
+ *  @param[in]      state    The current IP configuration state of @a
+ *                           service.
+ *  @param[in]      type     The IP configuration type of @a service to
+ *                           try to downgrade.
+ *
+ *  @returns
+ *    True if the service state was downgraded for the specified IP
+ *    configuration type; otherwise, false.
+ *
+ *  @sa service_downgrade_online_state
+ *  @sa service_downgrade_online_state_if_default
+ *
+ */
+static bool service_ipconfig_downgrade_online_state(
+					struct connman_service *service,
+					enum connman_service_state =
state,
+					enum connman_ipconfig_type type)
+{
+	if (!service)
+		return false;
+
+	DBG("service %p (%s) type %d (%s) state %d (%s)",
+		service,
+		connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
+		state, state2string(state));
+
+	if (is_online(state)) {
+		__connman_service_ipconfig_indicate_state(service,
+						=
CONNMAN_SERVICE_STATE_READY,
+						type);
+
+		return true;
+	}
+
+	return false;
+}
+
 /**
  *  @brief
  *    Downgrade the service IPv4 and IPv6 states from "online" to
--=20
2.42.0

