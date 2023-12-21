Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9434BA33
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id DBBA173203
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:14 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 9DAF573224
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:14 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 16/60] service: Add online check failure service error enumeration and string.
Date: Wed, 20 Dec 2023 22:39:20 -0800
Message-ID: <20231221064007.2347566-17-gerickson@nuovations.com>
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

This adds the 'CONNMAN_SERVICE_ERROR_ONLINE_CHECK_FAILED' service
error enumeration and "online-check-failed" string, used for services
that have met or exceeded the continuous mode online check failure
threshold.
---
 include/service.h | 19 ++++++++++---------
 src/service.c     |  2 ++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/service.h b/include/service.h
index 69f93574bafb..bfa3ab2592e4 100644
--- a/include/service.h
+++ b/include/service.h
@@ -71,15 +71,16 @@ enum connman_service_state {
 };
 
 enum connman_service_error {
-	CONNMAN_SERVICE_ERROR_UNKNOWN        = 0,
-	CONNMAN_SERVICE_ERROR_OUT_OF_RANGE   = 1,
-	CONNMAN_SERVICE_ERROR_PIN_MISSING    = 2,
-	CONNMAN_SERVICE_ERROR_DHCP_FAILED    = 3,
-	CONNMAN_SERVICE_ERROR_CONNECT_FAILED = 4,
-	CONNMAN_SERVICE_ERROR_LOGIN_FAILED  = 5,
-	CONNMAN_SERVICE_ERROR_AUTH_FAILED    = 6,
-	CONNMAN_SERVICE_ERROR_INVALID_KEY    = 7,
-	CONNMAN_SERVICE_ERROR_BLOCKED        = 8,
+	CONNMAN_SERVICE_ERROR_UNKNOWN             = 0,
+	CONNMAN_SERVICE_ERROR_OUT_OF_RANGE        = 1,
+	CONNMAN_SERVICE_ERROR_PIN_MISSING         = 2,
+	CONNMAN_SERVICE_ERROR_DHCP_FAILED         = 3,
+	CONNMAN_SERVICE_ERROR_CONNECT_FAILED      = 4,
+	CONNMAN_SERVICE_ERROR_LOGIN_FAILED        = 5,
+	CONNMAN_SERVICE_ERROR_AUTH_FAILED         = 6,
+	CONNMAN_SERVICE_ERROR_INVALID_KEY         = 7,
+	CONNMAN_SERVICE_ERROR_BLOCKED             = 8,
+	CONNMAN_SERVICE_ERROR_ONLINE_CHECK_FAILED = 9,
 };
 
 enum connman_service_proxy_method {
diff --git a/src/service.c b/src/service.c
index fb901ef16c9b..2599acd832ce 100644
--- a/src/service.c
+++ b/src/service.c
@@ -384,6 +384,8 @@ static const char *error2string(enum connman_service_error error)
 		return "invalid-key";
 	case CONNMAN_SERVICE_ERROR_BLOCKED:
 		return "blocked";
+	case CONNMAN_SERVICE_ERROR_ONLINE_CHECK_FAILED:
+		return "online-check-failed";
 	}
 
 	return NULL;
-- 
2.42.0

