Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15FA86337
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050690; cv=none; b=QidC7es86zgU+8zJcB/VumiDcHGt/525WsjV08qePPMwJkcrjLS4xjMXIx0Qjq4mU6ggrKGz4T7XUKM/30rbDQrSnO/79ekPPjA6e4T3bg90iMw/xkBZNvAQnkQrZLT3jLXuJYmdkGAy3TnoIJ+NmXbRTH0KUeKwAIS/ysAp6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050690; c=relaxed/simple;
	bh=DdMIxGVqO/dUphThZE8HzMbcWm40PUUlhhVyN/krUd0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOrHAuCqv9MMMmAiQueHdwvw7ZczPHtzVnYwuYLNKWHP581UT2BO84bXN6C8pJWlhCb/vviug5RV/udqeAHyST6cBj2R5ZNWEAvC24uAWM2Rhfubkk1qauvfrq3FipOHTRM5z7sBMM29CZdi5kJ2iCsSXBLpi5M4dfd36d7sD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=tZvlY9a9; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="tZvlY9a9"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E3529164B5F
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:24 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 91CE0124FD3
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:24 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 21/22] wispr: Fix documentation typo in 'portal_manage_success_status'.
Date: Mon,  3 Mar 2025 17:11:12 -0800
Message-ID: <9bec40acf7e63c782fd8d7159eb0d9297a8bfb1b.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=fu/ivN0hPQqSvO2dvECmWf4vSoj9SvDa9g/bGMwu00w=; b=tZvlY9a9wSbvmSYpZIu6qxHB5c/ABSBPkOGLTdDIIP+wpaQIF/SS+M7FdsG1JbYRsnNqCd/i5dV5xYGSiPUyfvWAZXvabF48PWLxP2BhdlbEf2IsYnuw08CyGKj/3cGyQUUE4xFLvsYwcET2RTSXPOQi7Yeik3or6123YliRfHVSzcWHWBoArprBCoffwH7Y4XfiI26i3kj2orMDF3e32OSLjGOSnGr4Vx9wV6XtU+huFpLPy0ZGztHIu8QYjmsEmQ157+BtDNFfMNXi3/p46Xbyf8pamE6IlcR2BS6GNGrhwWVu5EAjXwN0Uh1IZwTpWY2JGdt0zHz4DSyPNboM2A==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Fix a documentation typo in the 'wp_context' parameter for
'portal_manage_success_status'.
---
 src/wispr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wispr.c b/src/wispr.c
index 4abb8f071352..49801b015e30 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -685,7 +685,7 @@ static void portal_manage_failure_status(
  *                              Internet reachability check this is
  *                              handling.
  *  @param[in,out]  wp_context  A pointer to the mutable WISPr portal
- *                              detection context associated the
+ *                              detection context associated with the
  *                              successful "online" HTTP-based
  *                              Internet reachability check this is
  *                              handling.
-- 
2.45.0

