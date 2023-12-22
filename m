Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE11EB31
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 83EBF73106
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 17:47:13 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:601e:89f:ea32:6713])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id 451FA73144
	for <connman@lists.linux.dev>; Fri, 22 Dec 2023 17:47:13 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] doc: Correct 'OnlineCheck{Initial,Max}Interval' units.
Date: Fri, 22 Dec 2023 14:47:11 -0800
Message-ID: <20231222224711.2371812-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

This corrects the 'OnlineCheck{Initial,Max}Interval' units from 'secs'
to 'interval'.

Ultimately, in conjunction with a function associated with
'OnlineCheckIntervalStyle', 'OnlineCheck{Initial,Max}Interval' can be
translated into seconds; however, the values themselves are simply
unitless interval indices.
---
 doc/connman.conf.5.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 966c20709724..1f323980948c 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -225,7 +225,7 @@ default value is zero ('0') which indicates that no explicit
 connection timeout will be used, leaving the timeout to the underlying
 operating system and network stack.
 .TP
-.BI OnlineCheckInitialInterval= secs, OnlineCheckMaxInterval= secs
+.BI OnlineCheckInitialInterval= interval, OnlineCheckMaxInterval= interval
 Range of intervals between two online check requests.
 Please refer to the README for more detailed information.
 Default values are 1 and 12 respectively.
-- 
2.42.0

