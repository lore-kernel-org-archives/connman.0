Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3B2745E
	for <connman@lists.linux.dev>; Tue,  3 Jun 2025 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956242; cv=none; b=rqVBTax2Mt7fHfdsDkomEatnwXghm+8zesc/9fMPHw9TxNqvAy6XSDSyTnXJc1TrLSHmlALMedGd1W0KXpAupnOGEHLMMPaIDshQWbdN1xRFwt1oHRe85AmLOIZFzOBVxeJdMhdPU8ZyDl4EKFWUWMqW/DUhAIsutRoAKTF08lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956242; c=relaxed/simple;
	bh=5oW7gseTSyJHGu5xwu7mqSxJjxyGRjQlcIib0989LcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YL7dsMEUwrLSK6L88AmGP/aAViGeDp95BuKibyK3ACgq1nmvvF3VD/JsrdJLnFOgmTrVQASAC6nNJQ/j07StlIk2DvG/tG2WBoV7di++Wgbz3H44Jef4RMZ31T0OJ7qSGBPNdt5y8NwP96SzZ2AGgA4wlegizYY37L0vcALzlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=IuZxehz5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IuZxehz5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so9499705e9.1
        for <connman@lists.linux.dev>; Tue, 03 Jun 2025 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1748956239; x=1749561039; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HA3E4cLO9PM8c45fAq5+TrYbRiEdpDKHmtKvnl8dCf0=;
        b=IuZxehz5LMOSFtFR7NVH/j78nz2uGVEJgNlJsDjWVwlZtsf6YhYIdrE9I1cAQgLnJm
         x2Ss3Ot7W4vaZWu6pVnCGUEzYetkzegul67R0o52asQfsQaAXyRNZIupkWhE6VbJno+t
         vQ2NFElfB5D8aChs2tPdGmhDJo+bPU3384Zro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748956239; x=1749561039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HA3E4cLO9PM8c45fAq5+TrYbRiEdpDKHmtKvnl8dCf0=;
        b=Cl29YFEZSgZx3rnnnDaY8KnojF1Fe8vKqFzH0EzGaXG263598g2yAZOpl3Lc/fAIUk
         2qS3IYcASD7IQFOMTVPADxA7qbauZwy+5VFkq0YrmtlwuEn0n9z5tBaIKMeRm4Vk1+Fx
         ON5e5pTfmBlKYSBRVXL2xb/0z649CMRGLEdMuk3x5pgLc3txR48EgSzIZ37/b7TWAeTy
         Melluf6pcVAl7NX3QnMzsBrA7Sl9NfRoVtl33/hY97DnwhrFznHtfE8nj3TBSZ0YUkwX
         NDdJ7TQ4NyUClTYhZZxTaNxcgm5rf3WkrgWSpZeFTmUcUHFT8P2cmAYmF9+NMu+l/hS4
         lCuw==
X-Gm-Message-State: AOJu0YxDPO7iX9JaFlsBsA0L7EE7uJzPCs+C+hkBhsFLw/U3cuiiChLU
	oHc3ZJsoEN1xzeFIfggDuS4/fB2cB13LWMm7VUdxdpay4NiVF88GfGgcZGQ3/Q8TL7OJlAH7fhd
	zSJEnjEk=
X-Gm-Gg: ASbGncv82nqL6QRgYg+jx7JG+ZBSR3YIwFoS1enykUYAIX4AMS9gWoJMOGgoVhwTlM1
	NNBopXMsfoBJcVIKW4J3PtEcRwuyB8/EMsozThe42EIXCU9hpijucPCbNZ3qYYuxhwel3bO0LU6
	vTwXakNtplfA49DZBZXcrHfOYnfp6fmC9BwDv5mVob9JOAEyWOHAq/lVOB/fGrEQWRQaPtTwKmR
	1iIIUeAT9Ig9ZTy4OYlzOWph22U8ZPmHi9HpUojfPiE7Dn5uIHmOwA5n03+Hb1K2UxE/fIkXK5o
	18qvP62HmnTdioXmfAM8//Hj3CUfgbeCWjwxjYGL8xD4rNiGRgrhU1cvBV9vezU6uuY89VtdhOt
	CDVLomwJv1EA=
X-Google-Smtp-Source: AGHT+IEYGU/y5tHDpuvuT874t2bpqXZzmVX7rugcPU7RhbE1RPu9cL/Lnx6GyuYMOtC7wvpuWDD00g==
X-Received: by 2002:a05:600c:34c2:b0:450:cabc:a6c6 with SMTP id 5b1f17b1804b1-451e67bb968mr27658595e9.15.1748956238767;
        Tue, 03 Jun 2025 06:10:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:a6f7:2a98:84af:9b39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8f194sm163544965e9.4.2025.06.03.06.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:10:38 -0700 (PDT)
From: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [PATCH v2 1/1] timezone: Replace Localtime file copy with symbolic link
Date: Tue,  3 Jun 2025 15:10:34 +0200
Message-Id: <20250603131034.60946-1-andrea.ricchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the `man 5 localtime` documentation the `/etc/localtime`
file is expected to be a symbolic link, not a standalone
regular file.

This change replaces `write_file` with `write_symlink`, avoiding
unnecessary file I/O and memory mapping. It ensures Localtime accurately
reflects the selected timezone without duplicating data. This also
fixes `__connman_timezone_lookup()`, which requires Localtime to be a
symlink to function correctly.

This also fix `compare_file` as is intended to work with symlinks, enabling
full and accurate matching between the requested timezone and the zoneinfo
database.

Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
---

 Changes v1 -> v2:
   - Change comit message

 src/timezone.c | 53 ++++++++++++++------------------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/src/timezone.c b/src/timezone.c
index fba8b925..9b820477 100644
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
@@ -507,28 +507,20 @@ done:
 	return zone;
 }
 
-static int write_file(void *src_map, struct stat *src_st, const char *pathname)
+static int write_symlink(const char *target, const char *link)
 {
 	struct stat st;
-	int fd;
-	ssize_t written;
 
-	DBG("pathname %s", pathname);
+	DBG("pathname %s", link);
 
-	if (lstat(pathname, &st) == 0) {
-		if (S_ISLNK(st.st_mode))
-			unlink(pathname);
+	// Remove existing file or symlink if it exists
+	if (lstat(link, &st) == 0) {
+		if (S_ISLNK(st.st_mode) || S_ISREG(st.st_mode))
+			unlink(link);
 	}
 
-	fd = open(pathname, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0644);
-	if (fd < 0)
-		return -EIO;
-
-	written = write(fd, src_map, src_st->st_size);
-
-	close(fd);
-
-	if (written < 0)
+	// Create the symbolic link
+	if (symlink(target, link) < 0)
 		return -EIO;
 
 	return 0;
@@ -537,33 +529,18 @@ static int write_file(void *src_map, struct stat *src_st, const char *pathname)
 int __connman_timezone_change(const char *zone)
 {
 	struct stat st;
-	char *map, pathname[PATH_MAX];
-	int fd, err;
+	char pathname[PATH_MAX];
+	int err;
 
 	DBG("zone %s", zone);
 
 	snprintf(pathname, PATH_MAX, "%s/%s", USR_SHARE_ZONEINFO, zone);
 
-	fd = open(pathname, O_RDONLY | O_CLOEXEC);
-	if (fd < 0)
+	// Just check that the file exists and is a regular file
+	if (stat(pathname, &st) < 0 || !S_ISREG(st.st_mode))
 		return -EINVAL;
 
-	if (fstat(fd, &st) < 0) {
-		close(fd);
-		return -EIO;
-	}
-
-	map = mmap(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
-	if (!map || map == MAP_FAILED) {
-		close(fd);
-		return -EIO;
-	}
-
-	err = write_file(map, &st, connman_setting_get_string("Localtime"));
-
-	munmap(map, st.st_size);
-
-	close(fd);
+	err = write_symlink(pathname, connman_setting_get_string("Localtime"));
 
 	return err;
 }
-- 
2.34.1

