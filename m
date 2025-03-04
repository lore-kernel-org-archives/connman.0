Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348E3A8D2
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050687; cv=none; b=YZTcAPmjP+QzG8RgWZlkLNFUa/Wu9yjxhIUTV5GZWpQnV5I4BIY/dBKKG8IDCWz7nBhHHdiasGAxvJpPoLd1cZB+02RdZVeVU9VFCQa3n3nfIZ1JtO0cKLiduu2b2WekwLtomn4Me0bTzeNtjL8P9G21bUETk46JRq5ZF5mQX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050687; c=relaxed/simple;
	bh=lLyTWXL7x79r/g3/wtbcMIIO+tOP0FnKtNylLgg+43o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGZsnhLrgTw3tA2brfbh3YhbSFHTPd/CfcsNWM/IZKLdDzFdZx1jvXJyD7m0+2Mt2WEzLdXfQrmWha21VXg08iT0yM7w3FtTHcecPHVBNfuDhPTsKSgC393QGRucsdE96H2hYZbTtzLAnYukuhLBptYBjnAU0neQoFddfgNAnQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=bKcJfyWb; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="bKcJfyWb"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 00FAA164B55
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:20 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id AC5BB1260D5
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:19 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 10/22] gweb: Add documentation to 'received_data'.
Date: Mon,  3 Mar 2025 17:11:01 -0800
Message-ID: <0c04ea4d681879ea0fda5fa1e9c3e3a4d5543aee.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=8pFedP8XBuzudzXzX7zlchwUBRSP3uxNebmN75a3eto=; b=bKcJfyWbhe5TccclEnf8aAO4NwfcHqM862IXmTnOULf1q6jaqPTsJETHQORcuK+3jLrmexuDaIqCexUjZ8DsA3p9afqJH+ckjH022B1Z4baG+IVUKGNDJbY+apK4ANaCnBEhpZQObwaz8rEZFv41S90KOgFlF8JRUwfJT8PQO1c5Df+S0BNAwtwck2cO396k1WIyIRFbldfhxX9W3XxEWjueLUHL9DKqb+cgmOihizfjkTDqC6Qsk1+mLxVCDdb3y5YpHGbfPiz2j2Z4Tvo9A7XeCMBMvy2V0mFJC95oPEv6OVQ0lYmERpJdr/+lMGQOlH9eBJagUPSnxpagnQt3Ow==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'received_data' function.
---
 gweb/gweb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index ec72cd417a9c..78d4fb0517ff 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1234,6 +1234,28 @@ static bool received_data_continue(struct web_session *session,
 	return TRUE;
 }
 
+/**
+ *  @brief
+ *    Handle a glib I/O channel watch received data delegation for a
+ *    web session request.
+ *
+ *  This handles a glib I/O channel received data delegate for the web
+ *  session request associated with @a channel.
+ *
+ *  @param[in,out]  channel    A pointer to the glib channel that
+ *                             received data or a condition(s)/
+ *                             event(s).
+ *  @param[in]      cond       The conditions or events that
+ *                             generated this delegation.
+ *  @param[in,out]  user_data  A pointer to the mutable web session
+ *                             request associated with @a channel.
+ *
+ *  @sa received_data_finalize
+ *  @sa received_data_continue
+ *
+ *  @private
+ *
+ */
 static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
-- 
2.45.0

