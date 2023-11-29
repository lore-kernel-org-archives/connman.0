Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808A10975
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7B07E73118
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 02:39:48 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:230d:b2c9:c388:f96b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 362DC7315A
	for <connman@lists.linux.dev>; Wed, 29 Nov 2023 02:39:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 0/4] connection: Refactor 'connection_newgateway'
Date: Tue, 28 Nov 2023 23:39:42 -0800
Message-ID: <20231129073947.1280705-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This refactors the body tail of 'connection_newgateway' into a new,
separate function, 'check_default_gateway', shortening the length of
the former and making the latter an individually auditable and
comprehensible function.

In addition, this renames 'choose_default_gateway' as
'yield_default_gateway'. The latter more accurately reflects the
action of the function which is determining which of two gateway data
should cede or yield the default gateway and associated routes. The
actual "choice" and acquisition of the default gateway and associated
routes happens outside of the function.

Grant Erickson (4):
  connection: Refactor 'connection_newgateway'.
  connection: Document 'check_default_gateway'.
  connection: Rename 'choose_default_gateway'.
  connection: Document 'yield_default_gateway'.

 src/connection.c | 234 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 172 insertions(+), 62 deletions(-)

-- 
2.42.0

