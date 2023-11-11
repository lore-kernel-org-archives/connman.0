Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C61B280
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 68F1E730CE
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:57:13 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 2DAA4730F3
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 13:57:13 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 0/8] Add Configurable Online Check TCP Connect Timeout
Message-Id: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
Date: Sat, 11 Nov 2023 10:57:12 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This introduces support for a configurable "online" HTTP-based Internet
reachability check TCP connection timeout by:

    1. Introducing a new 'OnlineCheckConnectTimeout' setting.
    2. Adding to GWeb a TCP connection timeout member, getter, and setter.
    3. Leveraging both (1) and (2) in the service and WISPr code to pass
       (1) to (2) when so configured.

If the GWeb TCP connect timeout is greater than zero, a GLib connection
timeout timer and callback are added to the session such that, when they
expire, the in flight TCP connection is aborted and the session closure
function invoked with 'GWEB_HTTP_STATUS_CODE_REQUEST_TIMEOUT'.

A TCP connect timeout of zero (0) indicates that no explicit connection
timeout will be used and no timer or callback added to the session,
leaving the timeout to the underlying operating system and its network
stack.

With an operating system default connection time out of roughly 130
seconds, when the 'EnableOnlineToReadyTransition' setting is asserted,
failovers to an alternative network service can take unreasonably long
without such a setting as this since the connection timeout dominates
the failover time.

Grant Erickson (8):
  gweb: Add TCP connect timeout member and getter/setter.
  gweb: Factor out session transport closure.
  gweb: Leverage TCP connect timeout.
  gweb: Add documentation to TCP connect timeout-related functions.
  main: Introduce the 'OnlineCheckConnectTimeout' setting.
  Leverage GWeb connect timeout and 'OnlineCheckConnectTimeout'.
  Add documentation for 'OnlineCheckConnectTimeout'.
  wispr: Add documentation to '__connman_wispr_start'.

 doc/connman.conf.5.in |   9 ++
 gweb/gweb.c           | 286 +++++++++++++++++++++++++++++++++++++++---
 gweb/gweb.h           |   3 +
 src/connman.h         |   1 +
 src/main.c            |  30 +++++
 src/main.conf         |   9 ++
 src/service.c         |  10 +-
 src/wispr.c           |  57 ++++++++-
 8 files changed, 379 insertions(+), 26 deletions(-)

-- 
2.42.0


-- 
Principal
Nuovations

gerickson@nuovations.com
http://www.nuovations.com/

