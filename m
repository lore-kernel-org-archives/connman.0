Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BBF1F03E8
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 04:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742878779; cv=none; b=VSwnxwqsYEzK13FEaD0Hz8MoRfe7YExNZLzpWmbxpU6mohyH1w5DPFEEGcrcDRZHYEnbpNTXLX/XJSPsAMN+73+Xta7erxDuCrqYL4UKOmckoqw+Z5BzxCJXDEaGnl9XXQ1oHkiVKwaZIlHsOamFEBnd+rKn6IodNxgSO8eELCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742878779; c=relaxed/simple;
	bh=YT2il6FNQQPaQpQUdm/poun2Cp2F3fPyZ/aDFUjEAhg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C46rqATiEOwCV/9DOk/yGRH3+CYT7oTXt00OzXkMaWc6fRViVtuHApu8u+dCGpmf/He/3pyXz1gwT8T1Z1e3qe5PJoQJK5mz9B5SRMChnJ7eCuG4Mby6hWcB4XFyDmtjPR8kZ/dGC2xj/Au0yFOpKZwEYiAxVQWKv1qtOT5BrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=NJdAKA6T; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="NJdAKA6T"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 4D91C164AA9
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:31 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 01F6A125166
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 00:59:30 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v4 4/9] gweb: Add documentation to 'received_data_{finalize,continue}'.
Date: Mon, 24 Mar 2025 21:59:22 -0700
Message-ID: <a1c434d58f4bc8bc1df5299e087fc954fc037351.1742878567.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=I2IowPLQfgp+yiKEknGb8rvepB+LPdQxhdRcLimpV3s=; b=NJdAKA6TznsJ9SOTVCCLjiQtaf0ty4EGEGIJi46RGwfb0glByxvyleRlzc+ONnh9TNxMiH1rCRRVMLgUbgelYSykurXO7FLMB7Nn3bLPorgxxhRRC2l1QvLQLeukMpKbYTHP/VDJciEtrb8vybVdrluzK9esYqVB1JEkvtUsUfeNICjj69v8fWeP1xXbYqvKFK/ybZkbvn3cpSLYSeGm9CgJ3K5qZLAED44VbskBKMR+IFHkaEJHt2wr5i0j4w8t8U6yypcdYH2YW/V1rVl1b2lsLL0LMREMuH91CqCi34ra6Pbf/rXOKlIvStC0FH2fuFsVktMHHPcXaUpZ/XAMaA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'received_data_{finalize,continue}' functions.
---
 gweb/gweb.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 10f1cf1df0b2..c17475c5b8c1 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1228,6 +1228,43 @@ static void add_header_field(struct web_session *session)
 	}
 }
 
+/**
+ *  @brief
+ *    Finalize a glib I/O channel watch received data delegation for a
+ *    web session request.
+ *
+ *  This finalizes a glib I/O channel received data failure or
+ *  success for @a session. This assumes that @a status is either
+ *  #G_IO_STATUS_ERROR or #G_IO_STATUS_EOF. #G_IO_STATUS_ERROR
+ *  represents an unconditional failure completion. #G_IO_STATUS_EOF
+ *  may represent a successful completion, if it follows one more
+ *  prior received data transfers for @a session. However, it
+ *  represents a failure completion if it occurs prior to the receipt
+ *  of any @a session data.
+ *
+ *  @param[in,out]  session          A pointer to the mutable web
+ *                                   session request to finalize.
+ *  @param[in]      status           The status from the prior call
+ *                                   to #g_io_channel_read_chars used
+ *                                   to determine how to finalize @a
+ *                                   session.
+ *  @param[in]      bytes_available  The number of bytes advertised
+ *                                   to the prior call to
+ *                                   #g_io_channel_read_chars.
+ *  @param[in]      bytes_read       The number of bytes read by the
+ *                                   prior call to
+ *                                   #g_io_channel_read_chars.
+ *  @param[in]      error            An optional pointer to the glib
+ *                                   error instance associated the
+ *                                   prior call to
+ *                                   #g_io_channel_read_chars.
+ *
+ *  @sa received_data_continue
+ *  @sa received_data
+ *
+ *  @private
+ *
+ */
 static void received_data_finalize(struct web_session *session,
 				GIOStatus status, gsize bytes_available,
 				gsize bytes_read, const GError *error)
@@ -1286,6 +1323,23 @@ static void received_data_finalize(struct web_session *session,
 	call_result_func_failure(session, passed_error);
 }
 
+/**
+ *  @brief
+ *    Continue a glib I/O channel watch received data delegation for a
+ *    web session request and process the data from it.
+ *
+ *  @param[in,out]  session     A pointer to the mutable web session
+ *                              request to continue and process
+ *                              received data for.
+ *  @param[in]      bytes_read  The number of bytes read by the prior
+ *                              call to #g_io_channel_read_chars.
+ *
+ *  @sa received_data_finalize
+ *  @sa received_data
+ *
+ *  @private
+ *
+ */
 static bool received_data_continue(struct web_session *session,
 				gsize bytes_read)
 {
-- 
2.45.0

