Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB41EC00F
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059596; cv=none; b=LzrJMmADoJ5anlqqZxRmMnWXxpd2pSyb2KgUr1NHDAHawijZNae1O08HrIucC7QWyvVR8N8UlWb4WnHOTCj55cV2R0FmTk4vtJ+T0r3al5XLbr2iisFGCfYrTG2eBudB/AF9gu3VlnT2WZo4vIn3P2p+oB6NY/3Y+n6hJYUplg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059596; c=relaxed/simple;
	bh=S3qQ2W21wsUMzZZLKZGKe0y4IjHSdWnGscK0VGrL7aY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8Kcz7T7Ntzrfj8Wbppm0jrNB2Nh/zX9881TvyZKzzfOPj1yzcEO0Cnpd8Z64+CSvyLGkbmWmFtDkzmr04sNkTKIHB3dpRsmjDgRNgqcY61ihgSSmiTG5pl/ZhEpqOTm0n/sEhjZwNj2cuh4VZab6NDRZ0Bzew75dVfoE4Zj5yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=B7eFM5PA; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="B7eFM5PA"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 06D2B164B4D
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:54 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id B139112634F
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:53 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 17/22] wispr: Document 'portal_manage_failure_status'.
Date: Mon,  3 Mar 2025 19:39:39 -0800
Message-ID: <f3e3ac53bb1e1db9720bb3e68e33fb0f961a3349.1741059516.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1741059516.git.gerickson@nuovations.com>
References: <cover.1741059516.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=APz4zx/GjwROWDcIldVff1c2YWIGGOlNd93Xn0c1qhk=; b=B7eFM5PAnMySue1Q2euAad0KaxFAOJ2+2JcNld5TZ7FkpnOnk8zhTYOT6Ab4Mx/VTgbl1ABS04z5bUiaNrIQUZ/uwOL2EDbkKLs935rccSp9ufLwdOCsB+4WNPIDljUNgTE1b7dk41GuQmOQHKbij+275Ql91MQ8Vfe5I94k7hnJaO1Z2MEmDZ2wSED7PUGc2GQM4jryx1tgb+/2IhKiGaxb0H8/qbNox1HZ8shPi5QrlLtlAWe8nCuzShzKedKU0cyEoAjsnUOGBHuCiqtiESiePmDdKf2z2nAmjoZFHhWKWPDI1hoYfLY6Co37XKWrTkhanprm5kEJfKcQTxPzNQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'portal_manage_failure_status' function.
---
 src/wispr.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 3116edef0d4b..18930aa3a0ea 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -633,6 +633,34 @@ static void wispr_portal_error(struct connman_wispr_portal_context *wp_context)
 	wp_context->wispr_result = CONNMAN_WISPR_RESULT_FAILED;
 }
 
+/**
+ *  @brief
+ *    Handle an unsuccessful "online" HTTP-based Internet reachability
+ *    check.
+ *
+ *  This handles an unsuccessful (that is, either completed with a
+ *  non-successful operating system error or with a non-HTTP 200 "OK"
+ *  status code) "online" HTTP-based Internet reachability check
+ *  previously-initiated with #__connman_wispr_start.
+ *
+ *  @param[in,out]  wp_context  A pointer to the mutable WISPr portal
+ *                              detection context associated with the
+ *                              unsuccessful "online" HTTP-based
+ *                              Internet reachability check this is
+ *                              handling.
+ *  @param[in]      err         The negated POSIX domain error
+ *                              associated with the unsuccessful
+ *                              "online" HTTP-based Internet
+ *                              reachability check.
+ *
+ *  @sa portal_manage_success_status
+ *  @sa wispr_portal_web_result_no_err
+ *  @sa wispr_portal_web_result_err
+ *  @sa wispr_portal_web_result
+ *
+ *  @private
+ *
+ */
 static void portal_manage_failure_status(
 			struct connman_wispr_portal_context *wp_context,
 			int err)
-- 
2.45.0

