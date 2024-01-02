Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D9EBC
	for <connman@lists.linux.dev>; Tue,  2 Jan 2024 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0mVs/6U"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dbc4675749so3984286a34.3
        for <connman@lists.linux.dev>; Mon, 01 Jan 2024 17:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704160414; x=1704765214; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu4BT1L9zU4sZawlPxX1Sr1JbpE81JatxWOwg/FvzCw=;
        b=M0mVs/6UKmH6kfL9rvW/0eqF/6qtj76LEia18hcG83uLFCRM1P9DdOu+rkTmYJ4lae
         Sl7DdCw6eMnuzpjRq5w69N42akEwPunExPDxAzPoAAXj9vD/O6wKZLuKTVZPz7mAE4hf
         fTQ+WDrafixLocc6WNJyVLfVEtaWS77TT4KKsmDfUv0FvSGhUx5wHT/TYxB1sigafoFK
         nzMQTqrl3YOolYL3xjNaFn0ZDH/MQgVZPj0oOIFYbfDcUbvJWpnZVH3C8fXO1NkzntYB
         HE9qPTZBqnedOpJ1iyITnneQk2aW8lWTv+UP2QJFHRJ8zPGLZMoYUewb+ZO80/qRNdV7
         h/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704160414; x=1704765214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zu4BT1L9zU4sZawlPxX1Sr1JbpE81JatxWOwg/FvzCw=;
        b=oo3SWl4iFumR2D09LxSZUyoUijxLpNlAvqDJSDQ4g7LcpSwOevaiQJR7/X3vx1LiDE
         8ZkhSiG1UFQjbbu7bpWdKJy6eG3eKvAl5FEMgugnzYF0c7f3/lj8IzewIO3RQH0Ajzak
         PqImsv9IRlvdJJKh/0q5mJTvwZx4zgrPgvOpwiNmI5B1Hp20tHFNF1d3mutPwpGRdF5o
         xArYd2fTyRjcVGZ4+E30NpPSOvDeCVuPrPvkMXKIG4oIORfCB6+ZcJTCgcohKTTzas+B
         74jC7hJp86VyP9NG5UL3IxKaQAV+KE4mfmvG/zcf/DT1Jk3ZusSH4VSHDHQQW2ryVPbm
         IN5g==
X-Gm-Message-State: AOJu0YyXyuJ3+Lr+bsAj6+IauheWm7M8jI2NowhTHfo48/pCNtIP9A+m
	+G+tjNDJbJG5Tm0ZmgnOM8VNjrzvL0A=
X-Google-Smtp-Source: AGHT+IEKv3E1Lh7yqVj8QppywqOiRFavC0I1Z3uQoFN76pw9ivL8qxL+xK6sE0i+ouz1dmTmCf13Uw==
X-Received: by 2002:a05:6808:1301:b0:3bb:d02f:1443 with SMTP id y1-20020a056808130100b003bbd02f1443mr6850558oiv.21.1704160413808;
        Mon, 01 Jan 2024 17:53:33 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::4b6f])
        by smtp.gmail.com with ESMTPSA id g30-20020aa79f1e000000b006d942f43140sm16192388pfr.34.2024.01.01.17.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 17:53:33 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: connman@lists.linux.dev
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] src/log.c: Include libgen.h for basename API
Date: Mon,  1 Jan 2024 17:53:30 -0800
Message-ID: <20240102015330.3730946-1-raj.khem@gmail.com>
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
 src/log.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/log.c b/src/log.c
index 554b046..941e078 100644
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
+  char* tmp = strdup(program);
 	int option = LOG_NDELAY | LOG_PID;
 
 	program_exec = program;
@@ -212,8 +214,8 @@ int __connman_log_init(const char *program, const char *debug,
 	if (backtrace)
 		signal_setup(signal_handler);
 
-	openlog(basename(program), option, LOG_DAEMON);
-
+	openlog(basename(tmp), option, LOG_DAEMON);
+  free(tmp);
 	syslog(LOG_INFO, "%s version %s", program_name, program_version);
 
 	return 0;
-- 
2.43.0

