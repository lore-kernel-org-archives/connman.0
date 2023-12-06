Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6414870969
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6EA92730F2;
	Wed,  6 Dec 2023 17:19:06 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:e5d4:204:c817:ce4e] (unknown [IPv6:2601:647:5a00:15c1:e5d4:204:c817:ce4e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 0E52C730FB;
	Wed,  6 Dec 2023 17:19:05 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: RFC: There Are No Routes for Non-default Services
Message-Id: <4C194197-1C1D-4FB4-A526-4284D6545A37@nuovations.com>
Date: Wed, 6 Dec 2023 14:19:05 -0800
Cc: =?utf-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

There will be a patch series posted following this email; however, for =
anyone interesting in evaluating and testing this pre-upstreaming, a =
branch has been posted at:

    =
https://github.com/Nuovations/connman/tree/user/gerickson/github-issue-5-w=
ip

Hopefully, someone from the list can assist with VPN testing. I=E2=80=99ve=
 made every effort to not break it intentionally; however, there was =
some overloading of the =E2=80=9Cactive=E2=80=9D flag (which I=E2=80=99ve =
now formalized as one of four states in a lifetime finite state machine) =
and I=E2=80=99ve =E2=80=9Cun-overloaded=E2=80=9D it such that it behaves =
as it seems it was originally designed to at the outset of the project. =
If you are testing VPNs, please note the =E2=80=9CRegression caused by =
'Don't add route for invalid dst and gateway address combinations'=E2=80=9D=
 list thread and commit 9eb1772d31b6 (=E2=80=9CDon't add route for =
invalid dst and gateway address combinations=E2=80=9D).

=46rom the =E2=80=98@file=E2=80=99 comment in src/connection.c:

This (src/connection.c) implements non-client-facing functionality
for managing network service gateways and routes. It also serves
as a Linux Routing Netlink (rtnl) listener for routing table
additions and deletions in the Linux kernel.

Gateway lifecycle is generally top-down, from user space to
kernel. That is, Connection Manager manages and adds/sets or
gateway routes and then uses notifications from the kernel
Routing Netlink (rtnl) to confirm and "activate" those
routes. Likewise, Connection Manager removes/clears/deletes
gateway routes an then uses notifications from the kernel
Routing Netlink (rtnl) to confirm and "inactivate" those
routes. The following is the state machine for that lifecycle:

                          .----------.    SIOCADDRT /
                          |          |    RTM_NEWROUTE
       .------------------| Inactive |--------------------.
       |                  |          |                    |
       |                  '----------'                    |
       | connman_rtnl                                     |
       | .delgateway                                      |
       |                                                  V
  .---------.         SIOCADDRT / RTM_NEWROUTE        .-------.
  |         |---------------------------------------->|       |
  | Removed |                                         | Added |
  |         |<----------------------------------------|       |
  '---------'         SIOCDELRT / RTM_DELROUTE        '-------'
       ^                                                  |
       | SIOCDELRT /                                      |
       | RTM_DELROUTE                                     |
       |                   .--------.     connman_rtnl    |
       |                   |        |     .newgateway     |
       '-------------------| Active |<--------------------'
                           |        |
                           '--------'

Gateways, and their associated routes, are generally of two types:

  1. High-priority (that is, metric 0) default route.

     This is used by the default service and its underlying
     network interface.

  2. Low-priority (that is, metric > 0) default route.

     This is used by non-default services and their underlying
     network interface.

     For IPv6, these are handled and managed automatically by
     the kernel as part of Router Discovery (RD) Router
     Advertisements (RAs) and because link-local addresses and
     multi-homing are a natural part of IPv6, nothing needs to
     be done here. These routes show up in 'ip -6 route show'
     as:

         default via fe80::f29f:c2ff:fe10:271e dev eth0
             proto ra metric 1024 expires 1622sec hoplimit 64
             pref medium
         default via fe80::f29f:c2ff:fe10:271e dev wlan0
             proto ra metric 1024 expires 1354sec hoplimit 64
             pref medium

     For IPv4, largely invented before the advent of link-local
     addresses and multi-homing hosts, these need to be
     fully-managed here and, with such management, should up in
     'ip -4 route show' as low-priority (that is, high metric
     value) default routes:

         default via 192.168.2.1 dev wlan0 metric 4294967295

     The other alternative to low-priority routes would be to
     use "def1" default routes commonly used by VPNs that have a
     prefix length of 1 (hence the "def1" name). These would
     should up as:

         0.0.0.0/1 via 192.168.2.1 dev wlan0
         128.0.0.0/1 via 192.168.2.1 dev wlan0

     However, since these require twice the number of routing
     table entries and seem no more effective than the
     low-priority route approach, this alternative is not used
     here at present.

VPNs and point-to-point (P2P) links get special treatment but
otherwise utilize the same states and types as described above.

Operationally, down calls from outside this module generally
come from the following three functions:

  1. __connman_connection_gateway_add
  2. __connman_connection_gateway_remove
  3. __connman_connection_update_gateway

and up calls generally come from the following two functions:

  1. connection_newgateway
  2. connection_delgateway

=46rom these five functions above, we are then either attempting
to do the following for a gateway associated with a network
service and its underlying network interface:

  1. Set, or add, the high- or low-priority default route(s).
  2. Unset, or remove, the high- or low-priority default route(s).
  3. Promote the default route from low- to high-priority.
  4. Demote the default route from high- to low-priority.

The call trees for these operations amount to:

  set_default_gateway (1)
    |
    '-mutate_default_gateway
        |
        |-set_ipv4_high_priority_default_gateway
        |   |
        |   '-set_default_gateway_route_common
        |       |
        |       '-set_ipv4_high_priority_default_gateway_route_cb
        |
        '-set_ipv6_high_priority_default_gateway
            |
            '-set_default_gateway_route_common
                |
                '-set_ipv6_high_priority_default_gateway_route_cb

  set_low_priority_default_gateway (1)
    |
    '-mutate_default_gateway
        |
        '-set_ipv4_low_priority_default_gateway
            |
            '-set_default_gateway_route_common
                |
                '-set_ipv4_low_priority_default_gateway_route_cb
                    |
                    '-compute_low_priority_metric

  unset_default_gateway (2)
    |
    '-mutate_default_gateway
        |
        |-unset_ipv4_high_priority_default_gateway
        |   |
        |   '-unset_default_gateway_route_common
        |       |
        |       '-unset_ipv4_high_priority_default_gateway_route_cb
        |
        '-unset_ipv6_high_priority_default_gateway
            |
            '-unset_default_gateway_route_common
                |
                '-unset_ipv6_high_priority_default_gateway_route_cb

  unset_low_priority_default_gateway (2)
    |
    '-mutate_default_gateway
        |
        '-unset_ipv4_low_priority_default_gateway
            |
            '-unset_default_gateway_route_common
                |
                '-unset_ipv4_low_priority_default_gateway_route_cb
                    |
                    '-compute_low_priority_metric

  promote_default_gateway (3)
    |
    |-unset_low_priority_default_gateway (2)
    |
    '-set_default_gateway (1)

  demote_default_gateway (4)
    |
    |-unset_default_gateway (2)
    |
    '-set_low_priority_default_gateway (1)

where:

  * 'mutate_default_gateway' and
    '{un,}set_default_gateway_route_common' are abstract,
    generalized handlers that manage the broad error conditions
    and gateway data and configuration lifecycle management.

  * '*_route_cb' callbacks handle the actual routing table
    manipulation as appropriate for the IP configuration and
    gateway type, largely through the use of gateway
    configuration "ops" to help neutralized differences between
    IPv4 and IPv6.

    In the fullness of time, the use of the gateway
    configuration "ops" should allow further collapsing the IPv4
    and IPv6 cases and simplifying the IP type-specific branches
    of the above call trees.

    The low-priority metric is determined on a per-network
    interface basis and is computed by
    'compute_low_priority_metric'.

Historically, this file started life as "connection.c". However,
today it might be better named "route.c" or, perhaps more
precisely, "gateway.c" since its primary focus is gateway routes
and gateway route management.

Best,

Grant

--=20
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

