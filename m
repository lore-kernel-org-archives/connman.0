Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFE137F
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 04:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 9493573278
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 00:06:17 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03] (unknown [IPv6:2601:647:5a00:15c1:3153:736a:5c89:9b03])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 5DD4A732B3
	for <connman@lists.linux.dev>; Wed,  1 Nov 2023 00:06:17 -0400 (EDT)
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
Subject: [PATCH] Allow running bootstrap-configure from anywhere.
Message-Id: <E57C2057-AEAD-49B1-8577-6FD27680A4B2@nuovations.com>
Date: Tue, 31 Oct 2023 21:06:16 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

Frequently it is valuable to do non-colocated source and build
directories. This updates 'bootstrap-configure' such that it may be
run in any arbitrary directory such that builds so bootstrapped and
configured may be non-colocated.
---
 bootstrap-configure | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bootstrap-configure b/bootstrap-configure
index ed5ecd78..d8c9cfce 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -1,11 +1,13 @@
 #!/bin/sh
 
+ourdir=$(cd $(dirname "${0}") && pwd)
+
 if [ -f config.status ]; then
 	make maintainer-clean
 fi
 
-./bootstrap && \
-    ./configure --enable-maintainer-mode \
+(cd "${ourdir}" && ./bootstrap) && \
+    "${ourdir}/configure" --enable-maintainer-mode \
 		--enable-debug \
 		--prefix=/usr \
 		--mandir=/usr/share/man \
-- 
2.42.0


