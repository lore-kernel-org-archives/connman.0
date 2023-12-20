Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20ABA53
	for <connman@lists.linux.dev>; Wed, 20 Dec 2023 02:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 157ED73100
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 21:05:46 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:ed73:7d5e:cff0:c0f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BA9B173128
	for <connman@lists.linux.dev>; Tue, 19 Dec 2023 21:05:45 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] Add Service Identifier to a Couple of 'DBG' Statements
Date: Tue, 19 Dec 2023 18:05:42 -0800
Message-ID: <20231220020544.2272820-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This adds the service identifier to the 'DBG' statements in
timeserver.c:'ts_reset' and session.c:'service_state_changed' to aid
debugging in a multi-technology environment with
"EnableOnlineToReadyTransition" asserted and for consistency with
other DBG statements in other modules.

Grant Erickson (2):
  session: Add service identifier to 'DBG' in 'service_state_changed'.
  timeserver: Add service identifier to 'DBG' in 'ts_reset'.

 src/session.c    | 4 +++-
 src/timeserver.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.42.0

