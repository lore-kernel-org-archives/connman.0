Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1F328C0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9277573204
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:25 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4B86C73206
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:25 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 67/90] connection: Document call to 'connman_service_unref'.
Date: Wed,  6 Dec 2023 15:50:33 -0800
Message-ID: <20231206235056.322578-71-gerickson@nuovations.com>
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

This documents the call to 'connman_service_unref' to help point
readers or maintainers where its balancing retained reference is
located.
---
 src/connection.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 90e6f9f9d6be..fddf0d5406e2 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -2515,6 +2515,10 @@ static void remove_gateway(gpointer user_data)
 
 	gateway_config_free(data->ipv6_config);
 
+	/*
+	 * Release, and balance, the strong reference to the service
+	 * retained in #add_gateway.
+	 */
 	connman_service_unref(data->service);
 
 	g_free(data);
-- 
2.42.0

