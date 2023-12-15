Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71114363
	for <connman@lists.linux.dev>; Fri, 15 Dec 2023 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A364D730F3
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:58:21 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:839:244f:d841:d551])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 56F7B73106
	for <connman@lists.linux.dev>; Thu, 14 Dec 2023 19:58:21 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/1] inet: Eliminate dead store in 'iproute_default_modify'.
Date: Thu, 14 Dec 2023 16:58:19 -0800
Message-ID: <20231215005820.2141277-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

In 'iproute_default_modify' there is a dead store to
'rth.req.u.r.rt.rtm_scope' with 'RT_SCOPE_NOWHERE' only to be
overwritten two lines later with 'RT_SCOPE_UNIVERSE' without an
intervening read.

This eliminates the dead store of 'RT_SCOPE_NOWHERE'.
---
 src/inet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/inet.c b/src/inet.c
index 2abd55ef75e9..371b3328175f 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -4547,7 +4547,6 @@ static int iproute_default_modify(int cmd, uint32_t table_id, uint32_t metric,
 	rth.req.n.nlmsg_type = cmd;
 	rth.req.u.r.rt.rtm_family = family;
 	rth.req.u.r.rt.rtm_table = RT_TABLE_MAIN;
-	rth.req.u.r.rt.rtm_scope = RT_SCOPE_NOWHERE;
 	rth.req.u.r.rt.rtm_protocol = RTPROT_BOOT;
 	rth.req.u.r.rt.rtm_scope = RT_SCOPE_UNIVERSE;
 	rth.req.u.r.rt.rtm_type = RTN_UNICAST;
-- 
2.42.0

