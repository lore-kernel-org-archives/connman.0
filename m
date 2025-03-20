Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B421ABDC
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513966; cv=none; b=TdK3uX4xh+Y17KKWUNhiVm4cAK+UyqISbDIu5FM2ydNkKWmPbk7cWUv133yXDPn6gzXEgpMxw+xBwFYV6dFVwPnFKHJcMuXlh6LXx05+C2+vd3kSHiXrKP0ThZaf2BptvpMHJnQS6ZzbNedYbE4WqlwrgvZmH20iEJ+UqCKsiY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513966; c=relaxed/simple;
	bh=fNwq3QZ2ngKEEy9w1YLLqthMnx9Nbn4M4/VGvaPDmrw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHhlUwpk2kzrAc96Prvy+DmhcHN/nFzlrxAxgGVPfpo35yn9Cqo1ixOoG6tqpLdPTEsN7Ds5wdRV05cY3VTqRQ0gLujJAp5If+kvYsf+5v2l6Cs/rtmCn+mWC+9l7YZ8WJXXltbtAfouWz9nDGjKVUEWEDCZWxadiOiGLYebB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=BLv7PC5x; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="BLv7PC5x"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id AB687164AF3
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:18 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 60B84124C0A
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:18 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 16/18] wispr: Document 'wispr_portal_web_result_success'.
Date: Thu, 20 Mar 2025 16:39:07 -0700
Message-ID: <580078ad4c96baeecef17e2b362286fbfcf2092b.1742513884.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=fyVqVyamCY7N49cxeY36cjcTn7L181ioFANgwmajmn8=; b=BLv7PC5xTvEnI03bIPNGM12F5WAKTcTHNkW9HIreOIgTbzC8Ez61KM+ftfCAs6F46gdk0TVEyBnpAmcg6jhQ+JWGbA/WSJIw6N//PQ7S495RiZtfl4j0rHICpbylminNz1Urh6lz1xdVW6RGQ9q6XfWVx426tPFxNbs/LdHZ8ximY7a2vtz9tfKshuYdUVm+H76ktlw9dRAI2uzD87upT+yZhLW691BBYbAVdOH4fmbIfFuckpQcehiT5K2vpe8sIJOYRT2tmBbnbmCGbpKuNLwAm1GZZBhHHwl9YGEjtnwHlQqt/V4n8S3pDniDu7jP65jNRHpmOM/ZcwBuIwiNvw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result_success' function.
---
 src/wispr.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/src/wispr.c b/src/wispr.c
index 76a7ba219921..e69e90551979 100644
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
@@ -1024,7 +1024,7 @@ static bool wispr_manage_message(GWebResult *result,
  *                              finalizing.
  *
  *  @sa wispr_portal_web_result
- *  @sa wispr_portal_web_result_no_err
+ *  @sa wispr_portal_web_result_success
  *
  *  @private
  *
@@ -1039,6 +1039,25 @@ static void wispr_portal_web_result_failure(const GError *error,
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

