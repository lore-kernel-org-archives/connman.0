Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BCF1A8F60
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878781; cv=none; b=k9pnzvQ91DQ/JbWDWYPvOr+PkT/UboB+FsP/QBI3Mlh/LbJ+f8C2ydeH5Ry1vYCaWOfk28A3hNVPj0oq9N+007G9UN66jLt4kv/13MJlhPtseAsulRNAxYH29B2+5UIEZeXQfN58/Fd5hupbm/OwaPYBN4Mpy0JTVFRcs1/NvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878781; c=relaxed/simple;
	bh=qK9zOCqO/TbeQ0YHRUlbeK+1agpXP/VPqTZCcklMlss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OT/kRzTMmqRxqfdREd5lbv0godDnedRCButzJ8+Gz2rA2XuHUhF5noFXYbM6/UiWM8WRfKDQRM/xcyMGFOjyTpzdUqtYNaFGlVbE7vIwEyxDYhZ+4ajalSv1kE+y4eGm0e7Eey1rYGtF0TRkCf5gzQZs4PpdSTebyJHE7ZyOd8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=QKOuYjV0; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="QKOuYjV0"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 3A4B7164AAC
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:32 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E14E7125166
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:31 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v4 6/9] wispr: Document 'wispr_portal_web_result_failure'.
Date: Mon, 24 Mar 2025 21:59:24 -0700
Message-ID: <e94d455823e0073fb639725276976dd62d609b5f.1742878567.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742878567.git.gerickson@nuovations.com>
References: <cover.1742878567.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=ofBDPpC2ccO3ZRa0ibUw4dEvH04pokg0BoUt6PMWtMk=; b=QKOuYjV0AoII2/ZcmA8r0eGb64EkiN6cZy+eNa69l0f3f1UR9iIjWtuMPTO+M1LgUeW2/HW/NXP4XEEpCpi5DpyQmDe1N+taHB6+lES77xFd0D8eyuU2XC3DKGsYBCkq2DFr8xw3NRiMjrMv5Vpgtj5N/wfvzxtAqPHBDl46iytTyW4wZ+V3Mnhe6wp5LdU3KY4JRu9Lc9OU/WHjOlyUm0tL02V5k2cLLTt4cY+DeKXeqbtwhkxI0Blydjh2Crph9N6qnLsEqDUFlrLE4lftvCz1Bx1+IVXsHosVQqb2h0+ZBH7L9LRCpFniMWaszTqNdEoM+LQNmtnEvoGXvc50pg==
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

