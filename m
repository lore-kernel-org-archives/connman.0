Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642612B68
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6306373123
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:26 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2577173144
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:26 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 02/11] service: Document '__connman_service_get_route_metric'.
Date: Fri, 15 Dec 2023 22:12:14 -0800
Message-ID: <20231216061223.2199037-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231216061223.2199037-1-gerickson@nuovations.com>
References: <20231216061223.2199037-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the '__connman_service_get_route_metric'
function.
---
 src/service.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/service.c b/src/service.c
index f0b37e9a0d41..1f2c9f54db9a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6539,11 +6539,45 @@ __connman_service_get_network(struct connman_service *service)
 	return service->network;
 }
 
+/**
+ *  @brief
+ *    Return the current service count.
+ *
+ *  @returns
+ *    The current service count.
+ *
+ */
 static size_t service_get_count(void)
 {
 	return service_list ? g_list_length(service_list) : 0;
 }
 
+/**
+ *  @brief
+ *    Get the route metric/priority for the specified service.
+ *
+ *  This attempts to get the route metric/priority for the specified
+ *  service based on the current service and services state.
+ *
+ *  If the service is the default or if it is the only service, then
+ *  the metric is zero (0). Otherwise, a low-priority metric (metric >
+ *  0) unique to @a service and its underlying network interface is
+ *  computed and returned.
+ *
+ *  @param[in]      service  A pointer to the immutable service for
+ *                           which to get the route metric/priority.
+ *  @param[in,out]  metric   A pointer to storage for the route
+ *                           metric/priority, populated with the route
+ *                           metric/priority on success.
+ *
+ *  @retval  0        If successful.
+ *  @retval  -EINVAL  If @a service or @a metric are null.
+ *  @retval  -ENXIO   If the network interface index associated with
+ *                    @a service is invalid.
+ *
+ *  @sa connman_service_is_default
+ *
+ */
 int __connman_service_get_route_metric(const struct connman_service *service,
 				uint32_t *metric)
 {
-- 
2.42.0

