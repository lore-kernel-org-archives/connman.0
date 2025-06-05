Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117B2F5B
	for <connman@lists.linux.dev>; Thu,  5 Jun 2025 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110627; cv=none; b=eBoUxZAIsRmMyXp9hcsUTs3JXCGfBVOs6Ma6QdL6krcRTRttI+x4gxywEaumULgOsnv0WaVkbML68PCMlS1BdfL3A3UkTcrcvxvtF6cy2Wc6tq4pHtVOEBNG0ajZr2a50RbcmnNqvRNmGmQbftQIu39OM/r6HVA9hcJhooDdCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110627; c=relaxed/simple;
	bh=T1g9KqD07JVHCI0HVoL7zsB0fExWK6gYQWLISnEJpgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCKXCNp0B2jvM7zfohHrzIjgYH7ixDdughVNfv9IWaCn5PLKphfmo8n80S1TZw00J30pFHNZuv/0789c4vY9Sanf5DDoTmvAY7rzgr9xQeyUOLHONi+ZaXAGWthjkIo5i0cdIuprvWpYQSjnfFtT05kV7L5Jj64jhIOBoWmxGR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=qeNRW+cV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qeNRW+cV"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a51481a598so364438f8f.3
        for <connman@lists.linux.dev>; Thu, 05 Jun 2025 01:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1749110622; x=1749715422; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1nlKYK53z4jJ9E2oLLZERcct+EFkRRmg/08L7hvgx0=;
        b=qeNRW+cVFkmMrhjsXJAVIHpNNivlCQ/ckYwpA6lHA5Yanv5lFSrR5HILpOyXgaChJL
         PACZyKY8dEdHNxsmPJAIIA44yqdOZNcc7d/gwf+1NlQAIbdhSwalDV6uwJIE2yvzl8CE
         zZATS84lpmN5qyExJz+hNIDDeNmdxC3R1oHzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749110622; x=1749715422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1nlKYK53z4jJ9E2oLLZERcct+EFkRRmg/08L7hvgx0=;
        b=dHoUnFursNUTT4XDqyRlEwZmd5RYNP0+QGiEow34Vn/emlDGv+uAar8dXQf4vt0icS
         FNSKu2kRgbtWjk1hP/WerI3ofze33iX+WUeQgDGBF4x4aqu/3EDpIhZY5kYQ3Dp5KOW3
         k0T4OsIpzN7T3EA//dNy7Qxkg7BEO6tRDB2LCflatIQ+Tb5y327nwOkHVSAlv7GKKN5O
         d8jUlcLwVsjULO5k+eQ0aitBtKvIk0vedU0LD3IOB5G89JmNHE2WbqcP0kXnLUH33Bgd
         48xiFUlryZfcIBL3rboTH9nudImKUVuzMkuoogifrS+BZqIkVYoVYGabmyPOR++EWOez
         X69w==
X-Gm-Message-State: AOJu0YzsLb/mQ5y2zs0aR43PiV8H4An/5W5DDAowb6LCw9t/VtkEVCxq
	JAEY49hm4k5sqvY4UGbKP7X6jgNh1s8aX8Kh2dGg0Ty818cSLtCqF+h9HHVAXYT4ilE4TdZu+jl
	RwomloW450Q==
X-Gm-Gg: ASbGncuhsj7tZBqLZrwGdkW11ESrv7e0qY86e5iy2IpLepgU3gdIrGpYW3c7yAGL8q8
	gkhHBLZ5ndCs+9YJ4YSQVRuDWWUZrstId9BKpyhcTGHfh6zygGwP0Z5Z8B2xEz95076qezywcK7
	JF+FQm42jW5sspQPsSxmqbtw0VDaD8IzmEDwzU5VGAUsJSqfrgRdszELR7wTTFSbjuZlv1fMUpJ
	u1+M5X9z5n6tXLH8yGFJKgwbh4Col+pLtPyBfO2W8sls4P9j5z1p2cdHBhUvXJfnWbYgThx3mde
	aaCtKFNCxLLRpiEJ+Jb/dEVhJo4hdb5REyy1crS8xJBP1+aa7xvILq2kptZ2K6LHKLaxsYAR0MR
	FfBe2kJlL2s1mhvTfeNsORg==
X-Google-Smtp-Source: AGHT+IH69lstocDDMIO68Mj3EUKHy38I1cY9UUSfXTQ89ux73aITQtXWJCez1H3W4+7vfsG15DJPbw==
X-Received: by 2002:a05:6000:290c:b0:3a4:ff01:218a with SMTP id ffacd0b85a97d-3a51d982ebemr4375787f8f.50.1749110621541;
        Thu, 05 Jun 2025 01:03:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:408a:3921:7afa:68c0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a528ed512bsm1116558f8f.86.2025.06.05.01.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:03:41 -0700 (PDT)
From: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	jussi.laakkonen@jolla.com,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [PATCH v4 2/2] timezone: Replace Localtime file copy with symbolic link
Date: Thu,  5 Jun 2025 10:03:36 +0200
Message-Id: <20250605080336.21824-2-andrea.ricchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250605080336.21824-1-andrea.ricchi@amarulasolutions.com>
References: <20250605080336.21824-1-andrea.ricchi@amarulasolutions.com>
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
---
 src/timezone.c | 50 +++++++++++---------------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/src/timezone.c b/src/timezone.c
index 89c44895..f442bc2a 100644
--- a/src/timezone.c
+++ b/src/timezone.c
@@ -507,28 +507,18 @@ done:
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
+	if (symlink(target, link) < 0)
 		return -EIO;
 
 	return 0;
@@ -537,35 +527,17 @@ static int write_file(void *src_map, struct stat *src_st, const char *pathname)
 int __connman_timezone_change(const char *zone)
 {
 	struct stat st;
-	char *map, pathname[PATH_MAX];
-	int fd, err;
+	g_autofree char *pathname = NULL;
+	int err;
 
 	DBG("zone %s", zone);
 
-	snprintf(pathname, PATH_MAX, "%s/%s", USR_SHARE_ZONEINFO, zone);
+	pathname = g_strdup_printf("%s/%s", USR_SHARE_ZONEINFO, zone);
 
-	fd = open(pathname, O_RDONLY | O_CLOEXEC);
-	if (fd < 0)
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
-
-	return err;
+	return write_symlink(pathname, connman_setting_get_string("Localtime"));
 }
 
 static guint inotify_watch = 0;
-- 
2.34.1

