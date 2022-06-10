Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B610647
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:36 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95FB81FDC2
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654864414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce/NBoswwhCvbZkBbUvhiT2oarqIwf9oSIQwSq4cSZE=;
	b=qYrudJP93XboR/EpHbn4pcFJ4gnVvmpsZmxJUqjqXi5q2CWgHIkLLC64v7M10MVW9E7UNp
	y3O8oibdwypBtuWZOtmWU/7JxrOfG65+T9DL3OrRKxPjQ0iwFAe1W1Ff1xUejVOMreeSMe
	kKgDNLMLfm3FteH9R0YnmAX0HvikUMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654864414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ce/NBoswwhCvbZkBbUvhiT2oarqIwf9oSIQwSq4cSZE=;
	b=OMln1FZkwPz61ZDZZOm3+W1+GseY9pakLSChBZDAOgomTtLncYdNZoVCElC1QalNPhIUIp
	eawpcCuo/vCcmXDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FF3F139ED
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 02siIx46o2KCMgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Fri, 10 Jun 2022 12:33:34 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 07/16] dnsproxy: strip_domains(): fix out of bounds read access
Date: Fri, 10 Jun 2022 14:33:14 +0200
Message-Id: <20220610123323.8974-8-matthias.gerstner@suse.de>
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

If the name is not found in an answer record then `ptr` is NULL and the
calculation at the end of the while loop `maxlen -= answers - ptr` will
underflow, resulting in a very large `maxlen` value and consequently in
out of bound read accesses parsing beyond the actual end of the answers
section.
---
 src/dnsproxy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 209120add..bc92787e4 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1881,6 +1881,8 @@ static int strip_domains(char *name, char *answers, int maxlen)
 				end -= domain_len;
 				maxlen -= domain_len;
 			}
+		} else {
+			ptr = answers;
 		}
 
 		answers += strlen(answers) + 1;
-- 
2.35.1

