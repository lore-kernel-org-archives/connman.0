Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9B14291
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C9EBB73207
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:22 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 82E847321A
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:22 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 15/17] wispr: Add documentation to '__connman_wispr_cancel'.
Date: Sun, 19 Nov 2023 09:07:11 -0800
Message-ID: <20231119170714.775270-16-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119170714.775270-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
 <20231119170714.775270-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the '__connman_wispr_cancel' function.
---
 src/wispr.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 9f995060a6c0..3837a87811a9 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1341,6 +1341,41 @@ free_wp:
 	return err;
 }
 
+/**
+ *  @brief
+ *    Cancel a HTTP-based Internet reachability check for the specified
+ *    network service IP configuration type.
+ *
+ *  This attempts to cancel a HTTP-based Internet reachability check
+ *  for the specified network service IP configuration type.
+ *
+ *  If a matching HTTP-based Internet reachability check is found, the
+ *  original callback specified with #__connman_wispr_start will be
+ *  invoked with a success value of zero ('0') or false and an error
+ *  value of -ECANCELED.
+ *
+ *  @param[in,out]  service             A pointer to the mutable network
+ *                                      service for which to cancel the
+ *                                      reachability check.
+ *  @param[in]      type                The IP configuration type for
+ *                                      which the reachability check
+ *                                      is to be cancelled.
+ *
+ *  @retval  0            If a matching HTTP-based Internet reachability
+ *                        check was successfully cancelled.
+ *  @retval  -EINVAL      If the IP configuration type is not X or Y or
+ *                        if the network interface index associated
+ *                        with @a service is invalid.
+ *  @retval  -ENOENT      If a matching HTTP-based Internet reachability
+ *                        check could not be found.
+ *  @retval  -EOPNOTSUPP  If HTTP-based Internet reachability checks are
+ *                        not supported for the technology type
+ *                        associated with @a service.
+ *
+ *  @sa __connman_wispr_start
+ *  @sa __connman_wispr_stop
+ *
+ */
 int __connman_wispr_cancel(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
-- 
2.42.0

