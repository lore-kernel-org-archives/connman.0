Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1B2CA3
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 09:00:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE87B5D1AA;
	Tue, 25 Jan 2022 10:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643101231; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=mWvm8xRcpqx4N5L/B2uoZv3l52LTBDtSvXuDwW9IcyM=;
	b=XvsTHfLigeiY7G3XY2ppytwMnQLXO5KssEbTTZerjSkftn76HX1jjc6XAkpBEWjHVSWA4P
	jt3DNMGGOYECz6dvWtboNrXIpmwA/vXvIxYSdBQQ/ORkbRSbQ+KNmgPlhkCrC+TRDGDa7Y
	NT8E5JgvJQBd2n4Rh2FeSzCGfVEvue6tJ9Y6DYu/3d5PWl+rCJ6b3xJliPg+EPbq+gQZrZ
	MSoXUKLu+/+V8ksUmQiLsybtH+Or0lKpOlUTpN/BsSb4uVZFdLHxyO8mh38ost2xSx3erd
	pHmWdwjpdQu/y3rmOkOcMughg1RCbjguhvMy8HnTBjRY3T21Ox7bQrCFw9WuWQ==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Matthias Gerstner <mgerstner@suse.de>
Subject: [PATCH 5/5] dnsproxy: Keep timeout in TCP case even after connection is established
Date: Tue, 25 Jan 2022 10:00:26 +0100
Message-Id: <20220125090026.5108-6-wagi@monom.org>
In-Reply-To: <20220125090026.5108-1-wagi@monom.org>
References: <20220125090026.5108-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Matthias Gerstner <mgerstner@suse.de>

If an outgoing TCP connection succeeds but the remote server never sends
back any data then currently the TCP connection will never be
terminated by connmand.

To prevent this keep the connection timeout of 30 seconds active even
after the connection has been established.
---
 src/dnsproxy.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index 1ccf36a95a35..cf1d36c74496 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -2375,11 +2375,6 @@ static gboolean tcp_server_event(GIOChannel *channel, GIOCondition condition,
 		server->connected = true;
 		server_list = g_slist_append(server_list, server);
 
-		if (server->timeout > 0) {
-			g_source_remove(server->timeout);
-			server->timeout = 0;
-		}
-
 		for (list = request_list; list; ) {
 			struct request_data *req = list->data;
 			int status;
-- 
2.34.1

