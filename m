Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E221D00A
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513964; cv=none; b=old6vMJiNDQ8YzmW99A/MpneC2bWcNkKbp1JY7rDwfc9txxZtiOHrLBAGKcn+c3kTNTy/lMziDg1QXemRbEY+qmgDd727Rz0iq8OLm8IRrzsTRznXnrFZ3aNIqa2zfBhoDhyCVgjNTM84vyyb7MUpClLPUV9bzpJ+Bh3ih1+tCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513964; c=relaxed/simple;
	bh=UKx2vEMVr/I5VSmTcG+W5vw6q6/pFmWPDOnxwizoPTU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bijRjhjdlL2CPmXsh6JfHP8nBGSoPinu7au3jC+whBqWVVW0miy6jAgBMW84vhcfBXxC/nBIDqjsivrgmQ6ciAFNN1X7SH1Df04sMrcQjfn8/7TEqxti6RmRHvc3Y616dqN8yla7pi0AJzlWJBQQ8vo+CK0y10IdZKV4h4MqBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=fclwgYoA; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="fclwgYoA"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id B6CD7164AC7
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:13 -0400 (EDT)
Received: from localhost.localdomain (c-73-202-173-252.hsd1.ca.comcast.net [73.202.173.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 634CC125183
	for <connman@lists.linux.dev>; Thu, 20 Mar 2025 19:39:13 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v3 05/18] gweb: Leverage 'g_autofree' for 'port' local in 'handle_resolved_address'.
Date: Thu, 20 Mar 2025 16:38:56 -0700
Message-ID: <da3efe8ead1a59f2e57427d70bad94a2fd68840a.1742513884.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=9tYBVpkNzUXHwin1SyV69kZoqGoeIQJ9fR6gaz5IsJU=; b=fclwgYoAcvneSzjd4ETjSGARBQoQ+O2GJxQD0l0Qrv3GPrCapYM+LWVea3Fx91WLThKuWiD9gLnx4S+C3FuCHrLB9fXJBZ3I4rzhlQ5NGez1BZvypA62ardPJiM1zbMEn8DoV6RguWe4kcJucjEA3QygLxELFFApNHGYgLN9MQ1rIoZu3PcAscFCreOOk0eXb2ZlguPU1aFw1PkdcxcseRaDDaygESZgr1Mx52BOVd+UTjjj0CcYF+VCzmeerUdvMWnnzp61e4KSMOs5oWb7ydE3B4N9uApx7PD+HrJNwkgjBO7Da4DXN0reCWEq5FzB4ybA8pQR1asjiCXJBsFMig==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

---
 gweb/gweb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/gweb/gweb.c b/gweb/gweb.c
index 94d304bd40d6..ba3b62165f5e 100644
--- a/gweb/gweb.c
+++ b/gweb/gweb.c
@@ -2240,7 +2240,7 @@ done:
 static void handle_resolved_address(struct web_session *session)
 {
 	struct addrinfo hints;
-	char *port;
+	g_autofree char *port;
 	int ret;
 
 	debug(session->web, "address %s", session->address);
@@ -2256,7 +2256,6 @@ static void handle_resolved_address(struct web_session *session)
 
 	port = g_strdup_printf("%u", session->port);
 	ret = getaddrinfo(session->address, port, &hints, &session->addr);
-	g_free(port);
 	if (ret != 0 || !session->addr) {
 		call_result_func(session, GWEB_HTTP_STATUS_CODE_BAD_REQUEST);
 		return;
-- 
2.45.0

