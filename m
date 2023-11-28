Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CED41C94
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9034C73122
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 13:15:56 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 46BC67312C
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 13:15:56 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] ipconfig: Return a unique string for 'CONNMAN_IPCONFIG_TYPE_ALL'.
Date: Tue, 28 Nov 2023 10:15:51 -0800
Message-ID: <20231128181551.1149522-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

At commit 89f70d225df6 ("ipconfig: Define unique value for
CONNMAN_IPCONFIG_TYPE_ALL"), a unique enumertion value was provided
for 'CONNMAN_IPCONFIG_TYPE_ALL' to make it semantically different from
'CONNMAN_IPCONFIG_TYPE_ALL'; however, a unique string returned
from '__connman_ipconfig_type2string' was not, leaving it to misleadingly
return "unknown" for 'CONNMAN_IPCONFIG_TYPE_ALL'.

This addresses this oversight by returning a unique string for
'CONNMAN_IPCONFIG_TYPE_ALL', "IPv4 + IPv6".
---
 src/ipconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 64a74310d450..352ea524dbd9 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -225,12 +225,13 @@ const char *__connman_ipconfig_type2string(enum connman_ipconfig_type type)
 {
 	switch (type) {
 	case CONNMAN_IPCONFIG_TYPE_UNKNOWN:
-	case CONNMAN_IPCONFIG_TYPE_ALL:
 		return "unknown";
 	case CONNMAN_IPCONFIG_TYPE_IPV4:
 		return "IPv4";
 	case CONNMAN_IPCONFIG_TYPE_IPV6:
 		return "IPv6";
+	case CONNMAN_IPCONFIG_TYPE_ALL:
+		return "IPv4 + IPv6";
 	}
 
 	return NULL;
-- 
2.42.0

