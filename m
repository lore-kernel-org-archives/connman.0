Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A02573
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:01 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EAE133E89
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666082874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+zc7uHBbeMyN61387mPJj34+js4K64UPyvvcnXZtWs=;
	b=w8B0cA+03FgfJb3oIwESWBSKRKL/2Jzl3t0Yq5rrrHyycND9TV3Fr71fM7gytCkJhqbCRQ
	LbLjCFO6nhfyL6FfTySkHq7uTOmD228eEcz326mcBFoXekugoK32JwNTlmjYV8t6RPytWz
	130U1Q/j9GxLyZ6KcaSfX06jMU7JA9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666082874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+zc7uHBbeMyN61387mPJj34+js4K64UPyvvcnXZtWs=;
	b=bWownjnQ627kKehJEd5Q9G9l2XHU4+24ujvPgdpwNn2+E2D8YHel2FubE0EFyV+tDRNdD0
	BEiO1k4hAlN8t8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9731B139D2
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RETmJDpoTmOIcAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:54 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 02/16] autoconf: require C99 compiler and set C99 mode
Date: Tue, 18 Oct 2022 10:47:32 +0200
Message-Id: <20221018084746.21959-3-matthias.gerstner@suse.de>
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

For refactoring the dnsproxy codebase using C99 language features will
come in handy (mostly for using more localized variable declarations).
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a573cefd7..ea7a2facd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -22,7 +22,7 @@ AC_SUBST(abs_top_builddir)
 AC_LANG_C
 AC_USE_SYSTEM_EXTENSIONS
 
-AC_PROG_CC
+AC_PROG_CC_C99
 AM_PROG_CC_C_O
 AC_PROG_CC_PIE
 AC_PROG_INSTALL
-- 
2.37.3

