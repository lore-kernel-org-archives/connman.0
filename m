Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9728CF5C
	for <connman@lists.linux.dev>; Thu, 10 Apr 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302813; cv=none; b=llBz+5SQjKXH/BmoPyrfp3ke6CeG5O02/zgCTI8Ag+JTQyOd9SRufGD4RHlnB5D0QRohNZW8k1j++0hrA38yO5/8v2ZzsRjHJcS+BEZZJRk4nc4puR88gjSEMrc/0y531FmBOyvpLZrv8UAT6d5C/PLsMytRKCyzn43syGZOD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302813; c=relaxed/simple;
	bh=hTzyOjALqDvmWErPsOSecMzTNehWe5KRKbbGa50nfak=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXWGnJ19tmneuE93C6eltZ5kICwmPWEPmxFkUW/u+JTccH/ABzEboh4ZCy4bgovDggCMEO+XuOcCvPZeJYBLM1vx6Mc8oiCY1ARtldxOQTOupf/2weg5QoWJ6Rd6smisb4ejZjR2HnzemKU/sdHSXNbY5TjVnWf1s1mXHUqC4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=ylqtuwA5; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ylqtuwA5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=b91Pvh0W5BIdxHu+u++sIfjNSB06j8C5zjkt237qQak=; b=ylqtuwA5ain/g1GlRGyWKxBNIi
	jaBdN3qYfaKhxaLVxKP+Ykdzk1TRZlPTtKZib3S59ptu7qewU8C4Q7xeNkUozEx83o72TKlQ3GQFs
	LGZ6RXbmB/jLMw4f3U6PXMqL1n6bu+SW0cx115KklHhUyEhsshN8VzTVe8CSFM2DANwl5inAgUhVi
	WQviuQsYjejukn5+xs9PZ0ZZKNcYQP1ytIeAbLpjyBRoU0nIaWWl6mDwXgmPG3gzsELyEfeGOQfS/
	CDrDD8PyRZ+3JSJeN3XWB+qervoq3jY7vCXZBxSfmdl7KxKeASo6axmWBIl5oBa2FYqg4Mgm+ioxF
	NmeaXtEg==;
Received: from [2a10:a5c0:37:6500:604d:112d:4f8c:3578] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1u2uIp-004Gb9-0Q
	for connman@lists.linux.dev;
	Thu, 10 Apr 2025 18:58:55 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 5/8] ipconfig: Fix Clang garbage value complaints
Date: Thu, 10 Apr 2025 18:58:43 +0300
Message-Id: <20250410155846.252858-6-jussi.laakkonen@jolla.com>
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

---
 src/ipconfig.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/ipconfig.c b/src/ipconfig.c
index c2d7d2bc..ce4bbc27 100644
--- a/src/ipconfig.c
+++ b/src/ipconfig.c
@@ -3,6 +3,7 @@
  *  Connection Manager
  *
  *  Copyright (C) 2007-2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2025  Jolla Mobile Ltd
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -325,8 +326,10 @@ static int read_conf_value(const char *prefix, const char *ifname,
 	// null-terminated variable argument component list.

 	path = g_build_filename(prefix, ifname ? ifname : "all", suffix, NULL);
-	if (!path)
+	if (!path) {
+		*value = -ENOMEM;
 		return -ENOMEM;
+	}

 	errno = 0; /* Avoid stale errno values with fopen */
 	f = fopen(path, "r");
@@ -337,7 +340,7 @@ static int read_conf_value(const char *prefix, const char *ifname,

 		err = fscanf(f, "%d", value);
 		if (err <= 0 && errno)
-			err = -errno;
+			*value = err = -errno;

 		fclose(f);
 	}
--
2.39.5

