Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE131DC046
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059594; cv=none; b=JLWwP/hZziQ+Pmpyw/Fb3RcwhiENgx1HrKIT4Tt3hQfZHrOuUCxK9QHahlnzDpKq0/clHHqhyeSMKa0L7wOVhPHou2T/GqMp2LdosEQlRJZZy100mjY62UzI7HWeHKEr9qRu22ndaKZu7rya8qur4evMR9xSPkn9YYQnocQtbQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059594; c=relaxed/simple;
	bh=BSDpCfSloqLvSHajTRfJl9+f/Sbwe3sJIRINhQGr240=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IB4Ou0LiD5pMuLCdJWaSrdy+kfiJXaAHi0dRw/v71v3uG/Ivo2pG6PuhIL/EZrd4zfEZjOB8KNa5Rieu2+LAzOBr+q5YIiEZCQmY8F6Djxn9Z1aWqjYIjODwhxaygWNczc6ZIrgy20+kYFBgC0rclf+uQQlT2eGB2lI7oJ6psOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=NJ9+dZDn; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="NJ9+dZDn"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 38E3A164B4F
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:52 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id E0A3A124FE9
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:51 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 13/22] gweb: Add documentation to 'received_data_{finalize,continue}'.
Date: Mon,  3 Mar 2025 19:39:35 -0800
Message-ID: <7c22648e2f3f3138b4e44bdf462d8686917471f2.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=HaG/KMdQ7/9c30YHFESj0m55Cx83if+Mv2saGq8jdzQ=; b=NJ9+dZDn8EqoW2J2zdAQK2tjD7tH6j+BOtaCLm+WKqJrSB+tjpqzs8O0ZzAyb3WQbYqejNckSs6JiPyMZonuSeeQCpy3cwjMPavUK582EewsGKs5WR0vpBcyJZlLlg6xzr41/wPReQR0Xz7AM5syqcIAtE5w9gc68J7Yn/AlHZ2DqI2Lx0csPEKSV3LE6EHx3rFbCexvfdx5ko2na3R3UaLxnBJ1TATnCBqCsC3H37ZXq7pj6hqTQ0fh/JrhaioeyzTinfLhSf67cxjJWbJgEESueZyA1FVd8MB//PPXXa7YilKcQb9PDW6c4Emf2BDFngrNw+fAtJHtTQmlvZS9dA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'received_data_{finalize,continue}' functions.
---
 gweb/gweb.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 12fe682cedfb..c7af3986df8f 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1200,6 +1200,43 @@ static int map_gerror(const GError *error)
 	return err;
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
@@ -1249,6 +1286,23 @@ static void received_data_finalize(struct web_session *session,
 	call_result_func(session, err, code);
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

