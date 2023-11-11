Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3119BB2
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id EE298730FB
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 14:01:03 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18] (unknown [IPv6:2601:647:5a00:15c1:34e1:cabf:fe5f:4f18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BA7DD7311A
	for <connman@lists.linux.dev>; Sat, 11 Nov 2023 14:01:03 -0500 (EST)
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
Subject: [PATCH 8/8] wispr: Add documentation to '__connman_wispr_start'.
Date: Sat, 11 Nov 2023 11:01:03 -0800
References: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <7931960F-4A3F-448E-BDDE-773E48A1789B@nuovations.com>
Message-Id: <38E5F8F5-2EB8-4FB4-A7CF-BA28054FE479@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the '__connman_wispr_start' function.
---
 src/wispr.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 8618b5158b04..ab763d5bada0 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1071,6 +1071,49 @@ done:
 	return err;
 }
 
+/**
+ *  @brief
+ *    Start a HTTP-based Internet reachability check for the specified
+ *    network service IP configuration type.
+ *
+ *  This attempts to start a HTTP-based Internet reachability check
+ *  for the specified network service IP configuration type with the
+ *  provided connection timeout and completion callback.
+ *
+ *  @param[in,out]  service             A pointer to the mutable network
+ *                                      service for which to start the
+ *                                      reachability check.
+ *  @param[in]      type                The IP configuration type for
+ *                                      which the reachability check
+ *                                      is to be started.
+ *  param[in]       connect_timeout_ms  The time, in milliseconds, for
+ *                                      the TCP connection timeout.
+ *                                      Connections that take longer
+ *                                      than this will be aborted. A
+ *                                      value of zero ('0') indicates
+ *                                      that no explicit connection
+ *                                      timeout will be used, leaving
+ *                                      the timeout to the underlying
+ *                                      operating system and its
+ *                                      network stack.
+ *  @param[in]      callback            The callback to be invoked when
+ *                                      the reachability check
+ *                                      terminates, either on failure
+ *                                      or success.
+ *
+ *  @retval  0            If successful.
+ *  @retval  -EINVAL      If the reachability check subsystem is not
+ *                        properly initialized, @a callback is null,
+ *                        or if the network interface index associated
+ *                        with @a service is invalid.
+ *  @retval  -EOPNOTSUPP  If a reachability check is not supported for
+ *                        the network service technology type.
+ *  @retval  -ENOMEM      If resources could not be allocated for the
+ *                        reachability check.
+ *
+ *  @sa __connman_wispr_stop
+ *
+ */
 int __connman_wispr_start(struct connman_service *service,
 					enum connman_ipconfig_type type,
 					guint connect_timeout_ms,
-- 
2.42.0

