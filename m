Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D9511CA0
	for <connman@lists.linux.dev>; Fri, 15 Sep 2023 16:18:29 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1d682fd3c58so237509fac.3
        for <connman@lists.linux.dev>; Fri, 15 Sep 2023 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794708; x=1695399508; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swfUc+R4YZRs2QJyBlme5K3dKFTFOYBflNQOuVFgMcs=;
        b=MZ7ABUwwEOHYaPg21YOCRM37sCmsyjvWOgy5LoFU3he8bEvnlUc9k+Cd6SrxcMoe8d
         kjH3rEjVNQfnC5dkC7gTuqCjPl7hZtjgSqvAVzha9f8qEgUbIGlqrlcH+UeTRsV3F6n+
         ForwqSW2c8UY1H/TZEuAIf9KC6DxEWWxeeqyLhg2yJoovKEBU3U6oNue+2nlrjyvrlRE
         c7iXgx58S9jDYXNuUEp4hmPrkluFyCoI8HBx4R6zEdDsqXTPEIDQFEFybY0PzRrFaUAo
         3nwwWwh6qEX9KTPP3+htjODDaB8h5wDs8KoflyRg536EoSij1wgztkElzAcHUb50gMdZ
         Abkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794708; x=1695399508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swfUc+R4YZRs2QJyBlme5K3dKFTFOYBflNQOuVFgMcs=;
        b=MmV9gfE7OJJmJhp7itsFVd6st3vztMRK63yRbttxcUBkanQ4E4YwFCe2TXofZNqa0W
         boM7uQeWli9V0ww8YkvkYLAN5NiWtMErmvgzWXKmzGOXyhRGp4IZCPeRB/h7PSJFZAEP
         8WyfwJPDQlXd1QYmQQ4xe9FahXCEIRm/U0OXzkdxbJks0wMolSEM4euMxJ7B0RwOTsal
         rRdNwTJ3zyvXmkKkho1G8megI/LjDTaZMDb9Umof4yvBaxdBE+bD6fuFbu6C1/alXzY0
         8EVAK+BQJtbGEqD4OitoFtKNyGrD1Fjr/YSLO70rHU/dvQM4JTbJuzkEh7rYqF8dRzRz
         InHA==
X-Gm-Message-State: AOJu0YxXu/KmlEoVoQw0UQ52BvtPtmhL9PEcXRY3RZLZpIcBhynci9GV
	nt9qCQd7uYlcTEdVWvWUrHUif+T8jFo=
X-Google-Smtp-Source: AGHT+IHJvxJc+m9WmA1uvEhUvUcB0y6lsPQ7CXBd4FF4UN2t8mgVCiIN6InNzI1gsGh9UVMtj3snHg==
X-Received: by 2002:a05:6870:472a:b0:1bb:6792:4787 with SMTP id b42-20020a056870472a00b001bb67924787mr2353819oaq.40.1694794708104;
        Fri, 15 Sep 2023 09:18:28 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l22-20020a056870e91600b001cca1dc6d79sm2030431oan.34.2023.09.15.09.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:18:27 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/3] build: Enable building with sanitizers
Date: Fri, 15 Sep 2023 11:17:33 -0500
Message-ID: <20230915161740.599433-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on code from Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 acinclude.m4 | 37 +++++++++++++++++++++++++++++++++++++
 configure.ac | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/acinclude.m4 b/acinclude.m4
index 262465d8..9022cf3b 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -10,6 +10,43 @@ AC_DEFUN([AC_PROG_CC_PIE], [
 	])
 ])
 
+AC_DEFUN([AC_PROG_CC_ASAN], [
+	AC_CACHE_CHECK([whether ${CC-cc} accepts -fsanitize=address], ac_cv_prog_cc_asan, [
+		echo 'void f(){}' > conftest.c
+		if test -z "`${CC-cc} -fsanitize=address -c conftest.c 2>&1`"; then
+			ac_cv_prog_cc_asan=yes
+		else
+			ac_cv_prog_cc_asan=no
+		fi
+		rm -rf conftest*
+	])
+])
+
+AC_DEFUN([AC_PROG_CC_LSAN], [
+	AC_CACHE_CHECK([whether ${CC-cc} accepts -fsanitize=leak], ac_cv_prog_cc
+_lsan, [
+		echo 'void f(){}' > conftest.c
+		if test -z "`${CC-cc} -fsanitize=leak -c conftest.c 2>&1`"; then
+			ac_cv_prog_cc_lsan=yes
+		else
+			ac_cv_prog_cc_lsan=no
+		fi
+		rm -rf conftest*
+	])
+])
+
+AC_DEFUN([AC_PROG_CC_UBSAN], [
+	AC_CACHE_CHECK([whether ${CC-cc} accepts -fsanitize=undefined], ac_cv_prog_cc_ubsan, [
+		echo 'void f(){}' > conftest.c
+		if test -z "`${CC-cc} -fsanitize=undefined -c conftest.c 2>&1`"; then
+			ac_cv_prog_cc_ubsan=yes
+		else
+			ac_cv_prog_cc_ubsan=no
+		fi
+		rm -rf conftest*
+	])
+])
+
 AC_DEFUN([COMPILER_FLAGS], [
 	if (test "${CFLAGS}" = ""); then
 		CFLAGS="-Wall -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2"
diff --git a/configure.ac b/configure.ac
index df39a42a..35e8b81b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -25,6 +25,9 @@ AC_USE_SYSTEM_EXTENSIONS
 AC_PROG_CC
 AM_PROG_CC_C_O
 AC_PROG_CC_PIE
+AC_PROG_CC_ASAN
+AC_PROG_CC_LSAN
+AC_PROG_CC_UBSAN
 AC_PROG_INSTALL
 AC_PROG_MKDIR_P
 
@@ -60,6 +63,48 @@ AC_ARG_ENABLE(pie, AS_HELP_STRING([--enable-pie],
 	fi
 ])
 
+save_LIBS=$LIBS
+AC_CHECK_LIB(asan, _init)
+LIBS=$save_LIBS
+
+AC_ARG_ENABLE(asan, AS_HELP_STRING([--enable-asan],
+			[enable linking with address sanitizer]), [
+	if (test "${enableval}" = "yes" &&
+				test "${ac_cv_lib_asan__init}" = "yes" &&
+				test "${ac_cv_prog_cc_asan}" = "yes"); then
+		CFLAGS="$CFLAGS -fsanitize=address";
+		LDFLAGS="$LDFLAGS -fsanitize=address"
+	fi
+])
+
+save_LIBS=$LIBS
+AC_CHECK_LIB(lsan, _init)
+LIBS=$save_LIBS
+
+AC_ARG_ENABLE(lsan, AS_HELP_STRING([--enable-lsan],
+			[enable linking with leak sanitizer]), [
+	if (test "${enableval}" = "yes" &&
+				test "${ac_cv_lib_lsan__init}" = "yes" &&
+				test "${ac_cv_prog_cc_lsan}" = "yes"); then
+		CFLAGS="$CFLAGS -fsanitize=leak";
+		LDFLAGS="$LDFLAGS -fsanitize=leak"
+	fi
+])
+
+save_LIBS=$LIBS
+AC_CHECK_LIB(ubsan, _init)
+LIBS=$save_LIBS
+
+AC_ARG_ENABLE(ubsan, AS_HELP_STRING([--enable-ubsan],
+			[enable linking with undefined behavior sanitizer]), [
+	if (test "${enableval}" = "yes" &&
+				test "${ac_cv_lib_ubsan__init}" = "yes" &&
+				test "${ac_cv_prog_cc_ubsan}" = "yes"); then
+		CFLAGS="$CFLAGS -fsanitize=undefined";
+		LDFLAGS="$LDFLAGS -fsanitize=undefined"
+	fi
+])
+
 AC_ARG_ENABLE(hh2serial-gps,
 	AS_HELP_STRING([--enable-hh2serial-gps], [enable hh2serial GPS support]),
 			[enable_hh2serial_gps=${enableval}], [enable_hh2serial_gps="no"])
-- 
2.41.0

