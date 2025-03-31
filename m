Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1D1E0E0B
	for <connman@lists.linux.dev>; Mon, 31 Mar 2025 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454021; cv=none; b=KZYgUnsgQH2xIfnn+fyh3Nkcz5WiSXLcQO9tMIXgGS3W5/P9m9S/lkmMgrYeQECj39VUvhKiRA6j0nrlCQ6b/ymmSgpsw2gAaxOIamO+AHaYFrhkW3LCa4sWWpWKcfkakrHjvFFhQ7ARZu0Wdl3ZeKbLd8nJj/Kjctc4YOixKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454021; c=relaxed/simple;
	bh=iCSfb2QCw4RqYW25SYAYG6j8jsrc/LTEO4w2Qq0kVSs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mBYu/SQk7MjFj3FCeATpZdFtUXsAZSdvxI+Ur/e0a3tDGOWpjradZlnGeEdvlqSI/IA4gaCE3CFGtARCzvRsKG2ymwOKiPZOTFkC0tc2HiC3GmUs4RKtdIknCKCVPnhGoMIY4XVUANZXfCzR3h2oYOd2/+FgwMRB856IkzhHXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbEyhJcJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbEyhJcJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22622ddcc35so14833575ad.2
        for <connman@lists.linux.dev>; Mon, 31 Mar 2025 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743454018; x=1744058818; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FuZDY2R6Kt0eXlf213mpD+9+jKFX1c82xoYalwB/Lss=;
        b=WbEyhJcJLFoSjk9TwbeW4nAjbGjmBtI09Ztql1YZKvcVjlW/eKCx+E8aZLisFe6C9u
         tGvEQdKkygUJaes8brji+/OuodFuz8ZZZQQlhIJHrwVIt7daZL/uUJqSaSBJsc4k0RGR
         6Zo1Q1STRaNDMJY4LAJwBdNKe1XVJ0a0uao/4b6SPfn4dXIUTJC8npJ5ATSCVRqB482Z
         WxruSTbn0OhJgvJkPGGQ+vxWsVJHJWVbs7exrmw7AER2gGt+hISvML5LixMtg3yJPIrJ
         ZQg6eYLdFHR7Mj29oLcJsrf/0Vvzo9dU7Z07bZKQkrhEwoQq09mWeAmWIorvbniJVBxO
         839g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743454018; x=1744058818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuZDY2R6Kt0eXlf213mpD+9+jKFX1c82xoYalwB/Lss=;
        b=VuQY8Ab3eGlt193k+EYqkDi88VlRfjmTVqY5Z14LOT2zbaBmx1PNBM/skVn8rS19ko
         ArGDlrnBATqFggaJQrv8fX7RyN/wEIEZ9k3HZHLrcJftNqNBhKfng8prxCDGFknz1n7G
         1R1dxQNdoMraYxnYBcPkJlDk3sz0TMeUL8MulRm2tJffuTzZUnu8crxFD27/PvOQwcDN
         o4G/Tv2td/Mm9A7HqNoIlU1vwbHRTSoyqR1Z126I7mzoPGmeBzK91KCdd1Eui91PG57V
         5UVACwxWa7zEkdcq+uUZruT5Kb0yQ+02i3Qs6Esa5yOq0b/2N6DlrbH+eHiRHLJi77+V
         ITfA==
X-Gm-Message-State: AOJu0YwNjJX9i9BhhQPWl/THSmDkZ/crCkMy15P8kIsvGrYWnofiYMlx
	8Ym44zkdjMbSvRoWqfpaDh06+fDOQwJgCJFWWM7578mkvOSIwSj+3YWvRg==
X-Gm-Gg: ASbGnctbwjAH0WFWL2ZhEFPvHAjo6oFTzgFY7h/kqRQiYLWAkKCDMDLGzG0sJMuD6GN
	+dr4YUjRf9PZcqx85oH6cfm7koLj2N8waW5Gx4M6p9n4JoUHMRfOr1vI5zrqfbmSpKNci+9ob0B
	DL96LWtsJbbAnEuHpWsz8mp21pFxqHU20DEJf+2WY8S5YwG7hvQk7CMufxx1EkSRrFHtf3FVToa
	xQKT4hxrMssfk4Ifwb9+BCCg49/9FD3AWJTSUI/LNKuAOOLArS533QzxOMjcFIu1gED5bvraqBq
	uLdxOBRfIVyrCGeckBa3z8to1etqrSP6qc9tGtrrkIFEgxbCl20Ug8E8pmxdAaYUouuzFA==
X-Google-Smtp-Source: AGHT+IGgi3dg6Ju3C23sPiJmyZLGc+l7ZMfoweNel1QlREg27EPP07tRdjLI1F6g6NO/w8/EBnwu4g==
X-Received: by 2002:a17:903:3c63:b0:224:910:23f0 with SMTP id d9443c01a7336-2292fa0291emr166043745ad.49.1743454017952;
        Mon, 31 Mar 2025 13:46:57 -0700 (PDT)
Received: from localhost.localdomain ([181.28.57.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ecec0sm73639015ad.241.2025.03.31.13.46.56
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:46:57 -0700 (PDT)
From: Javier Bassi <javierbassi@gmail.com>
To: connman@lists.linux.dev
Subject: [PATCH] Update doc with the actual values from *default_blacklist[]
Date: Mon, 31 Mar 2025 17:46:41 -0300
Message-Id: <20250331204641.23365-1-javierbassi@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Javier Bassi <javierbassi@gmail.com>
---
 doc/connman.conf.5.in | 2 +-
 src/main.conf         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 3eb240f5..9d3dfb94 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -107,7 +107,7 @@ List of blacklisted network interfaces separated by ",".
 Found interfaces will be compared to the list and will
 not be handled by connman, if their first characters
 match any of the list entries. Default value is
-vmnet,vboxnet,virbr,ifb.
+vmnet,vboxnet,virbr,ifb,ve-,vb-,ham.
 .TP
 .BI AllowHostnameUpdates=true\ \fR|\fB\ false
 Allow connman to change the system hostname. This can
diff --git a/src/main.conf b/src/main.conf
index 5357edb8..cbfef228 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -66,8 +66,8 @@
 # Found interfaces will be compared to the list and will
 # not be handled by ConnMan, if their first characters
 # match any of the list entries. Default value is
-# vmnet,vboxnet,virbr,ifb,ve-,vb-.
-# NetworkInterfaceBlacklist = vmnet,vboxnet,virbr,ifb,ve-,vb-
+# vmnet,vboxnet,virbr,ifb,ve-,vb-,ham.
+# NetworkInterfaceBlacklist = vmnet,vboxnet,virbr,ifb,ve-,vb-,ham
 
 # Allow ConnMan to change the system hostname. This can
 # happen for example if we receive DHCP hostname option.
-- 
2.39.5

