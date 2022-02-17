Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3637C1FD3
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:29 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E81561F383
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1645097484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9o24MoEUMD3Z+36CDfOiZZkANR3ursUSfFNKT8fASOo=;
	b=eAulS1tkNy8sFVFqzdr1cj7g4sbfEpslT6u5v1mFqfMdfVybX+7m96ApWRitIrbifExKXt
	FI4xUQdh6pqnDV3IpirUI5o1GTksqA0E4tDQv0C/LpxUXCfFqB5qpwKtBhxccLAHbXnvZ9
	x5W9BAn2iA2haW7+RJrAT22mfGlPYxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1645097484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9o24MoEUMD3Z+36CDfOiZZkANR3ursUSfFNKT8fASOo=;
	b=JmbRGh3hhk+lEVTyt/aSaxzDL9pFVRoy/IbRBWBsNCLfQjt7CXvNHFCTrB0Ii4uQ1oIyjv
	D53pvBLNIYXDSFBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D092A13BBF
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2R+tMQwyDmJDXgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:24 +0000
From: matthias.gerstner@suse.de
To: connman@lists.linux.dev
Subject: [PATCH 2/7] dnsproxy: remove unnecessarily shadowed variable
Date: Thu, 17 Feb 2022 12:31:08 +0100
Message-Id: <20220217113113.24088-3-matthias.gerstner@suse.de>
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
 src/dnsproxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index ad8c5da2..b195f447 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -2855,7 +2855,7 @@ static void remove_server(int index, const char *server, int protocol)
 	destroy_server(data);
 
 	for (list = server_list; list; list = list->next) {
-		struct server_data *data = list->data;
+		data = list->data;
 
 		if (data->index != -1 && data->enabled == true)
 			return;
-- 
2.34.1

