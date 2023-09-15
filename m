Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A411CAF
	for <connman@lists.linux.dev>; Fri, 15 Sep 2023 16:18:32 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1d577c89a4fso1177742fac.1
        for <connman@lists.linux.dev>; Fri, 15 Sep 2023 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794711; x=1695399511; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6yxCDDqnOiC/84ofq0lsxDrIE4VmxMLRZ/D0MZdh6o=;
        b=HcGzCICbNybK871ByF4S69FDYbMNwUmEykVvke9NgrcjShY5+FUjjoKxxvVxITpCt6
         dHDC3zmgtsO2we1I5q6zjVtFZzLiRsD53OJWfwiVF8Nu9ijpQ2GK1QAj+0I3CZyLaJj0
         edURvBKHPtpFEiWX0FoZKTwja8AMTAz9N0wvs4bxx7xQry/wY9I+CWXhvWR956SZDcY7
         XDZU7+xazwu5ZbslBex7YiJOc4wB48fWtxNFK98gpmx18OChleQgv6tqWlOtnGO2KVch
         zrQN+QgCsBCH5FRlJx/1wpOnF5I9iHjWr2GTRHqrzPkMKx5tVy9AnBIoDEc93XhkYC/h
         1qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794711; x=1695399511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6yxCDDqnOiC/84ofq0lsxDrIE4VmxMLRZ/D0MZdh6o=;
        b=XReH/lXNLbhevL8mCmnH4Gv0PnCI0qaV1/eStnJ7LHCrKr+21gvsVuVVainoHqtFhn
         omnZWzFXIMsIhs+mgg9NyEGCyoxo0pWOiIA/0IXfBtbwDDSiW5L65tF+m16FgKJS8YL9
         F/gyRrHGphHDK9IFRj9xOu1J8Lo7Tpgu8Pxw8wfhV6ydC3G1fnA5/u3jq7N3YK5TYnxv
         A06Yie08P2njsS9NvNBL5TgCXR6F8S1i0V8XSEziqXfDi6uz7ZrkCK5Ld1AbIET54GQo
         oRL0fc+dEWvkiXmNfAfm75lZG4Aqti4MnrW58yrIYKVyfSkrkj9/v6WkWg6394KlC+PZ
         qKrA==
X-Gm-Message-State: AOJu0YxxBlS7SZkJLUEKZOdYqNi0whEq7a4ipVwkNVl3tbe8AUN5VXOt
	Jy2uBh/6+qHKiLvvzPK2kPVII8XvBiE=
X-Google-Smtp-Source: AGHT+IENwg6ADwv9K0H57sA328upPH+JMTd/e5ZU4VKPGphsbaL3GiCTV2qfXHpZEf10sVlHjv1CoQ==
X-Received: by 2002:a05:6871:154:b0:1be:f23f:99b with SMTP id z20-20020a056871015400b001bef23f099bmr2057908oab.42.1694794710168;
        Fri, 15 Sep 2023 09:18:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l22-20020a056870e91600b001cca1dc6d79sm2030431oan.34.2023.09.15.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:18:29 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: connman@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/3] build: Support building with clang
Date: Fri, 15 Sep 2023 11:17:35 -0500
Message-ID: <20230915161740.599433-3-denkenz@gmail.com>
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

---
 acinclude.m4 | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 829aae25..425d701c 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -58,9 +58,16 @@ AC_DEFUN([COMPILER_FLAGS], [
 		CFLAGS+=" -Wdeclaration-after-statement"
 		CFLAGS+=" -Wmissing-declarations"
 		CFLAGS+=" -Wredundant-decls"
-                if ( $CC -v 2>/dev/null | grep "gcc version" ); then
-                        CFLAGS+=" -Wcast-align"
-                fi
-		CFLAGS="$CFLAGS -DG_DISABLE_DEPRECATED"
+		CFLAGS+=" -DG_DISABLE_DEPRECATED"
 	fi
+
+	if (test "$CC" = "clang"); then
+		CFLAGS+=" -Wno-unknown-warning-option"
+		CFLAGS+=" -Wno-unknown-pragmas"
+	fi
+
+	if (test "$CC" = "gcc"); then
+		CFLAGS="$CFLAGS -Wcast-align"
+	fi
+
 ])
-- 
2.41.0

