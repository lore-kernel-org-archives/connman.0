Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47774ED6
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:43 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96F40210F5
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1650365141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ka+GjfygmaCFAvHOjr9W14uS1O03kWAZ5CF+IDa4ok=;
	b=RJDtabNle+YeM6GG00M/v7n7pe8GbJZ66H5x5hKC3GT3/GNB1hmrPD80AkQSnHiaN9n/c/
	on1T3M7vs6P/a6KZEc5wB556houjpuB6ncPtXK6y5Po8oN3PSuXgA4KJskE8WV9VmPoydP
	KM9HcGo/V47cQXnqni1y0LgGTDQb7Ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1650365141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ka+GjfygmaCFAvHOjr9W14uS1O03kWAZ5CF+IDa4ok=;
	b=/u3UZ5FXneCuyobz/81uiHA/7M8PigTxQDEGCe3aqme/7SbyqhKTQWyx9Nv6x3wQ5mcN9y
	9OizRrtVFeGq3LCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FABA139BE
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id j50OI9WSXmLjOAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 19 Apr 2022 10:45:41 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 06/12] dnsproxy: strip_domains(): fix out of bounds read access
Date: Tue, 19 Apr 2022 12:34:55 +0200
Message-Id: <20220419103501.30553-7-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419103501.30553-1-matthias.gerstner@suse.de>
References: <20220419103501.30553-1-matthias.gerstner@suse.de>
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
index 621a857d0..9cb92627a 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1877,6 +1877,8 @@ static int strip_domains(char *name, char *answers, int maxlen)
 				end -= domain_len;
 				maxlen -= domain_len;
 			}
+		} else {
+			ptr = answers;
 		}
 
 		answers += strlen(answers) + 1;
-- 
2.35.1

