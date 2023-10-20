Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4621DA59
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 7FEC073238
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:10:04 -0400 (EDT)
Received: from [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86] (unknown [IPv6:2601:647:5a00:15c1:ec66:51ea:5463:9b86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 47152732E9
	for <connman@lists.linux.dev>; Fri, 20 Oct 2023 16:10:04 -0400 (EDT)
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
Subject: [PATCH] Address scan-build warning in 'get_ipv6_privacy'.
Message-Id: <2CAC0923-E904-4671-8989-F06F9CAB6213@nuovations.com>
Date: Fri, 20 Oct 2023 13:10:04 -0700
To: connman@lists.linux.dev
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This addresses an "undefined or garbage value
returned to caller [core.uninitialized.UndefReturn]"
warning in 'get_ipv6_privacy' identified by clang/LLVM
scan-build-11.
---
 src/ipconfig.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 9cd04979..28c0ae0b 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -366,13 +366,12 @@ static int set_ipv6_state(gchar *ifname, bool enable)
 
 static int get_ipv6_privacy(gchar *ifname)
 {
-	int value;
+	int value = 0;
 
 	if (!ifname)
-		return 0;
+		return value;
 
-	if (read_ipv6_conf_value(ifname, "use_tempaddr", &value) < 0)
-		value = 0;
+	read_ipv6_conf_value(ifname, "use_tempaddr", &value);
 
 	return value;
 }
-- 
2.42.0


