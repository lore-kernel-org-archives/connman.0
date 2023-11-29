Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE51C68E
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 22D2273122
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 18:17:08 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BCCB7731A8
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 18:17:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] connection: Remove Unnecessary '__connman_service_get_index' Calls
Date: Wed, 29 Nov 2023 15:17:04 -0800
Message-ID: <20231129231706.1306676-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This removed unnecessary calls to '__connman_service_get_index' that are
either unused or are redundant.

Grant Erickson (2):
  connection: Remove unused local variables.
  connection: Remove unnecessary '__connman_service_get_index' calls.

 src/connection.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

-- 
2.42.0

