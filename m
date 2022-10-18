Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E677B
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:00 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB9AB33E78
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666082872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JrZKWWafr1HYpNQOhYX8y8SDf6tY2EHqeEb5pT4+7eA=;
	b=mydfMbpjEkl+u16krSyorZtf7QH3cL/iUUYQrZYIi0xFlSjxy1kqlK2kL6IXaR5RImZebz
	e2EDnqLvWhbBcUgEj44CWg1rmffEZKikHzA544C+QlAVHhOl0eEBl7iCb7jNWVqFQ5VJmK
	LYWoxZ5Q3IOpuqe4kNowwHl/0yBl9vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666082872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JrZKWWafr1HYpNQOhYX8y8SDf6tY2EHqeEb5pT4+7eA=;
	b=audhmPtguX122N04x46LtTOI8wrrFFvlAjf0jEGY3Vx6wT4S2I2rpqpSQrh9/M51FajUXl
	Z2zSAyurDuia2nAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5326139D2
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JzbpNzhoTmOAcAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:52 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: dnsproxy: first round of refactoring, TCP bugfix
Date: Tue, 18 Oct 2022 10:47:30 +0200
Message-Id: <20221018084746.21959-1-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From Matthias Gerstner <matthias.gerstner@suse.de> # This line is ignored.
From: Matthias Gerstner <matthias.gerstner@suse.de>
Reply-To: 
Subject: dnsproxy: first round of refactoring, TCP bugfix
In-Reply-To: 


