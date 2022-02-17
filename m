Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8383D7E
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:29 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FBA121997
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1645097487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jo5vDkxistTMChBjxAYVHwTpnr/UmtM4NuqtJZL7N/c=;
	b=kJ6BtrU94l1kHg/kqvZ0gIyrSqqOr8zlYqkVzer4+I6c6k6xLdcw7oOHbBsJ2mT+bLyOE5
	qJHPLduwVXrwkMBHmC12nIKHk+gev876b9fVAWnaFvPdWN+aZukyWEc9vGIl1Y9cJGmgHU
	OpyoDClHKNb0wzDkx0KUzW2m/0FpY9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1645097487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jo5vDkxistTMChBjxAYVHwTpnr/UmtM4NuqtJZL7N/c=;
	b=1vtDYz1enU/r83W6346su4U+nCcmkz6TpbQw8AI7VIvLLuhJWLKlOQEY5p5jbJ+cq6IzO1
	iMAfWJWy0YMl9hDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36C4A13BBF
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id aEf7Cw8yDmJJXgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:27 +0000
From: matthias.gerstner@suse.de
To: connman@lists.linux.dev
Subject: [PATCH 5/7] dnsproxy: support programmatic configuration of the default listen port
Date: Thu, 17 Feb 2022 12:31:11 +0100
Message-Id: <20220217113113.24088-6-matthias.gerstner@suse.de>
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

This way a test instance of dnsproxy can be setup that listens on an
unprivileged port for easier testing as non-root.
---
 src/connman.h  |  1 +
 src/dnsproxy.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/connman.h b/src/connman.h
index 68176086..909b53ae 100644
--- a/src/connman.h
+++ b/src/connman.h
@@ -983,6 +983,7 @@ void __connman_dnsproxy_remove_listener(int index);
 int __connman_dnsproxy_append(int index, const char *domain, const char *server);
 int __connman_dnsproxy_remove(int index, const char *domain, const char *server);
 int __connman_dnsproxy_set_mdns(int index, bool enabled);
+void __connman_dnsproxy_set_listen_port(unsigned int port);
 
 int __connman_6to4_probe(struct connman_service *service);
 void __connman_6to4_remove(struct connman_ipconfig *ipconfig);
diff --git a/src/dnsproxy.c b/src/dnsproxy.c
index d04057fa..f862c788 100644
--- a/src/dnsproxy.c
+++ b/src/dnsproxy.c
@@ -223,6 +223,7 @@ static GHashTable *listener_table = NULL;
 static time_t next_refresh;
 static GHashTable *partial_tcp_req_table;
 static guint cache_timer = 0;
+static in_port_t dns_listen_port = 53;
 
 static guint16 get_id(void)
 {
@@ -3704,7 +3705,7 @@ static GIOChannel *get_listener(int family, int protocol, int index)
 	if (family == AF_INET6) {
 		memset(&s.sin6, 0, sizeof(s.sin6));
 		s.sin6.sin6_family = AF_INET6;
-		s.sin6.sin6_port = htons(53);
+		s.sin6.sin6_port = htons(dns_listen_port);
 		slen = sizeof(s.sin6);
 
 		if (__connman_inet_get_interface_address(index,
@@ -3721,7 +3722,7 @@ static GIOChannel *get_listener(int family, int protocol, int index)
 	} else if (family == AF_INET) {
 		memset(&s.sin, 0, sizeof(s.sin));
 		s.sin.sin_family = AF_INET;
-		s.sin.sin_port = htons(53);
+		s.sin.sin_port = htons(dns_listen_port);
 		slen = sizeof(s.sin);
 
 		if (__connman_inet_get_interface_address(index,
@@ -4050,3 +4051,8 @@ void __connman_dnsproxy_cleanup(void)
 	if (ipv6_resolve)
 		g_resolv_unref(ipv6_resolve);
 }
+
+void __connman_dnsproxy_set_listen_port(unsigned int port)
+{
+	dns_listen_port = port;
+}
-- 
2.34.1

