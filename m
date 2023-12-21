Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05FBA57
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 961BD73207
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:11 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 4FC8773218
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 08/60] service: Document 'online_check_is_active'.
Date: Wed, 20 Dec 2023 22:39:12 -0800
Message-ID: <20231221064007.2347566-9-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221064007.2347566-1-gerickson@nuovations.com>
References: <20231221064007.2347566-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds documentation to the 'online_check_is_active' function.
---
 src/service.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/service.c b/src/service.c
index 27d261861b7c..0c1ed63c0ade 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1695,6 +1695,28 @@ static bool check_proxy_setup(struct connman_service *service)
 	return false;
 }
 
+/**
+ *  @brief
+ *    Determine whether an "online" HTTP-based Internet reachability
+ *    check is active.
+ *
+ *  This determines whether an "online" HTTP-based Internet
+ *  reachability check is active for the specified network service IP
+ *  configuration type.
+ *
+ *  @param[in]  service  A pointer to the immutable network service
+ *                       for which to determine whether an "online"
+ *                       HTTP-based Internet reachability is active.
+ *  @param[in]  type     The IP configuration type for which to
+ *                       determine whether an "online" HTTP-based
+ *                       Internet reachability is active.
+ *
+ *  @returns
+ *    True if an "online" HTTP-based Internet reachability check is
+ *    active for the specified network service IP configuration type;
+ *    otherwise, false.
+ *
+ */
 static bool online_check_is_active(const struct connman_service *service,
 		enum connman_ipconfig_type type)
 {
-- 
2.42.0

