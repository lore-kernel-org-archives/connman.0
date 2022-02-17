Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF273D7B
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:26 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B72E1F3A2
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1645097483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BRWiQlQ4PHg1CRrehSvbJlEM1Wx43mJj0O4iyIT2qPo=;
	b=2Z3ZZujcd0Jn8CWKoCWK5ZvrOSOaemrIexk917D3vB4yZB2+rZ6tEY/rae3HGTKf3ainCl
	kId0/OZ4h/OjO4l99LyuFYAKU+cIrqZPr0FBf9pPqxU3DDG9geiwiKbxTtAGbDBxg4XDlt
	ZNYyyA2KsUHHo8JNy5LYYZyt/ILHk1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1645097483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BRWiQlQ4PHg1CRrehSvbJlEM1Wx43mJj0O4iyIT2qPo=;
	b=eyeJkQNX8LzLSpLphj/zFs8zRQk8vpTX8MZ9p5lPqk3MzUWKBT82NmWNhYI3xHau0kdrVX
	mm2cal7bNh5VtlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46B7413BBF
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cc4oEQsyDmI/XgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:23 +0000
From: matthias.gerstner@suse.de
To: connman@lists.linux.dev
Subject: dnsproxy: some initial refactoring and integration test
Date: Thu, 17 Feb 2022 12:31:06 +0100
Message-Id: <20220217113113.24088-1-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are the first steps towards a bigger effort to refactor the dnsproxy
code. Some smaller fixes of compiler warnings and refactorings are already
included. Mostly this adds an integration test facility though that allows to
easily test the basic code paths of the dnsproxy without the need for root
privileges or extensive configuration. With this future changes to the
codebase can be more easily checked for regressions.


