Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A41877
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:16 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AAB652218D
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+zc7uHBbeMyN61387mPJj34+js4K64UPyvvcnXZtWs=;
	b=qz75DT0/HgGy7WN8sw6/KmEMkURVQJjehlnTbwiJZKcbzG8LQHvR4v8vsgVDbm/y6MDdh4
	Sv7aF3ZV96DKArhoZIU4kg5ep9cqyebHi3BJbIl99qrqYD+qs1aCQRp4nAQs+QDXsUwlB9
	w6mdAFtLicPWWZ2HXuCS6Y0LsL0xg64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+zc7uHBbeMyN61387mPJj34+js4K64UPyvvcnXZtWs=;
	b=SHARaupMh5YvhKaLebxQeEIseoydHhrdSfDGTFZYVTXx1VE5bb4ZuUGeifVOi2qIuJ8Bwe
	Feam8It+hjjDcbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A32E7134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UvnTJ2VeWmPZBAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:09 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 02/16] autoconf: require C99 compiler and set C99 mode
Date: Thu, 27 Oct 2022 12:32:45 +0200
Message-Id: <20221027103258.29129-3-matthias.gerstner@suse.de>
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

