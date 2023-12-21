Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6DB64A
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0394873213
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:43 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B6EE973219
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:42 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 17/60] doc/service: Document online check failure service error.
Date: Wed, 20 Dec 2023 22:16:40 -0800
Message-ID: <20231221061734.2344286-18-gerickson@nuovations.com>
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

This adds documentation for the online check failure service error
enumeration and string.
---
 doc/service-api.txt | 3 ++-
 include/service.h   | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/doc/service-api.txt b/doc/service-api.txt
index c0d5adbb2b57..89208a6dc55f 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -157,7 +157,8 @@ Properties	string State [readonly]
 
 			Currently defined error codes are: "out-of-range",
 			"pin-missing", "dhcp-failed", "connect-failed",
-			"login-failed", "auth-failed" and "invalid-key".
+			"login-failed", "auth-failed", "invalid-key",
+			"blocked", and "online-check-failed".
 
 		string Name [readonly]
 
diff --git a/include/service.h b/include/service.h
index bfa3ab2592e4..f194422fae48 100644
--- a/include/service.h
+++ b/include/service.h
@@ -80,6 +80,13 @@ enum connman_service_error {
 	CONNMAN_SERVICE_ERROR_AUTH_FAILED         = 6,
 	CONNMAN_SERVICE_ERROR_INVALID_KEY         = 7,
 	CONNMAN_SERVICE_ERROR_BLOCKED             = 8,
+
+	/**
+	 *	In "continuous" online check mode,
+	 *	the back-to-back online check
+	 *	failures threshold was met or
+	 *	exceeded.
+	 */
 	CONNMAN_SERVICE_ERROR_ONLINE_CHECK_FAILED = 9,
 };
 
-- 
2.42.0

