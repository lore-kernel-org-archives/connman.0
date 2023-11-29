Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EC5DF27
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 2270F73202
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:21:08 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id CCD407322E
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 14:21:07 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/8] connection: Improve Connection Gateway Debugging and Documentation
Date: Wed, 29 Nov 2023 11:20:58 -0800
Message-ID: <20231129192106.1295868-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128230847.1224497-1-gerickson@nuovations.com>
References: <20231128230847.1224497-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This improves connection gateway debugging with the following changes:

    * This introduces and leverages two functions
      'gateway_{config,data}_debug' to conditionally log gateway data and
      configuration at the debug level.

    * Expands, exhances, and refactors 'DBG' statements throughout the
      module to improve symmetry in content, aid in debugging, and to
      reflect the newly-leveraged 'GATEWAY_CONFIG_DBG' and
      'GATEWAY_DATA_DBG' macro which, in turn, are wrappers around
      'gateway_{config,data}_debug'.

In addition, this adds to or expands on function- and body-level
documentation for:

    * connection_{add,del}gateway
    * __connman_connection_gateway_{add,remove}
    * __connman_connection_update_gateway

The aforementioned 'GATEWAY_CONFIG_DBG' and 'GATEWAY_DATA_DBG' are
supported by log module changes, including:

    * Introduces 'CONNMAN_DEBUG_DESC_INSTANTIATE' which declares and
      instantiates an instance of 'connman_debug_desc'.

    * Replaces 'CONNMAN_DEBUG_DEFINE' with 'CONNMAN_DEBUG_ALIAS' which
      declares and instantiates an alias (that is, asserts the
      'CONNMAN_DEBUG_FLAG_ALIAS' flag) instance of
      'connmand_debug_desc', using 'CONNMAN_DEBUG_DESC_INSTANTIATE'.

    * Redefines 'DBG' against 'CONNMAN_DEBUG_DESC_INSTANTIATE' with
      '__func__' as the function parameter.

Grant Erickson (8):
  log: Refactor debugging preprocessor macros.
  log: Document debugging preprocessor macros.
  connection: Introduce and leverage 'gateway_{config,data}_debug'.
  connection: Document 'gateway_{config,data}_debug'.
  connection: Expand, Enhance, and Refactor 'DBG'.
  connection: Document 'connection_{add,del}gateway'.
  connection: Document '__connman_connection_gateway_{add,remove}'.
  connection: Document '__connman_connection_update_gateway'.

 include/log.h    |  99 +++++++++---
 src/connection.c | 390 +++++++++++++++++++++++++++++++++++++++++++++--
 src/log.c        |   2 +-
 3 files changed, 461 insertions(+), 30 deletions(-)

-- 
2.42.0

