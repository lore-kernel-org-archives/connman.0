Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891F641
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:34 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8674121FD6
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654864412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnyHROXHv9pJkFpMjVWaDOY0ffQVGLvPVFb8Y3N1Oms=;
	b=sFUSPftc71zkHk5gzYbnXNYPN8S26MQUNBJ+u+Trw79pZbDJRUjvO0ZSL1ikVeccDnFrJz
	eZwM7aYpoOVow1n8Zx7TCGhVmioP4X2zo6YiVnyLEub8KqvZKMDmyKfrovsi/Md2Y78ZRd
	EGe82Y3InSh3Qtx2mWNG66yUxsq1YsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654864412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnyHROXHv9pJkFpMjVWaDOY0ffQVGLvPVFb8Y3N1Oms=;
	b=27jfWNBknaRsecW/qEiozZrerY6aXA5pr7Vnmfhcc0wUWTNCMf2yXipsQmpbIBiIGTQH89
	yvn7BpXIgy/LmXCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CFD9139ED
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Z/t/Hhw6o2J1MgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:32 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 02/16] autoconf: require C99 compiler and set C99 mode
Date: Fri, 10 Jun 2022 14:33:09 +0200
Message-Id: <20220610123323.8974-3-matthias.gerstner@suse.de>
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
2.35.1

