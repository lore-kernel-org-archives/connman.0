Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D025B68D
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920073; cv=none; b=cnr+zRIFq7HstfZaCytjYflfmAtcfMCsOUFg7Y5MIxhNLVuscAeUrUf6xiofawng5PYj8DQNxo8HBzL2mpP6dDpMseHx22Wxx2++3rCaXDRSHcfHU8IjXpgCwQ8YWTaH/SWaGNWvt4Mu33EfS/gXReoUZB7y6CNh1Eifh+m2yuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920073; c=relaxed/simple;
	bh=rhnjJX4DpNCgL/Rh1zxyPk+peaLMVOmSeBaOF46UwXo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfVqKr8m3/q/SWPvZfNPrUTZVXtx7SZ6VdxboNv1q8R9ILSt2FB7z2jNz8QoTx1JSx0b80+2X4vMzeMMGDifQdpV/OSh9lf2fKNioIqVy+9yIgJ0KWTlA0ro0xatis+ArK3fJ+eMPRGYkraCxpOxbNlgIhpXuJIW9g2fXWwD1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=DSw5ZgW4; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="DSw5ZgW4"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 032C9164AB8
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 12:27:51 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id AB5F9125174
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 12:27:50 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v5 3/5] wispr: Document 'wispr_portal_web_result_success'.
Date: Tue, 25 Mar 2025 09:27:46 -0700
Message-ID: <cd39f2178f52f9192d2ade8cbec713e4899bc6cb.1742919926.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742919926.git.gerickson@nuovations.com>
References: <cover.1742919926.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=i00iMwAbVWLc1GJxDdwKJJU0iH9+g8+mp6ze38OsoUs=; b=DSw5ZgW4yP8PJc0Uu6Om/APqNZR7gSM1JGdJ43zkEdkB/R0mN7nRd5WTCgBwUo7Sm4TfVV3epnMo7peueeCMRwigALEdJcXqlvcQJAQEMtu7cF+MAYECLkhYIXjtjh9zmZ9z34YEdhthORkFOt8P6CFbtLACLmszqGPuQy4j8iVpWiFHcUU950qHMlK/eyR14IoIIv/wSYHbvkWAQFbqykGAtRRO614iXpaO2wpZ0/uL7mm7T7A3rK2Vr9JGxCASdm2Z5NhfvNMGMoeNIa4jQNlBDkc9tz6Grt4Xwb7OwJbGGjd5kkAwC11rCgrCry8JzEE0YgyuL2QBVaff6ST3Uw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result_success' function.
---
 src/wispr.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index fd80715ec719..47659b58383c 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -658,7 +658,7 @@ static void wispr_portal_error(struct connman_wispr_portal_context *wp_context)
  *
  *  @sa portal_manage_success_status
  *  @sa wispr_portal_web_result_failure
- *  @sa wispr_portal_web_result_err
+ *  @sa wispr_portal_web_result_success
  *  @sa wispr_portal_web_result
  *
  *  @private
@@ -1025,7 +1025,7 @@ static bool wispr_manage_message(GWebResult *result,
  *                              finalizing.
  *
  *  @sa wispr_portal_web_result
- *  @sa wispr_portal_web_result_no_err
+ *  @sa wispr_portal_web_result_success
  *
  *  @private
  *
@@ -1040,6 +1040,25 @@ static void wispr_portal_web_result_failure(const GError *error,
 	wp_context->request_id = 0;
 }
 
+/**
+ *  @brief
+ *    Handle closure and finalization of a web request associated with
+ *    a successful "online" HTTP-based Internet reachability check.
+ *
+ *  @param[in]      result      A pointer to the mutable web request
+ *                              result being finalized.
+ *  @param[in,out]  wp_context  A pointer to the mutable WISPr portal
+ *                              detection context associated with the
+ *                              successful "online" HTTP-based
+ *                              Internet reachability check this is
+ *                              finalizing.
+ *
+ *  @sa wispr_portal_web_result
+ *  @sa wispr_portal_web_result_failure
+ *
+ *  @private
+ *
+ */
 static void wispr_portal_web_result_success(GWebResult *result,
 		struct connman_wispr_portal_context *wp_context)
 {
-- 
2.45.0

