Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC81FD3
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:26 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25AB421119
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1645097484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=echYZxuNr5H7xbNuVHU1rnsyEvn7XY/VbIB8am22sxs=;
	b=rfomZPa4ykSOQV2kIjZU5UR9Xd8YRflGlOgMXbkS0v5OLAwPJ7wsG9u6/IWODnvxDUmvuf
	gzXZottHKsFUBvNyH6J9Ox85MNs30QpWgVMwpJzY/bgX0HHFHD0Sv0ND4xMh0xXW0m/RLU
	gt7twYv2GlAczS0gjXuSvgrY9gZAcLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1645097484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=echYZxuNr5H7xbNuVHU1rnsyEvn7XY/VbIB8am22sxs=;
	b=SjwYWTQHnPv155mqa1XBAd1/hfNgF8T9b80QLL4bjFY6lTgCkNbKtiq1j/JtwdSQ1T1FxT
	4UdeO2ryG24TpaBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E3B813BBF
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nTYAAgwyDmJBXgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:24 +0000
From: matthias.gerstner@suse.de
To: connman@lists.linux.dev
Subject: [PATCH 1/7] dnsproxy: remove unused domain parameter from `remove_server()`
Date: Thu, 17 Feb 2022 12:31:07 +0100
Message-Id: <20220217113113.24088-2-matthias.gerstner@suse.de>
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
 src/dnsproxy.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index cf1d36c7..ad8c5da2 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -2843,8 +2843,7 @@ int __connman_dnsproxy_append(int index, const char *domain,
 	return 0;
 }
 
-static void remove_server(int index, const char *domain,
-			const char *server, int protocol)
+static void remove_server(int index, const char *server, int protocol)
 {
 	struct server_data *data;
 	GSList *list;
@@ -2885,8 +2884,8 @@ int __connman_dnsproxy_remove(int index, const char *domain,
 	if (g_str_equal(server, "::1"))
 		return -ENODEV;
 
-	remove_server(index, domain, server, IPPROTO_UDP);
-	remove_server(index, domain, server, IPPROTO_TCP);
+	remove_server(index, server, IPPROTO_UDP);
+	remove_server(index, server, IPPROTO_TCP);
 
 	return 0;
 }
-- 
2.34.1

