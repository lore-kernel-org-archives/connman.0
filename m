Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A921186A
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:16 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B5A441F8C6
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gI/cIpc9p6J01qQwff5AtGMHhzYGWbnHsSa3AfaG3Ac=;
	b=FwH/Jc7zWB4DsYhmExjdsu334uhWOQnBQQmfHP3/5Qo6bRXiLmv+crcZElinhLgdLUw17C
	AyDyE+v5RlvNlnvHJRL0tAa4Iwg59K/UU38M/8TyiTekjrFwo+MQ1P+aLOPkBIiC+BXQGF
	yQOwgEKUB61JvCgpSStZsGjxIWtQ8ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gI/cIpc9p6J01qQwff5AtGMHhzYGWbnHsSa3AfaG3Ac=;
	b=Su5uUUDVwuKnHvjiOlq0X9MORP5Phyoyjgff4LckMF18xPRxUaaEceACjPPuxpJp+mamue
	FrU1odlOvBELvVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADB86134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +ko0KmNeWmPLBAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:07 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: dnsproxy: first round of refactoring, TCP bugfix
Date: Thu, 27 Oct 2022 12:32:43 +0200
Message-Id: <20221027103258.29129-1-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry about the messed up previous set of patches.

So this round features the following changes:

- every commit should now successfully compile and also compile without
  warnings
- as requested I let go off most of the mixed code/declarations at the loss of
  some const variables that now need to be declared non-const at the start
  of the functions. In a few spots I left a little mixed code / declarations
  just at the beginning of the function block to allow for early exits when
  e.g. insufficient input data is supplied. Declarations at the beginning of
  for/while/if blocks still remain where suitable.


