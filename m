Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235671878
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:17 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83C222266F
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFCDqBGIfwYKMwum9LS9Vj3YsQ1mnM1pbrO35ZJ9TT0=;
	b=dqWjQSrjLkrkjcdvEzu4/lSLRzUROFkqLVOnkBNNuJPZaJvYdl5RJC9PxB+TPMrl3HDhdg
	4zuRh5WWHOtNjMOzqvNNlZufpK9eMQzcx/Exf+1Fxgoo1OpPCe+mysZRlRjq7tfxcdUKHM
	zXcNB4E4wqIxLgbxADznCsmhSOck0Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866795;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFCDqBGIfwYKMwum9LS9Vj3YsQ1mnM1pbrO35ZJ9TT0=;
	b=qpu6fQee5ak9Yxhf9sJRSNUlT0FTlUDcg/YvcqfmotjlOxrFuORBVONSnK28RYL15qVwIC
	FhfI/KyzZgX7fpBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EBA6134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 5wEGG2teWmPzBAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:15 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 08/16] dnsproxy: strip_domains(): fix out of bounds read access
Date: Thu, 27 Oct 2022 12:32:51 +0200
Message-Id: <20221027103258.29129-9-matthias.gerstner@suse.de>
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

If the name is not found in an answer record then `ptr` is NULL and the
calculation at the end of the while loop `maxlen -= answers - ptr` will
underflow, resulting in a very large `maxlen` value and consequently in
out of bound read accesses parsing beyond the actual end of the answers
section.
---
 src/dnsproxy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index c98e04eb6..d32fbd6db 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1903,6 +1903,8 @@ static int strip_domains(char *name, char *answers, int maxlen)
 				end -= domain_len;
 				maxlen -= domain_len;
 			}
+		} else {
+			ptr = answers;
 		}
 
 		answers += strlen(answers) + 1;
-- 
2.37.3

