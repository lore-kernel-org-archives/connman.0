Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6128DEE6
	for <connman@lists.linux.dev>; Thu, 15 May 2025 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309456; cv=none; b=DKIn8OQItwLgO9pDqxMtsnrD69x4jC6pUWx3KFoUS/3pqUZLlVnht5UCQ6wpalVe18wVUDaqzSpk+tIlT/WagwHphDMczqnWQs8gDN79Y0MZiZdw8SR4pQB1/qcOlJ87GM1whkyPVU7PCHV73G9THcgCDndZQUy192iMky9dGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309456; c=relaxed/simple;
	bh=7ZK5Q20COKqUxec8BGYuLFBNpLLmO10or+Ctn24uteM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7xoDY9Ax3yd4ZHbXjwNj/FAr96UpWX1aIpDJnNFBIFX1EiH2Ip1yb33I5QOV47kaBbesXHh69DxdTA0/9ByvUoT+p8XKLXo8nEo82gJsIWhv5KwMbGAP79LQW9rZMRrBs8FqvetYWiqorTX5gZWTH7V/mAXYWzUHOO8aWQLc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=TOFXoKq0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TOFXoKq0"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so9083945e9.1
        for <connman@lists.linux.dev>; Thu, 15 May 2025 04:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1747309453; x=1747914253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGvWrXqFdmBy33k+JCEo0oh9W8n7yartqNOfjRp9nKM=;
        b=TOFXoKq0vkj+OzmvHiCpopQCv+A33H2nBa0MXFaHNWDc8FnTaT+dzNGDxEn0LdVINZ
         GIOUe9JPzNqTZ4ndp1cHWlLKKfOAIArwtMUKbZsfX/YAw6+aaPbRo+cvGMEHOER75Ia9
         VxBvTt/X8WFHmgxtzPe4Zje7M1mrlj8Wu7dV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747309453; x=1747914253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGvWrXqFdmBy33k+JCEo0oh9W8n7yartqNOfjRp9nKM=;
        b=oD83EL5fo/kdG5Dp6REUAj/6KbHiXbdhrNkjUwnF4+4bNf7xYIbofUgnZBP9tzvIjs
         HNgdKF8469y7b1vWxEzBtoqh/NaBhR2YY9RpVwbW1DJ+mbPsvg71MXNgWPmC7OgNToMV
         P1S5J2pSdbG2ceJumtpQVQ44kC+bZD7wljALahmdLSBKjWijuQCTgH5R+P4dLvZfPEbV
         AlunU+VP5fMbkZRsFbos7BWBk05SaF0PCKd8W9TAQAYGPnyE3k+C3+7NoyB9bl++kql2
         8EAvGhBOIdiEREkmwbRzXlf39PQOI3uONf4oSu5+JyMUTKWYwSh6eYFADZthPR9C8lTH
         8URg==
X-Gm-Message-State: AOJu0YwOLDQxmyuD1w/KOQFZKuI1BCHI/AZo6U3pulvshFHSugG0AB3y
	FQ15pX6czNjF/+Y0ak4yZY5jmPv9C7+48LHqawlE0Ah7mktZ5tUMebHCfuNn44A8We8B6nCvLUo
	nObovNSqQ
X-Gm-Gg: ASbGnctn8DiSQgveU77rDS58yHEN5JdGUJmnBagXud09YC9d+yzzUTleiWz5lfMYGJ0
	aLI+GGhKFTX7e+UrGyC81E4umjMmiKgQniTp+lEAJZ+F6i88sf6x5t0hzmtqrrCNSBUF8wbyXgw
	YG4Wt1BNY4NzvZSL/JpuDRxoW48f5KyOYzfxDnQ0zkMRXZnkEpILonZe6/kOa8LV8GE3dPd2nYP
	IYdf6iIv+/UzsN0aLi1Ztpd/8W3ivItn/r2MgfeH3RDAa/tmG4ZZHLwQPFSlIM5sFA2vxVi982l
	d6/HQeh7/xqxvTYONiqy3b5FA7OMoa6pUvgJy9Kywk8m2UjV8/elnxoZAADAdUPCSs8TbhvIbBJ
	yEyeiFaPm/FklK3EnpC4Uvi/+8z2c5EpL1uG4ApkS9K6GxsW4ZWs=
X-Google-Smtp-Source: AGHT+IEwdPu4ivRooHP0PWHMrzQO8indVYSP5vu2c6drm8+HDfNehsywUhMfTtiZQuqWQbDv1+nZpw==
X-Received: by 2002:a05:600c:5286:b0:440:66a4:8d1a with SMTP id 5b1f17b1804b1-442f20ba9fbmr65669015e9.7.1747309452794;
        Thu, 15 May 2025 04:44:12 -0700 (PDT)
Received: from panicking.amarulasolutions.com (p5b26784b.dip0.t-ipconnect.de. [91.38.120.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f397b6fbsm66608565e9.39.2025.05.15.04.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:44:12 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	linux-amarula@amarulasolutions.com,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [PATCH V2] timezone: Fix compare_file comparison in timezone checking
Date: Thu, 15 May 2025 13:44:09 +0200
Message-ID: <20250515114409.1456854-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original condition incorrectly returned -1 when the real path and the
provided pathname matched, due to a flawed use of `g_strcmp0`. This patch
corrects the logic to return 0 (success) when the paths match, ensuring
proper file comparison behavior.

Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
V1->V2: Improve commit message
---
 src/timezone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/timezone.c b/src/timezone.c
index 89c44895..fba8b925 100644
--- a/src/timezone.c
+++ b/src/timezone.c
@@ -124,8 +124,8 @@ static int compare_file(void *src_map, struct stat *src_st,
 
 	DBG("real path %s path name %s", real_path, pathname);
 
-	if (real_path && g_strcmp0(real_path, pathname))
-		return -1;
+	if (real_path && !g_strcmp0(real_path, pathname))
+		return 0;
 
 	fd = open(pathname, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
-- 
2.43.0

