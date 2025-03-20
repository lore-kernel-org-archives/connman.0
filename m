Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4B22A7FE
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513966; cv=none; b=oNbuwY5FLrp0CFhxedjW9Gycrnyuv/GY5SKClKPnrSmNC2LAQoug2w1bGvwdmcpDZd4mZ9FqbAFsOhQsIjPwy3Echw3ITyIfrKgk/ccPYYXtC7rMwELYdCaG/udNji59H1Hp1/mvespWVhwf6ZUzg94KcKd20c13rxIYO93lNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513966; c=relaxed/simple;
	bh=+IUD3Dlucz58jOB0gZ2N6VJ5IefbDkaFQv8FLsgIqqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsY0morQHtv51AXwF4YVZ7TpOly8nK6bFfIiFhvmdxQD/3xk7YOXveThK3Eyu7eY6p2cNpSznnAr5T5hB3B4sQxKH5J2nEEW3OUsiZG71PC00Kf0Iop7xOS/SZRO9tvp1+ugyeqtWB3UACyAhxtfnJx9rUWkteMcdrLSK2jIMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=EkTHmchJ; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="EkTHmchJ"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 24343164AF8
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:19 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id CE2E4125184
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:18 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 17/18] wispr: Document 'wispr_portal_web_result'.
Date: Thu, 20 Mar 2025 16:39:08 -0700
Message-ID: <1ba80f5f889d172ef11c2ba3c976b1fc6ff633ef.1742513884.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=6O7QOZn2szn4J2MSzFdPDhxp5pOxWmAC7au2odjwO1g=; b=EkTHmchJ1bb9xdykAmtYfFQvMY2DwN5fOY5u5VQCoDsfcosdWljRdkOb7EoFt/017fomFKgzPqX2/Q8NlMe6f8oD3Q7XMoRU43DpCf2hdHQLUAHYK6muSIYg6qZOBXlVm64dHSx8gb6HxMxa0sF29jr1p3mHXsPZGwfGiOhrsNiXjgISqM+DTeJt1Q1A1MWV9YmGB19GfldIOCln8OATo7qO7YdzyWYhLeVYe7cgr1W1DtQ7hFitlWsxzkaD2EzDmPIU/iMfnI0ioOZrY1+DxuLU8Qe3abv8C/6tgUIZ4dB5RGKvbbFnx5DfxYRy6jg8XnoOa6Mu6+nK6R2txh1FpA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Add documentation to the 'wispr_portal_web_result' function.
---
 src/wispr.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index e69e90551979..913c3135fffb 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1148,6 +1148,36 @@ done:
 	return;
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

