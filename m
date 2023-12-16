Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774F12B6E
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A0574730F9
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:25 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5F80973122
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 01:12:25 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 00/11] service/wispr: Add Per-service-unique WISPr Host Route Metric/Priority
Date: Fri, 15 Dec 2023 22:12:12 -0800
Message-ID: <20231216061223.2199037-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This add and leverages '__connman_service_get_route_metric' to select
an appropriate service-specific route metric/priority when adding or
deleting WISPr host routes.
    
This allows multiple such routes to coexist simultaneously, supporting
"continuous" mode online checks in which one or more services may be
conducting "online" WISPr-based Internet reachability checks as they
move in and out of reachability success/failure.

'__connman_service_get_route_metric' is a non-public service
interface, which attempts to get the route metric/priority for the
specified service based on the current service and services state.

If the service is the default or if it is the only service, then the
metric is zero (0). Otherwise, a low-priority metric (metric > 0)
unique to the service and its underlying network interface is computed
and returned.

Grant Erickson (11):
  service: Add '__connman_service_get_route_metric'.
  service: Document '__connman_service_get_route_metric'.
  wispr: Expand 'DBG' in 'wispr_portal_detect'.
  wispr: Add 'DBG' to '__connman_wispr_start' error path.
  wispr: Update 'DBG' in '__connman_wispr_start'.
  wispr: Refactor 'free_wispr_routes'.
  wispr: Simplify IPv4 vs. IPv6 host route management.
  wispr: Document 'free_wispr_route{,s}'.
  wispr: Document 'wispr_route'.
  wispr: Document 'wispr_portal_context_route_ops'.
  wispr: Leverage '__connman_service_get_route_metric'.

 src/connman.h |   2 +
 src/service.c |  98 ++++++++++++++++++++++++
 src/wispr.c   | 207 +++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 271 insertions(+), 36 deletions(-)

-- 
2.42.0

