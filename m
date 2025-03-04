Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6678F4A
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050690; cv=none; b=hRekr6+inV8E0VlLqemmsMf7Y6NkJdpGe10Qi9o2vQR0YzI1fT7DrrfsDsw9fd53ueRYbh/KRE2FCRiKWnGCJ4xij/rn/Gaz9zAZZggHSuDConvtUf8m438yWiZaB7aexox2VoxFtSVrIGGU/nS1qgGOL06ssJuSrcgUHr6mVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050690; c=relaxed/simple;
	bh=XX1T95mwvWuXbs10OZ2tWgGrnXoyIQOpfNIkkuz1iCY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4l21/ejkHBf8qCmc07ppY6QNb7l3g/mxthkLtbwnuNfp8WpmP1RtXLQd7Y5PQPXHSCeGo4GYYRpG7NQl7JlNYOq45SpnQI+J4/G+C+XpvNpEswvYLIx/xUq5p7qiOluz7puKNKePKctxm+qVKnxRt3QnzoxXMeLxD1n2f8z/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=J1ii+pl/; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="J1ii+pl/"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 89791164B5C
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:23 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 416F0124FD3
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:23 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 18/22] wispr: Document 'wispr_portal_web_result_err'.
Date: Mon,  3 Mar 2025 17:11:09 -0800
Message-ID: <aa20d594fea53deb897e24f2da6c3ce2a41a1644.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=aHZZKGleacv82JkKdvz7Ahq3dLEI8hESkEDRHkwaExc=; b=J1ii+pl/wy8htKrJoY1TT+oIcE/SQKESIcmNjI48qKKoUs/PKkw3ru7itSLtNvy5Z794xntXzF6WTXQrNMleoCMoZktyelqfE9W00cRS2ni78UUFfslEgi8L9//QMslJvLBJfKIrMcH0gnArJuZ1PjOk8th8gxGZGRR3Oe36eMwqi23LhBfJY734ycBESSJ5ZUcJtxHBg/1Fl+qRvpld20RIwqnIDCVAj67uvGsT5nBQmXjeg1XCR4eLnKYlKnHYKvUmSPdLL/QegjKQge8kb2UbgdwqzpQbZztjUzDZBuZahyFJHwYkIG1OuHLNpCuNd3tkYB9rASQLlc+OQQw/fg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result_err' function.
---
 src/wispr.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 83422c96b50d..0a29303116eb 100644
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

