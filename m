Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2921ABDC
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513962; cv=none; b=UP87g4EO3MyDiNEHEEBgonVSPNa0zb1UeeUn8MX5EZZ4yrlHvwpOOzCEWYr+hFmSBPQbrXHhF5Ee3s9YaE05HxJnVVw8ceZ9758FoY/kgpXR2ToEp+fqGabZRZXrd7fn6JiH6+PBRhb/GW9IvM6bA4lU2nsuQCoFqUhWIx782X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513962; c=relaxed/simple;
	bh=1c69Z6bUnmNnsdFA80pmSLc32hSa9KqbLNBbN9VUNaI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWCW9F5zqMj+iuzgl+lXbVG3pMIgxXG26ZTTLRvjexFDS+fMFApCCo+gAzLk4uSQghn0glLV+D7rZzT/qfyHzaJ99feIzsMrN9bKcMNKokcM1rJ2Jqss9xF55w8gaP2OeoOlNhu0JzoRTEPaeHbYXmRT0xMxWXGkQ9XB2JpixX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Wv88S2No; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Wv88S2No"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id DD74A164A1E
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:11 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 89C8412637B
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:11 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 01/18] build: Require gio >= 2.40.
Date: Thu, 20 Mar 2025 16:38:52 -0700
Message-ID: <9aa482d85c931c18f59e11f1f62f543dd486aeae.1742513884.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742513884.git.gerickson@nuovations.com>
References: <cover.1742513884.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=qMaV0OrBT3njJWC7aljYPsKSZHkn6AMroLFQkTwuyuo=; b=Wv88S2NoDBo3CsOCluceQXl4ur0mIi9LN5lTTSoaR22Pxn6P1d5P79Kfmf508EFjuds9v7+5xrZ/zQE3DeBNxRtxLsmWKLItqarxL78swSK4gC5MGHiocelrEpQqyYCYunAdICuORHNGbZU+FZd0w1Z2jYSAUtp2bjg/6WmyLqX5Hm8chMHMXceH9sJ1lhYwRKFVqd1ESQAxzn+NBLutLbkpw6xVkoFmvGYjM//XBlhLRnanP8Sv4ARmDrfOXCh/EARMaNE0ZRGBem3rkltUtYrw4+yfX5HN84m6BjScyPJeC8nJJDkZvIQjOtBTIQbRP/JNhu9/MgF5VXJwFZjjGg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Required for 'G_IO_ERROR' and 'g_io_error_from_errno' used by GWeb.
---
 configure.ac | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index 7430e2ec9c9b..cae36c9eb182 100644
--- a/configure.ac
+++ b/configure.ac
@@ -284,6 +284,11 @@ fi
 
 AC_DEFINE_UNQUOTED([STATS_MAX_FILE_SIZE], (${stats_max_file_size}), [Maximal size of a statistics round robin file])
 
+PKG_CHECK_MODULES(GIO, gio-2.0 >= 2.40, dummy=yes,
+				AC_MSG_ERROR(GIo >= 2.40 is required))
+AC_SUBST(GIO_CFLAGS)
+AC_SUBST(GIO_LIBS)
+
 PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.40, dummy=yes,
 				AC_MSG_ERROR(GLib >= 2.40 is required))
 AC_SUBST(GLIB_CFLAGS)
-- 
2.45.0

