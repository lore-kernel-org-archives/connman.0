Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771B3D7E
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:28 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 888721F76A
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1645097486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzvOO/VhoTmnyG31oJThzbEOe+Ti66KLzbnmds+2TNE=;
	b=qPgwYXUhdK5DlpNKEnXobZfqv+MF+7NtBKYUNjxn7VJi8lpoSL3KnC2j8sqB/2pjl8jb6O
	JCavOiKJ48oJq1D7sdWxGSbL+Du/HLTvWbhCaQyhTsvw94o90H8tv6uSg6OfqCvNN1fus1
	OXPWCkd6Zd56GjGQlpUb2iZxEXo7JAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1645097486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzvOO/VhoTmnyG31oJThzbEOe+Ti66KLzbnmds+2TNE=;
	b=/EHLpFEFOCp9A99tC62Wa6n2kxrst3FznK2OKAeiXyWXU1a3YV4rEf22zDZriv3cgeOeXf
	UYZQpN9+Psu0PBCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72A4B13BBF
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XwmvGg4yDmJHXgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:26 +0000
From: matthias.gerstner@suse.de
To: connman@lists.linux.dev
Subject: [PATCH 4/7] .gitignore: also ignore backup configure script
Date: Thu, 17 Feb 2022 12:31:10 +0100
Message-Id: <20220217113113.24088-5-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217113113.24088-1-matthias.gerstner@suse.de>
References: <20220217113113.24088-1-matthias.gerstner@suse.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthias Gerstner <matthias.gerstner@suse.de>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index cd7d8810..4e0c0aa7 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,6 +15,7 @@ config.log
 config.status
 config.sub
 configure
+configure~
 depcomp
 compile
 install-sh
-- 
2.34.1

