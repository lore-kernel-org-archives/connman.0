Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E165ECF
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id B58E173145
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 12:27:14 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 78E2E73159
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 12:27:14 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/2] connection: Document '__connman_inet_rtnl_recv'.
Date: Thu, 14 Dec 2023 09:27:12 -0800
Message-ID: <20231214172712.2083929-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214172712.2083929-1-gerickson@nuovations.com>
References: <20231214172712.2083929-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the '__connman_inet_rtnl_recv'
function.
---
 src/inet.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index 5b938cbade13..e957212f11e8 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -2574,6 +2574,40 @@ static gboolean inet_rtnl_timeout_cb(gpointer user_data)
 	return FALSE;
 }
 
+/**
+ *  @brief
+ *    Receive and process a Linux Routing Netlink (rtnl) response
+ *    message.
+ *
+ *  This attempts to receive and process a Linux Routing Netlink
+ *  (rtnl) response message to a previous request send by
+ *  #__connman_inet_rtnl_send or #__connman_inet_rtnl_talk.
+ *
+ *  @param[in]      rtnl  A pointer to an immutable Connection
+ *                        Manager Routing Netlink (rtnl) session
+ *                        handle with which the response message will
+ *                        be received.
+ *  @param[in,out]  n     An optional pointer to storage for the
+ *                        Routing Netlink (rtnl) response message
+ *                        header which will be populated if a message
+ *                        is received and processed.
+ *
+ *  @retval  0            If successful.
+ *  @retval  -EINVAL      If @a rtnl is null.
+ *  @retval  -ECONNRESET  If zero bytes were read and/or the remote
+ *                        end of the Routing Netlink (rtnl) socket
+ *                        closed the connection.
+ *  @retval  -EBADMSG     If NLMSG_OK evaluates to false for the
+ *                        received Routing Netlink (rtnl) message or
+ *                        if the received message was of type
+ *                        NLMSG_NOOP or NLMSG_OVERRUN.
+ *
+ *  @sa __connman_inet_rtnl_open
+ *  @sa __connman_inet_rtnl_send
+ *  @sa __connman_inet_rtnl_talk
+ *  @sa __connman_inet_rtnl_close
+ *
+ */
 int __connman_inet_rtnl_recv(const struct __connman_inet_rtnl_handle *rtnl,
 	struct nlmsghdr **n)
 {
-- 
2.42.0

