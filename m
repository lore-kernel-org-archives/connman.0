Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B8E1DDA1E
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059593; cv=none; b=E3GS7Lrsluz/GEX/RED8NzJoKat9zauENW1tgcBDt5xyppzF6kc1EzNO+ux8ngjVY//RLnMFhj2elgWA35vRY1lpjZkw3qE/fqqddMVPD3SPE4bMPm2G6NhuT+2HFY36q3tya96q2pm6ZYDAwznBFQRKsHlJR2QgYL6BAyqPwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059593; c=relaxed/simple;
	bh=44HUdhk7dssEJ9PRfq7Z/GkqK4eShLJD9Y8TkVr78Xs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Md1+3ftcGwA3jV7NtU/1KybTU125IkXir9icegUmC23ZNdrTnjrwebrt9aJgs02JaZl0jts3Y7cdi1G74O0ftJSVr1+WYXiH7Kw9AIhy5dpiML3JjGKLYkHkYyhXQ8H6/OETTe0K4TLsd9KuEhpu+F42290oEmDqJF3YSXLAIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=SEskxhoV; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="SEskxhoV"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 68BCF164B40
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:50 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 1ED66124FC9
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 09/22] gweb: Add documentation to 'g_web_result_get_status'.
Date: Mon,  3 Mar 2025 19:39:31 -0800
Message-ID: <008c8a22cd569df0fb8c8f815d946b0bf730b419.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=aP//wlS8ILBKjvXLMQ+tpDDPz4EdrX5YOmp9j5T5if4=; b=SEskxhoVePXg0D2FsdLNB5jwM6wZc/0CCaBcYtJOAlhpRUrKlqOONNN0KNSetAn9uj+WCsPWmZnemVhBTovjp7L2impML3zh40f2CW4y73++0W8hNUuuXghCeYpwVds+NdqyjSFzt/G/dH9UxX7RRU8C5W4JDPsk1PhIdySttb/z81LdkNiT8dUsh3lhxNRwMUET3q1YZAWN0GTz1cfkCoyZGEyW19cJNIrJO/QirOpgCefzG5LL4SxZ1m01bmUUyKdwnyBk9fR39zuikdjNaLQ8PNKQadN3Jcovj3SFzQRhfy8rFZ/uKVEKuwhMdw+kUn8Th7FIFihqL61S8cbM6g==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'g_web_result_get_status' function.
---
 gweb/gweb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 0256d622e00a..ec72cd417a9c 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -2526,6 +2526,21 @@ int g_web_result_get_err(const GWebResult *result)
 	return result->err;
 }
 
+/**
+ *  @brief
+ *    Returns the HTTP status code, if any, associated with the
+ *    web session request result.
+ *
+ *  @param[in]  result  A pointer to the immutable web session
+ *                      request result for which to return the
+ *                      HTTP status code.
+ *
+ *  @returns
+ *    The HTTP status code.
+ *
+ *  @sa g_web_result_get_err
+ *
+ */
 guint16 g_web_result_get_status(GWebResult *result)
 {
 	if (!result)
-- 
2.45.0

