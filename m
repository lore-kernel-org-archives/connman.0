Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DE36F
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C1AF2730F3
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:33 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8159273100
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:10:33 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/8] inet: Add IPv{4,6} Host/Network Route Add/Delete with Metric / Priority Functions
Date: Thu, 14 Dec 2023 16:10:23 -0800
Message-ID: <20231215001032.2127527-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds and documents
'connman_inet_{add,del}_{,ipv6_}{host,network}_route_with_metric'
functions that provide the ability to add/delete an IPv4 or IPv6 host
or network route with an explicit metric / priority.

As a convenience, the
'connman_inet_{add,del}_{,ipv6_}network_route_with_metric' network
route functions allow the caller to provide the IPv4 or IPv6 network
address in masked (for example, 169.254.0.0/16) or unmasked (for
example, 169.254.75.191/16) form. The function will mask the address,
based on the provided prefix length, before modifying the route with
it.

Grant Erickson (8):
  inet: Relocate 'rtnl_route_cmd2string'.
  inet: Reorder IPv6 host and network route function declarations.
  inet: Add IPv{4,6} host/network route functions with metric/priority.
  connection: Document 'inet_get_addr_data'.
  connection: Document 'inet_mask_addr_data'.
  connection: Document 'inet_modify_host_or_network_route'.
  connection: Document 'inet_modify_{,ipv4_,ipv6_}{host,network}_route'.
  inet: Document IPv{4,6} host/network route functions with
    metric/priority.

 include/inet.h |   43 +-
 src/inet.c     | 1275 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 1271 insertions(+), 47 deletions(-)

-- 
2.42.0

