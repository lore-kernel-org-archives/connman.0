Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D583E2ADB
	for <connman@lists.linux.dev>; Wed, 20 May 2026 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286143; cv=none; b=LfoADO+SAbfDM4wEJnrE85HKJUR+SbDOESCiCYQexAyVO8fFdD8YzqixqYzhnJig8eKN7ZjVnKOfzcXQKCrpMXaJXY39ioRAnbGHbU/6h7BlF7t72HQqWHP8ghIeMgplvoObe+09r1YZF+Gb0zLyxdnyYdn1m/8PyX9Tf5TFLV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286143; c=relaxed/simple;
	bh=DxNuuKpdBiCVCHFD3/OffJIG6ZMWiw9mRKUiKkWGaOg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVQXky+TToqeGR00IZ6wc3H9eSdzIvs0zfcj1/OfQE/k9gtHbUuPNWyN3rII/SS4iyVBwUx6wf8J5XBcnZ+fo5grHHHL1a3Diqg+ZmjR6Lr4DonGTr4EC0nr8RTdrQ0XGCuetYoXFoKdkfzvXrZrEnLA4QsuygSsb+rRIBYz7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=xlBlnFLE; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="xlBlnFLE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IwY8zupsJs8bkvQIf0q6YOw/wE+JKqh7xzv1zPywzsc=; b=xlBlnFLEB8dh8gc+U5BYhX/c3q
	edbWwN3/9VD/WNBhx1+JQfu2AwVK7kEZCGdTiD1TAsTuEPbJ0XNGik1GMa5hbnqotDN2Ufxyls2Eu
	kxfSh2mPKyCICJetSr2AIzZN7oM9hN7XqI+RSHAP2EuMkiHY94CEmmSEilQg6U1qaIaK4+n4aSCvI
	5NPGjgmRy+yqtd/UzBCLENJNFaBkOHj9XflVD54jU8AdUdSHYDyoI3581vpnEHfJdvetaPz9cV6lq
	PZDQSRMyKgQfhpJGLqQVgHCuxjzOJZyJ8ri2jMTfcZL4sXT1SpQdkd+1VTHScyumMts1nX/NB2swb
	Q0hMPv9Q==;
Received: from [2a10:a5c0:37:6500:de2b:9403:4cd1:218c] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa (Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
		id 1wPhGi-002WBi-1x
	for connman@lists.linux.dev;
	Wed, 20 May 2026 16:47:28 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 1/9] util: Add conf.d support for connmand and vpnd
Date: Wed, 20 May 2026 16:47:05 +0300
Message-ID: <20260520134720.981315-2-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
References: <20260520134720.981315-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.6 (-)
X-Rspam-Report: Action: no action
 Symbol: RCVD_TLS_ALL(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: LOCAL_OUTBOUND(0.00)
 Symbol: TO_DN_NONE(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: FUZZY_RATELIMITED(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_ONE(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_ONE(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 X-Symbol: RCVD_TLS_ALL(0.00); All hops used encrypted transports
 X-Symbol: FROM_HAS_DN(0.00); From header has a display name
 X-Symbol: FROM_EQ_ENVFROM(0.00); From address is the same as the envelope
 X-Symbol: MID_CONTAINS_FROM(1.00); Message-ID contains From address
 X-Symbol: LOCAL_OUTBOUND(0.00); Mail from local to external domain
 X-Symbol: TO_DN_NONE(0.00); None of the recipients have display names
 X-Symbol: TO_MATCH_ENVRCPT_ALL(0.00); All of the recipients match the envelope
 X-Symbol: MIME_GOOD(-0.10); Known content-type [text/plain]
 X-Symbol: NEURAL_HAM(0.00); Neural network HAM [-0.945]
 X-Symbol: BAYES_HAM(-3.00); Message probably ham, probability:  [100.00%]
 X-Symbol: FUZZY_RATELIMITED(0.00); Fuzzy rate limit is reached [rspamd.com]
 X-Symbol: RCVD_VIA_SMTP_AUTH(0.00); Authenticated hand-off was seen in Received headers
 X-Symbol: ARC_NA(0.00); ARC signature absent
 X-Symbol: ASN(0.00) [asn:202246, ipnet:2a10:a5c0::/36, country:FI]
 X-Symbol: RCVD_COUNT_ONE(0.00); Message has one Received header [1]
 X-Symbol: MIME_TRACE(0.00) [0:+]
 X-Symbol: RCPT_COUNT_ONE(0.00); One recipient [1]
 X-Symbol: R_MISSING_CHARSET(0.50); Charset header is missing
 Message-ID: 20260520134720.981315-2-jussi.laakkonen@jolla.com
 X-Milter-Del: X-Spam

Add support for reading and processing of additional configuration
files. Util is best suited for both daemons to avoid adding more
internal dependencies to vpnd.

The files are saved into the list with the full path if it is given as a
parameter. Callback can be omitted for only getting the list of
configuration files with the desired suffix in the given directory.
Callback gets the full path of the config file for convenience.

Add a Glib file error converter to utils. Map the errors in G_FILE_ERROR
domain to matching errnos. Return -EBADMSG if error is NULL and -ENOTSUP
when domain is not G_FILE_ERROR.
---
 src/shared/util.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h |   7 ++
 2 files changed, 186 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index bda2d2b3..fa42e1c9 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -3,6 +3,7 @@
  *  Connection Manager
  *
  *  Copyright (C) 2012  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2025  Jolla Mobile Ltd. All right reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -29,6 +30,11 @@
 #include <ctype.h>
 #include <stdarg.h>
 #include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdbool.h>
+
+#include <connman/log.h>
 
 #include "src/shared/util.h"
 
@@ -128,3 +134,176 @@ char *util_timeval_to_iso8601(struct timeval *time)
 
 	return g_strdup(buf);
 }
+
+static bool is_file_symlink(const char *filename)
+{
+	int fd;
+
+	fd = open(filename, O_WRONLY | O_NOFOLLOW | O_CLOEXEC);
+	if (fd == -1 && errno == ELOOP)
+		return true;
+
+	if (fd >= 0)
+		close(fd);
+
+	return false;
+}
+
+int util_g_file_error_to_errno(GError *error)
+{
+	if (!error)
+		return -EBADMSG;
+
+	if (error->domain != G_FILE_ERROR)
+		return -ENOTSUP;
+
+	switch (error->code) {
+	case G_FILE_ERROR_EXIST:
+		return -EEXIST;
+	case G_FILE_ERROR_ISDIR:
+		return -EISDIR;
+	case G_FILE_ERROR_ACCES:
+		return -EACCES;
+	case G_FILE_ERROR_NAMETOOLONG:
+		return -ENAMETOOLONG;
+	case G_FILE_ERROR_NOENT:
+		return -ENOENT;
+	case G_FILE_ERROR_NOTDIR:
+		return -ENOTDIR;
+	case G_FILE_ERROR_NXIO:
+		return -ENXIO;
+	case G_FILE_ERROR_NODEV:
+		return -ENODEV;
+	case G_FILE_ERROR_ROFS:
+		return -EROFS;
+	case G_FILE_ERROR_TXTBSY:
+		return -ETXTBSY;
+	case G_FILE_ERROR_FAULT:
+		return -EFAULT;
+	case G_FILE_ERROR_LOOP:
+		return -ELOOP;
+	case G_FILE_ERROR_NOSPC:
+		return -ENOSPC;
+	case G_FILE_ERROR_NOMEM:
+		return -ENOMEM;
+	case G_FILE_ERROR_MFILE:
+		return -EMFILE;
+	case G_FILE_ERROR_NFILE:
+		return -ENFILE;
+	case G_FILE_ERROR_BADF:
+		return EBADF;
+	case G_FILE_ERROR_INVAL:
+		return -EINVAL;
+	case G_FILE_ERROR_PIPE:
+		return -EPIPE;
+	case G_FILE_ERROR_AGAIN:
+		return -EAGAIN;
+	case G_FILE_ERROR_INTR:
+		return -EINTR;
+	case G_FILE_ERROR_IO:
+		return -EIO;
+	case G_FILE_ERROR_PERM:
+		return -EPERM;
+	case G_FILE_ERROR_NOSYS:
+		return -ENOSYS;
+	case G_FILE_ERROR_FAILED:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+int util_read_config_files_from(const char *path, const char *suffix,
+					GList **conffiles, config_callback cb)
+{
+	GList *files = NULL;
+	GList *iter;
+	GError *error = NULL;
+	GDir *dir;
+	const char *filename = NULL;
+	int err = 0;
+
+	if (!path || !suffix)
+		return -EINVAL;
+
+	if (!g_file_test(path, G_FILE_TEST_IS_DIR))
+		return -ENOTDIR;
+
+	dir = g_dir_open(path, 0, &error);
+	if (!dir) {
+		if (error) {
+			connman_warn("cannot open dir %s, error: %s", path,
+								error->message);
+			err = util_g_file_error_to_errno(error);
+		} else {
+			err = -ENOMEM;
+		}
+	}
+
+	g_clear_error(&error);
+
+	if (err)
+		return err;
+
+	/*
+	 * Ordering of files is not guaranteed with g_dir_open(). Read
+	 * the filenames into list to be sorted after.
+	 */
+	while ((filename = g_dir_read_name(dir))) {
+		char *filepath;
+
+		/* Read configs that have the requested conf suffix */
+		if (!g_str_has_suffix(filename, suffix)) {
+			connman_warn("suffix mismatch in %s required: %s",
+							filename, suffix);
+			continue;
+		}
+
+		filepath = g_build_filename(path, filename, NULL);
+
+		/* Allow only regular files */
+		if (!g_file_test(filepath, G_FILE_TEST_IS_REGULAR)) {
+			connman_warn("invalid non-regular file %s", filepath);
+			g_free(filepath);
+			continue;
+		}
+
+		/* Do not allow symlinks */
+		if (is_file_symlink(filepath)) {
+			connman_warn("config %s is a symlink, ignore",
+							filepath);
+			g_free(filepath);
+			continue;
+		}
+
+		/*
+		 * Prepend read files into list of configuration
+		 * files to be used in checks when new configurations
+		 * are added to avoid unnecessary reads of already read
+		 * configurations. Sort list after all are added.
+		 */
+		files = g_list_prepend(files, filepath);
+	}
+
+	g_dir_close(dir);
+
+	files = g_list_sort(files, (GCompareFunc)g_strcmp0);
+
+	if (cb) {
+		for (iter = files; iter; iter = iter->next) {
+			filename = iter->data;
+
+			err = cb(filename);
+			if (err)
+				connman_warn("cannot process config %s: %d",
+								filename, err);
+		}
+	}
+
+	if (conffiles)
+		*conffiles = files;
+	else
+		g_list_free_full(files, g_free);
+
+	return 0;
+}
diff --git a/src/shared/util.h b/src/shared/util.h
index 430b821f..39fcdeb7 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -3,6 +3,7 @@
  *  Connection Manager
  *
  *  Copyright (C) 2012  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2025  Jolla Mobile Ltd. All right reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -53,3 +54,9 @@ static inline struct cb_data *cb_data_new(void *cb, void *user_data)
 
 void util_iso8601_to_timeval(char *str, struct timeval *time);
 char *util_timeval_to_iso8601(struct timeval *time);
+
+typedef int (*config_callback) (const char *filepath);
+/* Returns -ENOTSUP for non G_FILE_ERROR in error */
+int util_g_file_error_to_errno(GError *error);
+int util_read_config_files_from(const char *path, const char *suffix,
+					GList **conffiles, config_callback cb);
-- 
2.47.3

