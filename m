Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8138FAD
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 02A5C7313F
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 18:43:51 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BC311731D1
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 18:43:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH 0/3] Add and Leverage HTTP Status Code Mnemonics
Message-Id: <F9A20319-A6BC-47C5-8D71-884B705AAF3F@nuovations.com>
Date: Thu, 9 Nov 2023 15:43:49 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This patch series adds and leverages IANA HTTP status code mnemonics
for improved code readability and self-documentation.

Grant Erickson (3):
  gweb: Add HTTP status code mnemonics.
  gweb: Leverage GWebStatusCode mnemonics.
  wispr: Leverage GWebStatusCode mnemonics.

 gweb/gweb.c | 23 ++++++++++--------
 gweb/gweb.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/wispr.c | 22 ++++++++---------
 3 files changed, 94 insertions(+), 21 deletions(-)

-- 
2.42.0
