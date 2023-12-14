Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2B65ECA
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id ECCB373144
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 12:27:13 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id AC3C473154
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 12:27:13 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] inet: Add and Document '__connman_inet_rtnl_recv'.
Date: Thu, 14 Dec 2023 09:27:10 -0800
Message-ID: <20231214172712.2083929-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This refactors the private, file-scope interface 'inet_rtnl_recv' into
a separate semi-public, project-scope interface
'__connman_inet_rtnl_recv'.

Currently, 'inet_rtnl_recv' is intended to be used as a glib runloop
helper in conjunction with '__connman_inet_rtnl_talk' for longer or
multi-phase Routing Netlink (rtnl) interactions.

However, for short, concise open/send/recv/close Routing Netlink
(rtnl) interactions in which there is a single request/response phase
or the complexity of an asynchronous run loop interaction is not
needed, there is not an appropriate 'recv' interface to peer with
open/send/close.

With this change, the core of 'inet_rtnl_recv' is factored out into
that missing 'recv' interface, '__connman_inet_rtnl_recv' with
'inet_rtnl_recv' invoking it.

Grant Erickson (2):
  inet: Add '__connman_inet_rtnl_recv'.
  connection: Document '__connman_inet_rtnl_recv'.

 src/connman.h |  3 +-
 src/inet.c    | 87 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 75 insertions(+), 15 deletions(-)

-- 
2.42.0

