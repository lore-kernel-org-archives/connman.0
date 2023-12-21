Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2685B664
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9EAE873224
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:46 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6033C73232
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:46 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 26/60] service: Capture IP configuration state by value rather than by pointer.
Date: Wed, 20 Dec 2023 22:16:49 -0800
Message-ID: <20231221061734.2344286-27-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221061734.2344286-1-gerickson@nuovations.com>
References: <20231221061734.2344286-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

With recent refactoring, there is no longer any need to capture the IP
configuration state by pointer in 'complete_online_check'. Instead,
capture it by value.
---
 src/service.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/service.c b/src/service.c
index a51c1685b308..2017370d7ce8 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2464,11 +2464,12 @@ static bool handle_online_check_failure(struct connman_service *service,
 {
 	bool reschedule = false;
 
-	DBG("service %p (%s) type %d (%s) "
+	DBG("service %p (%s) type %d (%s) state %d (%s) "
 		"one-shot %u err %d (%s)\n",
 		service,
 		connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type),
+		ipconfig_state, state2string(ipconfig_state),
 		oneshot, err, strerror(-err));
 
 	/*
@@ -2550,7 +2551,7 @@ static void complete_online_check(struct connman_service *service,
 					int err)
 {
 	struct online_check_state *online_check_state;
-	enum connman_service_state *ipconfig_state;
+	enum connman_service_state ipconfig_state;
 	bool reschedule = false;
 
 	DBG("service %p (%s) type %d (%s) "
@@ -2562,10 +2563,10 @@ static void complete_online_check(struct connman_service *service,
 
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4) {
 		online_check_state = &service->online_check_state_ipv4;
-		ipconfig_state = &service->state_ipv4;
+		ipconfig_state = service->state_ipv4;
 	} else if (type == CONNMAN_IPCONFIG_TYPE_IPV6) {
 		online_check_state = &service->online_check_state_ipv6;
-		ipconfig_state = &service->state_ipv6;
+		ipconfig_state = service->state_ipv6;
 	} else
 		return;
 
@@ -2577,7 +2578,7 @@ static void complete_online_check(struct connman_service *service,
 	else
 		reschedule = handle_online_check_failure(service,
 					 type,
-					 *ipconfig_state,
+					 ipconfig_state,
 					 online_check_state,
 					 !enable_online_to_ready_transition,
 					 err);
-- 
2.42.0

