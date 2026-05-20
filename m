Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73FB3F0ABD
	for <connman@lists.linux.dev>; Wed, 20 May 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289966; cv=none; b=q4NB+PF6WkU6G0K7+S05i0JcUS73IMETSdoppHsrkHbB75jGwGKuyPTiaIho845RcM0ZSs8OmDNsqSY+45tp2Lh3BIVSUANEygkTSxHyNLxHy4I5uMbuyRlNFHHpItMpeLVR6pi3bSyhuS+4tf3NGQnwDv68nRsOn6JgR5nmOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289966; c=relaxed/simple;
	bh=qynfB4DOaQSgsjwQgWeKBNwpILG/VKCANszfkXzd1ck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYFnKsjaC1GPLwtMn574V2+hEoOLfvp70X28NuM0fzQwc0eltvdERxynKS+PwApIcLhcPMbY9QutAAAHdt+SEzGnQZRx08xS2xcG+OT+vTdjsBzCqV4L1Pxy6czODpdi5rAvHXxxMG4YrPMGmAg9ASU2SQiZ/YPjU/zA2xftUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=1gSciMgo; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="1gSciMgo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FaVcFmQcIejXxheZIc/O5+WjFZIeJUXLYt3SG6hiTmY=; b=1gSciMgoUq6Stdh2WjdVpQzJrd
	SBTQ1App1QCZmrbe+CoIUuFAdfZFOO1ZoXsE2rGfqwd2Z/dTkSaGANEZ/j0LNfhWFT+fIqX7Y7GyD
	+QlmxWsE0wILxIp05XvuqyrFVy2ZgMNsRO3oRd8CBsnSFg9Am1gDvl9Fc8QQgoycjf1dyn1kgsgA0
	vGbFok0jSR8W4wwsv5w2nhneUE+pq1f9kDZ4Krxgog4XoD6/YKSOyTMPa4X0ecu1ey4R0h+J1PsWB
	YOZMaiuLQcrInMEdHqNZPKMVqCskHry9i+/0pJUDemRmTmFkOA3zJ2h5b05iNYQyDv6CeLkiIOTH5
	7w3Vae0A==;
Received: from [2a10:a5c0:37:6500:de2b:9403:4cd1:218c] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wPhGi-002WBi-3D
	for connman@lists.linux.dev;
	Wed, 20 May 2026 16:47:29 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 2/9] main: Support main.conf.d/ files for overriding configs
Date: Wed, 20 May 2026 16:47:06 +0300
Message-ID: <20260520134720.981315-3-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
References: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
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
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: NEURAL_HAM(0.00); Neural network HAM [-0.952]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: FUZZY_RATELIMITED(0.00); Fuzzy rate limit is reached [rspamd.com]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260520134720.981315-3-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

Use the util conf.d support to read additional configs. The values in
these additional configs will override any existing configuration set in
the main.conf or any previous conf.d files.
---
 src/main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/main.c b/src/main.c
index ddb28276..b1b4fd5a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -3,6 +3,7 @@
  *  Connection Manager
  *
  *  Copyright (C) 2007-2013  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2025  Jolla Mobile Ltd. All right reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -38,6 +39,7 @@
 #include <gdbus.h>
 
 #include "connman.h"
+#include "src/shared/util.h"
 
 #define CONF_ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]) - 1)
 
@@ -68,6 +70,8 @@
 
 #define MAINFILE "main.conf"
 #define CONFIGMAINFILE CONFIGDIR "/" MAINFILE
+#define CONFIGMAINDIR CONFIGMAINFILE ".d"
+#define CONFIGSUFFIX ".conf"
 
 #define GENERAL_GROUP "General"
 
@@ -1229,6 +1233,7 @@ int main(int argc, char *argv[])
 	DBusConnection *conn;
 	DBusError err;
 	guint signal;
+	int fs_err;
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
@@ -1292,6 +1297,12 @@ int main(int argc, char *argv[])
 	else
 		config_init(option_config);
 
+	fs_err = util_read_config_files_from(CONFIGMAINDIR, CONFIGSUFFIX,
+				NULL, config_init);
+	if (fs_err && fs_err != -ENOTDIR)
+		connman_error("failed to read configs from %s: %s",
+				CONFIGMAINDIR, strerror(fs_err));
+
 	__connman_util_init();
 	__connman_inotify_init();
 	__connman_technology_init();
-- 
2.47.3

