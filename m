Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55028274650
	for <connman@lists.linux.dev>; Mon, 14 Apr 2025 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647037; cv=none; b=TA41QSn2LFQPMhPWqHyZB9ymeE4/qIZfUZ5z7TDtI/WFLgmJn7EkPeb8XcA07UQ0F1IjaRl7CYxxMUaFnqYuMgL2QiR+wqTtsSGY1k010SdccgC5jTZMNNtalwygiK3+Q4htCbWyB7WgkPKmKeV/iX+tW7cYk8guZv9lVOmKGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647037; c=relaxed/simple;
	bh=kGg2qWt+ykTsG3RF9QbCzSciXkyqfLn8AudO9baa18o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nZHWwqi8dZDN+49zy2twItWZ5gzPHpN3Muab/pGV+NUlof+BrT7bDEG2OB2jrFt3OMOSF73kqs6nBbm2R1Z57Kp9NePMq9Z4vPpW5UbkhRqP978UwBTB79A7A489XojsgCVYDgYGSYEzeJPwjM5cpK9mzkcvYN0ixjCo6g2q8+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=qPcdylJZ; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="qPcdylJZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Jbk/YfV5SJ4dASxqwDMjByhbYPDOLHDLKsjpHTCKh1c=; b=qPcdylJZ7WDVNsiIYP9BIEcRJg
	U3/aohijSrI6SQPdnfbbyGNx9f+TfMeeBJxeqbDfBsRdTh76972chN1PNOmqa4Q2fAQFWRc+xB9N7
	FLOWSJUR2qxraaByd8TyecJKm9a0P8I7aMu/gw1qw5nxpMtz/zAmtTGerJrsUYD6on7JLJU3LiibG
	oMeijQIQRh8ttjgexULObF1MRiZoAp0aZkIs/XG8UWj5pu1sXdn+lrocM1zMnsPgzfulTVtmKfYik
	D1jnkccpCxBEgtkDaLcGgcyLNdxznQxOgdWl2iCTR1LlfcWTLdL1nPBtBJPJxIFp2hoLm+/mg+5Ku
	Rcx4dkPQ==;
Received: from [2a10:a5c0:37:6500:3b14:5037:32cc:1893] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1u4MO7-009UcO-21
	for connman@lists.linux.dev;
	Mon, 14 Apr 2025 19:10:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH] vpn: Fix extracting of PrefixLength D-Bus value
Date: Mon, 14 Apr 2025 19:10:15 +0300
Message-Id: <20250414161015.358056-1-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:3b14:5037:32cc:1893
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

