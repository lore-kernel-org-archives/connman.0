Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995C1DA5D
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id ADDA77338B
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 12:40:46 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e] (unknown [IPv6:2601:647:5a00:15c1:dd5a:c80e:674d:c32e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 798D17339C
	for <connman@lists.linux.dev>; Thu,  2 Nov 2023 12:40:46 -0400 (EDT)
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
Subject: [PATCH] configure: add xz archive support to dist target.
Message-Id: <AF69756E-A74C-417D-B3DF-F8A123C94A50@nuovations.com>
Date: Thu, 2 Nov 2023 09:40:45 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

For a given base of connman source code, xz compression results in
archives about 30% smaller than gzip.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 367b5304..4b845027 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,7 +3,7 @@ AC_INIT([connman], [1.42])
 
 AC_CONFIG_MACRO_DIR([m4])
 
-AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
+AM_INIT_AUTOMAKE([foreign subdir-objects color-tests dist-xz])
 AC_CONFIG_HEADERS([config.h])
 
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
-- 
2.42.0


