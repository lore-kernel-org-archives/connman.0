Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D31DF73A
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059596; cv=none; b=qj987mLMM5BGDpzoWx22qFAnIzgwmb7obQaj4jyAq0iX5pPboL/PB66kmSibA0YREF+mrMAeJSSXr7EMj5EH7R4bp2PRqy/VOsBJ1L/h3TSF++yTjt7GHc7J2jWRH1yCL+1hGaVyIjluNL3nq4On/cBlLOf4+2tSfPrUs3FrauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059596; c=relaxed/simple;
	bh=ee6eVXL+J+D1hp9+9D9jXD9pyzn3uM7oj1ASZGfX6Ps=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTDGm3QwB2YVuojEOKN3jyqtBTae0md9G/tmgeVsREEga94T0lv1ZNb+8ZkCbHpxi/h3OCjSNVMo38JpiXspw8usqAlITsfQkZbueuibC2Mez02wqRY7BjzBKS5OGSJ2bJd5QgRkvDcPlBvNDb1gXC6pBveXe6BbSzPNFZMx1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=iGWmgoEz; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="iGWmgoEz"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id DEC43164B4F
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:54 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 9636E124FC9
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 19/22] wispr: Document 'wispr_portal_web_result_no_err'.
Date: Mon,  3 Mar 2025 19:39:41 -0800
Message-ID: <27f48e9dd2863ab5b1ee98d38121f594151d4641.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=Q1Po7Yqoi4jhAS08w6pjXR6v01WKndIOdw0QoAlnlfg=; b=iGWmgoEzVQzoDaahGQdNY8tZqJO+QNYQUu3DScOeoAdHJI9lruiLQSU5TnEZwSFe1tuZHjAHue35KuIRxOcp1gunlBEipEQYE7Ke6IPcgHQx+GisqVZE7hf51P2BGgLWlz9hCP5Zlf7JINUbKAiuh1l/DAhbZ++O3H5cP0CH5rvJfkE2KMqqUClP2Mbjq9x00X50MPILU41khMxN5VlgpvsLmMVDJpFe0PqilVlGal1eEaYvgAJMqvbutNBH1AM1GW8jYscvzJxsxgiHjAJjf0ixgCt1+i4537jj2+O13BSq2hDynQpJYntkMT5THnD2xGqYqPIA+eY41j34fFqhmQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result_no_err' function.
---
 src/wispr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index b3fc99949206..bab12400aae7 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1036,6 +1036,25 @@ static void wispr_portal_web_result_err(GWebResult *result,
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
+ *  @sa wispr_portal_web_result_no_err
+ *
+ *  @private
+ *
+ */
 static void wispr_portal_web_result_no_err(GWebResult *result,
 		struct connman_wispr_portal_context *wp_context)
 {
-- 
2.45.0

