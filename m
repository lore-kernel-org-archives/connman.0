Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502F524B0
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050689; cv=none; b=e37nAjIcWzEX2m45mDmWWOAi/Z2pJNGJBjqn45RDek6XVNE9VlorcsJLw73bVjB8RZ3tfqETnOA0z13wzn7mG+sKdVGjHAmLNTK7eGzKBK8r5Puv+Aj2XTEZxEYgKIW/q++oK2t8rjq6NcUEZGKZQgk+3IYzWkKxclucIfDlJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050689; c=relaxed/simple;
	bh=G/Qe3zKlTWADGLY8hQl3objaGVPcpvPxCLiBXVnopwU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjPDenzQU55YqRc9NALqfTCEfoj0ra4GiTwRBMMdEAPeufdltwLzmo2OzMab4N1QK26cqSy3HluLdiyZ9tojDXDyalBHPwMaNtyBsuMvLG/2iKgOe739x+btWEo/RNvHk+znaSrCTVrb2uK1/A7uToYNGkp+e+YvYf1dP8i7/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=Mo4RvECE; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="Mo4RvECE"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 1C3E7164B53
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:19 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id C9372124FD2
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:18 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 08/22] gweb: Add documentation to 'call_result_func'.
Date: Mon,  3 Mar 2025 17:10:59 -0800
Message-ID: <5bca4dd1ae8cf27646239ffd4a1f3640cf455075.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=r/OwwCe7WVAb7p2me6Fo1ky5hBl9KQF3gIRNseVbf9M=; b=Mo4RvECEt0sPyGMDlRB80rQCn6a6r6vO8WP05rjbb2kpSCCevhW2j4KeQ3TLp8YugOLqLfA+USKOdRYUB5M1RUDyVy61kQ4A/Z6km5msJkckhcLA4IfuXCxEYmWQ+hnQx0ZnZeFdVQkhtJw/XjNVVf8P9XqpVJ8a7nTHMc3EUc9Q35BXeceO64jXIaR+WqlToiRSokVNrZ6pGP3ggEpaHEFmZ7i4AoDDFpg3a03Yeg/kT3bybmlccF4VXu0Z6kp7RX0S8LD6+VHU8Vt93Byf15HXQ96Y+ZCxhLE73tSMe4YysI2/6y/IcbftyqjhhWtnLUZ+/zb1XMpbuvW0KUVGZg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'call_result_func' function.
---
 gweb/gweb.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index f5accf80cbeb..0256d622e00a 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -164,6 +164,34 @@ static void _debug(GWeb *web, const char *file, const char *caller,
 	va_end(ap);
 }
 
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
+ *  @param[in]  err
+ *    Operating system error to set in the @a session result
+ *    structure.
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
 static inline void call_result_func(struct web_session *session,
 					int err, guint16 status)
 {
-- 
2.45.0

