Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C242088E
	for <connman@lists.linux.dev>; Wed,  8 Jul 2026 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481972; cv=none; b=K/ez9bzUTECnd4KF/8d5v5uRubDDh+jisNo+ZJIaJBxR4AXFXh4Tmw7qPZb+W3u8C3hNmR0dbTjyF/VtgA0XwBWHP5RPrTCkV8r8gIIzZBn9ycST7YFXjF4k0GQLO3mWInOY73aeEG+rIRX3Zf/abCK5LX1r+IzacPNd6oy8aiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481972; c=relaxed/simple;
	bh=awZGwJ2V/sa6l4un2MFt7JcRncLYgQMv+KgKhWubIpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jkUTogeZjKyzzuyPLwFXJQOq+WlBcE5BpwwCJ7gfK4Hc4n0YKal3rGDpWLCN7YSszP4OKawWCElKYwWh0Huv8Ya+uQmBCmcBQexjDBPRpcTzIqgnuhdqcCu17ozpdjGbd96A0KWVTl4aoMRZorMmIEh0UTJ1un45OwHL8t75IvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dViWrdNS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dViWrdNS"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3811f512167so272270a91.3
        for <connman@lists.linux.dev>; Tue, 07 Jul 2026 20:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481971; x=1784086771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBzFvdCHhBLjOQr2/7cUSVEqy4Y1heAHPSR9P446SqM=;
        b=dViWrdNSMMZ+gzOE2xpTi5hSczNWs3tccQyQ4Vz4g20u0rLW+zYFi13binWobGXpfN
         RX+c53cTC6aG4Lp7hl1Lm/YEnQOTVufxKt0r5eWJsJRFG2vpbX824oNYcuIfIp7Q3SSk
         6G2g/OdJ3g0V+woXuH9Ih9NeqIeLRR571mERLwkqK34Da7fnOvu8Z7BSAliuTCAR0XJ8
         XnWykU+aZXRc3fjxRjEzp+PRY4FXoIOImYFHca4F0u9z1oJ/r41BbHDZzOoIuQ1Yc64X
         xSJplG2ncR0ka4LufmMR04v3fi0V0oCSu71PjjsUQ0vjvlAyozWADrP3tkOf4KVjyCjv
         D5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481971; x=1784086771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBzFvdCHhBLjOQr2/7cUSVEqy4Y1heAHPSR9P446SqM=;
        b=YjzHvEJAmETUJOWHinKJ33PpfrYiF5fiy9mMUL4g3kEK2kEiD6J3MOZbgY8byki/pb
         QrqHz5mJQHP1D0OBChnwAM+ieu86qgtC3ULu6kgnrDpfs0/XZg5LFdRHVmszK4g/4SbF
         MyB8nBqOgIgBf5ctP6Jt+W5CcxronfBq0UYZuzG6CCJ2bgPDFcuh/3eq2l+/hwL71Yht
         a/6wG52cKc6KZMF0VCr6wpDgSepBnpJ3m3iY3kBhRwA3dstWjTSbgsMnueOTtwnlIfjN
         OgtiFgAd+jxtox7gpFVY4YRx6DFlMio428kOY1X57bSaluDQMFhgDGMMNT63tFmX1wZA
         dc9A==
X-Gm-Message-State: AOJu0YwrWEnS4d6Tmv40kgvRU4U8IImWh6urGffSeJtEM8HEUxBHAM7A
	2hDO1sf1/3IaJb7wo1RyzhtEjGJWOCjViKWH/2hbmhbLa9oLL2m0yI1vtOrEyg==
X-Gm-Gg: AfdE7clxQgsryLy18rlrTTDGsTxifq01l5rjHGw+ppktk0GYQGsx7FzxwXgildJfUeV
	XsgJHifea8c99k2g1JfC/uH/CetO18Wfg2uc7/xiCAy5uzZ3PIjcGs2smTpIiOWzTurjUeaWLHb
	Auk3T1+MJ4v7AawthWg7oOeUIHKVao/Z0FuFbRc7rUZIoQrl8F7SM7ejMQ34ckBcEGVScZGMr0H
	If8RHVJ2Hm/pKI8jl3LfUtM2JwzxRysga5yourh/r15ISBn5eCYGqJGNh50SQD4vX25cChRdc5w
	w8yrubjW+un9HgFYiVCw18wu0jUGENVagZWLib2R5L9GqHIYopqsbR1w5A8j/jnCQQWJ2I5Zho2
	SR0ec3le+/PlIlWLRH8j+tchOrZdVKI6nsOPTff/vKivl4uBSJdFj9nOQLeHv7mNerxzciDlY4+
	II76dRiGLT4JzN7QIlRPXEuy0xS6BCu+VTJnKkzJumtQNwGNhfGZCp7Gg0186a4WX4Gj3CRA==
X-Received: by 2002:a17:90b:6cf:b0:387:e0cb:c8dc with SMTP id 98e67ed59e1d1-389421adc75mr677114a91.37.1783481970831;
        Tue, 07 Jul 2026 20:39:30 -0700 (PDT)
Received: from localhost (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d36675d5sm2035593a91.12.2026.07.07.20.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:39:30 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: connman@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Denis Kenzior <denkenz@gmail.com>,
	Wig Cheng <onlywig@gmail.com>,
	LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH] iptables: Fix crash with iptables >= 1.8.11
Date: Wed,  8 Jul 2026 11:39:26 +0800
Message-Id: <20260708033926.1209049-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since iptables 1.8.11, xtables_merge_options() calls
xtables_free_opts(), which unconditionally free()s xt_params->opts.
ConnMan points opts at the static iptables_opts[] array, so the first
option merge for a target or match with extra options (e.g. the
MASQUERADE target when enabling tethering) aborts the daemon:

  free(): invalid pointer
  connmand[1223]: Aborting (signal 6) [/usr/sbin/connmand]

with the invalid free happening inside libxtables.so.12 called from
prepare_target().

Fix this by keeping xt_params->opts as a heap-allocated copy of
orig_opts at all times, so that libxtables is free to release and
replace it. This stays compatible with older iptables versions, where
xtables_free_opts() only frees opts when it differs from orig_opts.

Reproduced with ConnMan 1.43 and iptables 1.8.11 by enabling WiFi
tethering. Same issue reported in Debian bug #1112242 against
ConnMan 1.45 and Bluetooth tethering.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 src/iptables.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/src/iptables.c b/src/iptables.c
index a81a0779..956a5b6b 100644
--- a/src/iptables.c
+++ b/src/iptables.c
@@ -3541,6 +3541,23 @@ static int setup_xtables(int type)
 	return err;
 }
 
+static struct option *dup_orig_opts(const struct option *orig_opts)
+{
+	struct option *opts;
+	unsigned int i;
+
+	for (i = 0; orig_opts[i].name; i++)
+		;
+
+	opts = g_try_malloc0(sizeof(struct option) * (i + 1));
+	if (!opts)
+		return NULL;
+
+	memcpy(opts, orig_opts, sizeof(struct option) * i);
+
+	return opts;
+}
+
 static void reset_xtables(void)
 {
 	struct xtables_match *xt_m;
@@ -3566,11 +3583,17 @@ static void reset_xtables(void)
 	 * We need also to free the memory implicitly allocated
 	 * during parsing (see xtables_options_xfrm()).
 	 * Note xt_params is actually iptables_globals.
+	 *
+	 * Since iptables 1.8.11 xtables_merge_options() calls
+	 * xtables_free_opts(), which unconditionally free()s
+	 * xt_params->opts. Therefore opts must never point at the
+	 * static orig_opts array; keep it as a heap-allocated copy
+	 * that libxtables is free to release.
 	 */
-	if (xt_params->opts != xt_params->orig_opts) {
+	if (xt_params->opts != xt_params->orig_opts)
 		g_free(xt_params->opts);
-		xt_params->opts = xt_params->orig_opts;
-	}
+
+	xt_params->opts = dup_orig_opts(xt_params->orig_opts);
 	xt_params->option_offset = 0;
 }
 
-- 
2.34.1

