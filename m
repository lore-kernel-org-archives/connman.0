Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3427726
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745232; cv=none; b=pY/MhGL8vsztpQMnKizr2Wp6PlfIZ1a768FWK+FIl8Ev9gge1eBD9XOVUtFxegg7nBwmSuUufWYrjs+Ts2R3H4eUiQE8/akG4aC5lL1TjDMvQDUkzPsQ3lC3XM96q1PHo/V9EWMK9Oc+52w0GzOchBh4rXOy8pQajm8foWMt448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745232; c=relaxed/simple;
	bh=CECpAx+BN0rqZhfgT7yaCrv1ZRQm85oHgTWNUi/OzIQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIHjj2QiCRn/LLm27Ld0fgpTQpv1VGsyPo6Cb0kaV+RN7QlAodFalhy5Z2wRTr0eqScNxOOj4DsNjV4U/HRpLQ/z5FRyjImDFqQLwBhzAGkFA9pNmsHd0nDQcQDZL/ENvUb0krEr+jSg6SpvQF6ARQ+gOiH94CE6ySLmbDoJSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=QJGE59+F; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="QJGE59+F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5N2WHIMELnHpF5n8wUzVi9KHfGOevtc/VCsB3JTaTE8=; b=QJGE59+FUb6ox6I+7TbExIgXMt
	wKUAkgpFK/Dz0KeFKRSiC83RoTjEI4wT9P93ZFF1DgzQHIAGxbEv9NYFkcAxw5w3j9BJNJwbGlsGA
	WBBsf/7+wU2n7bC+95F9UmxtchRRv84OvPiY7MLfumjP8ZVdtUwvh6AHbMWvJtZh3ZbRPUrbni14G
	tK/ISgEGZKDxenvXLgmu8ylA6oXQ36mv3YCMCjF0LdsOV0tqg2ebX9cmN/3Z9BHe53JrLj6+V5T+c
	aJBSrE+wuPYtIEnhhf4GH5NRP1zSAxtdcySqxz77uZVtpw6vHvJK4oSQudUaFbmBltoFsFaXhKnxN
	ypEKBzuQ==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtI-006LIb-2l
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:58:52 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 08/11] vpn: Check if connecting when setting state or disconnecting
Date: Fri, 24 Jan 2025 20:58:42 +0200
Message-Id: <20250124185845.1546384-9-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
References: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Add checking of connected and connecting state in cases when the state
is being set and state transitions to disconnecting. This change avoids
clearing the transport ident when VPN is waiting for input from VPN
agent (association state).
---
 plugins/vpn.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index d9a56ae1..bec7f59f 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -270,6 +270,13 @@ static bool provider_is_connected(struct connection_data *data)
 			g_str_equal(data->state, "configuration"));
 }
 
+static bool provider_is_connected_or_connecting(struct connection_data *data)
+{
+	return data && (g_str_equal(data->state, "ready") ||
+			g_str_equal(data->state, "configuration") ||
+			g_str_equal(data->state, "association"));
+}
+
 static void set_provider_state(struct connection_data *data)
 {
 	enum connman_provider_state state = CONNMAN_PROVIDER_STATE_UNKNOWN;
@@ -278,7 +285,11 @@ static void set_provider_state(struct connection_data *data)
 
 	DBG("provider %p new state %s", data->provider, data->state);
 
-	connected = provider_is_connected(data);
+	/*
+	 * To avoid clearing transport ident when VPN is waiting for agent
+	 * take also connecting state into account.
+	 */
+	connected = provider_is_connected_or_connecting(data);
 
 	if (g_str_equal(data->state, "ready")) {
 		state = CONNMAN_PROVIDER_STATE_READY;
@@ -1076,7 +1087,7 @@ static int provider_disconnect(struct connman_provider *provider)
 	if (!data)
 		return -EINVAL;
 
-	if (provider_is_connected(data))
+	if (provider_is_connected_or_connecting(data))
 		err = disconnect_provider(data);
 
 	if (data->call) {
@@ -1730,7 +1741,7 @@ static void destroy_provider(struct connection_data *data)
 {
 	DBG("data %p", data);
 
-	if (provider_is_connected(data))
+	if (provider_is_connected_or_connecting(data))
 		connman_provider_disconnect(data->provider);
 
 	connman_provider_set_data(data->provider, NULL);
@@ -2183,7 +2194,7 @@ static bool vpn_is_valid_transport(struct connman_service *transport)
 
 static void vpn_disconnect_check_provider(struct connection_data *data)
 {
-	if (provider_is_connected(data)) {
+	if (provider_is_connected_or_connecting(data)) {
 		/* With NULL service ident NULL is returned immediately */
 		struct connman_service *service =
 			connman_service_lookup_from_identifier
-- 
2.39.5

