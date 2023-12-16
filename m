Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6F12E57
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id E25C17314E
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:29 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id A642673171
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:29 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 11/11] wispr: Leverage '__connman_service_get_route_metric'.
Date: Fri, 15 Dec 2023 22:12:23 -0800
Message-ID: <20231216061223.2199037-12-gerickson@nuovations.com>
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

This leverages '__connman_service_get_route_metric' to select an
appropriate service-specific route metric/priority when adding or
deleting WISPr host routes.

This allows multiple such routes to coexist simultaneously, supporting
"continuous" mode online checks in which one or more services may be
conducting "online" WISPr-based Internet reachability checks as they
move in and out of reachability success/failure.
---
 src/wispr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 1af880118e14..efc0ca2fbaa9 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -708,6 +708,17 @@ static bool wispr_route_request(const char *address, int ai_family,
 		return false;
 	}
 
+	result = __connman_service_get_route_metric(wp_context->service,
+				&metric);
+	if (result < 0) {
+		DBG("failed to get metric for service %p (%s): %s (%d)",
+			wp_context->service,
+			connman_service_get_identifier(wp_context->service),
+			strerror(-result), result);
+
+		return false;
+	}
+
 	DBG("service %p (%s) metric %u",
 		wp_context->service,
 		connman_service_get_identifier(wp_context->service),
-- 
2.42.0

