Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5895A3C
	for <connman@lists.linux.dev>; Tue,  2 Jan 2024 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COFRzhw7"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3ed1ca402so69413255ad.2
        for <connman@lists.linux.dev>; Mon, 01 Jan 2024 17:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704160761; x=1704765561; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PkMDQMz+OSux5Sij7qyilChAOcswZlRCV1veO0YrER8=;
        b=COFRzhw7p/3bB/Tz1VeUO2N+MiYNYqs6ecTkTNI4QryT7B7DsIVenGsPlQRJ3nn5pl
         wakyzhErcgKiq8ZX3neqb5xt5j+jukYlhLnNDBL14LjKpwUq8QJOktqDeo/VAxzA8L2Y
         R+exGAaV/hRcMfOU7Bn8r85kJ8VgrnOAguWyIkNuYe76G/liMmabMO2Y7o6KUbnldgGz
         LwMR1GDPDUb2geAYj+c+bviNhS2tmYZvNoqUISZgCBK7nLGPId/SVwCbuJ5vjnwNRefy
         nBH36t6RfRu4zagStQ44aVV0euZ43yjzflsSDT7hYlki9uNNAW6j8qfgA1iyUASBw7+z
         LYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704160761; x=1704765561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkMDQMz+OSux5Sij7qyilChAOcswZlRCV1veO0YrER8=;
        b=VF0JjGpzt5KvSisxt+Ms6gsTbIzZzFh4YWmXBEqpWEVpxzHjl8WQLt8uZWWNft6Uq3
         FfzY46Af0Ygsj/AubB9mktWPZR1/At+33GQhuEOSsjt4NfH+iK0p+/xY3II/P0XoPhjI
         5kgxJNfNcfoEvT+7chlpHlpvOljxA7rUEAiZFmwSOaFVe7F4Rn7ArwQuh19ohvsHAkLN
         OaSSq7h05QmClbIYO++QKPNoc2GwUEZm5SleDVeiNcGQXG+KYvn7OxNH3Ay5ZHFwbFIR
         FTdhyXuS7Cv6CR6fYaGZdGOqS7mq4KSk6f9hCfOAuaSYniPgyOQwvMmNbbRrs3bgXAzU
         fp1g==
X-Gm-Message-State: AOJu0YycoNYGlFXr+FV4V1k2IAH2cJ+zry/fSYGQhNhMybKASRDyxXky
	nPZdD+8lkKGzwtNgfQOGtbXasI2hT6o=
X-Google-Smtp-Source: AGHT+IHYaRQ3Hc0zmvzPs5YTdpwOsaiLU6MHXqBn55Ebt/SQKJxFXty27nrd7OAHAy7xCW/XVNEqUA==
X-Received: by 2002:a17:902:684f:b0:1d0:6ffe:9f5 with SMTP id f15-20020a170902684f00b001d06ffe09f5mr7759366pln.83.1704160760627;
        Mon, 01 Jan 2024 17:59:20 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::4b6f])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b001cf658f20ecsm20649326plf.96.2024.01.01.17.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 17:59:20 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: connman@lists.linux.dev
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH v2] src/log.c: Include libgen.h for basename API
Date: Mon,  1 Jan 2024 17:59:17 -0800
Message-ID: <20240102015917.3732089-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use POSIX version of basename. This comes to front with latest musl
which dropped the declaration from string.h [1] it fails to build with
clang-17+ because it treats implicit function declaration as error.

Fix it by applying the basename on a copy of string since posix version
may modify the input string.

[1] https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
v2: Fix formatting

 src/log.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/log.c b/src/log.c
index 554b046..2df3af7 100644
--- a/src/log.c
+++ b/src/log.c
@@ -24,6 +24,7 @@
 #endif
 
 #include <stdio.h>
+#include <libgen.h>
 #include <unistd.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -196,6 +197,7 @@ int __connman_log_init(const char *program, const char *debug,
 		const char *program_name, const char *program_version)
 {
 	static char path[PATH_MAX];
+	char* tmp = strdup(program);
 	int option = LOG_NDELAY | LOG_PID;
 
 	program_exec = program;
@@ -212,8 +214,8 @@ int __connman_log_init(const char *program, const char *debug,
 	if (backtrace)
 		signal_setup(signal_handler);
 
-	openlog(basename(program), option, LOG_DAEMON);
-
+	openlog(basename(tmp), option, LOG_DAEMON);
+	free(tmp);
 	syslog(LOG_INFO, "%s version %s", program_name, program_version);
 
 	return 0;
-- 
2.43.0

