Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA014291
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 6138573144
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:18 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1BCA2731BE
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:18 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 05/17] wispr: Add documentation to 'wispr_portal_detect'.
Date: Sun, 19 Nov 2023 09:07:01 -0800
Message-ID: <20231119170714.775270-6-gerickson@nuovations.com>
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

This adds documentation to the 'wispr_portal_detect' function.
---
 src/wispr.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 1370c93a0e9f..84ad21c2d6fb 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -968,6 +968,46 @@ static gboolean no_proxy_callback(gpointer user_data)
 	return FALSE;
 }
 
+/**
+ *  @brief
+ *    Start a WISPr / portal detection request / HTTP-based Internet
+ *    reachability check for the specified WISPr / portal context.
+ *
+ *  This attempts to start a WISPr / portal detection request /
+ *  HTTP-based Internet reachability check for the network service IP
+ *  configuration type associated with the provided WISPr / portal
+ *  context with the provided connection timeout.
+ *
+ *  @param[in,out]  wp_context          A pointer to the mutable WISPr
+ *                                      / portal context to supporting
+ *                                      running the WISPr request /
+ *                                      HTTP-based Internet
+ *                                      reachability check.
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
+ *
+ *  @retval  0        If the WISPr request / HTTP-based Internet
+ *                    reachability check was successfully queued.
+ *  @retval  -EINVAL  If the network interface or network interface
+ *                    index associated with @a wp_context->service is
+ *                    invalid, if @a wp_context->service has no name
+ *                    servers, or if a proxy could not be successfully
+ *                    associated with @a wp_context->service.
+ *  @retval  -ENOMEM  If a GWeb instance could not be allocated for
+ *                    the WISPr request / HTTP-based Internet
+ *                    reachability check.
+ *
+ *  @sa __connman_wispr_start
+ *
+ */
 static int wispr_portal_detect(struct connman_wispr_portal_context *wp_context,
 						guint connect_timeout_ms)
 {
-- 
2.42.0

