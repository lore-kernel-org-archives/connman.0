Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F0179BE
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 19AF573108
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:17 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BE66A73145
	for <connman@lists.linux.dev>; Sun, 19 Nov 2023 12:07:16 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 02/17] wispr: Add and leverage 'is_wispr_supported'.
Date: Sun, 19 Nov 2023 09:06:58 -0800
Message-ID: <20231119170714.775270-3-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119170714.775270-1-gerickson@nuovations.com>
References: <20231116010259.628527-1-gerickson@nuovations.com>
 <20231119170714.775270-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This factors out from '__connman_wispr_start', adds, and leverages
as an independent, file-scoped function 'is_wispr_supported'. It
determines and returns Boolean status whether WISPr requests /
HTTP-based Internet reachability check are supported for the
specified network service based on its associated technology
type.
---
 src/wispr.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 79cb713449bc..ae33a68ebbce 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1072,6 +1072,28 @@ done:
 	return err;
 }
 
+static bool is_wispr_supported(const struct connman_service *service)
+{
+	if (!service)
+		return false;
+
+	switch (connman_service_get_type(service)) {
+	case CONNMAN_SERVICE_TYPE_ETHERNET:
+	case CONNMAN_SERVICE_TYPE_WIFI:
+	case CONNMAN_SERVICE_TYPE_BLUETOOTH:
+	case CONNMAN_SERVICE_TYPE_CELLULAR:
+	case CONNMAN_SERVICE_TYPE_GADGET:
+		return true;
+	case CONNMAN_SERVICE_TYPE_UNKNOWN:
+	case CONNMAN_SERVICE_TYPE_SYSTEM:
+	case CONNMAN_SERVICE_TYPE_GPS:
+	case CONNMAN_SERVICE_TYPE_VPN:
+	case CONNMAN_SERVICE_TYPE_P2P:
+	default:
+		return false;
+	}
+}
+
 /**
  *  @brief
  *    Start a HTTP-based Internet reachability check for the specified
@@ -1132,20 +1154,8 @@ int __connman_wispr_start(struct connman_service *service,
 	if (!wispr_portal_hash || !callback)
 		return -EINVAL;
 
-	switch (connman_service_get_type(service)) {
-	case CONNMAN_SERVICE_TYPE_ETHERNET:
-	case CONNMAN_SERVICE_TYPE_WIFI:
-	case CONNMAN_SERVICE_TYPE_BLUETOOTH:
-	case CONNMAN_SERVICE_TYPE_CELLULAR:
-	case CONNMAN_SERVICE_TYPE_GADGET:
-		break;
-	case CONNMAN_SERVICE_TYPE_UNKNOWN:
-	case CONNMAN_SERVICE_TYPE_SYSTEM:
-	case CONNMAN_SERVICE_TYPE_GPS:
-	case CONNMAN_SERVICE_TYPE_VPN:
-	case CONNMAN_SERVICE_TYPE_P2P:
+	if (!is_wispr_supported(service))
 		return -EOPNOTSUPP;
-	}
 
 	index = __connman_service_get_index(service);
 	if (index < 0)
-- 
2.42.0

