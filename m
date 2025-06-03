Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675926290
	for <connman@lists.linux.dev>; Tue,  3 Jun 2025 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958357; cv=none; b=nJBMBnUiQzk4RWzpdsqfOyrZA68XUvq0/7T55BnJjx57VsMkIxiPlvVtXh3e8YaRsFLRk5MaLaNQ4ysmcvYXrlwrs6qSMRtihy+hSgyfW1cZpI/ydjF8JQH7p9inViYfGhsnPf16w2gkJhPdwGwkhOfVTksXGbnWSm/z7Zp3CDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958357; c=relaxed/simple;
	bh=OZE9J4TPhROre83vMwoqq4j0uOnWYwDXdh/baLpqNIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvtvqU03bwFaDthR8R30ExK1DZ6JqrPWiPufdmXyJZ3onHdNhsFQVxDRtx0VBUNpy95eOp+KEhaVcfast5J3hZuLtYYhztfUFQCAg8szZbQgXVEqGGq2yDFEhhOKiffLnPf1ZPWODUzPh9R+4HP9RcEkt06aHVmP9qGC6bFILxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=l+5uqc6X; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l+5uqc6X"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d3f72391so36929945e9.3
        for <connman@lists.linux.dev>; Tue, 03 Jun 2025 06:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1748958351; x=1749563151; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZzP51eVJYRSAvjqHR3U+vrKowTxxoMgdXUbX7xOG8g=;
        b=l+5uqc6XU1lRWNCLkcAp84NJG3nIPZrXaqix9e/Zi3U6Q8ACwK7gAjd2Hgme6/BH72
         GqQOscONrSo/D2xvDfsfywKDTsRy90L2h8sVKjEzJxKCtIpVExtZ1tlWh6IyNgfAiSPB
         InSGBRbIgBvFPEb/VxtB/zdHm3RhkvUoX1eJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958351; x=1749563151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZzP51eVJYRSAvjqHR3U+vrKowTxxoMgdXUbX7xOG8g=;
        b=hNPlpUjP+o5TzR2tnwg6+lQ/nBa9qU6oQ/Q9I76duYxG1QLrrdQ7bmVai6f1o0qDc7
         QZhJMXz+ljDp9N09mK7HOFPm/kgjtYshhn4UpeUNIFAomO2rqUEeXw30MRjqvgHG/72M
         vJ392QDdxV0swG0WlnrV5D1/ATA/aKIwqWjYzsT55DD31xXlhYLmM3DYxcyK9uaXLM3V
         pCiROIRULS11YJyfPGL3zIeghR4nDyKd7//EpYWrMLz5sUEmifV77pcI5odOOUDRIo9X
         ZOYbcTSlvD8aifJ8ZJ4sjJgjANHbewgrYb0wjmstTk58YPik5aMR9m4SoaDFSY3/8mN4
         kqyA==
X-Gm-Message-State: AOJu0Yy24KuHJ6P6BstBck0jsB1mB9EidWHFtAjqJr7QOPJQKbhPVMgf
	7U0g1MdkFw9JarLsIyn/F4gWoPBvHu7BkGzH5y/kvO2MBlqwWWlhjCtXBei+WaBLQA3J5GRGWfz
	Ca3DdFfeD/g==
X-Gm-Gg: ASbGncvQDJD+6Cu0hJko8DW3TGFkoWK0/xNtZT384PTjBDoLGG0NtEITlXvTynCobiz
	38yhlxP+WHoKnWkx13YFHXbjdsooQMu4lq8bj6cJWE3Tu9odUn0yhIK/abGTnkX2NhTgVw8mjb+
	y1zhNKjlvyxRZbCRMn1o6LKeSLku98X4+hv5fiELvXFYo+XqN2+lImELyf0aSPTWtkQT81VeOAE
	gJn2powZzdW9UhVM4SjUfawE5bcrDFgSEaDE3If+y2Mn8pZIEVlDFGSlV9hNRoBhWdvm6IVnXq3
	NGH8Sqc/ZRfiut1e9n04Mu4npDiCoqBfIFcqkgB2m9wx59Rs+muOwPzw0m81zQHBXdXWw/XO5TL
	P7W34udCCr8rj8z/5S6XFOQ==
X-Google-Smtp-Source: AGHT+IE9QSmWYCHCgU/Q+TGobsPM3hLBMXvvMZiCOWo7jcNBmK/U37Bdj8KcDm5HsJFbLpp5KYWFcA==
X-Received: by 2002:a05:600c:4f87:b0:442:cd03:3e2 with SMTP id 5b1f17b1804b1-450d87fd991mr157437025e9.2.1748958351420;
        Tue, 03 Jun 2025 06:45:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:a6f7:2a98:84af:9b39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8013e0esm161438535e9.39.2025.06.03.06.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:45:50 -0700 (PDT)
From: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	jussi.laakkonen@jolla.com,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [PATCH v3 2/2] timezone: Replace Localtime file copy with symbolic link
Date: Tue,  3 Jun 2025 15:45:42 +0200
Message-Id: <20250603134542.67627-2-andrea.ricchi@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603134542.67627-1-andrea.ricchi@amarulasolutions.com>
References: <20250603134542.67627-1-andrea.ricchi@amarulasolutions.com>
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

Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
---

 Changes v2 -> v3:
  - Splitted commit

 Changes v1 -> v2:
  - Change commit message

 src/timezone.c | 49 +++++++++++++------------------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/src/timezone.c b/src/timezone.c
index 89c44895..9b820477 100644
--- a/src/timezone.c
+++ b/src/timezone.c
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

