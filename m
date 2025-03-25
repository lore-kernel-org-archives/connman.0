Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7978F24
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920073; cv=none; b=N42ci/B6wSAU8t0x4g0OKcmfWfM6jkLZNY81yzbaZ+r7Mn5xotJ7NSTTNEQAZkx1uSyuPvUcbKRIehSrSnNvgTJat4zMRbYZphCSjDqbscA9XtoPm1RQl7Ft5CEFv3JP5vosTOEMsslPqSALFKN0Q1vTq4mL/lLmgNAyaVs4oC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920073; c=relaxed/simple;
	bh=hPJsj/V0ALJPKu59MxvLnM4DmkMSUoQRH8VElxtXpZc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7j7PBIFnxfEkHLkAz2DkVb78pLwh5+3eOJBhOU6YOTVuFn8oNxdYT2Pg9I8VhUT/x+K0cRyC+CgftRnR4C+OKSFNy7u5XMaJp8RUwsPvkXZeno9xjNkDpQ4//yG2cng9eyNOBwi2x+VCNNt6c/L317xeO1+QrFhpV0fzRYHe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=NlvSqqb2; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="NlvSqqb2"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 89041164AB4
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 12:27:50 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 3DA3D125174
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 12:27:50 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v5 2/5] wispr: Document 'wispr_portal_web_result_failure'.
Date: Tue, 25 Mar 2025 09:27:45 -0700
Message-ID: <1a53bb8fc641f957a8628eb491bb086150bf1769.1742919926.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=QDX3MGM4W9RIN15cV+OEmzgqmyJBByHRGT9Hf/OFu94=; b=NlvSqqb2qd5HJ3ec+44l9jBPrXvBNkygeRVaM+x5noJrY02NCU7xIRsuk8Ns9Bm/bj1+Od4Vc/Pkkke6H/kO7PWbYNb5Zyfhm3YX1cgUsM0GpdpuO4I3aOHhmkQdFJh2h5MYFtpUVnQOTLcw+VbRKx0pYNturv7MCLQrZ6OSgeK7hnZCCbJk2gfos4BCv2+5arVuFcmobOCO5paBZh+K3ZTj6G7m+aMjYkfYDg2weKIyoXzrezjR8km1iMf91ydWhN1nyb36YYI4r+AmJSrBK2a/aCgGbeeDlaLx5pCDDGb+bEzaK7/m2e4WsQbFBkBTMk8DqaBrxlfVzQmonnGQjg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result_failure' function.
---
 src/wispr.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/src/wispr.c b/src/wispr.c
index a21ec8e29aca..fd80715ec719 100644
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
@@ -1008,6 +1008,28 @@ static bool wispr_manage_message(GWebResult *result,
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

