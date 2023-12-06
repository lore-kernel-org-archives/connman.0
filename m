Received: from mohas.pair.com (mohas.pair.com [209.68.5.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D0328C0
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Received: from mohas.pair.com (localhost [127.0.0.1])
	by mohas.pair.com (Postfix) with ESMTP id 0EA5173202
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:17 -0500 (EST)
Received: from localhost.localdomain (unknown [IPv6:2601:647:5a00:15c1:dc81:1201:2884:36dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mohas.pair.com (Postfix) with ESMTPSA id BC5ED73229
	for <connman@lists.linux.dev>; Wed,  6 Dec 2023 18:51:16 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 45/90] ipconfig: Use 'RT_SCOPE_*' mnemonics.
Date: Wed,  6 Dec 2023 15:50:11 -0800
Message-ID: <20231206235056.322578-49-gerickson@nuovations.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206235056.322578-1-gerickson@nuovations.com>
References: <20231206235056.322578-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.112

From: Grant Erickson <erick205@umn.edu>

This leverages 'RT_SCOPE_*' mnemonics rather than magic numbers for
'scope2str'.
---
 src/ipconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index 55a05694ff14..e26fc13799fb 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -263,9 +263,9 @@ static const char *type2str(unsigned short type)
 static const char *scope2str(unsigned char scope)
 {
 	switch (scope) {
-	case 0:
+	case RT_SCOPE_UNIVERSE:
 		return "UNIVERSE";
-	case 253:
+	case RT_SCOPE_LINK:
 		return "LINK";
 	}
 
-- 
2.42.0

