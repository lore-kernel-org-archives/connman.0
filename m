Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC46ED7
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:52:02 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 31F721F38D
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1650365139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b2ASMnA/eLFuFHpmqrI7Xr+LynFmZMNHaZRGdJTsYtU=;
	b=xAk6k4RILz1vhGfjzEzYW9S1r1hyXnWf5H7DMOgQrenRXPAYjvkLlSuM0uxMfFiHK1aB5a
	me59T2C6glpkAVe/h9zx9HEarcbYCYX9Yn1lG1tIHWPSHY0Yi/slQWm7vuqFSXp6ppXcJD
	7dUK1GAdGrjPX/ki4UGEBXBtf889kCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1650365139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=b2ASMnA/eLFuFHpmqrI7Xr+LynFmZMNHaZRGdJTsYtU=;
	b=tahWzFPXbW16rTW5dM6QxpFAmmHOABHb1SNnJWBqNNwunR+vHdOOVbO0uZnGy+DT9Xy0Eh
	9y5rKK7lZ0L8FIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B2B6139BE
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id FuWDCtOSXmLWOAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:39 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: dnsproxy: first round of refactoring, TCP bugfix
Date: Tue, 19 Apr 2022 12:34:49 +0200
Message-Id: <20220419103501.30553-1-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a first iteration of refactoring the dnsproxy codebase. It is no major
change of the code structure yet, more a local refactoring of each function
trying to make the existing code more readable and less redundant.

Part of this is also improved testing capability, minor fixes of bugs
encountered during refactoring and a bugfix of the TCP protocol operation if
domain name appending is in effect.


