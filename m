Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC521C19E
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513965; cv=none; b=E471PokTifwkohrie67i8aslMXhcsB9oN3Grky5MJl3G2CL0ceI1X3virZutO3x+2AggJMscCT+gfRbxrNtfGMTb15glvUMv5HBZNtax3J63eoNjOQFVm2xFdwlkTMlgOYeSXplyXIz0EKZ3V0ZIzqeXnIMy4Ljvt/EmyV7fsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513965; c=relaxed/simple;
	bh=SYQMtG2riBuMgra4oMSpaSZFEfLU+3l8+3F7cmdi4js=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrGAT9rWhUq+zeWn8WAe6vNUasgO8zvtge2A6BtiG6RRLejKpizFPER6c1X88OpMj2oIAx7BIhfrgikhO8SnJJzIbFkXc3SAxsFMrIq4piIoh5LfooHT+TissbIaA4JoHCzE0Z5B8iuPlV6Zub0kGwDouhTd5LnynRgMUewjVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=NivJEPcD; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="NivJEPcD"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 1835D164ACE
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:15 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id C000F125183
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:14 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 08/18] gweb: Add documentation to 'received_data'.
Date: Thu, 20 Mar 2025 16:38:59 -0700
Message-ID: <3a0aa0f1a0b48643f66a11c5b3e7fd3753b603d5.1742513884.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=gAQZO1U0eymqnlX34mIbwGiPSY0rk92CUhNVlZX8LDU=; b=NivJEPcD7B40X2lAg/+U9RBk09TfjMD2RT7/iTe8SPGr0gycDrbskRjyeWWZTZL77DLzXdK47L9z7qKByrmKNPvecJx1T5RyA+FZrQcVKJJ03Gi/TqJAFnX4jEF3jG4hYr7emMYs4wjPf3QbqdcJHEVFyj1NXKvtexj3WFelPqVzzzkxMCKZ6/HzIvI/uHqbBDhCS/TWenZe7mH0/bV6lkxT8Nesd+G5bq4wdaRFU0+qywB/bYGJWFXGcYet5zCfcxHPeIsacB1q4VfEzA0+qAuuq1b8JjTP4msKOA7XGlHi1PdoVkVBLCb66gT1cLJP+WzUY0SJSYsqEpLHvBFSFg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'received_data' function.
---
 gweb/gweb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index c22ca8ef0aff..ad91d782e6e4 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1227,6 +1227,28 @@ static bool received_data_continue(struct web_session *session,
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

