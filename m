Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1138FB7
	for <connman@lists.linux.dev>; Mon, 20 Nov 2023 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 65C8F730FE
	for <connman@lists.linux.dev>; Mon, 20 Nov 2023 16:53:33 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 178357310B
	for <connman@lists.linux.dev>; Mon, 20 Nov 2023 16:53:33 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/2] service: Add and Leverage 'clear_error'
Date: Mon, 20 Nov 2023 13:53:27 -0800
Message-ID: <20231120215329.786768-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

There are a suffient number of instantiations of the following
implementation pattern:

    set_error(service, CONNMAN_SERVICE_ERROR_UNKNOWN);

to clear or reset the "Error" service property where it makes sense to
embody this in a single function.

This introduces and leverages the 'clear_error' function to embody
this pattern.

Grant Erickson (2):
  service: Add and leverage 'clear_error'.
  service: Document '{clear,set}_error'.

 src/service.c | 56 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 6 deletions(-)

-- 
2.42.0

