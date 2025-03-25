Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131E25BAAA
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920074; cv=none; b=CzoCV3J8KgXSNXA+JUHsvxgbh5nbqQUdMP3qr1Nb1bDh2D8x7nSdJbMfIJQfb2uY2KLLVME9YP514Q5EyD7WVWlh3DQIEI1IE5PyjlyE7lSVzXf18QFpsgX6GTpZAv/ZSROh4/ufXiSDql8DaJNtC87YJ7G2+49TVTgW9NWzIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920074; c=relaxed/simple;
	bh=Jn4e7o24L3129y7S0CXIf2LzsUYWCCemhGzx/uaXDbc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgU2xJiJUzaURT/EQoSQxTOQ2WLBOk8fxAC41kbRTNCxsAw+lqOhY7dQEPJqkojvu4RAs9yS/vNV4J+6jajqTv6TqWshh2qlaE1XjfStntbbrrYl6AXpuYhHY3JHPRAPa0YGSDE2PwuRf9zGYYsFo7R92Uq+VnEH5cPMP66AKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=LQzWQQv7; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="LQzWQQv7"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 6FBF1164ABD
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 12:27:51 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 25B20125174
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 12:27:51 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v5 4/5] wispr: Document 'wispr_portal_web_result'.
Date: Tue, 25 Mar 2025 09:27:47 -0700
Message-ID: <f447b545324c4d1f84de10ea05ec2980eddebd2c.1742919926.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1742919926.git.gerickson@nuovations.com>
References: <cover.1742919926.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=dxfXPV8+Wq0MN3WM9iyqxuiIs55+E6vg0qsp6ScQmQk=; b=LQzWQQv7KPVtCcARE+l41/egulqJbOKLXirCB57vh8l4x8H3344jVNqOsqLGY1Om58jBg+q2+JzGku28EDqbKTmnfOa414l276EMeqIK7U1CxBfTGfHTKX7QXv342ob5i7q3U1zfbfRoeNBxQ0fvcIWr+W0LYL8v1U2fYE1SCrwUvAdZriJ7pULmsaILrbJu67+eWVYt35olm6DFjLeFn2jJkHI/vcLH6oa5KVvMwvRWkV+mZwTwn917EGppcDu9Hc2zRYUnwI4yM4nz1zWyUH/P1uhZys/WVMFucGgO5FlxGDnLQEZcSsqD5c82s5W4TgZDy5BQWzlgctoMatTkqw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result' function.
---
 src/wispr.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index 47659b58383c..0cbc8095364f 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1145,6 +1145,36 @@ static void wispr_portal_web_result_success(GWebResult *result,
 	wp_context->request_id = 0;
 }
 
+/**
+ *  @brief
+ *    Handle the receipt of new data and the potential closure and
+ *    finalization of a web request.
+ *
+ *  This handles the receipt of new data associated with @a result and
+ *  the potential closure and finalization of it, if appropriate.
+ *
+ *  @param[in]      error      An optional pointer to the immutable
+ *                             GLib GError instance associated the web
+ *                             request, if it failed.
+ *  @param[in]      result     A pointer to the mutable web request
+ *                             result with data to process or to be
+ *                             finalized.
+ *  @param[in,out]  user_data  A pointer to the mutable WISPr portal
+ *                             detection context associated with the
+ *                             "online" HTTP-based Internet
+ *                             reachability check this is finalizing.
+ *
+ *  @returns
+ *    True if web request should wait for and process further data;
+ *    otherwise, false.
+ *
+ *  @sa wispr_portal_web_result_failure
+ *  @sa wispr_portal_web_result_success
+ *  @sa wispr_manage_message
+ *
+ *  @private
+ *
+ */
 static bool wispr_portal_web_result(const GError *error, GWebResult *result,
 		gpointer user_data)
 {
-- 
2.45.0

