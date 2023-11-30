Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5D633
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id BA51073122
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:23:11 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 619FB73144
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:23:11 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/3] connection: Optimize Conditional '&&' Clauses in '__connman_connection_gateway_remove'
Date: Wed, 29 Nov 2023 16:23:02 -0800
Message-ID: <20231130002309.1322111-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This optimizes the conditional && clauses in
__connman_connection_gateway_remove to take advantage of stored, local
state in set_default[46] thereby avoiding redundant checks of
do_ipv[46], data->ipv[46]_config, and data->ipv[46]_config->vpn.

Grant Erickson (3):
  connection: Fix white space indentation.
  connection: Optimize conditional '&&' clauses.
  connection: Rename 'set_default[46]' local variables.

 src/connection.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.42.0

