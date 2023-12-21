Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA487691C
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 743B073214
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:15 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3424973225
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 17:35:15 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 13/60] service: Document 'start_online_check_if_connected_with_type'.
Date: Thu, 21 Dec 2023 14:34:20 -0800
Message-ID: <20231221223508.2365510-14-gerickson@nuovations.com>
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
'start_online_check_if_connected_with_type' function.
---
 src/service.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/service.c b/src/service.c
index b1880fbc6457..b35a4dad1f29 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2553,6 +2553,40 @@ static void complete_online_check(struct connman_service *service,
 		online_check_active_clear(service, type);
 }
 
+/**
+ *  @brief
+ *    Start HTTP-based Internet reachability probes if the specified
+ *    service is connected.
+ *
+ *  This attempts to start IPv4 or IPv6 HTTP-based Internet
+ *  reachability probes if the IPv4 state or IPv6 state is connected
+ *  (that is, "ready" or "online") and if the online check state is
+ *  not already active for the specified network service IP
+ *  configuration type.
+ *
+ *  @param[in,out]  service  A pointer to a mutable service on which
+ *                           to start "online" HTTP-based Internet
+ *                           reachability checks if the IP
+ *                           configuration state associated with @a
+ *                           type is "connected" (that is, "ready" or
+ *                           "online").
+ *  @param[in]      type     The IP configuration type for which to
+ *                           start the "online" HTTP-based Internet
+ *                           reachability checks.
+ *
+ *  @retval  0          If successful.
+ *  @retval  -EINVAL    If @a service is null or @a type is invalid.
+ *  @retval  -EPERM     If online checks are disabled via
+ *                      configuration.
+ *  @retval  -ENOTCONN  If @a service is not "connected" (that is,
+ *                      "ready" or "online").
+ *  @retval  -EALREADY  If online checks are already active for @a
+ *                      service.
+ *
+ *  @sa start_online_check
+ *  @sa start_online_check_if_connected_with_type
+ *
+ */
 static int start_online_check_if_connected_with_type(
 					struct connman_service *service,
 					enum connman_ipconfig_type type)
-- 
2.42.0

