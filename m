Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042D35966
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050685; cv=none; b=DR85pm8q1BgaqUe7wF3DkiJJYEKaepBmjQ49nFU+ir356tWG8U/8t3w8iJyeDTbI9dxiv3vt5zDEHBK8g/YIkfGplpmf/hY+83mKNv8CQloz5vTyinndmSP0yfSwVrmzDmZoU4rO4BQEYXVKFqcrW3IfAVRUazEPUJgjzeYRdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050685; c=relaxed/simple;
	bh=LL2u+EZlVVABNibQgbxpMTLT/lTwI18Y1qx7Bl68zr8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZwX1YosGUewyO6VInhMZ7haPOZ83FsRbKIl3U0zyIdH+dK1hiOCdUOfMnWDAybhXLl9+jo/IUobxx7HUKqskIthm7tGnPGJrfgUUmlbEmQlH6BUUWIVxTZ71ULfIgbbAVpD4SRvQ8XvCOC/gm1VNtU0hb0bB9wVHUAD1sTy/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=cHxbFwhZ; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="cHxbFwhZ"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 639AC164B43
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:16 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 1AB0B124FD2
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:16 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 02/22] gweb: Refactor 'received_data' into 'received_data_{finalize,continue}'.
Date: Mon,  3 Mar 2025 17:10:53 -0800
Message-ID: <8f55c77f87703048d35509d4aaf014a9bc37d23d.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=MuyU4ipqjbcl+iZQJhZ8QLaI0UsZlmhTZ3nBit5XtSE=; b=cHxbFwhZP3fKHNDD1yK0Te8iJM/NOAUek6nP3nkf9cxljsbaEa/cz8XDCYa7n3t99ovXmGYRCIzkRn5vyPy9Hf+0ySty/T0O7ZeICJq3q8iKUCeA4zBBD1ewkIBdcweCeVhVwAyp1DnAFOMKEHYKmRAW62CCpNBgoIJgY57FmpznBV3PZQD2HJaZTqbgrMWoA9YY0VWbUcmgDXzzMfp+G0dlIFHPw7vqDune5Dw/SCnTDkQL3zO4aNg8t1lJhtSKC3dDRKSEqSVAPPjLL5PLzVDu5k+Pvc6hNYxTqX1BI/ULJMNkrpTk0mAx4xJM2c+AjSSZ+itYu9ukj+l2kvi3zA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

The receive-data-and-process-it path for the glib I/O add watch
received data handler was already sufficiently long to warrant its own
function. That now exists and 'received_data_continue'.

While short enough at present, as further error-handling cases are
developed, the finalization logic for an outstanding web request
session warranted its own peer function to
'received_data_continue'. That now exists as 'received_data_finalize'
where error or EOF cases are now handled.
---
 gweb/gweb.c | 88 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 26 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 8e0b79c52254..d4bdbdd641f5 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -1091,37 +1091,22 @@ static void add_header_field(struct web_session *session)
 	}
 }
 
-static gboolean received_data(GIOChannel *channel, GIOCondition cond,
-							gpointer user_data)
+static void received_data_finalize(struct web_session *session)
 {
-	struct web_session *session = user_data;
-	guint8 *ptr = session->receive_buffer;
-	gsize bytes_read;
-	GIOStatus status;
+	const guint16 code = GWEB_HTTP_STATUS_CODE_UNKNOWN;
 
-	cancel_connect_timeout(session);
+	session->transport_watch = 0;
 
-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		session->transport_watch = 0;
-		session->result.buffer = NULL;
-		session->result.length = 0;
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
-		return FALSE;
-	}
-
-	status = g_io_channel_read_chars(channel,
-				(gchar *) session->receive_buffer,
-				session->receive_space - 1, &bytes_read, NULL);
+	session->result.buffer = NULL;
+	session->result.length = 0;
 
-	debug(session->web, "bytes read %zu", bytes_read);
+	call_result_func(session, code);
+}
 
-	if (status != G_IO_STATUS_NORMAL && status != G_IO_STATUS_AGAIN) {
-		session->transport_watch = 0;
-		session->result.buffer = NULL;
-		session->result.length = 0;
-		call_result_func(session, GWEB_HTTP_STATUS_CODE_UNKNOWN);
-		return FALSE;
-	}
+static bool received_data_continue(struct web_session *session,
+				gsize bytes_read)
+{
+	guint8 *ptr = session->receive_buffer;
 
 	session->receive_buffer[bytes_read] = '\0';
 
@@ -1210,6 +1195,57 @@ static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 	return TRUE;
 }
 
+static gboolean received_data(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct web_session *session = user_data;
+	gsize bytes_read;
+	GIOStatus status;
+
+	/* We received some data or condition, cancel the connect timeout. */
+
+	cancel_connect_timeout(session);
+
+	/* If there was a low-level I/O condition or error, there is
+	 * nothing more to do; simply fail the request.
+	 */
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		session->transport_watch = 0;
+
+		session->result.buffer = NULL;
+		session->result.length = 0;
+
+		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
+
+		return FALSE;
+	}
+
+	/* Attempt to read received data from the channel. */
+
+	status = g_io_channel_read_chars(channel,
+				(gchar *) session->receive_buffer,
+				session->receive_space - 1, &bytes_read, NULL);
+
+	debug(session->web, "bytes read %zu status %d", bytes_read,
+		status);
+
+	/* Handle post-channel read errors, which could be either
+	 * G_IO_STATUS_ERROR or G_IO_STATUS_EOF.
+	 */
+	if (status != G_IO_STATUS_NORMAL && status != G_IO_STATUS_AGAIN) {
+		received_data_finalize(session);
+
+		return FALSE;
+	}
+
+	/* Otherwise, continue the session request and process the
+	 * received data.
+	 */
+
+	return received_data_continue(session, bytes_read);
+}
+
 static int bind_to_address(int sk, const char *interface, int family)
 {
 	struct ifaddrs *ifaddr_list, *ifaddr;
-- 
2.45.0

