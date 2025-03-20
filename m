Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32F22ACF3
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513966; cv=none; b=VqfB7azh93JVlnpErIfo0CTtVc7H7oDjer4yeX6ynlOcIxA1s8EYZWYYvg3R6FMsSkKS1u/TB+ae+SQn4YSkAp3Ni3+S//4LuY+rcqSPnEkcg9ylzYbvg5GZ/cLFZz2R2xjZISvU7SpcRSR4sd6Y+P2XPvgWwDPekyotdJLb8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513966; c=relaxed/simple;
	bh=qK9zOCqO/TbeQ0YHRUlbeK+1agpXP/VPqTZCcklMlss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv5ONyxRPx1jaKZVSzjI4Xk/0CMkIE10UoY77Qh+vFvSl7J7IJN4oZZE4vMxtPbFgky1RIv+Q5tzFX41Sq9eIXr+ORplTqxpqRzLiIyZ0/vb4L3eLydQAbhalgCPhJKKN9cfokqf9B3AYdsFm0M4z9BhVovicIF4179UlpKgo0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=q/NEs0Uq; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="q/NEs0Uq"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 3D50A164AEF
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:18 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E648C12635A
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:17 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 15/18] wispr: Document 'wispr_portal_web_result_failure'.
Date: Thu, 20 Mar 2025 16:39:06 -0700
Message-ID: <515ee111d4ece4434b46d50492720b7925b74b50.1742513884.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=ofBDPpC2ccO3ZRa0ibUw4dEvH04pokg0BoUt6PMWtMk=; b=q/NEs0Uq3kInojMVt1icVssk17JxR5afHLmkS8/Fb3UhNOo87hyNSXmV33np6dy/A8r4sR6NPpyrqqx4uO+kVbQJkpnEIQf3ygx7u0oRjBVJmzTIJTjOuRKsJ09kwgbcdNZ+mXKUeKw4prgsH5n+ViAqf/GmsEOmAO1jpSuGfGYp4Hj3rxrUM9X+CNfdpZJ6DAJFIeDG/07eHP4R7JiLVNv6HLD+CaGQQeu/3Bwzc3VJKEKPntg29rucblCr7eOTd4NjjoFADQ/V6ayHJWeB9Mgd4dMWFmZl/6NyMIKAvctQOX454dUbfbPFLuN9DOA0J3QZfk/NvKetMrgIc2bEvA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result_failure' function.
---
 src/wispr.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/src/wispr.c b/src/wispr.c
index 3f42e131608f..76a7ba219921 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -657,7 +657,7 @@ static void wispr_portal_error(struct connman_wispr_portal_context *wp_context)
  *                              reason for the online check failure.
  *
  *  @sa portal_manage_success_status
- *  @sa wispr_portal_web_result_no_err
+ *  @sa wispr_portal_web_result_failure
  *  @sa wispr_portal_web_result_err
  *  @sa wispr_portal_web_result
  *
@@ -1007,6 +1007,28 @@ static bool wispr_manage_message(GWebResult *result,
 	return false;
 }
 
+/**
+ *  @brief
+ *    Handle closure and finalization of a web request associated with
+ *    an unsuccessful "online" HTTP-based Internet reachability check.
+ *
+ *  @param[in]      error       A pointer to the immutable GLib GError
+ *                              instance associated the web request
+ *                              failure.
+ *  @param[in]      result      A pointer to the mutable web request
+ *                              result being finalized.
+ *  @param[in,out]  wp_context  A pointer to the mutable WISPr portal
+ *                              detection context associated with the
+ *                              unsuccessful "online" HTTP-based
+ *                              Internet reachability check this is
+ *                              finalizing.
+ *
+ *  @sa wispr_portal_web_result
+ *  @sa wispr_portal_web_result_no_err
+ *
+ *  @private
+ *
+ */
 static void wispr_portal_web_result_failure(const GError *error,
 		GWebResult *result,
 		struct connman_wispr_portal_context *wp_context)
-- 
2.45.0

