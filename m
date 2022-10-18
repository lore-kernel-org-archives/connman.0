Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B04257D
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:48:06 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFF78207DA
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666082878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKS2kZhPZ12RVEkMBG1vqbRVpDORKBr0s2Goyx7k5nA=;
	b=cEbuFyE9w+hwnzAZsWofCht/mNb4v1ZXB4cQ+m8HA3xW7BpnLLghzYlRZeZNHHJLzUhoQl
	J545H2757qE8bP0qX5k9ZyOB8v55tDxzfZYEEH7PQf/YwFg3cZUAKDKyGiKpwuVGigQ7ZV
	yH4DAqXORB3+5FqMtYIWodGwpvY5WSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666082878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKS2kZhPZ12RVEkMBG1vqbRVpDORKBr0s2Goyx7k5nA=;
	b=Ku3ZBolFaBzpYgAVAueKCdF7VCyA0+QUqbHNRj4QgWic5NQF+X62kWxyGbe2k8gcVen62a
	I15zHT1LdwE51eBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8BD3139D2
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Zv/+MD5oTmOZcAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Tue, 18 Oct 2022 08:47:58 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 07/16] dnsproxy: strip_domains(): fix out of bounds read access
Date: Tue, 18 Oct 2022 10:47:37 +0200
Message-Id: <20221018084746.21959-8-matthias.gerstner@suse.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018084746.21959-1-matthias.gerstner@suse.de>
References: <20221018084746.21959-1-matthias.gerstner@suse.de>
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
index 08c568899..05b606c3b 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -1880,6 +1880,8 @@ static int strip_domains(char *name, char *answers, int maxlen)
 				end -= domain_len;
 				maxlen -= domain_len;
 			}
+		} else {
+			ptr = answers;
 		}
 
 		answers += strlen(answers) + 1;
-- 
2.37.3

