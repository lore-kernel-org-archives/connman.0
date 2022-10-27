Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA21C2B
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:25 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80E8A22666
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHwGEwkfMV6tx2mvdeiLvay+2oOScL2IcMmPvrrZJZo=;
	b=vBXfskQ+GTnV3NXwPddAJuR8SIZompSAtAKolZQGOhPoWqRv3UNTWLUO3+Qq3mZfaECOHw
	8gLL8Jvf5zpAsd9FMXPfPva35XJVOEd2vPOlsfWonUZ3i1QzqWdHnIn56hO/i48Z8BJH/G
	WCXtIkWKCo+q43t05JASwYbG4YR/o+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHwGEwkfMV6tx2mvdeiLvay+2oOScL2IcMmPvrrZJZo=;
	b=Ih6GOxEnSFuL9S0h9YK23E5z6WA3+0+yOP9AurDlDOZT4R0QEblkA2JOuroQMSlLEK/bew
	Y2FgGhKCqVtrwlBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7815C134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Az0xHXNeWmMUBQAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:23 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 16/16] dnsproxy: add my copyright statement covering the larger refactoring changes
Date: Thu, 27 Oct 2022 12:32:59 +0200
Message-Id: <20221027103258.29129-17-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221027103258.29129-1-matthias.gerstner@suse.de>
References: <20221027103258.29129-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dnsproxy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index f0ecd1b28..c4d1e3935 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -3,6 +3,7 @@
  *  Connection Manager
  *
  *  Copyright (C) 2007-2014  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2022 Matthias Gerstner of SUSE. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
-- 
2.37.3

