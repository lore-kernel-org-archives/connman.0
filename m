Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ECD2248B9
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745172; cv=none; b=S+jHAtG1dKrkE2LcTPkOEX1N9FNTN+Ds1tBXLXoO2sAWrrf5/xj5d55n+zrUxTFzBj7oPRthXyB4aDychJPvx0pfqdnpoohV/lkdCHRwnF7QMdSQkJTRGUV9bSXRS1r6E3MDrHizojLfWHU/gSGJMa4M1KdqFGSEewjV9o0nNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745172; c=relaxed/simple;
	bh=kGg2qWt+ykTsG3RF9QbCzSciXkyqfLn8AudO9baa18o=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhyNdfLNHAqEfILCTHP5+NW7pxL+Y3Zg+zzyLnWeCmYGLgNR96J9z45iaH8adtQX5DfHbk4GUqZyhT1cvasf1mDRFAE8CvopeBszz9CpisoI1nNedqSAOWEE2HQbE9ULH7KrYKvJS9dFLJpFpiiNNMMZSpfTuSRuQLo3MibLTRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=mRVg9KbH; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="mRVg9KbH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Jbk/YfV5SJ4dASxqwDMjByhbYPDOLHDLKsjpHTCKh1c=; b=mRVg9KbHUjGRezyEJ/N9peRM+m
	Ro/ga3q3mO7zFVMFqcqgiqd4IqZSNI+DVgkJwwrDNlNIUu0vvfoJpfvFagMwRg1ZXHzI5yBd8cvPe
	iCCL8k/l0j2UI4WWlu8cmeKUA2I8xGSFZB23Xh4wF2RqwvD5JMnD+HegBbDvOK44V+3QOF2ThIc+f
	mc9QkxrimZuF+cBLYigSJWR4Gr7ww/RxKQMztxg+bragN258cJNKrTes4NSzlhmQxEVlxWGR3oHhZ
	UtqMdmRN9lAcb9cOM2Zec6F5civvj4I/sy2t7pQkLKzhhdMT3PNRaCVFwrzn8eZHf7UUrHkNlX8h+
	xeYv8NVg==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtr-006LTc-0J
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:59:27 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 11/12] vpn: Fix extracting of PrefixLength D-Bus value
Date: Fri, 24 Jan 2025 20:59:15 +0200
Message-Id: <20250124185916.1546471-12-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

The PrefixLength value is stored as a DBUS_TYPE_BYTE, and is an unsigned
char, thus should be read as such. This fixes crash when trying to read
the value into a char*.
---
 plugins/vpn.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index 42396d2a..332d8e83 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -412,8 +412,8 @@ static int extract_ip(DBusMessageIter *array, int family,
 			dbus_message_iter_get_basic(&value, &netmask);
 			DBG("netmask %s", netmask);
 		} else if (g_str_equal(key, "PrefixLength")) {
-			dbus_message_iter_get_basic(&value, &netmask);
-			DBG("prefix length %s", netmask);
+			dbus_message_iter_get_basic(&value, &prefix_len);
+			DBG("prefix length %u", prefix_len);
 		} else if (g_str_equal(key, "Peer")) {
 			dbus_message_iter_get_basic(&value, &peer);
 			DBG("peer %s", peer);
@@ -436,7 +436,6 @@ static int extract_ip(DBusMessageIter *array, int family,
 								gateway);
 		break;
 	case AF_INET6:
-		prefix_len = atoi(netmask);
 		connman_ipaddress_set_ipv6(data->ip, address, prefix_len,
 								gateway);
 		break;
-- 
2.39.5

