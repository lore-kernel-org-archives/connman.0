Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A407617E016
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981309; cv=none; b=d/IsyMGSOXXVV/O2QZvA2HaG1lTd4oXFtaj7R2k1qqHe5dBADko9sj2XGARXhDZUVGlW80YdE6YtkUWjzOJqwcwbwwcF7vtvwXvFVTMmG0JoLrbO3m0f+RWb96PR51ug388KR2sDkMnHg/9GLdpkFstBaVOYiklQ+jh1je6JhDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981309; c=relaxed/simple;
	bh=AvVP1kzGtYXjkdUdh39ZomKjDeeuTlBS+MQzjoCpXAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGgAXVX/bPVR14wsXg75pADeuky+/3tezNdoj4+r1Sz5LYe/+JjTcwlyLK/X5J5kg6TH/Iu0Cj9f/eYVqyB13/laZedoq901rpCEkFs1Z98nrMwrqJOFO9o0uHov4QpxIFDArh7N8zyg4bP26grb4u/RcaCmzDyvOZhKn4dRFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=qnAZ2cNN; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="qnAZ2cNN"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id C7FEE164A6B
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:24 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 7E1F3124EDB
	for <connman@lists.linux.dev>; Thu, 12 Dec 2024 00:28:24 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 13/15] wispr: Add 'wispr_log_proxy_failure' function.
Date: Wed, 11 Dec 2024 21:28:15 -0800
Message-ID: <20241212052817.2021264-14-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241212052817.2021264-1-gerickson@nuovations.com>
References: <20241212052817.2021264-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=IbJ/ABYzcjORSy9HsV7N+9RNPWw1UC5n2FRAmSdXB1o=; b=qnAZ2cNNSwc1xoTApQbDMUHOMxpFXT5fjZa48xeoR0k/mose2qfDH+IabrtJ4z2GXpfcyA/RYhJ5IjjypgQVWikoWMthdLA0BcIheh07WajiFh/2w6tBemzGLsYDhW0BjNdLezajP0M7LAR69+o3w5b3N3kTRDgTvSka13u9A48Hc2iZIKhZZ+dsbXlEskhy5pYC/dQrscjxopz700AnbjtuHPRk28nlK1PqpQ6fW6IpDnOqd9kmCk4HdGCKR3EIUvHRSOSMWBw4Jtsrj2PratBDxMfD1UOJ1UJXI2kplGZnYgR77ZV6CKF8vTC+tkyQ3WZ5q6shPgDLxRxxLP+Ebg==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Logs the network service interface name, type, proxy
auto-configuration (PAC) URL, online check URL, and proxy failure
reason at the error level when a Wireless Internet Service Provider
roaming (WISPr) online reachability check proxy failure occurs.

Frequently, a spurious, misconfigured, or otherwise incorrect PAC URL
is the source of WISPr online reachability check failures. Because
POSIX error codes are themselves limited (for example, there is no
-EBADPROXY or -EPROXYLKUP codes) and their usage for WISPr failures is
similarly limited (for example, -EINVAL), insight into the actual
nature of an online reachability check failure is, by extension,
limited. Consequently, log messages generated from this function
provide crucial insight into triaging and resolving such failures.
---
 src/wispr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/wispr.c b/src/wispr.c
index b1b0f337d3f8..60a3a011da58 100644
--- a/src/wispr.c
+++ b/src/wispr.c
@@ -1118,6 +1118,24 @@ static char *parse_proxy(const char *proxy)
 	return proxy_server;
 }
 
+static void wispr_log_proxy_failure(
+		struct connman_wispr_portal_context const *wp_context,
+		const char *reason)
+{
+	g_autofree char *interface = NULL;
+
+	interface = connman_service_get_interface(wp_context->service);
+
+	connman_error("%s with proxy auto-configuration (PAC) URL %s "
+			"for %s [ %s ] online check URL %s",
+			reason,
+			connman_service_get_proxy_url(wp_context->service),
+			interface,
+			__connman_service_type2string(
+				connman_service_get_type(wp_context->service)),
+			wp_context->status_url);
+}
+
 static void proxy_callback(const char *proxy, void *user_data)
 {
 	struct connman_wispr_portal_context *wp_context = user_data;
-- 
2.45.0

