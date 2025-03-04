Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402278F59
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050690; cv=none; b=bj6hUEcRMKmPAyK6tglIQwzsWrHtQbBH7+75lPi5fn25oqL3bYn+OFQV/xaBZDpBtEnAwKYWaVtdfjJ40eAXSWe9CtKSyNjB8qhAf2Uyh7J2hTJTyYatjddTtkb87KZXoqnNTyCy3RkIhzzYtsSW2/T82gEKI7jl/5DFJxt2zP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050690; c=relaxed/simple;
	bh=odnLORuzSz53Yv+gVZyQWhDL1a0anUDWkbDoNqjAbIA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0fZTUcVhXvZWeXbi0674iNSXItAZ5CJwMoL4nHZmXhp/HP69Ng9BW60Hh6c9AcnVwiwMdNMgI0hyeUTPWi8MrA+AuER6a7Q/41EZsb6n2RSBeGfKnA6Iur+MtTAWCRF4y9Z8gRAboi4f/SOfORK8KvTyLIHFUoTP3L896y7Jig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=mjge1j7+; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="mjge1j7+"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 017DF164B5D
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:24 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id ACFC2124FD3
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:23 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 19/22] wispr: Document 'wispr_portal_web_result_no_err'.
Date: Mon,  3 Mar 2025 17:11:10 -0800
Message-ID: <440d5f9ab1612ac850e5a6d9a4b485e3c49d097d.1741050622.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
References: <099f9cd55983495c71a47a68f402720c6b3c4cab.1741050622.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=6rM4L/QiLHjyyjDPcx84RyKuB0OvHA7ofQO/OSzRbSE=; b=mjge1j7+PVSUWJRgZt6Yb6WPpmJaJIzvIUjI0dR7fL8INevVPtg4dAa0vStLRU2uSBV7+SWB7eT9AWiiwN20d/5OoPBvGByV3yhzqoXzqvzrGnWJ0MRwZguyewTFM3UBlVe62M0uqiwtyFC2hwLA516SrSxYv8sWqVNossDqzexXPGgG6IlzwiKH4K6YHfOfKsm3QBy8oXSgbXveqcQVWTPD5RvtyZdNLzDqAwj7T/6qzB3JvkcWwGaJVBsuEB2bcOQ91Y3zqnkLPPgWCfCHQTod9cG/MO1CgN6ismRXr+v/0Zjs+i4LAcYsbktr2pHPsVIXuGDNFKRCr/JFLlLe6A==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result_no_err' function.
---
 src/wispr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 0a29303116eb..004227d5f1c7 100644
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

