Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5D1EE7AA
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059594; cv=none; b=PYTKkViFC3gxDSgJ2l8maW6/sCoRkS7Mfbpe1iC93jC42pDt1Exk8cvE+/S1Ei96TtD8G0a87Ab0QSBIWv4MobX8/FdmC4WkODEJ3f/rzUe0gy/3EN8PA6X3ulX6m/m2UYougu5mR020nM85scRZsyyo71jrQb2CvbTM+f0A0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059594; c=relaxed/simple;
	bh=qs5R7JB5PHvQNbpmDh3U23jml50Tl3iuv4oBaHA7GeM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT5NQfzcwCa2AeCmeeRXdiz3ew4bOfI+23/+JV46fbvDmryzOePJoS0/2yHzZp+XNXqfbJXWegZ2oajRQ975ZPOociGroSdGeX3jhBuoYmvdnfgfxOeEbkDW5x0GP8nnsAsIFn/UJLGvVHbKxbl2xpo/wFXUN2ADLL8lBm7MqqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=fMhGD9t+; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="fMhGD9t+"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id BD4A7164B4E
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:51 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 73FF8125163
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:51 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 12/22] gweb: Add documentation to 'map_gerror'.
Date: Mon,  3 Mar 2025 19:39:34 -0800
Message-ID: <e2baa4014772fc6c9ca52543a4c2d10139776a7e.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=iEOz9EaCgAx7IVywMFbcNPzXGx3AgL7YsYQhDq84H48=; b=fMhGD9t+tb4t3Lcit5PrnwPPkvcCsqJ+0WyBChZsNixh/+QSAUxjDJKhpJzhbMuiqpfBzHqUv45muPcUE7qPHoYcjCiNUG2VxaJUb7dLJ/VESuYgIjO7k0iJtQnEQPFrt/+My2VCrGg/28ERwZAEAH+0bGEsY+Z6UguZ8Lw9DkmxLyGoihVowRE8EuHi637b7gAqFRxYfx43lDl4//V8zNOw+fdCOvNkeX2YiD0o9m0BrUj4wP+RRt7ZVPxoyoLWWt5OFaJgB0ZtjmZx1ZFa0gOqlEgAjoiTs7zPwBFkGO2wwaY01Y3HaJtqSMshXrbUkbWnZokfbvMFJCh0oPl7gA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'map_gerror' function.
---
 gweb/gweb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 4a402ccfc346..12fe682cedfb 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1130,6 +1130,20 @@ static void add_header_field(struct web_session *session)
 	}
 }
 
+/**
+ *  @brief
+ *    Map a glib error into the negated POSIX error domain.
+ *
+ *  This attempts to map the specfied glib error into the negated
+ *  POSIX error domain, defaulting to -EIO for unmapped domain/code
+ *  pairs.
+ *
+ *  @param[in]  error  A pointer to the immutable glib error to map.
+ *
+ *  @returns
+ *    A mapped glib error into the negated POSIX error domain.
+ *
+ */
 static int map_gerror(const GError *error)
 {
 	int err;
-- 
2.45.0

