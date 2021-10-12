Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D12C85
	for <connman@lists.linux.dev>; Tue, 12 Oct 2021 07:07:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE9CA6188C;
	Tue, 12 Oct 2021 09:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1634022412; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=+vG2sy7TNfj772mXD4U15M3enouy2sBimD3Da7ZccUE=;
	b=Y4ydUYRmNOEmsZEdwwjB5haFe/MFfZKwvHkVWmMmifTrJR8skssF5vlnog+lAod+dCAvpx
	fFsVrEck+AJhI8jjPdv428MtiGN0gd1tmdGScWQC0jvY4QwqgdbXCi90l49p7vDDxC/iVv
	GuAqQfBBGwtejkNQjWsPJL9kGXNrhIyRtWwZbMwhskWCYRIxy/izR7vY4vAyP21wG7hfVI
	LXM8Zi5WNbLaylhBfgurQgannMIy5U5fDi7fJ6qWgnMpsV/wRWsRRAwXr1hmdky/CaiGOT
	XlS9vQA/VO6usP/qMtmAkkwKLb0oX0v7M7rifNoGjX8V/RIFPnHP4tIwVfzQEg==
From: Daniel Wagner <wagi@monom.org>
To: connman@lists.linux.dev
Cc: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v1 1/3] build: Only enable -Wcast-align for gcc
Date: Tue, 12 Oct 2021 09:06:46 +0200
Message-Id: <20211012070648.28947-2-wagi@monom.org>
In-Reply-To: <20211012070648.28947-1-wagi@monom.org>
References: <20211012070648.28947-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

clang -Wcast-align is very unhappy with various alignments of external
data structures and access helper such as CMSG_DATA. While its
worthwhile to fix these in the long run, let's disable the cast-align
warning for the time. This aligns it with iwd.
---
 acinclude.m4 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 9e8e0dc5e8b2..262465d8085d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -21,7 +21,9 @@ AC_DEFUN([COMPILER_FLAGS], [
 		CFLAGS+=" -Wdeclaration-after-statement"
 		CFLAGS+=" -Wmissing-declarations"
 		CFLAGS+=" -Wredundant-decls"
-		CFLAGS+=" -Wcast-align"
+                if ( $CC -v 2>/dev/null | grep "gcc version" ); then
+                        CFLAGS+=" -Wcast-align"
+                fi
 		CFLAGS="$CFLAGS -DG_DISABLE_DEPRECATED"
 	fi
 ])
-- 
2.33.0

