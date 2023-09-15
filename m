Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946F11CAF
	for <connman@lists.linux.dev>; Fri, 15 Sep 2023 16:18:30 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5717f7b932aso1374008eaf.0
        for <connman@lists.linux.dev>; Fri, 15 Sep 2023 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794709; x=1695399509; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4K33H0idgUXhMoDoGj+80Ft3+PDVeO6iCwwoB5ea3w=;
        b=NArIMB9WFRwC2tKLVRsvrhJAoo/otZlcUxaBkhyNJDX/MN5JEPhDHiCkU6Suo0kOjB
         kDZGQGJLsaRZM2DGUlVwGcaPzOY1OjLxcnWM2iNOm70lvnYgfGzM9rs0pawpYwn+OuBX
         2e003KUSBlp4IeKDykUCeu8DnUY1yqBflSDEA3d72Qc65LcsHWHRmxIGZ90z/oX8l1xM
         ZdChquWZ9iLdjmg7atOw/8pWt8om5tmD1NVzWqXIFVteXX1xk2jWRPIJav5n5vb4P2yl
         bc8oq8B0udF/cW/QVzmOPk7g8c9NsUgarVjXgQ5gu8VcNdb6fYrbHjNhQeQLo/fVCovl
         ajAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794709; x=1695399509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4K33H0idgUXhMoDoGj+80Ft3+PDVeO6iCwwoB5ea3w=;
        b=Os1vuJO9IO7/UwyVKtDInBtStaU22h+enYIiIdzKtWiARtN9g4YQKZ3CB+bZfqzwM3
         VA5SE5gePy1uCq5Sq82SxDrbklZw2FhNeckscOYzSqHQIHhnh00pHVuNaZRbH72lNUvR
         O7aAcLUwOi+c6ruSlgMjwvz9R5EcDV0LEoHCR/U1AA1rxYiV4kmvvQqQIt7dn149RbYX
         4AfStdEBG1HZ+awq3ppphq1CUklVbV3tkzkQTuaoh+CLV12DjZWBDTZc0/JaS50TcHnw
         TxoHmFY53ftbBOPe77CDvA+RA1P3X+5VGtqqt8fOpnClA4cG1kY5NzSV8ZI5cNB4Pq9H
         49AQ==
X-Gm-Message-State: AOJu0Yy1oU+CabLdqU6qWl+DUTCzcLrIutcfU79UGd0nidJBbnPyoZZT
	FzY6WWCzzH7FpABs8EVCbFXuFOBDoiA=
X-Google-Smtp-Source: AGHT+IFkIuplJYBZQ7vES5l8gbwdUFW/ia0m5UlXlPQlOAO1jofUKa8puJalSVAdIFISPXigybRpsw==
X-Received: by 2002:a05:6870:9721:b0:1d0:f0a9:b3f2 with SMTP id n33-20020a056870972100b001d0f0a9b3f2mr2507906oaq.48.1694794709078;
        Fri, 15 Sep 2023 09:18:29 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l22-20020a056870e91600b001cca1dc6d79sm2030431oan.34.2023.09.15.09.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:18:28 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/3] build: Make sure --disable-optimization works
Date: Fri, 15 Sep 2023 11:17:34 -0500
Message-ID: <20230915161740.599433-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230915161740.599433-1-denkenz@gmail.com>
References: <20230915161740.599433-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acinclude.m4 still adds -O2 and various FORTIFY_SOURCE flags, even if
--disable-optimization is used during configure.  Fix that.

While here, add -fsigned-char and -fno-exceptions flags.
---
 acinclude.m4 | 2 +-
 configure.ac | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 9022cf3b..829aae25 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -49,7 +49,7 @@ AC_DEFUN([AC_PROG_CC_UBSAN], [
 
 AC_DEFUN([COMPILER_FLAGS], [
 	if (test "${CFLAGS}" = ""); then
-		CFLAGS="-Wall -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2"
+		CFLAGS="-Wall -fsigned-char -fno-exceptions"
 	fi
 	if (test "$USE_MAINTAINER_MODE" = "yes"); then
 		CFLAGS+=" -Werror -Wextra"
diff --git a/configure.ac b/configure.ac
index 35e8b81b..367b5304 100644
--- a/configure.ac
+++ b/configure.ac
@@ -42,10 +42,14 @@ gl_CONFIGMAKE_PREP
 AC_ARG_ENABLE(optimization, AS_HELP_STRING([--disable-optimization],
 			[disable code optimization through compiler]), [
 	if (test "${enableval}" = "no"); then
-		CFLAGS="$CFLAGS -O0 -U_FORTIFY_SOURCE"
+		CFLAGS="$CFLAGS -O0"
 	fi
 ])
 
+if (test "${enable_optimization}" != "no"); then
+	CFLAGS+=" -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2"
+fi
+
 AC_ARG_ENABLE(debug, AS_HELP_STRING([--enable-debug],
 			[enable compiling with debugging information]), [
 	if (test "${enableval}" = "yes" &&
-- 
2.41.0

