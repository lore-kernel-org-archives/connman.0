Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CDB20F0
	for <connman@lists.linux.dev>; Tue, 11 Apr 2023 06:29:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 214A3DE32D;
	Tue, 11 Apr 2023 08:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1681193991; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=4Ho4kiwf3m9nKcd0hfBOReOa4oY11ZfiDtsfcLmSEjE=;
	b=hNXfgDHpf7NDH8woRGZ7cZv0yiWxkD+T07vynEYWf3aDSnHCGMtGnFzm3TbB2uZOjumoYD
	6PfcWjH5QpQBBL3Qr1jXuJeU0dvmYYmVhfli3nmyGy5PboWsCiJm4Yv9Vzei0H9r8f1wR7
	4BWR5GVge/3wDJQRYLVBWfwF/ieIU6lTcp2QdltNaVfsrL5OFtbrNqoBwM6CYnwXpd6Z/n
	Kym3SoOkzcYGUE+0iPU4anWEimEMMONWlW809tMry27eQ2KKzbxkEhX2yCU1sKWlyXvymQ
	FST0ao0Cy9dNw8wYHXOCtZbCtF9QXzyJln27TxYSDmnvRUrhpS9IQK5NCwvxzg==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Polina Smirnova <moe.hwr@gmail.com>,
	Daniel Wagner <wagi@monom.org>
Subject: [PATCH] gdhcp: Verify and sanitize packet length first
Date: Tue, 11 Apr 2023 08:19:45 +0200
Message-Id: <20230411061945.8089-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Avoid overwriting the read packet length after the initial test. Thus
move all the length checks which depends on the total length first
and do not use the total lenght from the IP packet afterwards.

Fixes CVE-2023-28488

Reported by Polina Smirnova <moe.hwr@gmail.com>
---

Patch already applied.

 gdhcp/client.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/gdhcp/client.c b/gdhcp/client.c
index 7efa7e45aa4d..8201769261d7 100644
--- a/gdhcp/client.c
+++ b/gdhcp/client.c
@@ -1319,9 +1319,9 @@ static bool sanity_check(struct ip_udp_dhcp_packet *packet, int bytes)
 static int dhcp_recv_l2_packet(struct dhcp_packet *dhcp_pkt, int fd,
 				struct sockaddr_in *dst_addr)
 {
-	int bytes;
 	struct ip_udp_dhcp_packet packet;
 	uint16_t check;
+	int bytes, tot_len;
 
 	memset(&packet, 0, sizeof(packet));
 
@@ -1329,15 +1329,17 @@ static int dhcp_recv_l2_packet(struct dhcp_packet *dhcp_pkt, int fd,
 	if (bytes < 0)
 		return -1;
 
-	if (bytes < (int) (sizeof(packet.ip) + sizeof(packet.udp)))
-		return -1;
-
-	if (bytes < ntohs(packet.ip.tot_len))
+	tot_len = ntohs(packet.ip.tot_len);
+	if (bytes > tot_len) {
+		/* ignore any extra garbage bytes */
+		bytes = tot_len;
+	} else if (bytes < tot_len) {
 		/* packet is bigger than sizeof(packet), we did partial read */
 		return -1;
+	}
 
-	/* ignore any extra garbage bytes */
-	bytes = ntohs(packet.ip.tot_len);
+	if (bytes < (int) (sizeof(packet.ip) + sizeof(packet.udp)))
+		return -1;
 
 	if (!sanity_check(&packet, bytes))
 		return -1;
-- 
2.40.0

