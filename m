Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D7218AD2
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153424; cv=none; b=g1vVCITGgHMgc+wSPJWQmE4+gC9zIBAoNyEcTsgwwRs0qzxG0py6KuB7bw/VF5SXCrxmG1mGpIHYpIt6KTst/Kk1xObtEcxr2MB335l/pFzHnxPV+weNtFWnPkrwmeRXS3Dwl6Y115Jym77cShArf87uMZpbl3QkBfHjv+eJAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153424; c=relaxed/simple;
	bh=AvVP1kzGtYXjkdUdh39ZomKjDeeuTlBS+MQzjoCpXAQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnEMIX5Rf0KUJhJOBcfBxR4yzzepb+sJpZ3H0AZ+2VC640BvcRslGB+lGlldE0tks01XuQSkT1cFBgcFlxU+7lTnf2dFeTecfvJODzzBVJ2lDXdGFIYVeuf5qxrCc2eScfk2cQqlMg1zSAD1EyxnA0cSHNFX6ri9lEQ4tKdiNo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=KhIpbon5; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="KhIpbon5"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 36042164A98
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:01 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id DE2E5125174
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 10:57:00 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Subject: [PATCH 13/15] wispr: Add 'wispr_log_proxy_failure' function.
Date: Fri, 21 Feb 2025 07:56:51 -0800
Message-ID: <20250221155653.760046-14-gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250221155653.760046-1-gerickson@nuovations.com>
References: <20250221155653.760046-1-gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=IbJ/ABYzcjORSy9HsV7N+9RNPWw1UC5n2FRAmSdXB1o=; b=KhIpbon5YM1AU+Dcn9YVG2HuXH2o284purpufw7ukhJxhjQfJtn5GvY5t6zLpPAGzUeTONLE2snVSPxEzaibtKTyzuOmo9/ZNxeIp5mqH5vczdoRundSyVPIRXJ9EujWLqrUKvdFNtUEaJO+ghu37d7LM2kYCLNJEd9H53T4JxxP2bAa8k63yP3obvbTCFi4GWoFOG1Dqji7QDHXyAy7H3P3Wj3LIokw9+u0PEar4uqIo5iGzUfPIFdJQwVALYoo16e71nc+zJnlBokfN5Y9r+noB5VikBdaPAFiZF7hKg9F/ncSpaMkJeOSbtl2ukGpPZo3+oiRvPlrtSArkX0ICQ==
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

