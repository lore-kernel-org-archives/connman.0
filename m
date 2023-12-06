Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D9328C5
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id AB4C973208
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:33 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 6E11B73225
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:33 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 88/90] connection: Add @file comment.
Date: Wed,  6 Dec 2023 15:50:54 -0800
Message-ID: <20231206235056.322578-92-gerickson@nuovations.com>
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

This adds a detailed @file comment, providing a high-level overview of
the module, key issues and principles, and theory of operation.
---
 src/connection.c | 208 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 8f745a4387bb..47ec67e6717a 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -20,6 +20,214 @@
  *
  */
 
+/**
+ *  @file
+ *    This implements non-client-facing functionality for managing
+ *    network service gateways and routes. It also serves as a Linux
+ *    Routing Netlink (rtnl) listener for routing table additions and
+ *    deletions in the Linux kernel.
+ *
+ *    Gateway lifecycle is generally top-down, from user space to
+ *    kernel. That is, Connection Manager manages and adds/sets or
+ *    gateway routes and then uses notifications from the kernel
+ *    Routing Netlink (rtnl) to confirm and "activate" those
+ *    routes. Likewise, Connection Manager removes/clears/deletes
+ *    gateway routes an then uses notifications from the kernel
+ *    Routing Netlink (rtnl) to confirm and "inactivate" those
+ *    routes. The following is the state machine for that lifecycle:
+ *
+ *                              .----------.    SIOCADDRT /
+ *                              |          |    RTM_NEWROUTE
+ *           .------------------| Inactive |--------------------.
+ *           |                  |          |                    |
+ *           |                  '----------'                    |
+ *           | connman_rtnl                                     |
+ *           | .delgateway                                      |
+ *           |                                                  V
+ *      .---------.         SIOCADDRT / RTM_NEWROUTE        .-------.
+ *      |         |---------------------------------------->|       |
+ *      | Removed |                                         | Added |
+ *      |         |<----------------------------------------|       |
+ *      '---------'         SIOCDELRT / RTM_DELROUTE        '-------'
+ *           ^                                                  |
+ *           | SIOCDELRT /                                      |
+ *           | RTM_DELROUTE                                     |
+ *           |                   .--------.     connman_rtnl    |
+ *           |                   |        |     .newgateway     |
+ *           '-------------------| Active |<--------------------'
+ *                               |        |
+ *                               '--------'
+ *
+ *    Gateways, and their associated routes, are generally of two types:
+ *
+ *      1. High-priority (that is, metric 0) default route.
+ *
+ *         This is used by the default service and its underlying
+ *         network interface.
+ *
+ *      2. Low-priority (that is, metric > 0) default route.
+ *
+ *         This is used by non-default services and their underlying
+ *         network interface.
+ *
+ *         For IPv6, these are handled and managed automatically by
+ *         the kernel as part of Router Discovery (RD) Router
+ *         Advertisements (RAs) and because link-local addresses and
+ *         multi-homing are a natural part of IPv6, nothing needs to
+ *         be done here. These routes show up in 'ip -6 route show'
+ *         as:
+ *
+ *             default via fe80::f29f:c2ff:fe10:271e dev eth0
+ *                 proto ra metric 1024 expires 1622sec hoplimit 64
+ *                 pref medium
+ *             default via fe80::f29f:c2ff:fe10:271e dev wlan0
+ *                 proto ra metric 1024 expires 1354sec hoplimit 64
+ *                 pref medium
+ *
+ *         For IPv4, largely invented before the advent of link-local
+ *         addresses and multi-homing hosts, these need to be
+ *         fully-managed here and, with such management, show up in
+ *         'ip -4 route show' as low-priority (that is, high metric
+ *         value) default routes:
+ *
+ *             default via 192.168.2.1 dev wlan0 metric 4294967295
+ *
+ *         The other alternative to low-priority routes would be to
+ *         use "def1" default routes commonly used by VPNs that have a
+ *         prefix length of 1 (hence the "def1" name). These would
+ *         show up as:
+ *
+ *             0.0.0.0/1 via 192.168.2.1 dev wlan0
+ *             128.0.0.0/1 via 192.168.2.1 dev wlan0
+ *
+ *         However, since these require twice the number of routing
+ *         table entries and seem no more effective than the
+ *         low-priority route approach, this alternative is not used
+ *         here at present.
+ *
+ *    VPNs and point-to-point (P2P) links get special treatment but
+ *    otherwise utilize the same states and types as described above.
+ *
+ *    Operationally, down calls from outside this module generally
+ *    come from the following three functions:
+ *
+ *      1. __connman_connection_gateway_add
+ *      2. __connman_connection_gateway_remove
+ *      3. __connman_connection_update_gateway
+ *
+ *    and up calls generally come from the following two functions:
+ *
+ *      1. connection_newgateway
+ *      2. connection_delgateway
+ *
+ *    From these five functions above, we are then attempting to do
+ *    the following for a gateway associated with a network service
+ *    and its underlying network interface:
+ *
+ *      1. Set, or add, the high- or low-priority default route(s).
+ *      2. Unset, or remove, the high- or low-priority default route(s).
+ *      3. Promote the default route from low- to high-priority.
+ *      4. Demote the default route from high- to low-priority.
+ *
+ *    The call trees for these operations amount to:
+ *
+ *      set_default_gateway (1)
+ *        |
+ *        '-mutate_default_gateway
+ *            |
+ *            |-set_ipv4_high_priority_default_gateway
+ *            |   |
+ *            |   '-set_default_gateway_route_common
+ *            |       |
+ *            |       '-set_ipv4_high_priority_default_gateway_route_cb
+ *            |
+ *            '-set_ipv6_high_priority_default_gateway
+ *                |
+ *                '-set_default_gateway_route_common
+ *                    |
+ *                    '-set_ipv6_high_priority_default_gateway_route_cb
+ *
+ *      set_low_priority_default_gateway (1)
+ *        |
+ *        '-mutate_default_gateway
+ *            |
+ *            '-set_ipv4_low_priority_default_gateway
+ *                |
+ *                '-set_default_gateway_route_common
+ *                    |
+ *                    '-set_ipv4_low_priority_default_gateway_route_cb
+ *                        |
+ *                        '-compute_low_priority_metric
+ *
+ *      unset_default_gateway (2)
+ *        |
+ *        '-mutate_default_gateway
+ *            |
+ *            |-unset_ipv4_high_priority_default_gateway
+ *            |   |
+ *            |   '-unset_default_gateway_route_common
+ *            |       |
+ *            |       '-unset_ipv4_high_priority_default_gateway_route_cb
+ *            |
+ *            '-unset_ipv6_high_priority_default_gateway
+ *                |
+ *                '-unset_default_gateway_route_common
+ *                    |
+ *                    '-unset_ipv6_high_priority_default_gateway_route_cb
+ *
+ *      unset_low_priority_default_gateway (2)
+ *        |
+ *        '-mutate_default_gateway
+ *            |
+ *            '-unset_ipv4_low_priority_default_gateway
+ *                |
+ *                '-unset_default_gateway_route_common
+ *                    |
+ *                    '-unset_ipv4_low_priority_default_gateway_route_cb
+ *                        |
+ *                        '-compute_low_priority_metric
+ *
+ *      promote_default_gateway (3)
+ *        |
+ *        |-unset_low_priority_default_gateway (2)
+ *        |
+ *        '-set_default_gateway (1)
+ *
+ *      demote_default_gateway (4)
+ *        |
+ *        |-unset_default_gateway (2)
+ *        |
+ *        '-set_low_priority_default_gateway (1)
+ *
+ *    where:
+ *
+ *      * 'mutate_default_gateway' and
+ *        '{un,}set_default_gateway_route_common' are abstract,
+ *        generalized handlers that manage the broad error conditions
+ *        and gateway data and configuration lifecycle management.
+ *
+ *      * '*_route_cb' callbacks handle the actual routing table
+ *        manipulation as appropriate for the IP configuration and
+ *        gateway type, largely through the use of gateway
+ *        configuration "ops" to help neutralize differences between
+ *        IPv4 and IPv6.
+ *
+ *        In the fullness of time, the use of the gateway
+ *        configuration "ops" should allow further collapsing the IPv4
+ *        and IPv6 cases and simplifying the IP type-specific branches
+ *        of the above call trees.
+ *
+ *        The low-priority metric is determined on a per-network
+ *        interface basis and is computed by
+ *        'compute_low_priority_metric'.
+ *
+ *    Historically, this file started life as "connection.c". However,
+ *    today it might be better named "route.c" or, perhaps more
+ *    precisely, "gateway.c" since its primary focus is gateway routes
+ *    and gateway route management.
+ *
+ */
+
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
-- 
2.42.0

