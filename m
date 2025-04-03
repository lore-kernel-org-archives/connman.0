Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D45F1E87B
	for <connman@lists.linux.dev>; Thu,  3 Apr 2025 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706417; cv=none; b=GXwc3lY3Iua+boB0cDjKfub+3S1G4d45gl01vTdxu8uLgS+6aU8VxfAvRWmtP0jOpdMjZx+x0YzB72GTtCMbZQVDTvRpoQZxV3MI2Ki5JwH29dOyxC0ZGVMEuBlqNcqjvUiAoZ9V4oZ5fMd7TZA5kLiKvrGVRXxc8VY9q18lknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706417; c=relaxed/simple;
	bh=8TGn31ukuJxFatZPxGckthq80p5YIju9ENKPG2qMAhU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FgDy4RT5kdEotf0x8EoyhQzirJ0vcwrcyySucJCDF7awFKXp7qrl1MILCftEu5oZMM95/FpDjWUs7558WPxwxP7BtLFEkEUfnUu2KS3QgU0gInsUHuipTd8fP2lwit9cI/AGdYJtGKYWifhN6LSQKxskGAwwr3iw7FB8YC/KQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVslvF6m; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVslvF6m"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223fd89d036so15260605ad.1
        for <connman@lists.linux.dev>; Thu, 03 Apr 2025 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743706413; x=1744311213; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFSrIjMeFj23huufuZ5Muud2m3e0cuyN/lsyEQ6Z3Tk=;
        b=gVslvF6mC/ch6QSdniGPaWfCWCr2r78zNh0OiufIItCkHIzwEpdn+IFOGYzbllFqZV
         Rl1J1CanYtzWZBLxRC9DF/T1vKKwftRGKS96JSDaxxSBWYeNRe+nM6njuw0w767PIuvB
         hdppJTb4dWvpJkRhxzomXXMQcfZE+JJp0fQcwJrWPjOlYD59eX2robwJ7dttKGVJyw8E
         pOV0sWyw55NMlumtexeNaSG+1stHxa0cR1Xofq/sgz3Ef5+FwU2/Si8QqgtUA1bVXK7p
         53ApDEhO9FeoBxJ9SV4oLGaoIyuezTl0k4erTrE3Rqu7+G+1vfIFLAt3dLchBsWOKX12
         WjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743706413; x=1744311213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFSrIjMeFj23huufuZ5Muud2m3e0cuyN/lsyEQ6Z3Tk=;
        b=HYzDdHyBhO5Nc/p4MMRk0RbM+JMNw9ZXaOcuZ9B6uoNoTA1rfHbVnz85C9NkLSlroC
         NQUyNyWTE0FtJE/g9L8NphGzQZqsJfIbwnfVqUA9BPL21PcOpdV6NvgfglRjrNXhux/c
         Lsh1be/pucHaEb+J4RseRVzjlukBr/xQ1ycvvZhSyP8Luz8CVi2+2BFi3/Q9MOZjpN1I
         54/3fy8C7/FNDDrtfdXaxhbSB49YbHbybgxnG091gGMQTF//hqM2dSN5vTZeormKw+cs
         dS3QndAurGDBbM9Tr07hqa9MUBRUwEQAEK8McdwI94S1iFbpPaF1SSwycfnX276OOO6C
         ztGA==
X-Gm-Message-State: AOJu0YyIBjfLttZbbThXSV3T/kRdBoerx2q99OzJO8AJLVWUV0pJN75l
	PNJ1agAZCdSREu128fQZTQtqb/0uq/vMKTRR8vQDa528iJydKF5TSLo+3g==
X-Gm-Gg: ASbGncvMmRA10gQsPlH6PYyv9FZHnyA3298tQLVnCUboaYZ8jhvEhyUrrdJdtzOzIWb
	z403I8JAWPRlC9uJ75fYViRhILpP/VOKOHoRSexiSuRy8nazECtA1pLDK0F3PIAsO8vEULaW/ld
	fFhtX6H+1+VWK0a5mMASMuzRe1ILiOzUQ7wZu+ewqlIiYGzd5CfisSmKnVxRl2s5OexV8btDOWi
	c41SwdxutpiGFU4Azw5H3j2sjcv4tEK3v2bG8aMoDXjzmdHmPq7pd00xUkbm+DYW5WRTtGUTEyw
	PwlqCijg8XxCskbXby7yKW3Bo+fxMRQCh/MzhvLYJoGh9W5kYyugrhwifk27/xEmUgg8kdnTl50
	=
X-Google-Smtp-Source: AGHT+IGdVSIOxlO8zvlqPHzhTL5JHmu4Ve7NMdMnCGUhLoE1+9XKbFibersYSm2+oirDB1DYjOqVeg==
X-Received: by 2002:a17:903:1c1:b0:220:fe51:1aab with SMTP id d9443c01a7336-22a8a0a33ffmr2219835ad.38.1743706412965;
        Thu, 03 Apr 2025 11:53:32 -0700 (PDT)
Received: from vbox.atrame.deloitte.com. ([181.28.57.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865bd75sm18038235ad.134.2025.04.03.11.53.31
        for <connman@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 11:53:32 -0700 (PDT)
From: Javier Bassi <javierbassi@gmail.com>
To: connman@lists.linux.dev
Subject: [PATCH] main: Add 'veth' to the default blacklist
Date: Thu,  3 Apr 2025 15:53:01 -0300
Message-Id: <20250403185301.178832-1-javierbassi@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connman conflicts with Docker, breaking networking, as explained
and fixed in 9eb1772d31b6f ("Don't add route for invalid dst
and gateway address combinations"). However, that fix was reverted
in d8a634f20de3 due to conflicts with WireGuard.

This approach is simpler and does not conflict with the WireGuard
daemon, as tested in https://github.com/moby/moby/issues/49653
---
 doc/connman.conf.5.in | 2 +-
 src/main.c            | 1 +
 src/main.conf         | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/connman.conf.5.in b/doc/connman.conf.5.in
index 9d3dfb94..7ab0b28b 100644
--- a/doc/connman.conf.5.in
+++ b/doc/connman.conf.5.in
@@ -107,7 +107,7 @@ List of blacklisted network interfaces separated by ",".
 Found interfaces will be compared to the list and will
 not be handled by connman, if their first characters
 match any of the list entries. Default value is
-vmnet,vboxnet,virbr,ifb,ve-,vb-,ham.
+vmnet,vboxnet,virbr,ifb,ve-,vb-,ham,veth.
 .TP
 .BI AllowHostnameUpdates=true\ \fR|\fB\ false
 Allow connman to change the system hostname. This can
diff --git a/src/main.c b/src/main.c
index 31a9f90a..5d13fb7b 100644
--- a/src/main.c
+++ b/src/main.c
@@ -91,6 +91,7 @@ static char *default_blacklist[] = {
 	"ve-",
 	"vb-",
 	"ham",
+	"veth",
 	NULL
 };
 
diff --git a/src/main.conf b/src/main.conf
index cbfef228..53de3cd2 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -66,8 +66,8 @@
 # Found interfaces will be compared to the list and will
 # not be handled by ConnMan, if their first characters
 # match any of the list entries. Default value is
-# vmnet,vboxnet,virbr,ifb,ve-,vb-,ham.
-# NetworkInterfaceBlacklist = vmnet,vboxnet,virbr,ifb,ve-,vb-,ham
+# vmnet,vboxnet,virbr,ifb,ve-,vb-,ham,veth.
+# NetworkInterfaceBlacklist = vmnet,vboxnet,virbr,ifb,ve-,vb-,ham,veth
 
 # Allow ConnMan to change the system hostname. This can
 # happen for example if we receive DHCP hostname option.
-- 
2.39.5

