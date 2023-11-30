Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460A54CB2D
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id CD0F0730FC
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:26:24 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 7AE5A7310E
	for <connman@lists.linux.dev>; Thu, 30 Nov 2023 00:26:24 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/4] connection: Simplify '{un,}set_default_gateway' Flow
Date: Wed, 29 Nov 2023 21:26:18 -0800
Message-ID: <20231130052622.1335266-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Ostensibly over time, the logic of both 'set_default_gateway' and
'unset_default_gateway' has become a bit complicated with early
returns, gotos (in the case of 'set_default_gateway'), repeated state
checks, and duplicated function calls (in the case of
'set_default_gateway').
    
However, amidst all of that, there is a simpler flow to surface. At
its core, the functions are two identical outer conditional blocks:
one for IPv4 and one for IPv6 and three inner conditional blocks
within those: one for a VPN, one for a gateway with an any/unspecified
address, and one for everything else. In the case of
'set_default_gateway', on success, a call to
'__connman_service_indicate_default' is made; on failure, it is not.
    
This simplifies the flows of both functions accordingly, curtailing
the number of early returns, eliminating all of the gotos, and
reducing the repeated state checks and function calls to one through
the use of those simplified conditional blocks.

Additionally, this adds 'DBG' statements and documentation to both
functions.

Grant Erickson (4):
  connection: Simplify 'set_default_gateway' flow.
  connection: Simplify 'unset_default_gateway' flow.
  connection: Add additional DBG statements to '{un,}set_default_gateway'.
  connection: Document '{un,}set_default_gateway'.

 src/connection.c | 223 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 145 insertions(+), 78 deletions(-)

-- 
2.42.0

