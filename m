Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09FF13FE2
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 1DC94731A4
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 14:03:41 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:601e:89f:ea32:6713])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id C6D09731D2
	for <connman@lists.linux.dev>; Sat, 23 Dec 2023 14:03:40 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] doc: Remove 'Experimental' designation from 'EnableOnlineToReadyTransition'.
Date: Sat, 23 Dec 2023 11:03:39 -0800
Message-ID: <20231223190339.2389588-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This removes the "Experimental" designation from
"OnlineCheckMode=continuous" / "EnableOnlineToReadyTransition=true" as
it is functional, verified, and no longer experimental.
---
 doc/connman.conf.5.in | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 1f323980948c..3eb240f5ec1d 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -252,7 +252,6 @@ an hour at interval 19 which "geometric" does not reach until interval
 60.
 .TP
 .BI EnableOnlineToReadyTransition=true\ \fR|\fB\ false
-WARNING: Experimental feature!!!
 In addition to EnableOnlineCheck setting, enable or disable use of HTTP GET
 to detect the loss of end-to-end connectivity.
 If this setting is false, when the default service transitions to ONLINE
-- 
2.42.0

