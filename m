Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074AC26290
	for <connman@lists.linux.dev>; Tue,  3 Jun 2025 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958350; cv=none; b=Ix7kiEABoa9Sqm0HRiy5lEjjaneuma0NOffVCEibL6Xo6D+YJDVnoAx3cVW5QbA/sbMKas/zX9Gki5UL+9N/iWoVhSpOBo9ADrJZBnakrirWpugWBGydEfvi2M8pSDSSry60ldmwzfL97+FYgRArelZ7BzfDNztFylbKAaE2sEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958350; c=relaxed/simple;
	bh=0q3kQttQyhxnPSHsDy4TYG6GRQQjBUoJU5LVp6CcVm4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TTXqFsdynFn01YaG0YX0IyOrV8v1yT+ikgBEkmTFt/ZMIkgbKsu1gIHnT+H5HqdvRy/ZtBiJ+c7d4RrNaNj0x8w6i6dQuUVVAn3kNeW99lYyDdtTxlb8lclseLOHCllr3MqS9Gzo20zh0ix9w8f+3Tas67Oxd8UB1xWb8ia/gYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=UaP6Woow; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UaP6Woow"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4f78ebec8so2534555f8f.0
        for <connman@lists.linux.dev>; Tue, 03 Jun 2025 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1748958347; x=1749563147; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7v06QsmJjHy2W57WezqHI39uXYcisyibsvxnupNOPM=;
        b=UaP6Woow4dWWI1O/LB8o0ludlVBDur2BFyarCn8JmholO/8mhssycXEkRkpI2Mfw+D
         TlSonpQyuHvrPAv5QpRr9jJNmTRfzryDhBR10g9JQtVa8P4Q5d1W+yAN30ZY9zCQbHlk
         wKrLHLayxTO5OZPWGXcq7c3Yy3MiWIVon5WS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958347; x=1749563147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7v06QsmJjHy2W57WezqHI39uXYcisyibsvxnupNOPM=;
        b=CnhrRTIB4r267esqqSud1eE8Os6uu7USoB5CdcmLuh7AxVlXrz+/84XeUGcVMf8wCl
         AOaSzISxs0+oCeTkuQI9ulicCrQ2F3nIAf3zXw9knOTv+r18Uwt4Vll0YqIPqfwqeIQw
         5ShbedQzvWY5bakhAjXfOZ+9kUHZyS1dwnWzQv9Y6a8l6KekDM5QRq5YhZgr9E9fz9wn
         FgseZmD+b1MlUaswKdGa1TTJoEwrMkgLAbmoL/+oFQOQBPi7pOHNrZl13RTExyE/epzW
         WEnW2UEpEGZ8eI5W/aMRX0Mx99DE/AiVEKmopGe+gP3vRgXWCbKYp+oREIbE6Xig7SIc
         YlDA==
X-Gm-Message-State: AOJu0Yzal3GMK/coRBTO2CM17iGwfF0x97b6P8+Osv644cS20vcFoD2T
	q/IxtXDgaXAvcrC8caV+7oxl0QcL4NwP+bAY6ME5kLrLa+ssinpUzv55M6yZTlvRFJDEd84Zf6X
	UkKeYlVDrnw==
X-Gm-Gg: ASbGncshQ/DwFluwcY9zQkfPCAaT/3fjiMXACPyVJbeRwXRYyomeNP3f83UE8GIUUpv
	RMYpn+USd63/DH5swP/5s9Tt9JpUWHi16sBwFX1qvgbTUf9qI4suFdleD6O1XeRy73JwUPwyhkT
	wtNxw6FrKMz4HoqT/UG1z1EP2chU4seEbv8EYdJqsr4RNfOF6UttLrV93Bs68NVOij5kJza5DRT
	wvjFdZx2axtrZisZRrHyHQoVC+OgHUyXa7I48IBLFlit+fRxj88z5rLCua2k/hXnFpv7foP06/s
	mh5wqpHMC13sRkkBoaQoq0VFqploR+RGMPSUOKxWpS/Qgd+W5hky4WlNJCDaKAb98J82PJyBYLP
	hFP9cQy/Vn1Q=
X-Google-Smtp-Source: AGHT+IGz0G+gG8l738B66he2o+2J+YdEr5tKN0lu3mC4dx/i1XrNz9KQGWGG31aaRvkX0osFihbUpw==
X-Received: by 2002:a05:6000:288b:b0:3a4:e5bc:9892 with SMTP id ffacd0b85a97d-3a4f89a892bmr13490404f8f.21.1748958346848;
        Tue, 03 Jun 2025 06:45:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:a6f7:2a98:84af:9b39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8013e0esm161438535e9.39.2025.06.03.06.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:45:46 -0700 (PDT)
From: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	jussi.laakkonen@jolla.com,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [PATCH v3 1/2] Revert "timezone: Fix compare_file comparison in timezone checking"
Date: Tue,  3 Jun 2025 15:45:41 +0200
Message-Id: <20250603134542.67627-1-andrea.ricchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f20ccd19a62bd01aa117bfc8e7c388d2a16cde05.

`compare_file` is intended to work with symlinks, enabling
full and accurate matching between the requested timezone and the zoneinfo
database.

Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
---
 Changes v2 -> v3:
  - Added to version v3

 src/timezone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/timezone.c b/src/timezone.c
index fba8b925..89c44895 100644
--- a/src/timezone.c
+++ b/src/timezone.c
@@ -124,8 +124,8 @@ static int compare_file(void *src_map, struct stat *src_st,
 
 	DBG("real path %s path name %s", real_path, pathname);
 
-	if (real_path && !g_strcmp0(real_path, pathname))
-		return 0;
+	if (real_path && g_strcmp0(real_path, pathname))
+		return -1;
 
 	fd = open(pathname, O_RDONLY | O_CLOEXEC);
 	if (fd < 0)
-- 
2.34.1

