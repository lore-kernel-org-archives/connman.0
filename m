Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF68F54
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C108973248
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:26 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:f5ab:4a5e:2861:14b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 8251473250
	for <connman@lists.linux.dev>; Thu, 21 Dec 2023 01:40:26 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 46/60] service: Add @sa documentation references.
Date: Wed, 20 Dec 2023 22:39:50 -0800
Message-ID: <20231221064007.2347566-47-gerickson@nuovations.com>
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

This adds additional @sa ("see also") documentation references to the
'handle_online_check_{failure,success}' and 'complete_online_check'
functions.
---
 src/service.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/service.c b/src/service.c
index 20cc5914a016..c376b559e915 100644
--- a/src/service.c
+++ b/src/service.c
@@ -3220,6 +3220,8 @@ static bool handle_continuous_online_check_success(
  *    false.
  *
  *  @sa handle_online_check_failure
+ *  @sa handle_oneshot_online_check_success
+ *  @sa handle_continuous_online_check_success
  *
  */
 static bool handle_online_check_success(struct connman_service *service,
@@ -3514,6 +3516,8 @@ static bool handle_continuous_online_check_failure(
  *    false.
  *
  *  @sa handle_online_check_success
+ *  @sa handle_oneshot_online_check_failure
+ *  @sa handle_continuous_online_check_failure
  *
  */
 static bool handle_online_check_failure(struct connman_service *service,
@@ -3615,6 +3619,9 @@ done:
  *  @sa start_online_check
  *  @sa start_online_check_if_connected
  *  @sa __connman_service_wispr_start
+ *  @sa handle_online_check_success
+ *  @sa handle_online_check_failure
+ *  @sa reschedule_online_check
  *
  */
 static void complete_online_check(struct connman_service *service,
-- 
2.42.0

