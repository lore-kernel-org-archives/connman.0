Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1310926AD9
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059596; cv=none; b=LVVSnpzMwWhzIw6NFXKokEcggqhUOWvzvbbX/FqzHPLeYPmq/v0yL2tV43SvE5jeXg3mD8fkvmsV5hog7z2uQIbIXMTPeajHA0GnRuHvkv6mNx/GhV/W9RKVvh641iZe6/V6UTEQh/C1AsMZqGCwAvAj8PHnJ8MsA9uy/rDHGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059596; c=relaxed/simple;
	bh=iVyPh10aaEerxAQ9vreU+OC6lYrjrkqBt5wWfIseAt0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tx1rjmtOi3YeZkL0WWVTFXpjN2jJb1A5wUYwbCLP826tjzvtxGn3LQIlbStfG/w6IdGTadP4VU4WDhvhHeQzDdC/dRraUtJAun/Uo3WR5fnrq9aE1bPv/KRDwDyCwHUTYeH17EeCVeJxyz5u0FBnhR/UeNaRVwFi/RwASUV9bfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=HSyoPM3V; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="HSyoPM3V"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 7255E164B4E
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:54 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 2A73E124FC9
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:54 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 18/22] wispr: Document 'wispr_portal_web_result_err'.
Date: Mon,  3 Mar 2025 19:39:40 -0800
Message-ID: <2cf56e52c1a64301782ff0d8e2966486c3d92d8f.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=khrDj1n+Gm/4/L3ggj06a+R01+UaoKO4mWmdwzUHF/k=; b=HSyoPM3V4HTL0J+V41E28N2rasyblzUMdOj93+Gl/T7f8Oc1pOevxFyomewjnFB1kSReOgCX+2aDFtRJcOAQ6ckvGVuSerB9iU5GrHX7GfdyzyLc1VGJtdTnswv7c07HIBN5P9NUD1Hj08641QK+0c/0uDErFrhd3AZUlRsw9EG9P+f8PhLFkJxH6rtzG1E9WahXYPAbbyYVjuRGvQ0eXYQBD7MaEbG7fLmNFSNNy9I3k/TL4OC3xHoWHaIcUPqhWPyINjFr4w3ZmTaExBb+Wcssx/OJuo7FbWR4AdDuS7IbUfK82fupUGD/xc7Ggdqo4joyyT/lGRZoa9MWdjmlFQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result_err' function.
---
 src/wispr.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 18930aa3a0ea..b3fc99949206 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1003,6 +1003,29 @@ static bool wispr_manage_message(GWebResult *result,
 	return false;
 }
 
+/**
+ *  @brief
+ *    Handle closure and finalization of a web request associated with
+ *    an unsuccessful "online" HTTP-based Internet reachability check.
+ *
+ *  @param[in]      result      A pointer to the mutable web request
+ *                              result being finalized.
+ *  @param[in,out]  wp_context  A pointer to the mutable WISPr portal
+ *                              detection context associated with the
+ *                              unsuccessful "online" HTTP-based
+ *                              Internet reachability check this is
+ *                              finalizing.
+ *  @param[in]      err         The negated POSIX domain error
+ *                              associated with the unsuccessful
+ *                              "online" HTTP-based Internet
+ *                              reachability check.
+ *
+ *  @sa wispr_portal_web_result
+ *  @sa wispr_portal_web_result_no_err
+ *
+ *  @private
+ *
+ */
 static void wispr_portal_web_result_err(GWebResult *result,
 		struct connman_wispr_portal_context *wp_context,
 		int err)
-- 
2.45.0

