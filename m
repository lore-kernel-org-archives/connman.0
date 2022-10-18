Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6B257D
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:09 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD2272081D
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666082885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iw1lfxb8+X2JHtuB9SsPqk9wVSIOFJOl3f4+4WhOLE=;
	b=X2rgMPpRlpMeDZARyp05TJb+aOmpRaPQk2S2gbDBU7RS+m4EoiZ2dciYODMO41yvAqqI75
	JycslW54CGrKT9bNtmZ8zOf0CcS+IlsuIx+6BU43ejGMFQQn1bsHm7Jp0S45uDh8u1yX68
	eTtkw5QibIAENBgSDcYiINZdYp+GH70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666082885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iw1lfxb8+X2JHtuB9SsPqk9wVSIOFJOl3f4+4WhOLE=;
	b=yFJidu88JBJibJp2wyLzbqvjrGfM8M+Lp0B2sRf0zydr8fcrdQeRLpNjWJr1k8k918rIS6
	6/rD7+z/djEZuVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B637B139D2
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fmB3LEVoTmO6cAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:05 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 15/16] dnsproxy: add my copyright statement covering the larger refactoring changes
Date: Tue, 18 Oct 2022 10:47:45 +0200
Message-Id: <20221018084746.21959-16-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018084746.21959-1-matthias.gerstner@suse.de>
References: <20221018084746.21959-1-matthias.gerstner@suse.de>
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
index d375c10f5..9ab4a6742 100644
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

