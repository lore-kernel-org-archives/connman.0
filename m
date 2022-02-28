Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C8559D
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 13:19:43 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F2491F39E
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1646054376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9o/n+r5HXdb8QxRdI2dU/c+Z8+V/QHgS1ypRYzXZZA=;
	b=crEGyxASD1nboRZFwhkpGwllEDF2SMRvXXE9370+MCwNky/k5aQY95sZJ2T/p5qMyn6fuG
	v0YiPuFTdxA6AgUzz2G501ezUoCwbCgGFHVjAD/JSvTaKJygih/I/1iNRz5hfiASpQVSls
	vKEeYKDlNiNVOQA7VfJC/UaJyUnhGhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1646054376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9o/n+r5HXdb8QxRdI2dU/c+Z8+V/QHgS1ypRYzXZZA=;
	b=Wxy45qjTlT9Fw6RQJYgTeMPUEcjTXqOwWjvZXqhW7R2B70+n02c/4FcZyI9swUWEYkvA5p
	xkmyjApeR9p3PdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 600E113C3E
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 13:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id j2NpFujLHGInPwAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Mon, 28 Feb 2022 13:19:36 +0000
From: matthias.gerstner@suse.de
To: connman@lists.linux.dev
Subject: dnsproxy: some initial refactoring and integration test
Date: Mon, 28 Feb 2022 14:19:20 +0100
Message-Id: <20220228131921.5573-1-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220221084813.sk5thg5pj24ym3db@beryllium.lan>
References: <20220221084813.sk5thg5pj24ym3db@beryllium.lan>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed off-list, adding this test variant of connmand to noinst_PROGRAMS
means that all major object files will be built twice by default, considerably
increasing the build time with no benefit for most users.

Therefore only add the test program if `--enable-test` is set during configure
time. Pass this switch in bootstrap-configure to allow developers to catch
errors in the test source code.

