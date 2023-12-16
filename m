Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB3013AD2
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6C42673106
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:06 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:29e5:59c3:7c60:32d3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2B1DF73123
	for <connman@lists.linux.dev>; Sat, 16 Dec 2023 03:28:06 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/9] inet: Add Missing Gateway Parameter to Host Route Deletion Interfaces
Date: Sat, 16 Dec 2023 00:27:55 -0800
Message-ID: <20231216082805.2221938-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Routing table manipulation, host routes among them, should be
fundamentally symmetric. The routing table entry parameters used to
add a route should be identical to those used to delete the same
route. Otherwise, an 'ESRCH' error may occur which, at present, are
suppressed due to commit e03a01d3182d ("inet: Fix error handling when
adding/removing routes") that is masking route deletion errors where
this gateway parameter asymmetry is occurring.

This adds a previously-missing gateway address parameter to the
'connman_inet_del_{,ipv6_}host_route' functions. In addition, call
sites to 'connman_inet_del_{,ipv6_}host_route' are updated to pass the
gateway parameter.

In addition, in the process, this refactors 'nameserver_del_routes'
into a second, helper function 'del_nameserver_route' such that host
route deletion is separated from DNS server iteration. This structure
now mirrors that of 'nameserver_add_routes' and 'add_nameserver_route'
since, again, route addition and deletion should be symmetric.

NOTE: This is only the first half of the necessary change. The second
half is revising the actual implementation of
'connman_inet_del_{,ipv6_}host_route' to take advantage of the
newly-added gateway parameter. Implementation notes in each of
'connman_inet_del_{,ipv6_}host_route' have been added toward that end.

Grant Erickson (9):
  service: Refactor 'nameserver_del_routes'.
  service: Add gateway parameter to DNS host route deletion paths.
  inet: Add gateway parameter to 'connman_inet_del_{,ipv6_}host_route'.
  inet: Document 'connman_inet_{add,del}_{,ipv6_}host_route'.
  service: Const-qualify 'add_nameserver_route'.
  service: Add 'DBG' to 'add_nameserver_route'.
  inet: Document '{add,del}_nameserver_route'.
  inet: Document 'nameserver_{add,del}_routes'.
  inet: Document '__connman_service_nameserver_{add,del}_routes'.

 include/inet.h |  17 ++--
 src/connman.h  |   1 +
 src/gateway.c  |  33 +++++---
 src/inet.c     | 184 ++++++++++++++++++++++++++++++++++++++--
 src/service.c  | 225 ++++++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 419 insertions(+), 41 deletions(-)

-- 
2.42.0

