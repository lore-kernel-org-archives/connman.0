Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A351DA59
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 954ED730F7
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:10:33 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86] (unknown [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 604067318D
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:10:33 -0400 (EDT)
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
Subject: [PATCH] Address scan-build warning in 'get_rp_filter'.
Message-Id: <62EE11B0-219A-4846-B455-99A5EEF17B27@nuovations.com>
Date: Fri, 20 Oct 2023 13:10:33 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This addresses an "undefined or garbage value
returned to caller [core.uninitialized.UndefReturn]"
warning in 'get_rp_filter' identified by clang/LLVM
scan-build-11.
---
 src/ipconfig.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 28c0ae0b..aa57b97c 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -392,10 +392,9 @@ static int set_ipv6_privacy(gchar *ifname, int value)
 
 static int get_rp_filter(void)
 {
-	int value;
+	int value = -EINVAL;
 
-	if (read_ipv4_conf_value(NULL, "rp_filter", &value) < 0)
-		value = -EINVAL;
+	read_ipv4_conf_value(NULL, "rp_filter", &value);
 
 	return value;
 }
-- 
2.42.0


