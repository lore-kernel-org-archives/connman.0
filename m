Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89325749
	for <connman@lists.linux.dev>; Fri, 24 Nov 2023 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 00C4373106
	for <connman@lists.linux.dev>; Fri, 24 Nov 2023 12:40:29 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id ACC737313E
	for <connman@lists.linux.dev>; Fri, 24 Nov 2023 12:40:28 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 3/3] service: Add documentation to 'address_updated'.
Date: Fri, 24 Nov 2023 09:40:25 -0800
Message-ID: <20231124174025.971512-4-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124174025.971512-1-gerickson@nuovations.com>
References: <20231116030912.636756-1-gerickson@nuovations.com>
 <20231124174025.971512-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'address_updated' function.
---
 src/service.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/service.c b/src/service.c
index ce02aa62fb7c..86eb74d26c6e 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2235,6 +2235,33 @@ void __connman_service_wispr_start(struct connman_service *service,
 			online_check_connect_timeout_ms, complete_online_check);
 }
 
+/**
+ *  @brief
+ *    Handle an update to the address(es) for the specified network
+ *    service and IP configuration type.
+ *
+ *  This attempts to handle an address change or update for the
+ *  specified network service and IP configuration type if and only if
+ *  it is connected (that is, #is_connected returns true) and it is
+ *  the default service (that is, has the default route).
+ *
+ *  If the service meets those criteria, then nameservers are
+ *  refreshed, an "online" HTTP-based Internet reachability check is
+ *  initiated, and a time-of-day synchronization is requested.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           for which there was an address change or
+ *                           update.
+ *  @param[in]      type     The IP configuration type for @a service
+ *                           for which there was an address change or
+ *                           update.
+ *
+ *  @sa nameserver_remove_all
+ *  @sa nameserver_add_all
+ *  @sa start_online_check
+ *  @sa __connman_timeserver_sync
+ *
+ */
 static void address_updated(struct connman_service *service,
 			enum connman_ipconfig_type type)
 {
-- 
2.42.0

