Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633851EC00F
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059597; cv=none; b=KPhrzW4FHh0cd83spq3mqJDCx+CrIiI+JGEvGM/6iO17vKDkxb3xJ7z5tylCkh8e/SMFgfPqg+mdBGpzQUhi0G8VzSMc1+C0q8p+BNKkG5mNJKr1okfg2s8hAnnoHZn2RPsaPOdx9AGpAIKbc5aAtU0pkm9WYcx3pAVjIRLY0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059597; c=relaxed/simple;
	bh=C+2xt599aW9PEaKLAobtBisses3l3Xdrd0QCpe6R8WE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZMFJwkY30AqZCJ2u2HHyV+d7x7gv8qDobtArlNhNoht3rvPmiEhrB+lx+XZ1VwD8IVdQ2SvsLpL6EVzGb0WJ8hkiAOvabQEqBd+3H5zEJXp4oq4PmuGnjiqRZku1AsQbS53+cRamcLeeY2dDe+ep0GkfYTQ/hPH2+STg0occ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=MofTneLh; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="MofTneLh"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CD6EE164B40
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:55 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 7BA121262C4
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:55 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 21/22] wispr: Fix documentation typo in 'portal_manage_success_status'.
Date: Mon,  3 Mar 2025 19:39:43 -0800
Message-ID: <e3d6ab43291ea2d6f2e600265f5b418b5d52fc18.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=3ptnywhKJq+pDBC67xPz8kOSdmy4jo6NnHS1rpxrlkQ=; b=MofTneLhcuD8hzNgmc7MXK3QGfic7dwwATOngzmUYuEj2qo6Bl2jPUe4AyPekJQRsuYfBfqCb3jyyapwNremNrLPsYXJ9mm9OOw9rPCHiNAncsed1VJQ+BdJRJlak4sUrdvWEYJpK4cmX6Jf4GJqtBKLYEea5QrRrFJqTdH8HwJiDkZ1zeMrmYRKMVeLOz5UMY/1pLfOtnyWvY5uM0/L0wj/w/RhWkbCsWuuhIkW97N3oLjJrbPz62Y55m9wJdfD6noS/a5E4VeyinRkgPfmOXZRNGezRQd6hu6/cgOgvhHYOWifyF8Q2M3dhoxHqG/XPohzcrLUMdq9SqGhKAdPEQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Fix a documentation typo in the 'wp_context' parameter for
'portal_manage_success_status'.
---
 src/wispr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wispr.c b/src/wispr.c
index 963454c823b0..4a4688178734 100644
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

