Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D97A
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:33 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B476221FC7
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654864411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pqqm79Xmi49xUZHOnCA9WQuSUoXm0MfPBI459iwe7SQ=;
	b=gcrAnC2l203UvJHzifivwXuCM1AgPwSSFnCkyURiF4Ilv29lD9eAwTJwMrZHbUr2D/Rjk2
	l3pki0zm/lXtviTVxnQxjc5F5w2iEaxA5evA0Y6fYBm3mGQLeNmct5xlfGAqRpWJrGN89K
	BOBuvv3U2zAr9uR3wYvGv9ZR5R1Iosc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654864411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pqqm79Xmi49xUZHOnCA9WQuSUoXm0MfPBI459iwe7SQ=;
	b=ck/2cnz9utMpwEIOpXzvWfcSHWLD6xR4rGHWWpN2jMPElMJ8Tp8WCV5mFTCMBEt9yONixn
	MUesWOHinf5rShCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9DF4139ED
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 87RvKRs6o2JvMgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:31 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: dnsproxy: first round of refactoring, TCP bugfix
Date: Fri, 10 Jun 2022 14:33:07 +0200
Message-Id: <20220610123323.8974-1-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Second round of patches with Daniel's comments adressed:

- consistently use macros for various sizeof() calculations
- moved a default: label to the bottom of the switch
- early exit & coding style fix in cache_free_ipv[46]
- more verbose commit messages with refactoring details (they're a bit
  repetitive)
- added C99 compiler requirement to autoconf
- fixed a few newly occuring GCC warnings
- added my copyright to dnsproxy.c


