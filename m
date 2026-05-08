Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA03D524E
	for <connman@lists.linux.dev>; Fri,  8 May 2026 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256398; cv=none; b=FiEQtA8NwtbySJpPjH9qRzvrdeRrVyAF7Sod+s+e9oAPTYjetRIKq/M44vy95lwuGNeHIhBtlCucny8jU/k94kxakDPaK7IO0BtDXVr/L+tL38d87NEECK+gpXYiisbvkZTqJHnIz3ZdKD0yj6LQl6RFDe6Yf3yvgVJqCfnO08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256398; c=relaxed/simple;
	bh=YwXDa8LKEGonVpWwo7BVQLYWujCG4yOoiQljQWmJx2I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUL/bVTZN7/rONzQQ5Lk4tEIrqfJvOTM+IWHra9O9txhLZu0yAOJ6a3bJDxXUe9tUr/qHdE+ZhFtTrFnmzvorOPZUP8QvQVLpv2Dasd0Kr+GRiTK7sXtXQzCnMq2jJvuJVVrsyJceNReuhco4dOKDTI9sqBVgqLkiQuFIxb6fkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=YdqIQJDa; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="YdqIQJDa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=snOhldHii4ul74iH0kMAbGD2ST/CFoGrTY5IVJ8IJmM=; b=YdqIQJDasytSiQJUj32d4JPnf8
	quLQXeizwhOybkVRiQU5JoR8l9fZCJqc/56cfA6zXzC/EzIpCt88bXpeHBB+dtaRiCmvFVhDNnmP6
	C4nWhHc2xPm0WbwMoPxwxcq+q05j1eMvcqvTPCBEP6S4zuNjYrjsk/oI0m45cYC1NVbWZt8W3SD/2
	xKMWKDMlsDjl7XC/yHcgZxe6iJUdOSxqYFE7WLe5DHSvZpXM8zCtKfp6P+4ZC/7f4EO+NXH2FFRNp
	sLNcBxj1xfBO+tlTrR/J/M7Hpq2AEfmwJBlux4uj5EMrhkX6N3z+SL9xbTYdT64eWtGMCSe/hkWbv
	O0v3KnAg==;
Received: from [2a10:a5c0:37:6500:11f6:3d14:7c4:afac] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wLNie-00CcPv-1Z
	for connman@lists.linux.dev;
	Fri, 08 May 2026 19:06:28 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/5] systemd-resolved: Proxy tethering client DNS requests to resolved
Date: Fri,  8 May 2026 19:05:36 +0300
Message-ID: <20260508160620.214218-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508160620.214218-1-jussi.laakkonen@jolla.com>
References: <20260508160620.214218-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Message-ID: 20260508160620.214218-3-jussi.laakkonen@jolla.com

Proxy the DNS requests from tethering clients to resolved using the
dns.c functionality. Add an UDP listener for the tethering interface to
serve the requests from that interface and use the shared/dns.c with the
default, hardcoded systemd-resolved server 127.0.0.53 by binding the
socket to localhost interface. This ensures that the limitations set in
the systemd-resolved (by allowing only localhost to connect to the
server) can be circumvented by making the packets to originate from
localhost and not getting dropped as martians or by the server itself.
---
 src/dns-systemd-resolved.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/src/dns-systemd-resolved.c b/src/dns-systemd-resolved.c
index 9dd0328c..644ef3c5 100644
--- a/src/dns-systemd-resolved.c
+++ b/src/dns-systemd-resolved.c
@@ -31,10 +31,12 @@
 #include <glib.h>
 #include <connman/dbus.h>
 
+#include "shared/dns.h"
 #include "connman.h"
 
 #define SYSTEMD_RESOLVED_SERVICE "org.freedesktop.resolve1"
 #define SYSTEMD_RESOLVED_PATH "/org/freedesktop/resolve1"
+#define SYSTEMD_RESOLVED_SERVER "127.0.0.53"
 
 struct resolved_dbus_data {
 	int index;
@@ -375,14 +377,34 @@ int __connman_dnsproxy_append(int index, const char *domain,
 
 int __connman_dnsproxy_add_listener(int index)
 {
-	DBG("");
+	int lo_index;
+	int err;
+
+	DBG("index %d", index);
+
+	err = dns_add_listener(index, DNS_IPPROTO_UDP, true);
+	if (err)
+		return err;
+
+	lo_index = connman_inet_ifindex("lo");
+	err = dns_create_server(lo_index, "local", SYSTEMD_RESOLVED_SERVER,
+								IPPROTO_UDP);
+	if (err)
+		return err;
+
+	err = dns_enable_server(lo_index, SYSTEMD_RESOLVED_SERVER, IPPROTO_UDP,
+								true);
+	if (err)
+		return err;
 
-	return -ENXIO;
+	return 0;
 }
 
 void __connman_dnsproxy_remove_listener(int index)
 {
 	DBG("");
+
+	dns_remove_listener(index);
 }
 
 static int setup_resolved(void)
@@ -779,6 +801,10 @@ int __connman_dnsproxy_init(void)
 	if (!interface_hash)
 		return -ENOMEM;
 
+	ret = dns_init(NULL);
+	if (ret)
+		return ret;
+
 	ret = connman_notifier_register(&resolved_notifier);
 	if (ret < 0)
 		DBG("cannot register notifier");
@@ -821,4 +847,6 @@ void __connman_dnsproxy_cleanup(void)
 		dbus_connection_unref(connection);
 		connection = NULL;
 	}
+
+	dns_cleanup();
 }
-- 
2.47.3

