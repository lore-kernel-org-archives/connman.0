Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7A32C60
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2E0BB7311A
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:08 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id E509A73140
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 25/90] connection: Document 'mutate_default_gateway'.
Date: Wed,  6 Dec 2023 15:49:48 -0800
Message-ID: <20231206235056.322578-26-gerickson@nuovations.com>
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

This adds documentation to the 'mutate_default_gateway' function.
---
 src/connection.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index d78b3f0400a9..532b8f06713c 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1167,6 +1167,31 @@ static int add_gateway(struct connman_service *service,
 	return err;
 }
 
+/**
+ *  @brief
+ *    Mutate the gateway for the specified IP configuration type for
+ *    the provided gateway data.
+ *
+ *  This attempts to mutate (including, but not limited to, adding/
+ *  setting or clearing/deleting/removing routes) the gateway for the
+ *  specified IP configuration type for the provided gateway data.
+ *
+ *  @param[in,out]  data      A pointer to the mutable gateway data
+ *                            to mutate.
+ *  @param[in]      type      The IP configuration type for which the
+ *                            gateway configuration will be selected
+ *                            from @a data and used for mutation.
+ *  @param[in]      ops       A pointer to the default gateway mutation
+ *                            operations to use for the mutation.
+ *  @param[in]      function  A pointer to an immutable null-terminated
+ *                            C string containing the function name to
+ *                            which the call to this function should
+ *                            be attributed.
+ *
+ *  @returns
+ *    0 if successful; otherwise, < 0 on error.
+ *
+ */
 static int mutate_default_gateway(struct gateway_data *data,
 				enum connman_ipconfig_type type,
 				const struct mutate_default_gateway_ops *ops,
-- 
2.42.0

