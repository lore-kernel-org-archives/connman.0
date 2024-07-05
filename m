Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803C42F52
	for <connman@lists.linux.dev>; Fri,  5 Jul 2024 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720151437; cv=none; b=VjoNCGlPn7OCBMGUOHcskQsx7EjfjEXG/pcT2HHkAEhVDssl9uIH+hUgQB8VUVCKRwu0zx3t9pNNTkRcglg29XnTDOacBapdmWOUnjyspuqm7LhkwOUsEe/9PGxayXs6HFwLrYmn5qCLUnw2sK2FYHkGJbWp1TTO66Kc85iNemE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720151437; c=relaxed/simple;
	bh=sycU0Mn4chcpkgiy4mfQ885LAwmWGBEXygU24xEsikU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1c9sMnmLUF+Cp4wmbBZQLei9rwBvWuLuJ2xW5KSzswraJonY0oh0OEjtCmZxQpgziTHrqd3L3IPn1ACrQaXWI8bZ8rYK4GV3AnwEfivcKl/aZJMWBCPuFEFe60iAD0g8AYy0dQtt0jygkZNpuTeiUyaSnMubHj6y8JxTcmKRDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro; spf=pass smtp.mailfrom=shruggie.ro; dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b=InOVhTx4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b="InOVhTx4"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52e99060b41so1207779e87.2
        for <connman@lists.linux.dev>; Thu, 04 Jul 2024 20:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1720151432; x=1720756232; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qjONbfrP4iKpiOK00YyPuNtn9xlq5A4gYFoBtplHOK0=;
        b=InOVhTx4HyIcKa0mkZO7vH8OM3WXeRoods0ipCtTJMbQ+Q/YHtq5xDO5zxI6n6SWBs
         mivwCGGFmtZaqCFw4OX5+iwYgwoT/rHeP9XrMP2VbyBbMyqc9QWagDEyHB7lvlWGaxtA
         Ne1bF/WLCsNFTtKai/71qFEahKcKMSjH89VPc79E6xIPtyokv2ppnZ+4WFcfnoR088HE
         x3EGbm6cOo/pqt95jD/FHhS0lxOT0EP4Fnp0144DMePes4fToJg0f4EjgmPdb82wE9s3
         0F8lgnx05nHpV28Y6ltOrdarcfZLWjcfxOCWmWEcWiIHLMixY1e5dFMeAKX49C1MIooF
         97uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720151432; x=1720756232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjONbfrP4iKpiOK00YyPuNtn9xlq5A4gYFoBtplHOK0=;
        b=BPuV7ugLKbOWUbhOGDOtTQc3jfy74v/LN1nSI9QfchtZMYg7gILYVUqvTq+lgUwBKv
         9vBPUf2lx7AfpSuvGuCMSHQIPfVoSE/TSJjOFd3BCeNf3tGXqmIqEyFjVC70stTNvgdl
         An4NnotH0mPzH83dZkEqy92VHtMyW70AI59Bkrl4Akl9cxIshl0nyai/tBK0kTk7eHUX
         Dl+YaLMsJ/MFFSv37MSTHR2cNVhbgVzYKnkXuPhvzRGEiBL1j9rSaz6bKNnNjo7d29hm
         pEe3Noxb7BeJ5H1QdSMot3mqwf+I4Nu13NacNO/2lOvmg0woFvggc3iMBBDLvMnz/bWw
         4tIg==
X-Gm-Message-State: AOJu0YzC9Ztiun1rKsGrwr32tHjpg73+R5IxClTbr4nrGUDX1WiYbk1o
	nJ8jwEE/UUE8y50dMsaNj+2N9f3DQSkEArJ8qklX4pydAqhZlPWCTCb3ChSedWg/3hCfXjjmT72
	j8y8LlQ==
X-Google-Smtp-Source: AGHT+IGPzp655tOFKl7VNXOOfpmref66NQLXoVgmt+jrZD3n9NLEgjDvxHyxOQZU7u4T+0jKb+6Fnw==
X-Received: by 2002:ac2:4c0d:0:b0:52e:9cc7:4461 with SMTP id 2adb3069b0e04-52ea061af1amr1956654e87.5.1720151432248;
        Thu, 04 Jul 2024 20:50:32 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679508ff26sm5279941f8f.111.2024.07.04.20.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 20:50:31 -0700 (PDT)
From: Alexandru Ardelean <alex@shruggie.ro>
To: connman@lists.linux.dev
Cc: Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] .gitignore: add tools/ip6tables-test utility
Date: Fri,  5 Jul 2024 06:50:28 +0300
Message-ID: <20240705035028.57697-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I botched a patch with this.
Adding 'tools/ip6tables-test' to make this less likely to happen again.
Link:
   https://lore.kernel.org/connman/20240704204732.56553-1-alex@shruggie.ro/

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 2f8dcd74..8284a1b3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -56,6 +56,7 @@ tools/wpad-test
 tools/resolv-test
 tools/polkit-test
 tools/iptables-test
+tools/ip6tables-test
 tools/iptables-unit
 tools/dnsproxy-test
 tools/supplicant-test
-- 
2.45.2

