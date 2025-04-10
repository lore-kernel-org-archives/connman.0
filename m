Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693E1EFF9A
	for <connman@lists.linux.dev>; Thu, 10 Apr 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302757; cv=none; b=NLbXZQBDWpJOFbUwFWSdk0kAwpUNU+kY3I3yn5SJq3GbABIS/WYmaLJbkLgKLGNNfGthMUbUcXrmlUyAQgZyQoAgI7+xhzi2Nit6tTQiE5kb3UzRjf0H1ggxEv2bWFrWdh6wXLFPzrdQcyJjymoR6ZTobHavkiTUzgzZrsMeD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302757; c=relaxed/simple;
	bh=DmsVHqIVm+9TcdcSAbA1GNGKdhrIfpHDv5x6ZiOOz7s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1M6/qOG08dzZ/pkn/QoV0WHQFBoN4WSukjXv4UNhPjCldzhuWqgaVmQfCMUVgqyG01uTJKyTdSfaDpFD7sW2QDS0uy9FGQD/uLzY3p8FSoH93RPyriJ0AN3QWZhbbyy+nRZhtGmc3mVSk2+nONsp/cMgzIEkS+6dccFmOomayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=mxikHQ7D; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="mxikHQ7D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6nqxHzgsAZGuikq0p6OTgJdXnlotRLlnDIQU4s/75EY=; b=mxikHQ7Dh/kO7YsGyMJFAF3Rbo
	gfXO8S++K30XokUHNWNshZzqFLf6giMjHRt0ptSS3dnChjtDQ93/P0A4hJOAmKhLtaH4Aznl1GJKt
	TKIbZb+BYAGhJ9FcnYpUsgqvSzJuAut1TquyD+IxOLW2jBQwyElR6R9KoVRivS6bfpU7TF3KOlTY1
	9fbWkN9hTVgMXfDiGPFDVHzOLxQwzjjyzugDjro1JbjZTnpMNgNLASatcz86MOz9VIRvQRO6l6onl
	GyZzUMftrELS9VIk74jLw5xTm4HIH3C8AbsgsRPsk7LHDiVXexZLhxE9Exdi4JCNfohr9II0nXEE6
	xNZ1JZ0g==;
Received: from [2a10:a5c0:37:6500:604d:112d:4f8c:3578] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1u2uIp-004Gb9-08
	for connman@lists.linux.dev;
	Thu, 10 Apr 2025 18:58:55 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 3/8] vpn: Avoid using uninitialized prefix_len
Date: Thu, 10 Apr 2025 18:58:41 +0300
Message-Id: <20250410155846.252858-4-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:604d:112d:4f8c:3578
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Clang complains about the prefix_len being possibly uninitialized. Set
the max for IPv6 prefix len as the value.
---
 plugins/vpn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index 42396d2a..9664c82f 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2012-2013  Intel Corporation. All rights reserved.
  *  Copyright (C) 2019-2021  Jolla Ltd. All rights reserved.
+ *  Copyright (C) 2025  Jolla Mobile Ltd
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -388,7 +389,7 @@ static int extract_ip(DBusMessageIter *array, int family,
 {
 	DBusMessageIter dict;
 	char *address = NULL, *gateway = NULL, *netmask = NULL, *peer = NULL;
-	unsigned char prefix_len;
+	unsigned char prefix_len = 128;

 	if (dbus_message_iter_get_arg_type(array) != DBUS_TYPE_ARRAY)
 		return -EINVAL;
--
2.39.5

