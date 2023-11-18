Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F1360
	for <connman@lists.linux.dev>; Sat, 18 Nov 2023 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 16A14730F7
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 19:22:51 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id B3F9D73108
	for <connman@lists.linux.dev>; Fri, 17 Nov 2023 19:22:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] service: Bifurcate 'complete_online_check' handling.
Date: Fri, 17 Nov 2023 16:22:42 -0800
Message-ID: <20231118002244.723157-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This bifurcates 'complete_online_check' closure handling into a
success and failure handler: 'handle_online_check_success' and
'handle_online_check_failure'.
    
Both at present and as the continuous online check mode (also known
as, 'EnableOnlineToReadyTransition') evolves, the closure handling of
online checks is both more tractable and easier to reason about when
partitioned into success and failures rather than co-mingling both
into the same function. Moreover, this simplifies
'complete_online_check' itself.

Grant Erickson (2):
  service: Bifurcate 'complete_online_check' handling.
  service: Document 'handle_online_check_{failure,success}'.

 src/service.c | 199 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 168 insertions(+), 31 deletions(-)

-- 
2.42.0

