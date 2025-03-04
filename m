Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184678F54
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050691; cv=none; b=VvOsN0oYCm/mr821BFPKtaH0HzT23uvUIk6Zk3gtfuQ7bQ3jzdZhhS8W02RvmXx1evYZLblSdu6wIJ58L9NPjFWrc+F0U3rberC/7m0Kyev8B1ENAgUFUm8vkYm9bo69nxEr/FcIt6A50D8gtr9zyopOblZVf3iiN59kVynKSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050691; c=relaxed/simple;
	bh=YbAUPjldnLPUCARNckCZm0n5v+Lyah5w5BhUerVg3+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Usbk4/MzXDpoLuwNjK1EroJpqEXAbMDMezyjacdpk8R1NHpyVyZ5uxkg755vVk6M3MFe57IqOq5t76O/ljU5iqPuFUs4RXEkQrTiYdr9PDDLcTV3RlY50wlMu6/5y0NT25Zxlk6NMflgjJ5c8geA7O1lpfInvHWn8f2uKenVej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=rpboBhWs; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="rpboBhWs"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 6E261164B5E
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:24 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 25129124FD3
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:24 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 20/22] wispr: Document 'wispr_portal_web_result'.
Date: Mon,  3 Mar 2025 17:11:11 -0800
Message-ID: <969196ef7e20566d13ce4b04dc29709f8d0dd020.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=1CIgFa4WJtqIgDXAXN2a7UnSOHe3saxlzlh81eJ1oVA=; b=rpboBhWsWoKZRC7j+tfR7AZzea7jcWPZWnl0Yi06CNb18tEUNTsM2nm9nHZ4HQKthkX+DA6TtWMOD+2KXa7dU0zIDyCF7p4nWvEpO9sQ7XhEDDJEG0eDkCRaTtiUs+1U3zivR1gUALV7HgphvTeu5LoKpJEgfOhO0678Nhvf2IbeNS1eNhpyM1v3X0Wkw1egY3DR4hXxf0Mo7Hs0CgQTjVO8nFhckZcesFZVYfFgb/W7mB0D9w9KA6S+cGqRkpdLy8zenys++U9lL3HTCiRBaswzMjSfzTctXzZt3YixsonmCIdkLs/B58Iy8SmvxGX0TLuQ+93Tf5cpxaCZ1CG4cQ==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result' function.
---
 src/wispr.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 004227d5f1c7..4abb8f071352 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1145,6 +1145,33 @@ done:
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
+ *  @sa wispr_portal_web_result_err
+ *  @sa wispr_portal_web_result_no_err
+ *  @sa wispr_manage_message
+ *
+ *  @private
+ *
+ */
 static bool wispr_portal_web_result(GWebResult *result, gpointer user_data)
 {
 	struct connman_wispr_portal_context *wp_context = user_data;
-- 
2.45.0

