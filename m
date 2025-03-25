Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9B1F12EE
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878781; cv=none; b=Hlrm3YDTgHRHYuP+h556/MA8UvzO03G6RoytfhTMA9IWFM6y2GQnLwntmhmI7fMR6tih5gcsG8d1YO0ri1lNl8zE2Fdjoy73rG1hD2OZLsN9440/RiwVk6di9WOvpL9HMayK5kqWT+kcNrq1Sh5hmDTX5GM1GtDwqU7OR52MRBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878781; c=relaxed/simple;
	bh=+IUD3Dlucz58jOB0gZ2N6VJ5IefbDkaFQv8FLsgIqqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tClVLcYfqbiW3hn0c8ZHdsD/Z406t7RYkW79yCcNgcyvS3sfAZHjuerVcxbEIsvgyex2p+rV5IKKEm25VJppnBKqE5lUcy362wmxKxwj7qpkWqG4c8+P6FY+uVOfXBN/deTDW0AEipDF0mztq+47kq8xKY+05tVwkX99VeN4wqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=ssLAOF8H; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="ssLAOF8H"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 248B4164AB1
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:33 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id CB9AE125166
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:32 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v4 8/9] wispr: Document 'wispr_portal_web_result'.
Date: Mon, 24 Mar 2025 21:59:26 -0700
Message-ID: <1d017b0f153305e71e22bde372e0e7f2821d8c21.1742878567.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=6O7QOZn2szn4J2MSzFdPDhxp5pOxWmAC7au2odjwO1g=; b=ssLAOF8HCubgwBIsYEIuy/gKmaWlqJm0YO7SEKujv6dmYSIfM7DC84wBkifSpGiHsPCED49YCcP2uE5EbKYYSTfnzRO32kOPyUOrdc3ayDumko9j8882ttM60cxfwcdQXvQ3ErlSJ56k8TwCatuScLgLHjCC04GqvKMG+S8S8yqVVPH5UDqYA38CrVhHMBtN9k8c9Olz3LRA8kX6vseibTH7xTjZIfyRU5iCutOSYmlajCTvdrv8X20od/eGdFqfpKy7HADrNyg1l0Rr4Gc0LzPkjHTKEDirg6mU05OY/MK1HBZeJRtZoFoUKy8UF4RpunqHWvYpg51ZQEsdGaVRgA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result' function.
---
 src/wispr.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index e69e90551979..913c3135fffb 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1148,6 +1148,36 @@ done:
 	return;
 }
 
+/**
+ *  @brief
+ *    Handle the receipt of new data and the potential closure and
+ *    finalization of a web request.
+ *
+ *  This handles the receipt of new data associated with @a result and
+ *  the potential closure and finalization of it, if appropriate.
+ *
+ *  @param[in]      error      An optional pointer to the immutable
+ *                             GLib GError instance associated the web
+ *                             request, if it failed.
+ *  @param[in]      result     A pointer to the mutable web request
+ *                             result with data to process or to be
+ *                             finalized.
+ *  @param[in,out]  user_data  A pointer to the mutable WISPr portal
+ *                             detection context associated with the
+ *                             "online" HTTP-based Internet
+ *                             reachability check this is finalizing.
+ *
+ *  @returns
+ *    True if web request should wait for and process further data;
+ *    otherwise, false.
+ *
+ *  @sa wispr_portal_web_result_failure
+ *  @sa wispr_portal_web_result_success
+ *  @sa wispr_manage_message
+ *
+ *  @private
+ *
+ */
 static bool wispr_portal_web_result(const GError *error, GWebResult *result,
 		gpointer user_data)
 {
-- 
2.45.0

