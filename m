Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F31FB3
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id A7D7573128
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 20:52:55 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 552BB73140
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 20:52:55 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/3] connection: Introduce and Leverage IP Any / Unspecified Address String Constants and Functions
Date: Tue, 28 Nov 2023 17:52:50 -0800
Message-ID: <20231129015253.1254116-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

The IPv4 and IPv6 any / unspecified address string literals, "0.0.0.0"
and "::" respectively, and comparisons against them appear often
enough throughout the code where they warrant referencing through
file-scoped constants and introducing and leveraging introspection
functions to encapsulate the comparison patterns.

This introduces and uses such constants and 'is_ipv[46]_addr_any_str'
introspection functions to encapsulate these comparison patterns.

Grant Erickson (3):
  connection: Introduce and leverage 'ipv[46]_addr_any_str' constants.
  connection: Introduce and leverage 'is_ipv[46]_addr_any_str'
    functions.
  connection: Document 'is_ipv[46]_addr_any_str'.

 src/connection.c | 84 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 19 deletions(-)

-- 
2.42.0

