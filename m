Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1E7A
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:39 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFDEC1FD3A
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654864417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbR2YI0Cu3qVV77sub9X6T5a2TkqirxOOG7WevZl12w=;
	b=ZJNXFJZLJ43CBlr5SHvzM/jcD73/Y0Zqf+57jrdfpTyP4WQsFCOSj5jsm9dczdhpaPUrda
	BOIVxovs0EDwEyJvm7gtPwgY4N217yJzcWvXyBbcN28xzbxYaFFdewkf41cYrvKcwAq749
	4JL75xCZXA8nW+ZvuWhBvg/RSu3TKLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654864417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbR2YI0Cu3qVV77sub9X6T5a2TkqirxOOG7WevZl12w=;
	b=FMt09vmmloJLn/V6Pa8hV3hCqThRpMdMf2S7Cs1K7EBu123PrjHsUKmcL527lvRnTQmrpd
	WwmCNtA0RDOD2OCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D963B139ED
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0EERNSE6o2KbMgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:37 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 15/16] dnsproxy: add my copyright statement covering the larger refactoring changes
Date: Fri, 10 Jun 2022 14:33:22 +0200
Message-Id: <20220610123323.8974-16-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610123323.8974-1-matthias.gerstner@suse.de>
References: <20220610123323.8974-1-matthias.gerstner@suse.de>
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
index e3f768da8..1f873eeec 100644
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
2.35.1

