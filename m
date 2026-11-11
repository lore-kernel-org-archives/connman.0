Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441235;
	b=h0cyGH7bd1KujvffqyoOtHUMS9T1M/j+pyd2eDiG5E6m3pvnLh0o0i5rtSfIYKuUyKi6
	 gEAqu1I0meAVTnnZG0uvfXVeiYxyN3nU5il5SrfrfZkzDv3K7sWGKKctgvEWpgQWA8QsW
	 qi+Q6K7oVIGjGr4Z/dxBR221fIOh9vBQnS7VotMw6edfLUfCdGof/Ild/CUz6KwMtfFJm
	 4FrWo0MbNVx9jDuQdns4v2a/kckFyOi+mxZxd7RdjSeFmdUifW0Np741ze/XjiHRGb27n
	 HEMwF2qWL55WO/qj5TBQttR5zd0riHJ2s2dGThh26QHe2UVb3LVV0gtr3NSysY/c+6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441235;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=8g9iv7e/sjoC6oPHu3sxHYxVtw/7jcyfjsFPnPfJU3Y=;
	b=y0pPi5/8BBZfa/ht2qJb5GJpcyh2nCF5SjALmszHWart/PL0gqpJolVqD83HDHSL3RB8
	 TMDeyVPhTONsUyu9RIDZe6Yllso5AAb1tZdsJxshTKBHMaPlQ7bfvWO63TeNyrOX5Y/Lq
	 RJVKk53CYDq3baYZmSRGHulqN/rnMe+J0h+Eml90l/8sNCjFiDUQNB/dv9+E9090o7wkX
	 fsKd27xzZdj2zt8IDtJouNvdFTX2V0y1F68CM4XJqxLxs7cCMOjgdLi8Fo+0HaZewGQBg
	 CUr/jPBqpFZmN49LpojrR1umr73V6Dq9ACM1Olmp/vXPvzC5D06p1Za/lkv+qOKQ7HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=mquYQQuk;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18146606A32A
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 23:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18146606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=mquYQQuk
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 3F90A16024F;
	Wed, 11 Nov 2026 18:53:54 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D39A0124C5F;
	Wed, 11 Nov 2026 18:53:53 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] wispr: Fix leak of earlier redirect URLs
Date: Wed, 11 Nov 2026 15:53:52 -0800
Message-ID: <20261111235352.1609830-1-gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=8g9iv7e/sjoC6oPHu3sxHYxVtw/7jcyfjsFPnPfJU3Y=; b=mquYQQukY0lDL/1VHc7QVW2dS4gO1GPktGLNqCSPMEc2oKMhBm2ya65Q+78SCpGuE4qdh9Nn+TW6cRrPKJgMZGTHFIDqQwdJyRDYXr9PavJovqHKR+ALJcDTCSjyJOF8zO0gU70n8OwtJCPykuMCo89v717x0nyKrfcNN+zgUz7Fx255ymxA4+S2BV/Ju9dArw5110vVj6kEcAqy85b21ERb7PGzChbX1BRd345IS69nAasTGG3FoXuRMMMXdYjt0/80GWNukIW+/XsZ4FueYTVnMVQh5EM77yrRtYI1T8VMQ56dqgMv6R9b49M7XrY1cTYxGkhkY9Y+LWInPQ6U0A==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

When an online check response is a redirect that wispr follows,
wispr_portal_web_result_success records the redirect target in
wp_context->redirect_url, replacing any earlier value without freeing
it. The value is freed when the WISPr/portal context is freed, so a
context that follows a single redirect does not leak. One that follows
a chain of two or more redirects leaks every target but the last.

Free the earlier value before recording the new one.
---
 src/wispr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/wispr.c b/src/wispr.c
index a40cf353b54e..64c5639d59ef 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1111,6 +1111,7 @@ static void wispr_portal_web_result_success(GWebResult *result,
 
 		DBG("Redirect URL: %s", redirect);
 
+		g_free(wp_context->redirect_url);
 		wp_context->redirect_url = g_strdup(redirect);
 
 		wispr_portal_context_ref(wp_context);
-- 
2.52.0

