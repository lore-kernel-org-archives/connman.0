Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B312FE0D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C9E0F73208
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:24 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8581873224
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:24 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 65/90] connection: Document 'compute_low_priority_metric'.
Date: Wed,  6 Dec 2023 15:50:31 -0800
Message-ID: <20231206235056.322578-69-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206235056.322578-1-gerickson@nuovations.com>
References: <20231206235056.322578-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'compute_low_priority_metric' function.
---
 src/connection.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 7bfbefb2cfda..b2b5f01867b9 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1988,12 +1988,57 @@ static int unset_default_gateway(struct gateway_data *data,
 	return mutate_default_gateway(data, type, &ops, __func__);
 }
 
+/**
+ *  @brief
+ *    Compute and return a low-priority gateway default route metric
+ *    unique to the specified gateway data.
+ *
+ *  This computes and returns a low-priority gateway default route
+ *  metric unique to the specified gateway data, @a data.
+ *
+ *  @param[in]  data  A pointer to the immutable gateway data with
+ *                    which to compute the low-priority default route
+ *                    metric.
+ *
+ *  @returns
+ *    The low-priority default route metric/priority.
+ *
+ */
 static uint32_t compute_low_priority_metric(const struct gateway_data *data)
 {
 	static const uint32_t metric_base = UINT32_MAX;
 	static const uint32_t metric_ceiling = (1 << 20);
 	static const uint32_t metric_index_step = (1 << 10);
 
+	/*
+	 * The algorithm uses the network interface index since it is
+	 * assumed to be stable for the uptime of the network interface
+	 * and, consequently, the potential maximum lifetime of the route.
+	 *
+	 * The algorithm establishes UINT32_MAX as the metric base (the
+	 * lowest possible priority) and a somewhat-arbitrary 2^20 as the
+	 * ceiling (to keep metrics out of a range that might be used by
+	 * other applications). The metric is then adjusted in increments
+	 * of 1,024 (2^10) from the base, but less than the ceiling, by
+	 * multiplying the increment by the network interface index. This
+	 * is easy and simple to compute and is invariant on service
+	 * order.
+	 *
+	 * In the fullness of time, the "rule of least astonishment" for
+	 * Connection Manager might be that low priority metrics follow
+	 * the service order with the default service always having metric
+	 * zero (0) and lowest priority metric assigned to the lowest
+	 * priority service, etc. Achieving this would require 1) caching
+	 * the computed metric in the gateway data since services may
+	 * re-sort by the time we are asked to recompute high- and
+	 * low-priority routes and we need a stable and matching metric to
+	 * successfully delete a previously-created route and 2) having
+	 * access to an API (such as
+	 * '__connman_service_get_order(data->service)') that exposes a
+	 * strictly-in/decreasing service order with no duplicates. Today,
+	 * there is no such API nor is there such a durable service order
+	 * meeting that mathematical requirement.
+	 */
 	return MAX(metric_ceiling,
 				metric_base -
 				(data->index * metric_index_step));
-- 
2.42.0

