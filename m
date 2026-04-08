Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A053B3BED
	for <connman@lists.linux.dev>; Wed,  8 Apr 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643612; cv=none; b=CQWykLaLFoPEizqSsRqDFVNz22wvY3Rs/EiMgACp1CmgxKkaT9D3m5A9LAIilPtbgGMJBhNHdz8jr2Crcyr0ii0P0+87g8dqd6L5gaou+o7bM78NQwW8Woh+PfkQ9amZSTfNZJaX1uS9jxAtZNA++FA41iB1vWfH2x7CvrkVdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643612; c=relaxed/simple;
	bh=Qo1pbqNW4eAymg58L4eJuTjXwgkuUQwxXD/uXIGD9fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tabsnRiMsCd9n2HTxP0uauLmY40bPzI6rpFn8bccv1JYyejXd/nEKOaPNkBJrCE6HTDElO2I/xgTpcrVlxdNp+3aZAvpfFHwbaondFxb42HPEZldQg+2FSIhG4GDDyEvhDWmel8HCQIYudCWFPyza4pE5LwFgAB5xdMRwFLZK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJG8Lm/7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJG8Lm/7"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a3d2824e4bso5225713e87.3
        for <connman@lists.linux.dev>; Wed, 08 Apr 2026 03:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775643596; x=1776248396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XydEMi+P/vb4iyOcn0KbKQclF8c2GQRUhbbptXdYFls=;
        b=IJG8Lm/71HkuoCajD12TDOWXqZZusNufBln6ScWp6IqC+ImW2hvdsV4z4NsR5nKFUc
         eMUzHRW7pyhbY6vtGH2mjHInVut8GqB9SMkzhj6y18j0MfbXzg73cMDpDCN3m4uoSLuJ
         0XaGkpKaOL3ghLp2DPZzC+3SNSZDXeo1tx5u7bGzY0aQSvICVSXFojXtQS8n9ELKLwFO
         gl2Y4Ep7627EOiRh3yh27dQR1tlAiB5x0T0phOECp7ZXGrSE7tJthIAbUKg/0roSrT7S
         tdR/6vsQ3L01769jmKc+AO/PLm9WHKvENsqzkeXAXRUAq6ArY2joRrkJjD+OzxzA7peE
         PIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775643596; x=1776248396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XydEMi+P/vb4iyOcn0KbKQclF8c2GQRUhbbptXdYFls=;
        b=G0aLmSPzd8wf5Xz5KLZKUei5hQ0KD1gb4gCmMr0QWej3ZgmJ5eLH4SY6s0f97QoUro
         4arxGwLkgarJzSmtcTaw22FTmv6juPIXN+nZriAslCZrCiZbKv4zZR0a5O3EDGPR6dtK
         fYMcX7cqB0d9vxpK1FGYTYmKvx1AARX4dlih6XxLjgG/LPkfaaYGqwoxtKkVC0bjl1cu
         c9wySv3ezVVWg8NGmL5TLbOpfIU2mKBg9/yxTD5VMuV5SWlMkYHIE+NbezQg9SOMFFi4
         1Q5GG3NIwDl0e68Oh8zWdFr6EQQrZ0+4mdgcAnduYWV7XgDOvsTpdbvgQN+ITnB3DQJf
         A5lA==
X-Gm-Message-State: AOJu0Yxc6Cibw5pNu4HQY2AYKKwkH/WlhXfWT2s9l9fQX6HK1S3Krcc+
	bUNZb6dKjB29OCNIMsKLovcDR+oqz2kdBFT/rnOdtaF8Kpkj/kd+NK2SL2F46Fv0fRk=
X-Gm-Gg: AeBDiesHYaedtu4ucZ8rjaqKNW1y6tgETrlb32L1O5ZPIUDE8mrt+o/9/WzbWNluwKC
	t2cb5d53afZdHxFf7ncpmPsBDKy+uYUwGZK2hsl6LuMamvF6Yiep+Rsj3DsOps+XiBB1kZFgqUF
	Dyrezl+mnWj7IkL9vcsY6KHBhaZ9mzxlqxa3zf+KbDyMIyLsGWlEU6EZHjCW2fOQfYQHCCeEfwf
	7pSzmmm9jPBpJ2KGJ/56NdFO9+zablBz24XX3+w8/fUinNz0yQhbskx2BUh1VnTD+nIN4S2DNBf
	CyePeu9tp6ZFmWSuAeT10TbnDwtCnT3CfetRNo3bWPXhPYWWKMasXHPtTvYaReE2lGMP8FLi0dU
	qLzMVSRhJ9TTJ0fThPurSnMzPf1QfQi8TeiN63kKqdn0NqDp7nK/bfFBTqwgQZpy4Wy4yaJibrc
	6B8J8uBIHIBB5NxFpnkLspzM/3UG1cZfGhUBW51hOdxJiY5WuGI8z0B3hZoGT2mbSQtXjyBfn0B
	X69H6zDEnnkqAMRVHuUJJCEb8WugjzQQr60hg==
X-Received: by 2002:a05:6512:3f02:b0:5a2:bcbd:579c with SMTP id 2adb3069b0e04-5a3375832aemr6165729e87.28.1775643596406;
        Wed, 08 Apr 2026 03:19:56 -0700 (PDT)
Received: from nucken2.localdomain ([2001:9b0:25f:c800:cac3:52:5400:da8f])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-5a2c6cccc83sm4657629e87.65.2026.04.08.03.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:19:55 -0700 (PDT)
From: "=?UTF-8?q?Richard=20R=C3=B6jfors?=" <richard.rojfors@gmail.com>
X-Google-Original-From: =?UTF-8?q?Richard=20R=C3=B6jfors?= <richard@puffinpack.se>
To: connman@lists.linux.dev
Cc: =?UTF-8?q?Richard=20R=C3=B6jfors?= <richard@puffinpack.se>
Subject: [PATCH] gweb: Ignore debug calls in case web is NULL
Date: Wed,  8 Apr 2026 12:19:50 +0200
Message-ID: <20260408101950.1768872-1-richard@puffinpack.se>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of URL parse error, free_session is called
before web is assigned to the session. free_session
makes a call to _debug, which did dereffed web and crashed.

So simply return from _debug in case web is NULL.
---
 gweb/gweb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 0a87da64..b9778ec6 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -177,7 +177,7 @@ static void _debug(GWeb *web, const char *file, const char *caller,
 	va_list ap;
 	int len;
 
-	if (!web->debug_func)
+	if (!web || !web->debug_func)
 		return;
 
 	va_start(ap, format);
@@ -458,11 +458,11 @@ static void free_session(struct web_session *session)
 	if (!session)
 		return;
 
-	debug(session->web, "session %p", session);
+	web = session->web;
 
-	g_free(session->request);
+	debug(web, "session %p", session);
 
-	web = session->web;
+	g_free(session->request);
 
 	if (session->address_action > 0)
 		g_source_remove(session->address_action);
-- 
2.51.0

