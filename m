Received: from mail.monom.org (mail.monom.org [188.138.9.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F62173
	for <connman@lists.linux.dev>; Tue, 22 Jun 2021 07:49:45 +0000 (UTC)
Received: from mail.monom.org (localhost [127.0.0.1])
	by filter.mynetwork.local (Postfix) with ESMTP id C7BE550064D;
	Tue, 22 Jun 2021 09:49:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.103.148])
	by mail.monom.org (Postfix) with ESMTPSA id 8C224500196;
	Tue, 22 Jun 2021 09:49:37 +0200 (CEST)
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 0/2] Fix -Werror=array-bounds errors
Date: Tue, 22 Jun 2021 09:49:31 +0200
Message-Id: <20210622074933.5406-1-wagi@monom.org>
X-Mailer: git-send-email 2.32.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gcc complains with

  src/rtnl.c: In function ‘send_getlink’:
  src/rtnl.c:1485:12: error: array subscript ‘struct rtnl_request[0]’ is partly outside array bounds of ‘unsigned char[17]’ [-Werror=array-bounds]
   1485 |         req->hdr.nlmsg_len = RTNL_REQUEST_SIZE;
        |            ^~


The netlink helper 'struct rtnl_request' doesn't include any padding
between header and message. This is wrong. Fix this by removing the
helper structure and open code the message generation.


Daniel Wagner (2):
  rtnl: Fix netlink message alignment
  vpn-rtnl: Fix netlink message alignment

 src/rtnl.c     | 125 ++++++++++++++++++++++++-------------------------
 vpn/vpn-rtnl.c | 125 ++++++++++++++++++++++++-------------------------
 2 files changed, 124 insertions(+), 126 deletions(-)

-- 
2.32.0
