Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B721C9E7
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513963; cv=none; b=IyRs3ro5+yXaF3zrtcHRGLrLg5ahh6bK/MP7qK6AJtk2ZrJrdTgT99/k3unHU4UymD3GZlM4ROAChVUnqT0KzVLNLR3n/jS6mhosgaf1n1M4yiUeQQDBscF6Rko1gjKwnUFrYYOq6yQr8fVIGZ5MQrEeKTh2qFP4BXfwyzZKBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513963; c=relaxed/simple;
	bh=Pm6YcG2PKJoULCSEhKc5W6TYUaTpU2U1jJtqnM1y3CY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni4q4AcEsGXyRzfe4Ijm/wAYBfuQMU84Q2gxgwHaCUT0sQZeN/6Rt7o92jqRlM/RmwnlDdkR/R6sIUSMVQ0foRH0BlUftK5O5X25g4U1ZtfTfxfn31vXfNXVLj+fO4KSQCBRkH7KkVWDdV1Mddffwx6ntmsjWWPeE3KBBCFvV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=fs1wqhLQ; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="fs1wqhLQ"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 301FB164AC9
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:14 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id D9203125183
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:13 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 06/18] gweb: Add documentation to 'call_result_func'.
Date: Thu, 20 Mar 2025 16:38:57 -0700
Message-ID: <6c5d314bc2e5e20f507cb9caea5dc00f57fc06ee.1742513884.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=YLavwPfL/S0RGutMtrzOU3hkzcjtINQRj1X8WmIC3UA=; b=fs1wqhLQv0sEj9QjYyplYK2P2do2iW6C7cVOcmda2j9DtGrFS2L4x1iKTsw+yzmUXVnpqgB17sqnYuBKCiQgGt5yvqCCT9g3tA6D4KOvGV/1i+0iv1q3k+N1JwIliyB1MEL+Vp2tOOl6Z7A2THBB+m9UhdSlS6coa7v1fNiQrkSbqRWNLjgF96F3sxwlxz9Wqs8admvsLGVXgBnQmb2bK4mosA+N7DI2FQTWG1oS65DEx00CttsR8DP5rpDvs3VB0cR0YvAAKvzm4nx6nL8FK85LfCM0NrGuQPloRuO2VscACMhdDv+NFEqtA46RqPTBkE53drP5/Q6k1UngSc3Jrw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'call_result_func' function.
---
 gweb/gweb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index ba3b62165f5e..e4dad4f95e42 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -165,6 +165,30 @@ static void _debug(GWeb *web, const char *file, const char *caller,
  */
 G_DEFINE_QUARK(g-web-error-quark, g_web_error)
 
+/**
+ *  @brief
+ *    Invoke the closure callback associated with the web session
+ *    request.
+ *
+ *  This closes the specified web session request by invoking the @a
+ *  result_func originally assigned in #do_request when the session
+ *  was first initiated.
+ *
+ *  @param[in]  session
+ *    A pointer to the mutable web session request for which to invoke
+ *    the closure callback.
+ *
+ *  @param[in]  status
+ *    HTTP status code on success to set in the @a session result
+ *    structure. Note that #GWEB_HTTP_STATUS_CODE_UNKNOWN acts as a
+ *    null value such that the status is only set if the value is
+ *    not #GWEB_HTTP_STATUS_CODE_UNKNOWN.
+ *
+ *  @sa do_request
+ *
+ *  @private
+ *
+ */
 static inline void call_result_func(struct web_session *session, guint16 status)
 {
 
-- 
2.45.0

