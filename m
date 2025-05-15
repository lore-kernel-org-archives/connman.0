Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0B6819
	for <connman@lists.linux.dev>; Thu, 15 May 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309354; cv=none; b=P9lyryPAVRgaQ/2JvTHfMg1ebwQeEUlZhH7NKKSLzsiLZ4BsyoAwY/b2EibEiCLfw6VCl8NUp9dDzDAJLuQnfdexCOjuDkvQIIHAf+KYL7HhleZxHecT8M1AnrEUooDZPvdEARlDFt9jsPapHIGCWlp3pDTBKcqxx14gXHtYMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309354; c=relaxed/simple;
	bh=kX1xrEG/BDLe0R8QIo78aCRa6XR9zMGJvZuRtuhkNU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/yF20l26yjpQ5F2ghFrEOpnZg4bwciIqXtSgPNiPxZBTbOOe/rVLLoU2QrMNfFrxzZHlkL2ikOofNpEJALng7f01QRS9oUCgxOtPftykQF0ceL15YRl7Kq3B0BigGMf9CiP1qhgdF+jq/ds1/86eU4yFBIUtfEjumYhAaACc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=lnJKvI75; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lnJKvI75"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so10138425e9.3
        for <connman@lists.linux.dev>; Thu, 15 May 2025 04:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1747309351; x=1747914151; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FouuJ1o2eXS/CmPDJBY8FiJN0WfCkNIPxSz3kBraOmM=;
        b=lnJKvI75z/fpM4GKL5xUpXv5Mgj/O2cTA6ScJhenmcCLWMCFY8gQXUfctG+JX1wb3e
         l2Kuz/SJGErsOs9p9mQI167GAsLkYH2ZjoHmL0c4jsl/Ff7MlY156CcM5B6qoVmeTkvg
         b5W4EIkfN33hn5pJ2tvIJOjfkI8oS5x++H3+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747309351; x=1747914151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FouuJ1o2eXS/CmPDJBY8FiJN0WfCkNIPxSz3kBraOmM=;
        b=lonrEFymRigQwgtRIr2HFW2rhLrbL217tEDLZ1ulRsNIcNk/0oHRkglGzDzqoEnBgg
         TSiOxo0DZ7kTOdmAXAUa7rjdYurInr+/OxpljYy4I9omguxvohNCvne+XdPDVSQtOtK9
         wk7/P1bCb2dFnPNYZdLTrF86O6tX9b0Nvoov/m6+JfkLpeq9pIc5clOYQg+a6LjogOms
         z3W4xLGvL63qPPCtMg2D4PE1SzRyrq8wyz9kj9ujsUkUG3KafOymeS83Vv7FV8afX44r
         CcZr4jIU0Ln0nOaqa2p7HjFXiFl+p8P9DO9uD9ov/rFylytQHbzR8KD/qLxQkS0HPhqH
         2LbQ==
X-Gm-Message-State: AOJu0YwSYwFIxiRX+wkKxTqt2Rl7hAjbXOAl7zh3kQ+7sMEr9oxk02ti
	u6f7TrgX/DbSMSDmPAIeN0u+VCOgpaD9/ikGvZXMobY2kmEFz09eoWquPQQQ8sxAFeWzopzRwkI
	7ZLa0iKUK
X-Gm-Gg: ASbGncvQyNV4rY2/nBoHHq3tL8M+JGKWOgbYOThIW3h6tLsS94d/+unakhX0rMu7fVC
	3CzwXUiPZAmWynLqdpZTLxoq3vWWKYPn1z8NXtzVpLeY60b5+L7VHBCOUCnoBGs7RpwGrW5lALI
	jL7uEHBpu2Dj1T4hUS357mdBcrgT1ZfqQdpNdcbkHyPemhuQjRzUGH1m8fAnz0HAMWyGLRgUUAG
	jpNQTxLkLxD5HZJ0klXF5Zvq+cs9PC97SENfHIeOC1yDoRo+9uTp9QNBqlnI2Pqq9SAxoKK5bFK
	UxXJrtQ6Rs4JDGkj7ZDjxoaa2JOVc798GbIA/FW66zdybplap8A3oIvLWgIV7zQIOZexasAaQyt
	bpE8ayFzarIn3iq80YeUqfUaBXFjsB0StkGvT88IYqF4KjG3wRH0=
X-Google-Smtp-Source: AGHT+IH/p4Fo65YuOxLVRqI/Lq1if0sFDuQd2TwsWr50ImupnInucfK7byyuyC+ikLM+T6R23dwIVw==
X-Received: by 2002:a05:600c:6099:b0:439:6118:c188 with SMTP id 5b1f17b1804b1-442f2110fe7mr69404485e9.19.1747309350745;
        Thu, 15 May 2025 04:42:30 -0700 (PDT)
Received: from panicking.amarulasolutions.com (p5b26784b.dip0.t-ipconnect.de. [91.38.120.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e851bsm67918975e9.28.2025.05.15.04.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:42:30 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	linux-amarula@amarulasolutions.com,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [PATCH] timezone: Fix compare_file comparison in timezone checking
Date: Thu, 15 May 2025 13:42:26 +0200
Message-ID: <20250515114226.1456590-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch allow to compare file only when are not in the same
path. The compare_file is used to understand if the set timezone
if the same we are going to set

Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
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

