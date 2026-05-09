Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81562571C7
	for <connman@lists.linux.dev>; Sat,  9 May 2026 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334515; cv=none; b=ZwDVdeiUhek1GNBVOvu6Dd8kzh0SJ6pyPxLfCQxwqFpImTuz16Tu1eGSrdhX8MhKW73QzyTPo6rMbWiXCjo2hcHWhnDKvEF6duqoKcUbch1aQcaIUQmDI7UBJmWMc3FtjM+7M9BT6hbYuGqqrC4UT/AuIJV+7TIm6c6zHW7mYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334515; c=relaxed/simple;
	bh=yyqjSSHVbtrrd1mlqBLG4LKtlmxKmzU5BlPijENins8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VArQ7/k+JuxubW42yY6OFxnHWuEWIE19pyhwdNSeNjdP/fCzDu7mHFTfpGM7y5e69fCMul1m432OXW3yFCjEKHMXvnD4Lt+OT9XLQTHkFUYWGnDs78bixf5j+9zl2mz+MJrt9eEKFpQbZmKRor1lTDIHeXaJvI6BJo70HYOx6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=cCmakLjl; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="cCmakLjl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6NicGEF6z8S+XLK8MNGr2oZodFLGo3LdAhtZzVaVsDI=; b=cCmakLjlhM6G9QPFXcR24BxLL2
	Wmvu4QzLFv1Y7FgeN0u7u8vF4HgVC6AYQLPw+5qiAv714biFthbTwzzb8HXvPL3RGANbLY7skDvlS
	q+qb7Oe5B2ZHIUIBVmTpUPKaqXY+QD0x3KqFZn2O7m0ZD3BeVqBnbV3jjamAH8LQKTzDLntWDWZDy
	eLjCN+S6+l5suQpUTkWyoObpVAza04ugFm5x6LdHRgRBMU1egLwhqF3DLCBd1Emu06yo19nhqqxks
	CcDE+1txi5HIh6U31BDueX8kB35KLANP49+3r6V68VUxG9abj48jGBWDvzIOzPm7FnzAIus2UBSVc
	hqz8KQCw==;
Received: from [2a10:a5c0:37:6500:41d2:24bc:9d82:eda4] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wLi2i-00H1Hp-0w
	for connman@lists.linux.dev;
	Sat, 09 May 2026 16:48:32 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 5/5] systemd-resolved: Proxy tethering client DNS requests to resolved
Date: Sat,  9 May 2026 16:47:38 +0300
Message-ID: <20260509134822.343265-6-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509134822.343265-1-jussi.laakkonen@jolla.com>
References: <20260509134822.343265-1-jussi.laakkonen@jolla.com>
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
 Message-ID: 20260509134822.343265-6-jussi.laakkonen@jolla.com

Proxy the DNS requests from tethering clients to resolved using the
dns.c functionality. Add an UDP listener for the tethering interface to
serve the requests from that interface and use the shared/dns.c with the
default systemd-resolved server 127.0.0.53 by binding the socket to
localhost interface. This ensures that the limitations set in the
systemd-resolved (by allowing only localhost to connect to the server)
can be circumvented by making the packets to originate from localhost
and not getting dropped as martians or by the server itself.
---
Changes since v2:
 - Use the build-time DNS_BACKEND_V4 as systemd-resolved server address
 
 src/dns-systemd-resolved.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/src/dns-systemd-resolved.c b/src/dns-systemd-resolved.c
index 9dd0328c..6d46de49 100644
--- a/src/dns-systemd-resolved.c
+++ b/src/dns-systemd-resolved.c
@@ -31,6 +31,7 @@
 #include <glib.h>
 #include <connman/dbus.h>
 
+#include "shared/dns.h"
 #include "connman.h"
 
 #define SYSTEMD_RESOLVED_SERVICE "org.freedesktop.resolve1"
@@ -375,14 +376,32 @@ int __connman_dnsproxy_append(int index, const char *domain,
 
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
+	err = dns_create_server(lo_index, "local", DNS_BACKEND_V4, IPPROTO_UDP);
+	if (err)
+		return err;
+
+	err = dns_enable_server(lo_index, DNS_BACKEND_V4, IPPROTO_UDP, true);
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
@@ -779,6 +798,10 @@ int __connman_dnsproxy_init(void)
 	if (!interface_hash)
 		return -ENOMEM;
 
+	ret = dns_init(NULL);
+	if (ret)
+		return ret;
+
 	ret = connman_notifier_register(&resolved_notifier);
 	if (ret < 0)
 		DBG("cannot register notifier");
@@ -821,4 +844,6 @@ void __connman_dnsproxy_cleanup(void)
 		dbus_connection_unref(connection);
 		connection = NULL;
 	}
+
+	dns_cleanup();
 }
-- 
2.47.3

