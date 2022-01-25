Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C412CAC
	for <connman@lists.linux.dev>; Tue, 25 Jan 2022 09:00:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7163B5D1A6;
	Tue, 25 Jan 2022 10:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1643101231; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bn+FrolDNM9FcJrQ2au/J27Eo1Cgr8+oKMzGnRm4mpg=;
	b=OC089Zug4Bi46jcYB77MtMP2lMTNeG0DgPI2QdERG/YR3RSD2sfjjwgJRlmdL/ebZ5uVFU
	p1tsZPIltGWwfZsY5Hc8eEdLDqlCqxuzvKvqvb64kkZOfL0+9io29XHV722/yiLAM6TD9w
	lJkCZrS34D2so6omwKaw305VzyYrC7RgTrmdf8qsUIAshEoz6WSk6YWkj94f8EoVEld8Z5
	q4aL1W5glLZ7BhNGg5QSsBoSaAccoxQqz9K5IkxHcBgsQY93JgH2XqaPgjukA8ObZeQLnW
	oKzqGy9mzyC8INXvGH1f122JymkhdTDgkIwsCgHYbiEVzoAqet+/dg+o/eL5ww==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Matthias Gerstner <mgerstner@suse.de>
Subject: [PATCH 4/5] dnsproxy: Avoid 100 % busy loop in TCP server case
Date: Tue, 25 Jan 2022 10:00:25 +0100
Message-Id: <20220125090026.5108-5-wagi@monom.org>
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

Once the TCP socket is connected and until the remote server is
responding (if ever) ConnMan executes a 100 % CPU loop, since
the connected socket will always be writable (G_IO_OUT).

To fix this, modify the watch after the connection is established to
remove the G_IO_OUT from the callback conditions.

Fixes: CVE-2022-23098
---
 src/dnsproxy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index c027bcb972c4..1ccf36a95a35 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -2360,6 +2360,18 @@ static gboolean tcp_server_event(GIOChannel *channel, GIOCondition condition,
 			}
 		}
 
+		/*
+		 * Remove the G_IO_OUT flag from the watch, otherwise we end
+		 * up in a busy loop, because the socket is constantly writable.
+		 *
+		 * There seems to be no better way in g_io to do that than
+		 * re-adding the watch.
+		 */
+		g_source_remove(server->watch);
+		server->watch = g_io_add_watch(server->channel,
+			G_IO_IN | G_IO_HUP | G_IO_NVAL | G_IO_ERR,
+			tcp_server_event, server);
+
 		server->connected = true;
 		server_list = g_slist_append(server_list, server);
 
-- 
2.34.1

