Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389CA6FA6
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0908B73105
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:53:31 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 1FB0673144
	for <connman@lists.linux.dev>; Tue, 28 Nov 2023 23:53:28 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/3] connection: Refactor 'add_gateway'
Date: Tue, 28 Nov 2023 20:53:13 -0800
Message-ID: <20231129045321.1263302-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This refactors the 'add_gateway' function by:

    1. Leveraging early parameter checking, the 'g_autofree' pointer
       decoration, and the 'g_steal_pointer' macro to simplify exception
       handling.

    2. Changing the function signature by migrating the return type to
       a double-pointer parameter and changing the return type to an
       'int' for error status.

       This allows passing the full range of failure errors to the
       caller and allows the caller to pass those errors directly
       along as their own return status.

In addition, this documents the function.

Grant Erickson (3):
  connection: Simplify exception handling in 'add_gateway'.
  connection: Change the function signature of 'add_gateway'.
  connection: Document 'add_gateway'.

 src/connection.c | 124 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 92 insertions(+), 32 deletions(-)

-- 
2.42.0

