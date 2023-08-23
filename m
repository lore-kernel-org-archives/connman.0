Received: from mail.ifd.de (mail.ifd.de [217.91.79.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A23C139
	for <connman@lists.linux.dev>; Wed, 23 Aug 2023 17:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=patlkli.org;
	s=202003; t=1692812799;
	bh=jac83dw+7Y5Ijtnjfx8EMjauAg3aldo8mfuAdSVJm+w=;
	h=From:To:Cc:Subject:Date:From;
	b=wz0iM2jKOyDzQ24eImSeA3x3UfDi5YHNGbCkiMm+sJjp9aNua53sDEh7j7UsoXu97
	 L4A7F8OyRq5lPUNc/DDvk524d4GLom+K7edUXDLu4zK5jA05mUFurE05Uo0ZoAREfX
	 SdoepBjsMVlDthmVgfz9wLg/qifZKhVl3QFX/ia3AaISZZv+xJE9nK2V5igI+5UNBE
	 e99IgTODr1dxDSnySfbiCOSx2beB4Dt2UITsRBch5suH+WS42DOrPZdt9mBAIpVjrt
	 Pd54DevLnR5nzF0lg3HOAARe2XY89UhKUN/3gUKW4fMY7o3WfeC9LEAvYAN1yLSXe3
	 OjtXHVAnpILFw==
Received: from localhost (localhost [127.0.0.1])
	by mail.ifd.de (Postfix) with ESMTP id 859B36808AC;
	Wed, 23 Aug 2023 19:46:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at sixtysix.ifd-altdorf.de
Received: from mail.ifd.de ([127.0.0.1])
	by localhost (sixtysix.ifd-altdorf.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mNzofxYpgVx; Wed, 23 Aug 2023 19:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=patlkli.org;
	s=202003; t=1692812793;
	bh=jac83dw+7Y5Ijtnjfx8EMjauAg3aldo8mfuAdSVJm+w=;
	h=From:To:Cc:Subject:Date:From;
	b=BSARA/8cQzBoIEd5kfmMecLK99efGW0BGDzE16Vyw13BtonO/jqOdnDKCjctjvZMh
	 bItcEQ8eoXt6ytYWr+oEiNJ/Oyw5Pb5MAj425GrqhAXEHYXWVsM17oBKGxm/8teXDj
	 2b+Kv0buSxmgPrulaET7mHJ0zoac9LSOCBQFQraxbqDrBH/mbC6Q9L24NmHHro+Zta
	 BgKuUtHA1v2bPsiOEkToIIa1Qg/f7FkuJ+viZ6CIAcNaxOMF6F0o5PuYeZkse2BICr
	 C+UngQHv1UZxhymevxqs+um5CsGzVzBkLmP2TG3AsRn74lik+8qz8zys2x+Z8y9ATY
	 5BMYt9ArU/btg==
Received: from athene.fritz.box (ppp-93-104-163-83.dynamic.mnet-online.de [93.104.163.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ifd.de (Postfix) with ESMTPSA id 412846805A5;
	Wed, 23 Aug 2023 19:46:33 +0200 (CEST)
From: Patrick Geltinger <patlkli@patlkli.org>
To: connman@lists.linux.dev
Cc: Patrick Geltinger <patlkli@patlkli.org>
Subject: [PATCH] dns: filter invalid addresses for systemd-resolved
Date: Wed, 23 Aug 2023 19:46:13 +0200
Message-Id: <20230823174613.706596-1-patlkli@patlkli.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

systemd-resolved's SetLinkDNS method will refuse to apply any changes if
any of the specified DNS server addresses are invalid (zero address or
their own DNS stub).

To avoid a misconfigured DHCP server leaving the system without any DNS
configuration, filter the server list before calling SetLinkDNS.
---
 src/dns-systemd-resolved.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/dns-systemd-resolved.c b/src/dns-systemd-resolved.c
index 912ab3fe..413daf20 100644
--- a/src/dns-systemd-resolved.c
+++ b/src/dns-systemd-resolved.c
@@ -99,11 +99,16 @@ static void setlinkdns_append(DBusMessageIter *iter, void *user_data)
 
 		DBG("index: %d, server: %s", iface->index, server);
 
+		type = connman_inet_check_ipaddress(server);
+
+		if (__connman_inet_is_any_addr(server, type)) {
+			DBG("Ignoring invalid address: %s", server);
+			continue;
+		}
+
 		dbus_message_iter_open_container(&address_array,
 				DBUS_TYPE_STRUCT, NULL, &struct_array);
 
-		type = connman_inet_check_ipaddress(server);
-
 		if (type == AF_INET) {
 			result = inet_pton(type, server, ipv4_bytes);
 			if (result != 1) {
-- 
2.39.2

