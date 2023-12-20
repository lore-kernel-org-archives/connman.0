Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D321D528
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C9E8F73100
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:15 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8D79E7312C
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 00:56:15 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/5] inet: Use '__connman_inet_rtnl_recv' for RTNL default route transaction.
Date: Tue, 19 Dec 2023 21:56:09 -0800
Message-ID: <20231220055613.2287074-2-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220055613.2287074-1-gerickson@nuovations.com>
References: <20231220055613.2287074-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This leverages '__connman_inet_rtnl_recv', introduced at commit
97967b4aae40 ("inet: Add '__connman_inet_rtnl_recv'."), to complete
the Routing Netlink (rtnl) default route addition or deletion
transaction in 'iproute_default_modify'.

Every rtnl route addition or deletion transaction consists of a
request and a response phase. The request phase contains the details
of the route to be added or deleted. The response phase contains the
status of whether the request succeeded. Unfortunately, to date,
'iproute_default_modify' did not include the response phase.
Therefore, it did not complete the route request transaction,
rendering the returns status incomplete in that it only reflected the
success or failure of the request phase.

Unfortunately, for callers of interfaces that, in turn, called
'iproute_default_modify', this made all routing requests appear to
artificially succeed even when, in fact, they were failing and elided
response status that callers need to conditionally act in the face of
the transaction failure.

By adding '__connman_inet_rtnl_recv' to complete the response phase of
the rtnl route transaction, the return status of
'iproute_default_modify', and those interfaces that call it, now
accurately reflect both the request and response status of the
transaction.
---
 src/inet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/inet.c b/src/inet.c
index e0f927a12dcb..8a1e34235230 100644
--- a/src/inet.c
+++ b/src/inet.c
@@ -4748,6 +4748,12 @@ static int iproute_default_modify(int cmd, uint32_t table_id, uint32_t metric,
 		goto done;
 
 	ret = __connman_inet_rtnl_send(&rth, &rth.req.n);
+	if (ret < 0)
+		goto done;
+
+	ret = __connman_inet_rtnl_recv(&rth, NULL);
+	if (ret < 0)
+		goto done;
 
 done:
 	__connman_inet_rtnl_close(&rth);
-- 
2.42.0

