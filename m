Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667FC2D634
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 8CEE273200
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:21:28 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039] (unknown [IPv6:2601:647:5a00:15c1:30b8:2e3:edd9:a039])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 58D0F7327D
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 23:21:28 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 6/6] timeservice: Add function documentation for 
 '__connman_timeserver_sync'.
Date: Wed, 1 Nov 2023 20:21:28 -0700
References: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
To: connman@lists.linux.dev
In-Reply-To: <EA3460D2-744F-4DED-9284-0AC453189BAC@nuovations.com>
Message-Id: <8055B295-214F-4B3E-BDD2-AA036991A871@nuovations.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

---
 src/timeserver.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/timeserver.c b/src/timeserver.c
index 1d39cbe4..9c0d7aa5 100644
--- a/src/timeserver.c
+++ b/src/timeserver.c
@@ -481,6 +481,21 @@ static const char *timeserver_sync_reason2string(
 	return "unknown";
 }
 
+/**
+ *  @brief
+ *    Initiate a time of day synchronization with time services.
+ *
+ *  This initiates a time of day synchronization with time services
+ *  for the specified network service for the provided reason.
+ *
+ *  @param[in,out]  service  A pointer to the mutable network service
+ *                           object for which a time of day
+ *                           synchronization with time services should
+ *                           be initiated.
+ *  @param[in]      reason   The reason for the time of day
+ *                           synchronizization request.
+ *
+ */
 void __connman_timeserver_sync(struct connman_service *service,
 			enum connman_timeserver_sync_reason reason)
 {
-- 
2.42.0

