Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3719BCE
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A02D673144
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 16:03:43 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 54094731A8
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 16:03:43 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 58/58] service: Make DBG in '__connman_service_ipconfig_indicate_state' consistent.
Date: Fri, 17 Nov 2023 13:03:36 -0800
Message-ID: <20231117210336.699149-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This makes the DBG statement in '__connman_service_ipconfig_indicate_state'
consistent in format of 'service <service_pointer> (<service_name>) type
<ipconfig_type> (<ipconfig_type_name>)' with that of other DBG statements
in the module.

This makes at-a-glance, columnar correlation and comparison of service
activities easier.
---
 src/service.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index 81a1bebdc14b..a5aef1402933 100644
--- a/src/service.c
+++ b/src/service.c
@@ -7126,11 +7126,11 @@ int __connman_service_ipconfig_indicate_state(struct connman_service *service,
 	if (old_state == new_state)
 		return -EALREADY;
 
-	DBG("service %p (%s) old state %d (%s) new state %d (%s) type %d (%s)",
+	DBG("service %p (%s) type %d (%s) old state %d (%s) new state %d (%s)",
 		service, connman_service_get_identifier(service),
+		type, __connman_ipconfig_type2string(type),
 		old_state, state2string(old_state),
-		new_state, state2string(new_state),
-		type, __connman_ipconfig_type2string(type));
+		new_state, state2string(new_state));
 
 	switch (new_state) {
 	case CONNMAN_SERVICE_STATE_UNKNOWN:
-- 
2.42.0

