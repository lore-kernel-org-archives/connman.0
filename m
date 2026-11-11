Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440866;
	b=cxztRa+bvdCyrqaw+8AVZ+PY6jjStxF62mHXDuaOoO4gG056z/h6F9fxzQo3XVLaIJSX
	 VF8xPIBrHhL7/Vyt5jJ119vGA8vluI213sdvSj1Ur+X4PTNdFLVZxoA8KNWE30y9L4hNi
	 sjWXHoQHe0ZyeY7RgWDk2hV8JPZtp2ga9e8knyAANyXURCpZp51PWzAQ/ct3Ogivb2Jm1
	 FyOOc1aT/EWrljXDnG0qTNt5JHFZkJG0MRRNwdON/i29j8Xwv+9SWxwRVtsyiFDpFdRdQ
	 OpMEylaws6IcTgF6gxqS0SnBxD9H/jiirHmjEyHZC0sQaM+SiYo21TtxeJGZxu3OM6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440866;
	h=DMARC-Filter:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=8g9iv7e/sjoC6oPHu3sxHYxVtw/7jcyfjsFPnPfJU3Y=;
	b=VJfXT2vPmYWWDCE13N0JLGL8muqmZUDgK7R+dQiK72/o2iGE6Qr+Oz5Vuj8Iop2Zp8WH
	 4wyeqFlbrdUDvH1PeFRJwWlanJ5MTiPySjbkXahyBcU4r1bd6LJFzCn6oSjoX2Fq1VAqV
	 I27b6rMHpgek+utJ4CKt56h5w/Gjs410rEIsS1wqEETQJRWgcyWT9kTngbXzf/Ids64zD
	 Y9/stLXi/WNGezEZXpQXuFX2MtSzicipT69xjmmiWE1MQ7IcMDegXBeyfVev/RQu5ocOl
	 n5YWSc1Im1XDn1YjB4Ef7xgqam3/9wkqjCo3Pvx2TEt44dP79D0C48Q0qy1C6VzvMJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=FO16rc1T;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C742606A89A
	for <connman@lists.linux.dev>; Wed, 11 Nov 2026 23:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C742606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=FO16rc1T
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id A2C14160069;
	Wed, 11 Nov 2026 18:47:44 -0500 (EST)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 4C782124C53;
	Wed, 11 Nov 2026 18:47:44 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH] wispr: Fix leak of earlier redirect URLs
Date: Wed, 11 Nov 2026 15:47:43 -0800
Message-ID: <20261111234743.1609688-1-gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=8g9iv7e/sjoC6oPHu3sxHYxVtw/7jcyfjsFPnPfJU3Y=; b=FO16rc1TFJqyy6nop7oDE90D79+7Y7e/k5Ul8a/5GrNFsNTkm02ICrPro/mUNUmMXESwZCJDWD6aOx7o2QOOpJJf3f/6jJdIigcEL4H56qspt8cwY31VJyW768B7IL1Qkqx5hrdU7IOrE1dioZpyu9fEAU+v0zgF/qwazrlgTDyZrBw1ZcleNkT0sGUf85MYvPoQDl9BcYmCPKpgTfGBM01mNMa5Al2iO5gcx0FGLk4PZ3pC1chiSVXlYAF2x8uxw8EUSddORRkFSHr1gcWyfGS7frNye1kBmHg1tfKHEQtS0cmCXXhFl6rnKGlUXMoE02GrTb+9h/ZmpybgKCR/eg==
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

