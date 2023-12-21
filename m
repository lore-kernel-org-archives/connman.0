Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5868156D6
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 19C6773145
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:37 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D037773206
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:36 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 02/60] service: Sanity check the 'type' param in '__connman_service_wispr_start'.
Date: Wed, 20 Dec 2023 22:16:25 -0800
Message-ID: <20231221061734.2344286-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231221061734.2344286-1-gerickson@nuovations.com>
References: <20231221061734.2344286-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds sanity checking for the 'type' parameter in
'__connman_service_wispr_start'. In addition, it adds an explicit
conditional test for the 'CONNMAN_IPCONFIG_TYPE_IPV6'.

Both of these ensure that neither 'CONNMAN_IPCONFIG_TYPE_ALL' or
'CONNMAN_IPCONFIG_TYPE_UNKNOWN' trigger a WISPr start but, instead,
error out.
---
 src/service.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/service.c b/src/service.c
index 7af0d4a5f60c..e5cd6fcd306a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -2430,10 +2430,18 @@ int __connman_service_wispr_start(struct connman_service *service,
 	if (!service)
 		return -EINVAL;
 
+	switch (type) {
+	case CONNMAN_IPCONFIG_TYPE_IPV4:
+	case CONNMAN_IPCONFIG_TYPE_IPV6:
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (type == CONNMAN_IPCONFIG_TYPE_IPV4)
 		service->online_check_state_ipv4.interval =
 					online_check_initial_interval;
-	else
+	else if (type == CONNMAN_IPCONFIG_TYPE_IPV6)
 		service->online_check_state_ipv6.interval =
 					online_check_initial_interval;
 
-- 
2.42.0

