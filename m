Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511926AD9
	for <connman@lists.linux.dev>; Tue,  4 Mar 2025 03:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741059598; cv=none; b=JkUXeYzPjuZUEQC1mr3rMs3Jzg6oEu/J693nqV/5NU4RmXxxKf8TnwpCqWt8oPvVUX5UcSlwY701gcMSwPd8auy/Rwv5jv3NFtPoGZ3HnMOTwepZIo8XQdtMut5TKUSxdSbK/EzFX6qn+JGfQrF1w//iarVmW6iUugIhhcXiSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741059598; c=relaxed/simple;
	bh=S0IoI8cW8osAWztK89NCeIuGZOYZXpRC44vzGmqg3hw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=so1PhghvbcfOJtBwn4ia1gmQTdG9ckKSrE3WrzQ0lbUMTPhVUnN2NKSQRA4TRKXWCTgCKudsLCTb47uuxmylBN1KdPgLZcYTlenuxn8hMaMsmNNE2lAYtw/HIZX1V2WBMxyToUZDGlEcDcrv75BbxznLWTpH/eVUdHAaoSFXAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=C0+vnjE3; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="C0+vnjE3"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 461CD164B4D
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:56 -0500 (EST)
Received: from localhost.localdomain (c-73-202-63-31.hsd1.ca.comcast.net [73.202.63.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id F1889126291
	for <connman@lists.linux.dev>; Mon,  3 Mar 2025 22:39:55 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 22/22] service: Capture and propagate '__connman_wispr_start' return status.
Date: Mon,  3 Mar 2025 19:39:44 -0800
Message-ID: <5fd52e40e7e85da71db641040c1becf04f97f1f4.1741059516.git.gerickson@nuovations.com>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=JzuyPr/g95tGKoZQCm7eAGXm0UDoCaMEAA5YfTq7iZI=; b=C0+vnjE3BHK2WQSj9gK3P+8Ai/RUQZoVFL+CYSONsENY34Qy7cZ0jItyNbLhMHqNZNGr+xbYXfYp6uPg0Qq5JNOXowC1ZBx+B5jUXLe0j5Vuap2UliaCPS0BrrwSFGz3UCYzEm66gZXAPic8tNZy1IzPWk2QqwB03jXmicOx0pn497Hx6hNJwXHwDCeS1+XLsFMiTJGbjec9iq6tANX/0o9tQOSNf3FWhE3CoDYsBRzG3IWrkF9lYnAwlTjX6c9JWKf+c8CMCjpIJFWiYP+QMtGzdzMjWFjovpnCMh/G9WIyrIyHtz4eqzUolPH5WtmWB1hjWdhPRRdVCnAUr1k7rA==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

'__connman_wispr_start' has a number of early failure conditions
before the call closure becomes asynchronous. Capture the return
status from '__connman_wispr_start' in '__connman_service_wispr_start'
and propagate it forward, ensuring that 'online_check_active_set' is
NOT called in the failure case.
---
 src/service.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/service.c b/src/service.c
index 0cfb516016b5..48a7d1f72367 100644
--- a/src/service.c
+++ b/src/service.c
@@ -4003,6 +4003,8 @@ static int start_online_check_if_connected(struct connman_service *service)
 int __connman_service_wispr_start(struct connman_service *service,
 					enum connman_ipconfig_type type)
 {
+	int err;
+
 	DBG("service %p (%s) type %d (%s)",
 		service,
 		connman_service_get_identifier(service),
@@ -4034,14 +4036,17 @@ int __connman_service_wispr_start(struct connman_service *service,
 		service->online_check_state_ipv6.interval =
 					online_check_initial_interval;
 
-	__connman_wispr_start(service, type,
+	err = __connman_wispr_start(service, type,
 			online_check_connect_timeout_ms, complete_online_check);
+	if (err < 0)
+		goto done;
 
 	/* Mark the online check state as active. */
 
 	online_check_active_set(service, type);
 
-	return 0;
+done:
+	return err;
 }
 
 /**
-- 
2.45.0

