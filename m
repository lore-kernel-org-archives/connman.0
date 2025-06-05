Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3A2F5B
	for <connman@lists.linux.dev>; Thu,  5 Jun 2025 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110624; cv=none; b=jQexcLgMSnR5FEoiMFJS1qlIPDnxyx/MnY5zPooYfizjIY4Il9uZ+rijrw0S0t7SJK5vWN9LpngNksHYkiOt94e1p7IWgrkBYi+25l2Br5H/elnfJaBCVArMxkXrZIhaBhkgSqfSTxLr7L7jx2wuKUHX7g7vpNZnRf0w+slEIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110624; c=relaxed/simple;
	bh=yG4unmHdtfjtMhsy8lqQlJZCvFzFsNmlrgW68bA9zsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qeF9b+zYj8kULOnlCgG+z5SbhebD73pCLa16RLaJXPuzHjjWmILtSvOwRF+3BfZ+np7sVwfPXP/eE4oWdB+M2Cwt+GEc1puI0JWdvrnzJ/re7zePoErr76vyFqghuIDBLjk4O/TWtO1xaotoHrul0zS0F8ng3s9lgpI6ewynIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=HvIxJsf/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HvIxJsf/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so3950395e9.1
        for <connman@lists.linux.dev>; Thu, 05 Jun 2025 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1749110620; x=1749715420; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCJ3GM0LOEnohXcGlT6amYfEMNz9itMZBFqGLnUegyQ=;
        b=HvIxJsf//TN32vL4MXkzJsgzZMAPohGPeOhLu7uXn8xTdLorIL6LPFlNFNzbz5iYBT
         oO5ALH4FFORrRSanwdEwyKJ0PLVKiarm705KJ8rQw0wG5Wl+Fmz0Azh1LMyQo0xpHwDB
         XGBEBcLhFXJFgrwsAg0LxzhxqQAXut7iyiaSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749110620; x=1749715420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCJ3GM0LOEnohXcGlT6amYfEMNz9itMZBFqGLnUegyQ=;
        b=AfpTaclmVXHuZJ8S0IzXZ5qiGT7amCun6hTAcaUiHdMZYUtdknKmI6lVqG/tHsE9wd
         4+Ox6f6ZbyaRWzd881Pj5C4wqOoeAAHgC2YFaiqhcmEQJSpltjT2bIXQM2KxDzR0jalT
         a3rF45P0NdVUm8otbRQLvJMps29FxzIkcU8EDMIV0cT8/imYudbp8EUTz6R0cavZ7MQm
         ni0/DwRwjdCjgGIqgpeEABAyrMlgULd6Xr4Z5nvg2RIu1vSEsV0p0S+XhYBS1T923AH1
         knv35RzQx5CL5A++TYzaiBkQy47s24tvU+iyRD0CcWWIs5XCeyjDqJJ7AHVmrlTXMFqC
         v37A==
X-Gm-Message-State: AOJu0YzeiSQxRI862GUtjtrRhxKBrGdpDmlBCjmlFD2gamMtXh6b3/z8
	/w+yA0n1yZOn230rNovk3x8LaP09C3SG2uQdaCmlcqo7FbReh6OIeBM6xdMVcZdodr7EsMML7VA
	KXiOC1TslSQ==
X-Gm-Gg: ASbGnctACSx2c3sSc1C3SBd5EWD9bInQikpfDn62MbHokRREkySQAwjKRiTrziFvsuS
	91b8WIRCNFkWnb572wF42Sz7m90p1hxPIhqRj4XbpNUwcYJdlYoraa/9OIC17/V4+b+nWtjUM6+
	nIcRIrC9Hb3yY8co6xpUULQVLpipBWPwOYdr4FyYQ/S8p0VFW4j4AmUkLw2HTHWgE6LYuCgpINX
	i+xIKNNgxxVYfSDsq1KoqezSE1PGx+BuL+HHTzl/yZsClndRSgGS1v5x/SGdjPTheSvckoMsT7F
	vDkFXqYLX7b/ul1mMVuXVRIuuyCamOctQOfRvNMYod1fkQMW4lCQNNTnX3I4RRgIYu+C04mS8j/
	2VsFI1VOhJ1CB+kPHGRUu/A==
X-Google-Smtp-Source: AGHT+IGi++w+Hi840nhuVHigUgTukNC+If6uavXgYvoEh9OgpUR1D7pwI9Q7AVkPV+AMHsqv6XcPyA==
X-Received: by 2002:a05:6000:2410:b0:3a5:1c0f:146d with SMTP id ffacd0b85a97d-3a51d958046mr4481224f8f.33.1749110620557;
        Thu, 05 Jun 2025 01:03:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:408a:3921:7afa:68c0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a528ed512bsm1116558f8f.86.2025.06.05.01.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:03:40 -0700 (PDT)
From: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	jussi.laakkonen@jolla.com,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [PATCH v4 1/2] Revert "timezone: Fix compare_file comparison in timezone checking"
Date: Thu,  5 Jun 2025 10:03:35 +0200
Message-Id: <20250605080336.21824-1-andrea.ricchi@amarulasolutions.com>
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
---
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

