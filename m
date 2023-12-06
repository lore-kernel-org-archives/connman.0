Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46282FE0D
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CE18E73128
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:50:58 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9134773145
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:50:58 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 02/90] connection: Document 'find_any_active_gateway_data'.
Date: Wed,  6 Dec 2023 15:49:25 -0800
Message-ID: <20231206235056.322578-3-gerickson@nuovations.com>
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

From: Grant Erickson <erick205@umn.edu>

This adds documentation to the 'find_any_active_gateway_data'
function.
---
 src/connection.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index f0da0c3c442c..6be39a773df1 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -352,6 +352,21 @@ static struct gateway_data *find_gateway_data(
 	return NULL;
 }
 
+/**
+ *  @brief
+ *    Find the first, or any, gateway data marked active.
+ *
+ *  This attempts to find the first, or any, gateway data marked
+ *  active.
+ *
+ *  @returns
+ *    A pointer to the first, or any, gateway data marked active on
+ *    success; otherwise, null.
+ *
+ *  @sa find_default_gateway_data
+ *  @sa find_gateway_data
+ *
+ */
 static struct gateway_data *find_any_active_gateway_data(void)
 {
 	GHashTableIter iter;
-- 
2.42.0

