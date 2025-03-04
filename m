Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC47346D
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050688; cv=none; b=KRhL6JFshAnpqDdZ5kMyYnDQQG4ZL0AUDxKo0PNunxpCI15pSjC7M6TiOmqaTV4MpatYgfWxlie+0w6v6PwGZMG4nxJI1AN4agndqkw+zW9rRKvqKXEofpei5tusYtYc1muMJ5JKrWZmltkK/1u5le59SIwyJYRfC13kv1KvaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050688; c=relaxed/simple;
	bh=BSDpCfSloqLvSHajTRfJl9+f/Sbwe3sJIRINhQGr240=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fi03Rc3AV5oy1mu3Kvla4lhx795lVzuCImbIBPkGAORqpDt2tGTBApGfgtTBcKQxs0KshSLgwV2hH9zWj4Gaq/cTiOjKZ6meRlaj0sSjRnWKVDyVWP6u9hxua6vcS8Q1wx/dkWFNqgvlp1ozEz9//TVmb2DW9KjZONk20B1XfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=YDqwGn9B; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="YDqwGn9B"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 54729164B58
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:21 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 0A891124FBC
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:20 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 13/22] gweb: Add documentation to 'received_data_{finalize,continue}'.
Date: Mon,  3 Mar 2025 17:11:04 -0800
Message-ID: <7c22648e2f3f3138b4e44bdf462d8686917471f2.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=HaG/KMdQ7/9c30YHFESj0m55Cx83if+Mv2saGq8jdzQ=; b=YDqwGn9BQGMpHw4QxanJylmb/BWD7LaDXigJEzVvUI5B6Nd7BvbTCdJLeel7q+1tjYPG5dgcSzPUSLxatedmId8bYIDCFMmf2aICNpFp9fYm5ujKgQI+6j2tHldqlxa9Uwr0vG9IMyYyzpI2qfp+c9OZc7izlbRVtrAaXNph70pbgiVre7GoJXRZsIgOuRvBVPCO2uZabJ7kt82QVXlk+csZB8byILncBMY6Brs8FvpWQgO5WrKRTaFdMXus+GxTaLYrfRZZXHPyFjmRq8NT7U2DGVaNyoQbAjKfl4qL5uIT4+0Hpq6GSP6SJo4hyPno0Mp0qf4wIhumMGwIJjp1cw==
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

