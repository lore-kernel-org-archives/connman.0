Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C387328C0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A00FA73202
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:23 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5B0777322A
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:23 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 62/90] connection: Document 'gateway_hash'.
Date: Wed,  6 Dec 2023 15:50:28 -0800
Message-ID: <20231206235056.322578-66-gerickson@nuovations.com>
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

This adds documentation to the 'gateway_hash' global.
---
 src/connection.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index d575e514e101..f1e91c7c8518 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -418,6 +418,11 @@ static const struct gateway_config_ops ipv6_gateway_config_ops = {
 static const char *const ipv4_addr_any_str = "0.0.0.0";
 static const char *const ipv6_addr_any_str = "::";
 
+/**
+ *	A dictionary / hash table of network services to gateway, or
+ *	default router, data.
+ *
+ */
 static GHashTable *gateway_hash = NULL;
 
 /**
-- 
2.42.0

