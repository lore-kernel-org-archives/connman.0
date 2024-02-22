Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1C17BC1
	for <connman@lists.linux.dev>; Thu, 22 Feb 2024 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644310; cv=none; b=OHZVjcyHIEqPPut/9354D0gNK8ylxr9tMUM/1cbhG9xdGzaa9sGyBpwqgajM+jQHVF1LYH7J1we/9Wowu6bDVoYYuMAqTDmoOjoZlEWCwxzewct/qwQY+TpoZ4y+ZGrdfQNMRMjCvx8QSqJdvjlZ2hdXClbgDPTmh6iK5vfDXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644310; c=relaxed/simple;
	bh=ZCiwYSSsaua/OFiQDLAUz+whU1EMwOgQHHZJrbS2X6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UFtPgCsJXE+ko2zn2wpjzkQUb7FeGb1cKCEjwAd3LYntuSkC5u+UI3QR6ESlabj/1iTtGUOgsKGBngpjTYD7vdooH2HxM/7YPjGmG/2/XM60SBoI13kTIfX11p/aISlUKUv/o9K/HQqUbwzOP4QFN5vgJ23a5RFyd8W3Hf+X7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=QqMNOBpY; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QqMNOBpY"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8C7F9240027
	for <connman@lists.linux.dev>; Fri, 23 Feb 2024 00:24:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1708644299; bh=ZCiwYSSsaua/OFiQDLAUz+whU1EMwOgQHHZJrbS2X6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=QqMNOBpYYgL9u9w3jHZwgIi7hgeV2zLSRvEhFn2rfMbFuGanZTQJYZlIYZulj66t0
	 HlwSQnjDEn/DLEqqPSNwXVBd6bzN01D7cppcC8tTShasji7wgkWCqM6U0dv027gSF/
	 L0o/V8rgIW8Gf62zAYTOcGvXmQsIOuLaoZnXprXPggwjOTjQ9dotMD2nANI4pTT8qQ
	 dx+s89K91dtJXH4ub0hcl+6mAqQ0YeSLdHumxPVuDh7p0TV+AaNJcWaNIe8jKkjKdK
	 9jUqCFPM+2qAe7OJaJTMz8Y2h/KRgn6/HvxmgYg2W7xR/HdbI/10T6qdxtf0jsTRp6
	 UdSNB7IH814dg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Tgq4C0yYyz6tvJ;
	Fri, 23 Feb 2024 00:24:59 +0100 (CET)
From: Christian Meusel <christian.meusel@posteo.de>
To: connman@lists.linux.dev
Cc: Christian Meusel <christian.meusel@posteo.de>
Subject: [PATCH 1/1] log: Use a log identity always valid while logging
Date: Thu, 22 Feb 2024 23:23:26 +0000
Message-Id: <20240222232326.1677146-2-christian.meusel@posteo.de>
In-Reply-To: <20240222232326.1677146-1-christian.meusel@posteo.de>
References: <20240222232326.1677146-1-christian.meusel@posteo.de>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The result from basename is not guaranteed to be.

I'm running connmand 1.42 on Yocto Kirkstone and in this setup log
identities ending up in the journal are garbage and change during the
run of a connmand process.

Explicitly allocating the log identity fixes this behaviour and gives
the expected 'connmand'.
---
 src/log.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/log.c b/src/log.c
index f7483194..108dcb0b 100644
--- a/src/log.c
+++ b/src/log.c
@@ -36,6 +36,11 @@
 
 static const char *program_exec;
 static const char *program_path;
+/*
+ * Provide a log identy to syslog whose lifetime is greater than the timespan
+ * we're logging. The result from basename does not guarantee that.
+ */
+static char *syslog_identity;
 
 /* This makes sure we always have a __debug section. */
 CONNMAN_DEBUG_ALIAS(dummy);
@@ -212,7 +217,11 @@ int __connman_log_init(const char *program, const char *debug,
 	if (backtrace)
 		signal_setup(signal_handler);
 
-	openlog(basename(program), option, LOG_DAEMON);
+	/* Clean up any previos identity and set the new one. */
+	g_free(syslog_identity);
+	syslog_identity = g_path_get_basename(program);
+
+	openlog(syslog_identity, option, LOG_DAEMON);
 
 	syslog(LOG_INFO, "%s version %s", program_name, program_version);
 
@@ -228,5 +237,8 @@ void __connman_log_cleanup(gboolean backtrace)
 	if (backtrace)
 		signal_setup(SIG_DFL);
 
+	g_free(syslog_identity);
+	syslog_identity = NULL;
+
 	g_strfreev(enabled);
 }
-- 
2.34.1

