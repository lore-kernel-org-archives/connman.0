Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC333A6FF
	for <connman@lists.linux.dev>; Mon, 26 Jan 2026 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435089; cv=none; b=A16/3jIGi6QN+XFO6ylVV8T1bD+PpsEvEEjB+AjTVnClsF7Bp7S0fVcst/zKNmn+dRL9t1I5MKEY+ukhSnNx3iym9taWdihzUUDuIikLWi2GroUqccqeAZe6A+RioVE9ng7RFPFexHmYL/+qEfpet0FSC0G00mwnwhdR1xYsB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435089; c=relaxed/simple;
	bh=iPHHUK3qo4PpET6WfDD7gwG4xwKdG+McX5u+nLKehMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPWcFZoO3IsKQq6fhMXj6qhLuVKierPpt+BMo2NpQ/o8HUFZE1EpsRpfI7GkF+vzttw4Fyh8NzZGRM5YjF5ggjVGLQgxgV4D3NdeazGr9V93iC53xT6M4rdnAxNqr5enLA6jo9juyb6L71pexcEZeEKjjj9Q09FKgzG5xmvksFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=JRz9omVo; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="JRz9omVo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VHdhO0/uJGgcwtnwXOS1E8KgHhPpIJ/w5eSp2yQ4O7M=; b=JRz9omVoeh7wIdNvUmF1jmZauA
	bX9EZd/n9EBQInOHtWnJKC9/3ip0LNIuhalvFY2AmiAzKtuzSlZ/a4hLh8noOVWKwBduvhDcriidz
	T4yQgQHj7aRTvE42CeLtv/ZlyEz39u0heuL1HOQSgYJliG6FJv5AtsVNqpibOpgWtjh9+51wMECIw
	vljHF1cEqu145sODlvtgqVxYwftr/+m0rQN9G1VyPgOK7o8KwCBcDaNee4x8JNjmc5bt06mb8OnRZ
	gaeGiiJLdNvNEG4d6CJbHXAAKC4lfA5YTBnCpKeVhbXA/tcz/jGYJwFweQ+FWTCbhFAP2FIfM/Dzp
	RzfBRtfg==;
Received: from [2a10:a5c0:37:6500:4460:24f0:14b1:617b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1vkMtZ-00C0gj-2D
	for connman@lists.linux.dev;
	Mon, 26 Jan 2026 15:44:45 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 5/9] pptp: Do not clear credentials on connection error
Date: Mon, 26 Jan 2026 15:43:44 +0200
Message-ID: <20260126134410.55749-6-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
References: <20260126134410.55749-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:4460:24f0:14b1:617b
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Utilize the authentication and connection errors to detect which error
should be reported back on the pppd error code 16 (modem hangup).
Connection errors will be reset when connection succeeds, or the service
is saved. If there is at least one authentication error code 16 means
the credentials need to be cleared.
---
 vpn/plugins/pptp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/vpn/plugins/pptp.c b/vpn/plugins/pptp.c
index 2ae4e0f3..2e91300a 100644
--- a/vpn/plugins/pptp.c
+++ b/vpn/plugins/pptp.c
@@ -660,14 +660,29 @@ error:
 
 static int pptp_error_code(struct vpn_provider *provider, int exit_code)
 {
-	DBG("exit code %d", exit_code);
-
+	unsigned int conn_errors = vpn_provider_get_connection_errors(
+								provider);
+	unsigned int auth_errors = vpn_provider_get_authentication_errors(
+								provider);
+
+	DBG("exit code %d connection errors %d auth errors %d", exit_code,
+						conn_errors, auth_errors);
+
+	/* With PPTP the exit code comes from pppd */
 	switch (exit_code) {
 	case 1:
 		return CONNMAN_PROVIDER_ERROR_CONNECT_FAILED;
 	case 2:
 		return CONNMAN_PROVIDER_ERROR_LOGIN_FAILED;
-	case 16:
+	case 16: // The link was terminated by the modem hanging up.
+		/*
+		 * These values are reset when connection is success or the
+		 * provider is saved. If there are connection errors do not
+		 * reset the credentials.
+		 */
+		if (conn_errors && !auth_errors)
+			return CONNMAN_PROVIDER_ERROR_CONNECT_FAILED;
+
 		return CONNMAN_PROVIDER_ERROR_AUTH_FAILED;
 	default:
 		return CONNMAN_PROVIDER_ERROR_UNKNOWN;
-- 
2.47.3

