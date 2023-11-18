Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28B360
	for <connman@lists.linux.dev>; Sat, 18 Nov 2023 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B8392730FE
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 19:22:59 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6F66B73145
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 19:22:59 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] service: Document 'handle_online_check_{failure,success}'.
Date: Fri, 17 Nov 2023 16:22:44 -0800
Message-ID: <20231118002244.723157-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231118002244.723157-1-gerickson@nuovations.com>
References: <20231118002244.723157-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'handle_online_check_{failure,success}'
functions.
---
 src/service.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/src/service.c b/src/service.c
index 34608ba9ce67..9808028637dd 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1917,6 +1917,40 @@ static void reschedule_online_check(struct connman_service *service,
 		online_check_state->interval++;
 }
 
+/**
+ *  @brief
+ *    Handle the successful completion of an "online" HTTP-based
+ *    Internet reachability check for the specified network service
+ *    and IP configuration type.
+ *
+ *  This handles the completion of a successful "online" HTTP-based
+ *  Internet reachability check for the specified network service and
+ *  IP configuration type. This effectively "bookends" an earlier
+ *  #__connman_service_wispr_start.
+ *
+ *  @param[in,out]  service             A pointer to the mutable service
+ *                                      for which to handle a
+ *                                      successful previously-requested
+ *                                      online check.
+ *  @param[in]      type                The IP configuration type for
+ *                                      which to handle a successful
+ *                                      previously-requested online
+ *                                      check.
+ *  @param[in,out]  online_check_state  A pointer to the online check
+ *                                      state for @a service
+ *                                      associated with @a type.
+ *  @param[in]      oneshot             A Boolean indicating whether the
+ *                                      online check mode is
+ *                                      "one-shot" (true) or
+ *                                      "continuous" (false).
+ *
+ *  @returns
+ *    True if another online check should be scheduled; otherwise,
+ *    false.
+ *
+ *  @sa handle_online_check_failure
+ *
+ */
 static bool handle_online_check_success(struct connman_service *service,
 				enum connman_ipconfig_type type,
 				struct online_check_state *online_check_state,
@@ -1941,6 +1975,47 @@ static bool handle_online_check_success(struct connman_service *service,
 	return reschedule;
 }
 
+/**
+ *  @brief
+ *    Handle the failed completion of an "online" HTTP-based
+ *    Internet reachability check for the specified network service
+ *    and IP configuration type.
+ *
+ *  This handles the completion of a failed "online" HTTP-based
+ *  Internet reachability check for the specified network service and
+ *  IP configuration type. This effectively "bookends" an earlier
+ *  #__connman_service_wispr_start.
+ *
+ *  @param[in,out]  service             A pointer to the mutable service
+ *                                      for which to handle a
+ *                                      failed previously-requested
+ *                                      online check.
+ *  @param[in]      type                The IP configuration type for
+ *                                      which to handle a failed
+ *                                      previously-requested online
+ *                                      check.
+ *  @param[in]      ipconfig_state      The current @a type IP
+ *                                      configuration state for @a
+ *                                      service.
+ *  @param[in,out]  online_check_state  A pointer to the online check
+ *                                      state for @a service
+ *                                      associated with @a type.
+ *  @param[in]      oneshot             A Boolean indicating whether the
+ *                                      online check mode is
+ *                                      "one-shot" (true) or
+ *                                      "continuous" (false).
+ *  @param[in]      err                 The error status associated with
+ *                                      the failed previously-requested
+ *                                      online check. This is expected
+ *                                      to be less than zero ('< 0').
+ *
+ *  @returns
+ *    True if another online check should be scheduled; otherwise,
+ *    false.
+ *
+ *  @sa handle_online_check_success
+ *
+ */
 static bool handle_online_check_failure(struct connman_service *service,
 				enum connman_ipconfig_type type,
 				enum connman_service_state ipconfig_state,
-- 
2.42.0

