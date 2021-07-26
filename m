Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829070
	for <connman@lists.linux.dev>; Mon, 26 Jul 2021 07:30:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E956C5E363;
	Mon, 26 Jul 2021 09:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1627284600; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=so6v2/7lqx+ACcKSdoJmrknOZ5ZX+PpEmJxqi2lRxKU=;
	b=yPfZPQaTVcn2I463M5tpjE7BoW/WdD8LXxMvQg3aO6WqQJ+yei4iuL+HnAttN7LHbryNuW
	xG8/RWeI2EPi6yw9UE/nDHqP5RM+Dk5oQ7urA8yxP0DZ8z4VHXzOqQgFuOdsH6LSzXz2NZ
	MIxEBCWwFGP0TzmVimMP+gPFUzvoPGIMfd+hDxkgika4fhO5UJvdTPbkfw5HcZaMQ+6CFj
	VN/0gZwaEcDbg56uL+KwbsQESo7YqI9F8NiCCWk3+oDVbYpE1SIOmlJvcCn1A6WlFb6F2B
	PB5L0atM+BJIgiBSfhSuDmE5OOC/l4eNdx0Z/x/fMBMuJVCjvp8PydQt3S79GA==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] gdhcp: Do not process missing DHCP_SERVER_ID fields
Date: Mon, 26 Jul 2021 09:29:58 +0200
Message-Id: <20210726072958.23281-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The DHCP might send an invalid DHCP response with a missing
DHCP_SERVER_ID field. In this case just abort the processing and
return to the idle loop.

Reported by Mike Evdokimov.
---
 gdhcp/client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gdhcp/client.c b/gdhcp/client.c
index c7b85e58e2be..3016dfc2582b 100644
--- a/gdhcp/client.c
+++ b/gdhcp/client.c
@@ -2381,6 +2381,9 @@ static gboolean listener_event(GIOChannel *channel, GIOCondition condition,
 		dhcp_client->retry_times = 0;
 
 		option = dhcp_get_option(&packet, pkt_len, DHCP_SERVER_ID);
+		if (!option)
+			return TRUE;
+
 		dhcp_client->server_ip = get_be32(option);
 		dhcp_client->requested_ip = ntohl(packet.yiaddr);
 
@@ -2442,6 +2445,8 @@ static gboolean listener_event(GIOChannel *channel, GIOCondition condition,
 			if (dhcp_client->state == REBOOTING) {
 				option = dhcp_get_option(&packet, pkt_len,
 							DHCP_SERVER_ID);
+				if (!option)
+					return TRUE;
 				dhcp_client->server_ip = get_be32(option);
 			}
 
-- 
2.32.0

