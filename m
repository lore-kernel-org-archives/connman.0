Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B51642B
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6891773203
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:28 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2A6487321E
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:28 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 45/60] service: Document 'handle_{continuous,oneshot}_online_check_failure'.
Date: Thu, 21 Dec 2023 14:34:52 -0800
Message-ID: <20231221223508.2365510-46-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221223508.2365510-1-gerickson@nuovations.com>
References: <20231221223508.2365510-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the
'handle_{continuous,oneshot}_online_check_failure' functions.
---
 src/service.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/src/service.c b/src/service.c
index b2eb00a3e774..20cc5914a016 100644
--- a/src/service.c
+++ b/src/service.c
@@ -3283,6 +3283,47 @@ static void online_check_log_failure(const struct connman_service *service,
 		strerror(-err));
 }
 
+/**
+ *  @brief
+ *    Handle the failed completion of an one-shot mode "online"
+ *    HTTP-based Internet reachability check for the specified network
+ *    service and IP configuration type for the "one-shot" online
+ *    check mode.
+ *
+ *  This handles the completion of a failed one-shot mode "online"
+ *  HTTP-based Internet reachability check for the specified network
+ *  service and IP configuration type for the "one-shot" online check
+ *  mode. This effectively "bookends" an earlier
+ *  #__connman_service_wispr_start.
+ *
+ *  This simply indicates that rescheduling another check is desired.
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
+ *  @param[in]      err                 The error status associated with
+ *                                      the failed previously-requested
+ *                                      online check. This is expected
+ *                                      to be less than zero ('< 0').
+ *
+ *  @returns
+ *    True, unconditionally.
+ *
+ *  @sa handle_online_check_failure
+ *  @sa handle_oneshot_online_check_failure
+ *
+ */
 static bool handle_oneshot_online_check_failure(
 			struct connman_service *service,
 			enum connman_ipconfig_type type,
@@ -3299,6 +3340,46 @@ static bool handle_oneshot_online_check_failure(
 	return reschedule;
 }
 
+/**
+ *  @brief
+ *    Handle the failed completion of an one-shot mode "online"
+ *    HTTP-based Internet reachability check for the specified network
+ *    service and IP configuration type for the "continuous" online
+ *    check mode.
+ *
+ *  This handles the completion of a failed continuous mode "online"
+ *  HTTP-based Internet reachability check for the specified network
+ *  service and IP configuration type for the "continuous" online check
+ *  mode. This effectively "bookends" an earlier
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
+ *  @param[in]      err                 The error status associated with
+ *                                      the failed previously-requested
+ *                                      online check. This is expected
+ *                                      to be less than zero ('< 0').
+ *
+ *  @returns
+ *    True if another online check should be scheduled; otherwise,
+ *    false.
+ *
+ *  @sa handle_online_check_failure
+ *  @sa handle_continuous_online_check_failure
+ *
+ */
 static bool handle_continuous_online_check_failure(
 			struct connman_service *service,
 			enum connman_ipconfig_type type,
-- 
2.42.0

