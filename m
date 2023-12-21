Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594F20317
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 48C8B73207
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:14 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 0A32A7321E
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:13 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 10/60] service: Document 'online_check_active_{clear,set}'.
Date: Thu, 21 Dec 2023 14:34:17 -0800
Message-ID: <20231221223508.2365510-11-gerickson@nuovations.com>
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

This adds documentation to the 'online_check_active_{clear,set}'
functions.
---
 src/service.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/src/service.c b/src/service.c
index 4238d81c7c0d..cd1e56d0cf7a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1800,12 +1800,54 @@ static void online_check_active_set_value(struct connman_service *service,
 		service->online_check_state_ipv6.active = active;
 }
 
+/**
+ *  @brief
+ *    Set, or assert, the "online" HTTP-based Internet reachability
+ *    check active state.
+ *
+ *  This sets, or asserts, the "online" HTTP-based Internet
+ *  reachability check active state for the specified network service
+ *  IP configuration type.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to set the "online" HTTP-
+ *                           based Internet reachability active
+ *                           state.
+ *  @param[in]      type     The IP configuration type for which to
+ *                           set the "online" HTTP-based Internet
+ *                           reachability active state.
+ *
+ *  @sa online_check_active_set_value
+ *  @sa online_check_is_active
+ *
+ */
 static void online_check_active_set(struct connman_service *service,
 		enum connman_ipconfig_type type)
 {
 	online_check_active_set_value(service, type, true);
 }
 
+/**
+ *  @brief
+ *    Clear, or deassert, the "online" HTTP-based Internet
+ *    reachability check active state.
+ *
+ *  This clears, or deasserts, the "online" HTTP-based Internet
+ *  reachability check active state for the specified network service
+ *  IP configuration type.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which to clear the "online" HTTP-
+ *                           based Internet reachability active
+ *                           state.
+ *  @param[in]      type     The IP configuration type for which to
+ *                           clear the "online" HTTP-based Internet
+ *                           reachability active state.
+ *
+ *  @sa online_check_active_set_value
+ *  @sa online_check_is_active
+ *
+ */
 static void online_check_active_clear(struct connman_service *service,
 		enum connman_ipconfig_type type)
 {
-- 
2.42.0

