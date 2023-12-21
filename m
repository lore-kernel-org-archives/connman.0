Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA7B664
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 89A4D73200
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:56 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4BAD773226
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:56 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 51/60] service: Document 'service_route_changed'.
Date: Wed, 20 Dec 2023 22:17:14 -0800
Message-ID: <20231221061734.2344286-52-gerickson@nuovations.com>
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

This adds documentation to the 'service_route_changed' functions.
---
 src/service.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/service.c b/src/service.c
index 0f3ea526967c..07322b80bdf7 100644
--- a/src/service.c
+++ b/src/service.c
@@ -9911,6 +9911,25 @@ static void service_ip_release(struct connman_ipconfig *ipconfig,
 	settings_changed(service, ipconfig);
 }
 
+/**
+ *  @brief
+ *    Handler for IP configuration routes changes.
+ *
+ *  This is the IP configuration handler for route set (add) and unset
+ *  (delete) operations for the specified IP configuration and its
+ *  associated network interface name.
+ *
+ *  @param[in]  ipconfig  A pointer to the IP configuration associated
+ *                        with the network service route change.
+ *  @param[in]  ifname    A pointer to an immutable null-terminated
+ *                        C string containing the network interface
+ *                        name associated with the route change.
+ *
+ *  @sa __connman_ipconfig_set_data
+ *  @sa __connman_ipconfig_set_ops
+ *  @sa settings_changed
+ *
+ */
 static void service_route_changed(struct connman_ipconfig *ipconfig,
 				const char *ifname)
 {
-- 
2.42.0

