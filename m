Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA47226CE7
	for <connman@lists.linux.dev>; Mon, 19 May 2025 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639160; cv=none; b=EJ/7Nwfa5L6Obzg9ZiOw5DP/BNC6QuCrXr3hF4I+0ZI6z7o4V3WfAaxn5suH+bFhuDvEf/NmvDeARalO/IASG1++aZCBM/1ydJQfSRDO3Qecup2l72dbIMhBjsic0zkR3xphqWVhVePgvpr7fnArUpfDrjSxmCSbDpjYBRDu3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639160; c=relaxed/simple;
	bh=C9deiScE2KnC3wcvXPeCERZ79PEWr7A1U4tyasJELmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DnC1wgi+2gDXPwGMzDJm0y4HOxiuoYQBbAZORRm4iT5ZUklETWjmGOuYRrk63qYD5tT2NBvp+k52fLBUVpfXl6DZoZfxD3MnNfhKlHFZawsdyzIYxbPWuOLtHLGlLGQbTs0tahbhGxPXhh/bwbrnA7hyW4JaMryodjKIjrvqEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=iome9YUR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iome9YUR"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-601dd3dfc1fso1722974a12.0
        for <connman@lists.linux.dev>; Mon, 19 May 2025 00:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1747639155; x=1748243955; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34lQZHRbPH38MslFz4uguIv87aaypwDgOnOz2gmrXio=;
        b=iome9YUR6JtxPCgHh/EiQ7JE/V2qgZtDfomEAaWpJbxPSrmh0W0yQuu1tNcoGwRLDO
         MbNgQMQKPM64j65Aheb2s227y80hGidNi8jaZCcNtVDsnjiiJFWNg8Nv32RyvTrygMGh
         OZRMFjQ2stdnCQJenE0q9QKEwV8RqyxEHncW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747639155; x=1748243955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34lQZHRbPH38MslFz4uguIv87aaypwDgOnOz2gmrXio=;
        b=Ebray9XuX0Y1Ib/i3OWR7JTqM9Cw4/wVMle577m+clF0Fhejum4phZsWSBHpKxJjQs
         iCM7MEyaxHVvJZk+vcHKAePhWUI+Ynsb4zHU6sbl9dSMBn/wpooPSsw5gNXvujVHTdnc
         t+HFaKdTAg/XQThOZUPiQVomOhfY3gSchFdEt8cgzkBxpT51xCiNE6QmpHqyZEyt5/Jv
         cnkMW8YTqHRL68jjm1BUvYLmGRzsuTri6jNlQPWZ67t8Z/0/MwhHw+VuPU1/Vdz/V70B
         GBVBbFpSlL63ctZ+A5MZn+YsjG+gD8V84xTfEr+J/mnOirM1lHFGR3MSNq2TAEsGIIxD
         7YMw==
X-Gm-Message-State: AOJu0YxlKyPx5yuL/W/3KKX0p4wIuaRMVpDyU8HcOlqnMUAHPe4Y0ing
	N0qTEDt1CYQVYw1FlK+azP3dEYMvO11mtDODZQavOwbA6iFPwDWrRlafeSstwKwNcKhbVHiiYak
	jlxgt81k=
X-Gm-Gg: ASbGncuY1AmvD5noVljGCyB0fhLwzuLT9s0Azh/fsE67hY/L1ualEIvYW5EutB/zIos
	YVQoLeOyFLhpi7wA3HN7DKDxkIvXhUVwkJQJI6ae62S2pFideqrdpGp87h0uzW6TrTsIaBeEnkh
	lk4PhDoF2YnpEr+7gxHfogQznixgEdQrePm2eQduCuIKCUpwtqF1P2W30PhhiQI4T8EkemxidfQ
	bd6NgOcmS8F/X9yqavz3DoMKlERQWiG08DhS2dL1OhtW3tAm3Xxao8DVUQED9mBUe+Uq6qATpFI
	ECohhXiH5FHJhWze1y4Hi87oVP7fzAtUzt6K6f0kYKfFukk8IJRuGVf9TcCCfa2Yf7BK5k8c82Z
	bZJYM9ZmHO7C7Ytnq1j0QUrYaAcl+o25Hd9YtNyzh7THZ7lxAiWiqEgWm6tzS2bkozVmC0Otus4
	qtR24=
X-Google-Smtp-Source: AGHT+IGs1xsYBJtogASsrwziYn8GUPWHgDxfoJulSI/cZnEZ1ETdH1lhuqv/1AdmSv3S7K7XeOYegQ==
X-Received: by 2002:a17:906:6a26:b0:acb:5343:e75 with SMTP id a640c23a62f3a-ad536c23c18mr869111666b.34.1747639154817;
        Mon, 19 May 2025 00:19:14 -0700 (PDT)
Received: from RccLenovo-T14S.homenet.telecomitalia.it (host-79-25-253-230.retail.telecomitalia.it. [79.25.253.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d498f18sm544006266b.150.2025.05.19.00.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:19:14 -0700 (PDT)
From: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	linux-amarula@amarulasolutions.com,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [PATCH] timezone: Replace Localtime file copy with symbolic link
Date: Mon, 19 May 2025 09:19:12 +0200
Message-Id: <20250519071912.7682-1-andrea.ricchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `/etc/localtime` file is expected to be a symbolic link to a
timezone file under `/usr/share/zoneinfo`, not a standalone
regular file.

This change replaces `write_file` with `write_symlink`, avoiding
unnecessary file I/O and memory mapping. It ensures Localtime accurately
reflects the selected timezone without duplicating data. This also
fixes `__connman_timezone_lookup()`, which requires Localtime to be a
symlink to function correctly.

This reverts commit f20ccd19a62bd01aa117bfc8e7c388d2a16cde05, since
`compare_file` is intended to work with symlinks, enabling full and
accurate matching between the requested timezone and the zoneinfo database.

---
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

