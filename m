Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE63BBC9
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050687; cv=none; b=WggILpIRLP3ptPREjZwfX4aqTpcgrmICrQM9r0a8Bxabk5jCat8vZgZCYa1HvI9dPlempVzTdUst6EIKQMxg52VVyCZDKSc9sJZJN2pbvQHJvhp0Bhw1VSkyxQw63Al2JLk9xZ5ltXqWrlOUzlsuQJgdCIcombY2hLMSQJFY07M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050687; c=relaxed/simple;
	bh=44HUdhk7dssEJ9PRfq7Z/GkqK4eShLJD9Y8TkVr78Xs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6phmAfywukUCnfqSRrfthpCVvmSaMkNpuFLUFm4Y6M+FJYJBvoPnfEIBTmr2C5dF9QHdKkuXIiOmDafiCCRfH2KreDmJoEp0OYs/LB5Wy3Ut7Rjfhr+5UVOvLq12CAmIOAOfMf3zbSPsBw2P6pndgzWKWK3haJ5VnNtXVqD2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=aR5OUbkr; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="aR5OUbkr"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 889DC164B54
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:19 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 3F9D21260D5
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 20:11:19 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 09/22] gweb: Add documentation to 'g_web_result_get_status'.
Date: Mon,  3 Mar 2025 17:11:00 -0800
Message-ID: <008c8a22cd569df0fb8c8f815d946b0bf730b419.1741050622.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=aP//wlS8ILBKjvXLMQ+tpDDPz4EdrX5YOmp9j5T5if4=; b=aR5OUbkrYyTKcAOsHGfYbjm4tfd44EHHRZL/a9XZMHQIhWgnIys9CW4078v738kfnTvpPdN0f9NNEw6vKCFtP2zB7//a6Z3Xm9vsSRnc8THGKnQRJHVelLOKERfNgHu3yC6AcfaRRNOdAE7aVmuYfKu68bn7eRGhLpIRa2j4dHW6j6atsDS1wNUXuj3Z+5B7YyCqd/4Esu+Ynx17HEoJh5kl/HIDy7/F/A++tHvujzm24TMxRBzWa8WssiSpCaO3NF9nEcctnRphaWtG7AJ5do1jyu4fUk/T5jZRypNy157BkuFpZxxVVFIGxsth1Pp4imz8ic9N1Mr0V/IaR6WWEw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'g_web_result_get_status' function.
---
 gweb/gweb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 0256d622e00a..ec72cd417a9c 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -2526,6 +2526,21 @@ int g_web_result_get_err(const GWebResult *result)
 	return result->err;
 }
 
+/**
+ *  @brief
+ *    Returns the HTTP status code, if any, associated with the
+ *    web session request result.
+ *
+ *  @param[in]  result  A pointer to the immutable web session
+ *                      request result for which to return the
+ *                      HTTP status code.
+ *
+ *  @returns
+ *    The HTTP status code.
+ *
+ *  @sa g_web_result_get_err
+ *
+ */
 guint16 g_web_result_get_status(GWebResult *result)
 {
 	if (!result)
-- 
2.45.0

