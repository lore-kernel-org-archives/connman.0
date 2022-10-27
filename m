Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C501879
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:17 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1D1E1FDFD
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666866790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n04pEI8Es+tqA5NngmOeYdGNXDI3iDAuFnYIK8N/oAk=;
	b=xyL1bJIYCySyMiO2p/4l63GWCICDb1017TRCZKqE8y2so7KFUOo/0EDQlq0N6HQOtmlHzi
	GhNwXrgRJsv8QjgU1c0D2tDjiFiqCU3Zx9r2xE29MQSJ0TqncCMWxW4gc8W7OdBJwxrIK5
	LPy/TtaboLY51Bqgtf2zzHuGOzs9fcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666866790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n04pEI8Es+tqA5NngmOeYdGNXDI3iDAuFnYIK8N/oAk=;
	b=XWteR+yQzSRfgVzuLjESmoTsQs16bGpWvCrXylTTdBIU5oXY/9/YQlngxs4wTs+p3Q9pib
	UoqokGytE0kv6mDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 998C8134CA
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pAt7JWZeWmPcBAAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 27 Oct 2022 10:33:10 +0000
From: Matthias Gerstner <matthias.gerstner@suse.de>
To: connman@lists.linux.dev
Subject: [PATCH 03/16] dnsproxy: fix compiler warning about zero length printf format string
Date: Thu, 27 Oct 2022 12:32:46 +0200
Message-Id: <20221027103258.29129-4-matthias.gerstner@suse.de>
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

---
 src/dnsproxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 458694e60..cbe03038f 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -2482,7 +2482,7 @@ static gboolean tcp_idle_timeout(gpointer user_data)
 {
 	struct server_data *server = user_data;
 
-	debug("");
+	debug("\n");
 
 	if (!server)
 		return FALSE;
-- 
2.37.3

