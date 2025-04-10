Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3C28A407
	for <connman@lists.linux.dev>; Thu, 10 Apr 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302824; cv=none; b=bux6AP0hSInGFtPuuRDHx1otu8iWyhzNTWKP1Vo/GNIGwCHitMytIm07JQ2JOMlh0uJKrqT8wjBD+TWugmIbf/u/1Ur8rljTNWBaHabvP8YI1idSBCtbjwo1w+BuGcy1oyCY/BnZWFrY5rV95wQVBBzgKRMEQ9IUmbi4ovl82/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302824; c=relaxed/simple;
	bh=MTsz9uSwEDO9/kO3iJLzVqGbtOIqq3bLFKa06FWVJvw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/TYXQaPbOdLwG6NjbduciE0tBnzP4Qs+1hdoGBrx+PHfYmfOWPwvXIO9kBT8X/wNEnHIizqGdENptVhCdgtbjIMh9p/lpHhxzzH9OW5AudOWdofl4zV0LCOdBOqKn/JNScJosy5vLZ3YfvmImTw6/CbMDc4qMa/VJGgSyqpH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=mNtuzixR; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="mNtuzixR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cgceNrhPxeDe0RsHmRDKQDp+NQNuw0dshW8Htgzc6Sc=; b=mNtuzixRPPmjdza9ip2P4oSVMj
	v4QmsQjTgxqaGibB7S/KeIdGqjwn0L+Hu8ibhy+ioHDJeFCTODCcFQYh/VHtBDbJj0oy3DohOh4mn
	ZQzzY1IbJARUDjp7fIKkww+XBFefJ0Xrpwketlj5WS7MJx74DuTWWGpLKcQ022CRaZ1RmFebZrUF0
	aUDI+xF6Hp+IrW+xfXKBbKO+UEDZlz6MH4ImKyQ1YcKLW+O/g87dtGKJNc+gcoW3CU8gfkE9AZfs1
	LiGl6WrytDPFIv241nDc9XGJJuNt4a8beI0SsNgSu6TV5Po45q16wHIrwibZCM+LEZmlgENuVk4rq
	yneDiOkg==;
Received: from [2a10:a5c0:37:6500:604d:112d:4f8c:3578] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1u2uIo-004Gb9-3C
	for connman@lists.linux.dev;
	Thu, 10 Apr 2025 18:58:55 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/8] vpn: Check also vpn-driver to avoid NULL ptr dereference.
Date: Thu, 10 Apr 2025 18:58:40 +0300
Message-Id: <20250410155846.252858-3-jussi.laakkonen@jolla.com>
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

Found with Clang analyzer.
---
 vpn/plugins/vpn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/vpn/plugins/vpn.c b/vpn/plugins/vpn.c
index cb0d304b..fc2a0e74 100644
--- a/vpn/plugins/vpn.c
+++ b/vpn/plugins/vpn.c
@@ -3,6 +3,7 @@
  *  ConnMan VPN daemon
  *
  *  Copyright (C) 2007-2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2025  Jolla Mobile Ltd
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -162,7 +163,7 @@ vpn_exit:
 		if (name)
 			vpn_data = g_hash_table_lookup(driver_hash, name);

-		if (vpn_data &&
+		if (vpn_data && vpn_data->vpn_driver &&
 				vpn_data->vpn_driver->error_code)
 			ret = vpn_data->vpn_driver->error_code(provider,
 					exit_code);
--
2.39.5

