Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA878F4C
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050690; cv=none; b=Udwn9laxcJUZGOtwph9Prf3NpJuN86ailwxCzo27eZfEHx+WifX4i28zrt2VyjkFyeDMc07IaziX6aYppaz5EXqcvYqVxdLzg8E1b/a7e+ouVIdfizFfkFJTwzyOsaMQHZ4OVFj2jrcAECF89GOTofTaAylpEzu6x0fsWRM6Zzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050690; c=relaxed/simple;
	bh=U3KYwO1Rtcp8+xN+QuOdp/29DrtAC3bS3WGl/lIsINI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqZjX3yslTozW/loQ/ppb9CeZB5NfptAy0Vx4OYCBfbchJwuRb6bbdfx8S4Ydbs0MdhqcQh17/sHqRi1fiGdfn0zz+1yHVln/Pais1Q5IGSqSz1v6aVxLxHESdmIs7EXLgXTtRoxUpbU6SEnzgXawmJt7YlxC7Z1XybWG4rLEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=RabdN2ay; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="RabdN2ay"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 1DDB3164B5B
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:23 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id C9C34124FD3
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:22 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 17/22] wispr: Document 'portal_manage_failure_status'.
Date: Mon,  3 Mar 2025 17:11:08 -0800
Message-ID: <87d043db5ae7bb0c55ae4c00a24ca8dd813ca7cc.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=k5J1l7mFN93UAHnz15FMHUZ4cJNt8weXt4+Lpc6tgdM=; b=RabdN2ayTSnnbKGV2zAG7dMhKpsu8KEPwD7EDAXa9wv2RldaEwf/qpnMgbNd7DLE7A1Pqt9zVf1Z1zfEIh0YMaMrK2mR5v2JI6eULDtduV44TQAMXDCBrFGPJU5CelKeoYjZACMbQp+uNoRcydDfzwkyZFLDNJ60I4OhGRxU9DeQXVhRHbBQSaicvDWDhQTNbGv92+qB1+1k/pNARjH9Ed40MsiWCdKv96pN8TMwEf9rMk34pMMH9t2sCDbuGpF/4jpPcIQjy2bV37y1TD4yCk5+n2h0t++K8FI/9f708xNRccf8O7n3pvKP6dlRBOQ7e3EH1Z2WO2nSSJ7fzW5Wsw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'portal_manage_failure_status' function.
---
 src/wispr.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index d1d49704e5bf..83422c96b50d 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -633,6 +633,34 @@ static void wispr_portal_error(struct connman_wispr_portal_context *wp_context)
 	wp_context->wispr_result = CONNMAN_WISPR_RESULT_FAILED;
 }
 
+/**
+ *  @brief
+ *    Handle an unsuccessful "online" HTTP-based Internet reachability
+ *    check.
+ *
+ *  This handles an unsuccessful (that is, either completed with a
+ *  non-successful operating system error or with a non-HTTP 200 "OK"
+ *  status code) "online" HTTP-based Internet reachability check
+ *  previously-initiated with #__connman_wispr_start.
+ *
+ *  @param[in,out]  wp_context  A pointer to the mutable WISPr portal
+ *                              detection context associated with the
+ *                              unsuccessful "online" HTTP-based
+ *                              Internet reachability check this is
+ *                              handling.
+ *  @param[in]      err         The negated POSIX domain error
+ *                              associated with the unsuccessful
+ *                              "online" HTTP-based Internet
+ *                              reachability check.
+ *
+ *  @sa portal_manage_success_status
+ *  @sa wispr_portal_web_result_no_err
+ *  @sa wispr_portal_web_result_err
+ *  @sa wispr_portal_web_result
+ *
+ *  @private
+ *
+ */
 static void portal_manage_failure_status(
 			struct connman_wispr_portal_context *wp_context,
 			int err)
-- 
2.45.0

