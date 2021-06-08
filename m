Received: from forward2-smtp.messagingengine.com (forward2-smtp.messagingengine.com [66.111.4.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D970
	for <connman@lists.linux.dev>; Tue,  8 Jun 2021 15:39:47 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailforward.nyi.internal (Postfix) with ESMTP id 396451940BE1;
	Tue,  8 Jun 2021 11:39:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 08 Jun 2021 11:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=f+YvdfO284R1MdAy9
	e8zYWmT9RKLB+1Y7vkyDE3C6/k=; b=XMZD+hb2MORh6QBDJjDxOcNu/BwVXcgnq
	zZ3fy3KRkOTWcNsWCz4aCri6AMZ4Bq8FSaSHH5e2dhhewZ4GIrLtTQV2DTE+QLEa
	dZ/Uzv2zKtp9WBXqna9HGTdnJClxhu3KDd6KdQU+KZwkWlHJjIbeJaNSSUjUdwIB
	oLk0pcGPzLYr3AygM1JLLt1eHImBZ7sXPHDbfp03LZLB3tRG3lU+U7aLSWB8lKv2
	yXaD7kMYWOmCzy9ivpjkMUUmLvCgsam6cSO6IrlmrBsH76+9R5iD1nmZB0DSFHpL
	kMyfG2cwUaJaQ1IABSOhHx7SYTHrMli1jPRlJJzIHHxg7dwavDiQw==
X-ME-Sender: <xms:Qo-_YM7AeNMFOqCiZ40xkN-j78xD482J-BqPyY9fL5Fei9qEEVSLaw>
    <xme:Qo-_YN5HgTFibYbzBjH9RKmkUp37jxR0YHla4VrvqIe_dBxuUdRmQkDao_BJc3f7e
    2ap3YR-l1ltmPKaUA>
X-ME-Received: <xmr:Qo-_YLdlpfYCtE2eXun36tcTt3YvCv3-1gkQbeZZZ_HSxiUOyfho-sfeK-PmPijxI9MNl6ZjU8s3g15iVQa3-Kx6O6A7qUgy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheq
    necuggftrfgrthhtvghrnhephefgtdelieffueevgeekueffhedvvefhteefheefffelte
    etvddvgeekuddugefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehqhihlihhsshesvghvvg
    drqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:Qo-_YBIlZln1Q0Rw6TfupulYEslu8Uk1RMsiuO5lBecSZWe0KK0LZA>
    <xmx:Qo-_YAK5p9r36in0-Mexm6_I3b_CjjDhFeEhGH962Qh6x-bowhGzBQ>
    <xmx:Qo-_YCwuYJQ-O01IZJHWs92QniBVPRUBvVJOz6A5jim3lY99_-ZAMw>
    <xmx:Q4-_YKziPgpX4qAtSwvY6l8oZEO1BrCFJwfJHt7mXFpsy3lw_5F1sw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jun 2021 11:39:46 -0400 (EDT)
Received: by eve.qyliss.net (Postfix, from userid 1000)
	id 6CD66E9D; Tue,  8 Jun 2021 15:39:45 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] README: fix typo
Date: Tue,  8 Jun 2021 15:39:35 +0000
Message-Id: <20210608153935.746482-1-hi@alyssa.is>
X-Mailer: git-send-email 2.31.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index e36d796c..b8154e67 100644
--- a/README
+++ b/README
@@ -451,5 +451,5 @@ send a (empty) message from your email account to
 
 	connman+subscribe@lists.linux.dev
 
-Maling list archive:
+Mailing list archive:
 	https://lore.kernel.org/connman
-- 
2.31.0

