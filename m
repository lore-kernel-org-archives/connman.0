Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1601EBA07
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059593; cv=none; b=nCCQJXyQBGPx4XcebTgn3Q/OLI+a+ad1pasIw+4Fe+NCgIbGINDr4yKRiCUKlwEkU0JIPU+cIEBLWKWv6gPl/U1jhsOmxvmcmm1RhSMyGnLqLydk7TaWPoaHKICil82ByJS0TNaRjP+cYph11T/rj8awUcT3R1nKcSco96WQpM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059593; c=relaxed/simple;
	bh=lLyTWXL7x79r/g3/wtbcMIIO+tOP0FnKtNylLgg+43o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeK5eI/iyw1ZkHK0Anj4kVh5OysNtx+8PX6eCwXyLFqG2IWcgA8z3MJjW+KACxG3YzD75xaSGaYWVozcXdeGcJyy9zI1Ezqb/1keuKY8CXkmZ9RvpBFf0B0UfTqGk7S73HRz+d2wy4OAxj8EEj17or7AWPNB468RQ3G0+N+n8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Igl52nnx; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Igl52nnx"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id D6FB8164B43
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:50 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 8C698124FC9
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:50 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 10/22] gweb: Add documentation to 'received_data'.
Date: Mon,  3 Mar 2025 19:39:32 -0800
Message-ID: <0c04ea4d681879ea0fda5fa1e9c3e3a4d5543aee.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=8pFedP8XBuzudzXzX7zlchwUBRSP3uxNebmN75a3eto=; b=Igl52nnxcRGlUbZrijoe2aJw5PrR8lJvqn6cNEHAORqjCFtorUF04C+W8mJ5+sMwaI0ZMMBSCKBgz+bI2Z2jf0xIPL7tCL2ek7ViwkoRS+ZTTdCB8nfaqiDQRuE9HhF7266yRdlzUg/ZdOTPPgsP6bjSWQFwaKMaOiP/2Ksz00pZFMXIiyfO3CwBHMdFYyjMLIWMnB0ivU9j+Wo4cDM+g+uIli9puQS54ecXhgnZ4II8n9+JoufB12aAXwkAz3II9BY4gMnP/xIPRtwu6JFugl3GOtoROalsgZFDSDdd7jC/1HtBS7BuSG69dLz8O225Nzg1aQHkuW8A7U4GF9Amvw==
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

