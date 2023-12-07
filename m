Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0C563BE
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 34C3973100
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 18:41:32 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:851a:6a54:a980:b9a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id DFF5E7312B
	for <connman@lists.linux.dev>; Thu,  7 Dec 2023 18:41:31 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/4] connection: Harmonize Search Function Names and Document Search Functions
Date: Thu,  7 Dec 2023 15:41:26 -0800
Message-ID: <20231207234130.1093617-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This colocates service/gateway search functions, harmonizes their
names, and documents them.

Grant Erickson (4):
  connection: Colocate search functions.
  service: Const-qualify 'lookup_gateway_data'.
  connection: Harmonize search function names.
  connection: Document search functions.

 src/connection.c | 161 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 115 insertions(+), 46 deletions(-)

-- 
2.42.0

