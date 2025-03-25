Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E361F0E5D
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878781; cv=none; b=nkCCENT2sm5elQa5GiLOfi2EQbGXwozzWfgN0VjBpuCmLuG2QShFRdxrzbtYr9JSbQUfCAFUpwGUnvQUrdP4H3N44q8gJXgRncH0gkl7mXQfa2Ccy2BztkJZUrhCiFz//qfdCYPzDfG9KQXZEd9PUOtKR/de0VJOeno1R6wwsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878781; c=relaxed/simple;
	bh=fNwq3QZ2ngKEEy9w1YLLqthMnx9Nbn4M4/VGvaPDmrw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJjvw/XPorRNPRL0ndkGmhWYu+rB6gYb2SoYap6MIKCAE15e7+BkfaCVgQMMNIQ7pA50SXzPAQZ6RegOVurYKzwGOLB9rf/IQutnLUrK+vwZKkY5Sh4VS3OqLWizKX4FsIt0JkaYCPwq8qjTv4px5Vfofonsr9cYstEF7o7WDRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=QoDdAGH6; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="QoDdAGH6"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id A9555164AAE
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:32 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 5DD5A125166
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:32 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v4 7/9] wispr: Document 'wispr_portal_web_result_success'.
Date: Mon, 24 Mar 2025 21:59:25 -0700
Message-ID: <09fd61603e4b40bf2c6a5e1202b90670398d34a9.1742878567.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=fyVqVyamCY7N49cxeY36cjcTn7L181ioFANgwmajmn8=; b=QoDdAGH6T2XwyWL7NBqo77tXJMvb15fcpns/4sKK/m0B2IT30b3M9xTRgXhLIE3TZ/ulrY8wR3Dwjv1Z4p9DKiMGlHwI9xsGxNztoU2NmAmQ3Zc8+kt2krOVOhrktHXN9q4tvsgZHI4dfpZrMq7r1gpAYYWczt0SRefwUTYlXk2f0/pMPUcKOM0aKWEAtOpHVnn3BOlo8IVKx0TeYEkNVLv54uvbw5OLua+J7yyGrYFZ5WZPpNw2Rmsy12kjrYB+cImxxdbJAHC2widKdv1mllcvmEynHVbh+8/EAOCWtXlNtanTEp18lFXSw5ziKDTFuWbFnAmOT/OVJoplBRsoSw==
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

