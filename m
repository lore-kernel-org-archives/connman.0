Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648512B85
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 05A5273118
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:26 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BD74773128
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:25 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 01/11] service: Add '__connman_service_get_route_metric'.
Date: Fri, 15 Dec 2023 22:12:13 -0800
Message-ID: <20231216061223.2199037-2-gerickson@nuovations.com>
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

This adds a new non-public service interface,
'__connman_service_get_route_metric', which attempts to get the route
metric/priority for the specified service based on the current service
and services state.

If the service is the default or if it is the only service, then the
metric is zero (0). Otherwise, a low-priority metric (metric > 0)
unique toservice and its underlying network interface is computed and
returned.
---
 src/connman.h |  2 ++
 src/service.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/src/connman.h b/src/connman.h
index 24e667d8e1f4..90d5a34b8c58 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -733,6 +733,8 @@ void __connman_service_remove_from_network(struct connman_network *network);
 void __connman_service_read_ip4config(struct connman_service *service);
 void __connman_service_read_ip6config(struct connman_service *service);
 
+int __connman_service_get_route_metric(const struct connman_service *service,
+				uint32_t *metric);
 struct connman_ipconfig *__connman_service_get_ip4config(
 				struct connman_service *service);
 struct connman_ipconfig *__connman_service_get_ip6config(
diff --git a/src/service.c b/src/service.c
index 020e43fa4038..f0b37e9a0d41 100644
--- a/src/service.c
+++ b/src/service.c
@@ -6539,6 +6539,70 @@ __connman_service_get_network(struct connman_service *service)
 	return service->network;
 }
 
+static size_t service_get_count(void)
+{
+	return service_list ? g_list_length(service_list) : 0;
+}
+
+int __connman_service_get_route_metric(const struct connman_service *service,
+				uint32_t *metric)
+{
+	static const uint32_t metric_base = UINT32_MAX;
+	static const uint32_t metric_ceiling = (1 << 20);
+	static const uint32_t metric_index_step = (1 << 10);
+	int index;
+
+	DBG("");
+
+	if (!service || !metric)
+		return -EINVAL;
+
+	DBG("service %p (%s) metric %p",
+		service, connman_service_get_identifier(service),
+		metric);
+
+	index = __connman_service_get_index(service);
+	if (index < 0)
+		return -ENXIO;
+
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
+	 * priority service, etc. Achieving this would require having
+	 * access to APIs (such as '__connman_service_get_count()' and
+	 * '__connman_service_get_order(service)') that expose a
+	 * strictly-in/decreasing service order with no duplicates. Today,
+	 * there is no such API nor is there such a durable service order
+	 * meeting that mathematical requirement.
+	 */
+
+	if (service_get_count() <= 1 || connman_service_is_default(service))
+		*metric = 0;
+	else
+		*metric = MAX(metric_ceiling,
+					metric_base -
+					(index * metric_index_step));
+
+	DBG("metric %u", *metric);
+
+	return 0;
+}
+
 struct connman_ipconfig *
 __connman_service_get_ip4config(struct connman_service *service)
 {
-- 
2.42.0

