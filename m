Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F546BB9
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id C00CA730E8
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 14:23:05 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 70AD2730FC
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 14:23:05 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] ipconfig: Add DBG and Documentation to '__connman_ipconfig_gateway_{add,remove}'
Date: Tue, 28 Nov 2023 11:23:02 -0800
Message-ID: <20231128192304.1179479-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This not only expands and harmonizes the initial 'DBG' statements in
'__connman_ipconfig_gateway_{add,remove}' to aid debugging in a
multi-technology environment with "EnableOnlineToReadyTransition" but
also adds function documentation to these functions.

Grant Erickson (2):
  ipconfig: Expand and harmonize 'DBG' in
    '__connman_ipconfig_gateway_{add,remove}'
  ipconfig: Document '__connman_ipconfig_gateway_{add,remove}'.

 src/ipconfig.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

-- 
2.42.0

