Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33810227EB2
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513965; cv=none; b=Zi/ANhazqa1BqDBRpUjzLMFlJU3OeRdxS9LVLcbGvc3nqNpsie7Y6IDhqK2vXkm/T02Ohq7JkjFLb+LkOPtCNx4JGFQoZoit7kj4sNomHFfHhd6BFvpMmqX6FhlLOlWLX2B8wQ4B8vqye4WmxdwfI+QvH0ZkJLqW1p4Je0eRMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513965; c=relaxed/simple;
	bh=+3t1T2SNFSJXWyp4zSS3rpp9DEpOobuhRj5ymcOWLJo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzcZENtzQ30YwMbMuxkNCZafOzPX+ZgobL19V56a+5RUN0b5XvXSvhV4QvvbeyUWkk+Wi5DFCIu8cDjg0vcIZTFX5+Iwp+kmVLo2PqyzLXCl6b23K7lxHGdVEpRxb0cipSsCoM9kcbPi/cCnA0yelL7ZimF+LC2V5fbT4sBJPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=F56z5zv5; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="F56z5zv5"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id DDB11164AE2
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:16 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 9301512635A
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:16 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 12/18] gweb: Add documentation to 'received_data_{finalize,continue}'.
Date: Thu, 20 Mar 2025 16:39:03 -0700
Message-ID: <f8ae6ba80ec3496f39c9eb51429fff6574802109.1742513884.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=/FTxVsuyjH5E/J7mdnkfR0Dfhvu308iR2Ol+nFlSj30=; b=F56z5zv5nYvxEuHE8aYxojtfk9kjMpAjwajCSRjig6Hmzz0tvafplVgCW2TGU86VldvueGJUfE4DwUZGzklQgnOa3Iv7v+JGRm5F68zbTZDxawLcYCUIOnsJ6QNjXgChFFaM7EcXs0bQY0g7IBcc7sP6zpKeSDeoQIafzRPtIjEcHiPjy+fPYFGtan7gFs2mJhmBXDIR6Z5XgtP/4g1LpHzLROmVm+fK4+K4VB+KB2DJPZPSfO8X3gSov96s0s7wtXIufyhtLEiPAh5pVNETWAaXl6ReNF/zX6qceAyhIC2T8WqQEk81DinRbWxy+FB+x31CPQhS2FLGwltpHN/6xA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'received_data_{finalize,continue}' functions.
---
 gweb/gweb.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 6d517f9467bb..b0f2077a176a 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1202,6 +1202,43 @@ static void add_header_field(struct web_session *session)
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
@@ -1263,6 +1300,23 @@ static void received_data_finalize(struct web_session *session,
 		g_error_free(local_error);
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

