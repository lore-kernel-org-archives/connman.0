Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E81FD3
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:30 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 180621F884
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1645097488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGCxQocdPd5mhuJjtelHBpUqNIBykuzyTE07qPLdVEY=;
	b=AEduBV5+JQ5J8y9hcqSNqymxiQh8RRZawOX0F2BJ/LotFIrd/bEeDOOb1v/vPiy0GPtoj+
	5NCg3xWtGfBMS5Ud61cfXaYW8rELtILXLfCGu1uSiYMtxl7M7Fz/00K8k3Wz9vOH8VQprt
	hEuuiLcCv4xVfwBu4gHi/qVXYxLEB98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1645097488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGCxQocdPd5mhuJjtelHBpUqNIBykuzyTE07qPLdVEY=;
	b=nOC5rLIwtZvvSI9yrjJ6bL0BaUlgWJY317/myiMJGMKnBMYTo87hSETXXMB7zNPL+djFSu
	8ZVhD9vfy8LFG5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 038B713BBF
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /c8PABAyDmJLXgAAMHmgww
	(envelope-from <mgerstner@suse.de>)
	for <connman@lists.linux.dev>; Thu, 17 Feb 2022 11:31:28 +0000
From: matthias.gerstner@suse.de
To: connman@lists.linux.dev
Subject: [PATCH 6/7] dnsproxy-test: support command line specification of dnsproxy port
Date: Thu, 17 Feb 2022 12:31:12 +0100
Message-Id: <20220217113113.24088-7-matthias.gerstner@suse.de>
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

This way a dnsproxy running on an unprivileged port can be tested.
---
 tools/dnsproxy-test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/dnsproxy-test.c b/tools/dnsproxy-test.c
index 371e2e23..7660db71 100644
--- a/tools/dnsproxy-test.c
+++ b/tools/dnsproxy-test.c
@@ -99,6 +99,8 @@ static unsigned char msg_invalid[] = {
 	0x31, 0xC0, /* tran id */
 };
 
+static const char *dns_port = "53";
+
 static int create_tcp_socket(int family)
 {
 	int sk, err;
@@ -139,7 +141,7 @@ static int connect_tcp_socket(char *server)
 	hints.ai_socktype = SOCK_STREAM;
 	hints.ai_family = AF_UNSPEC;
 	hints.ai_flags = AI_NUMERICSERV | AI_NUMERICHOST;
-	getaddrinfo(server, "53", &hints, &rp);
+	getaddrinfo(server, dns_port, &hints, &rp);
 
 	sk = create_tcp_socket(rp->ai_family);
 	err = sk;
@@ -201,7 +203,7 @@ static int connect_udp_socket(char *server, struct sockaddr *sa,
 	hints.ai_socktype = SOCK_DGRAM;
 	hints.ai_family = AF_UNSPEC;
 	hints.ai_flags = AI_NUMERICSERV | AI_NUMERICHOST;
-	getaddrinfo(server, "53", &hints, &rp);
+	getaddrinfo(server, dns_port, &hints, &rp);
 
 	sk = create_udp_socket(rp->ai_family);
 	err = sk;
@@ -430,6 +432,11 @@ int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
 
+	if (argc == 2) {
+		// alternative dns port
+		dns_port = argv[1];
+	}
+
 	g_test_add_func("/dnsproxy/ipv4 udp msg",
 			test_ipv4_udp_msg);
 
-- 
2.34.1

