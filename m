Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF71D53D
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 75848730F7
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:15 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 3196B7310B
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:15 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/5] Address Unhandled Gateway Route Lifecycle Events/Transitions
Date: Tue, 19 Dec 2023 21:56:08 -0800
Message-ID: <20231220055613.2287074-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

There were a number of "escapes" or unhandled events and transitions
that did not adhere to the documented gateway configuration lifecycle
/ state machine.

Failure to handle these was resulting in duplicate default routes, no
default routes, and incorrect default route priorities for some
services and their underlying network interfaces.

These "escapes" were handled in three primary ways with this patch series:

  1. Leveraging '__connman_inet_rtnl_recv' in 'iproute_default_modify'.
  2. Leveraging -ESRCH returned by 'iproute_default_modify'.
  3. Adding explicit conditional cases for the "escapes" not otherwise
     covered by (1) and (2).

Grant Erickson (5):
  inet: Use '__connman_inet_rtnl_recv' for RTNL default route
    transaction.
  gateway: Handle -ESRCH in 'unset_default_gateway_route_common'.
  gateway: Address unhandled gateway lifecycle events/transitions.
  gateway: Add and leveage 'gateway_config_set_{,in}active'.
  gateway: Expand the @param documentation for
    'yield_default_gateway{,_for_type}'.

 src/gateway.c | 80 +++++++++++++++++++++++++++++++++++++++------------
 src/inet.c    |  6 ++++
 2 files changed, 68 insertions(+), 18 deletions(-)

-- 
2.42.0

