Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C789111B
	for <connman@lists.linux.dev>; Fri, 10 Nov 2023 04:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 17E5B7314E
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:44:59 -0500 (EST)
Received: from [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44] (unknown [IPv6:2601:647:5a00:15c1:8c0c:4eeb:e12e:6e44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id D1F44731ED
	for <connman@lists.linux.dev>; Thu,  9 Nov 2023 23:44:58 -0500 (EST)
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
Subject: [PATCH 0/4] wispr: Address reference counting heap-use-after-free
Message-Id: <0CA760E5-A632-43E0-924A-EB4363ABE1BF@nuovations.com>
Date: Thu, 9 Nov 2023 20:44:57 -0800
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This patch series adds documentation, 'DBG' statements, and balances
WISPr/portal context reference counting with proxy handling that leads
to a heap-use-after-free fault.

Grant Erickson (4):
  wispr: Add DBG statement to 'free_connman_wispr_portal_context'.
  wispr: Document 'wispr_portal_hash'.
  wispr: Add documentation about reference counting.
  wispr: Address unbalanced reference counting with proxy handling.

 src/wispr.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
2.42.0


