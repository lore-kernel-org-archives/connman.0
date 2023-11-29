Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FD110A21
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 07:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 3A85873156
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 02:39:49 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id ED3CC731A8
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 02:39:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/4] connection: Document 'check_default_gateway'.
Date: Tue, 28 Nov 2023 23:39:44 -0800
Message-ID: <20231129073947.1280705-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129073947.1280705-1-gerickson@nuovations.com>
References: <20231129073947.1280705-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'check_default_gateway' function.
---
 src/connection.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/connection.c b/src/connection.c
index 747b744a295e..8f6a08e12cf3 100644
--- a/src/connection.c
+++ b/src/connection.c
@@ -1051,6 +1051,26 @@ static bool choose_default_gateway(struct gateway_data *data,
 	return downgraded;
 }
 
+/**
+ *  @brief
+ *    Check whether the specified gateway should yield or become the
+ *    default.
+ *
+ *  This compares the specified, ostenisbly new, gateway data against
+ *  all, known existing gateway data in the service-to-gateway hash
+ *  and determines whether or not the default should be ceded from an
+ *  existing gateway and given to the new, incoming gateway or vice
+ *  versa.
+ *
+ *  @param[in,out]  activated  A pointer to the mutable gateway data
+ *                             associated with a newly-activated
+ *                             gateway route which is to be checked
+ *                             against existing gateway data.
+ *
+ *  @sa choose_default_gateway
+ *  @sa connection_newgateway
+ *
+ */
 static void check_default_gateway(struct gateway_data *activated)
 {
 	GHashTableIter iter;
-- 
2.42.0

