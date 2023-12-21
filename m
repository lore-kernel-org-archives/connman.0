Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C89AB662
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 4264173222
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:46 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 018C473230
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:17:45 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 25/60] service: Move 'set_error' forward declaration earlier in the source.
Date: Wed, 20 Dec 2023 22:16:48 -0800
Message-ID: <20231221061734.2344286-26-gerickson@nuovations.com>
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

This moves the 'set_error' forward declaration earlier in the source
such that it may be invoked by functions that precede its position
before this change.
---
 src/service.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index 6c898476627b..a51c1685b308 100644
--- a/src/service.c
+++ b/src/service.c
@@ -225,6 +225,8 @@ static void complete_online_check(struct connman_service *service,
 					int err);
 static bool service_downgrade_online_state(struct connman_service *service);
 static bool connman_service_is_default(const struct connman_service *service);
+static void set_error(struct connman_service *service,
+					enum connman_service_error error);
 static void clear_error(struct connman_service *service);
 
 struct find_data {
@@ -4538,9 +4540,6 @@ int __connman_service_check_passphrase(enum connman_service_security security,
 	return 0;
 }
 
-static void set_error(struct connman_service *service,
-					enum connman_service_error error);
-
 int __connman_service_set_passphrase(struct connman_service *service,
 					const char *passphrase)
 {
-- 
2.42.0

