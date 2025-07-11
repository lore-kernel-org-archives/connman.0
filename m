Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C692E763A
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244075; cv=none; b=Uelj+d738AlG5GmF6Os2KKGnTKuxGDD7YP+P3/TTYc4iSM17f/bZjBxf+T5vk0OiRJ/VZ2LUa73DIlSXgvD9fahjhzAJ26ZncnQz0C0RCxNyD1wlK07A7dL+oY9quL0Q1015IsiovEeHgwGkOaVIP00R2EGdiVNarMXQQLkJG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244075; c=relaxed/simple;
	bh=5mYgqKEHzc99hkehSCXmuFDEFcSGYD7GqOamZQZRDyM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwmmJ8iwbJaVcy7zQggLa3BcthUQv/iryNpqj6ihM4FynOIy2OseZaxIhBPHDOmOxvJybshjmvPT+hIpn7Zz8/98kGveevjHDh9loVCJKwEmCwHVazF6vtf5/LncW0v33BxmnY2dUS+ICyv11/ZFtBim0Iq9o4HV7SeahVcf0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=kIyB0tMR; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="kIyB0tMR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uBtwDvnBx13SMhrgd8/WaGr9gUW8vCEO/JMSDszRVjc=; b=kIyB0tMRnqZRMhW5D3PsesuilR
	rrsfG/+TAZVMjUPI4MWpTC9oXpMqNQBsDTI2PLBAmFxfFUethA0KbBQAkepe/wPuqC02SJPZliGDZ
	pqdE232TBeOCQHEcbAoaCBPXELV2ckWj/WPGPbNNCEfmHfLwwZOL3eT2bc6WgSQ8JydJ/qWIx9X6I
	LBNNr+zMPvMxI7ywrst0hhJnskDs/4t+nwOHqwnJLlUofOFM18KnJyac+xSs8VM/P4oFZg7UQ1om6
	lLq1ogreNToGqMEPZIYpAlEOKqeEAPAPiv3LJfJiXFiztOxDbar0CABU8H1nTI02Xu6NwtmdyG6Z1
	+r2VRkOw==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-0Q
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 08/45] vpn: Check if connecting when setting state or disconnecting
Date: Fri, 11 Jul 2025 17:26:59 +0300
Message-Id: <20250711142736.1757060-9-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:7901:7c96:5fcf:719b
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
index 854b817f..d683c67d 100644
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
@@ -1075,7 +1086,7 @@ static int provider_disconnect(struct connman_provider *provider)
 	if (!data)
 		return -EINVAL;
 
-	if (provider_is_connected(data))
+	if (provider_is_connected_or_connecting(data))
 		err = disconnect_provider(data);
 
 	if (data->call) {
@@ -1729,7 +1740,7 @@ static void destroy_provider(struct connection_data *data)
 {
 	DBG("data %p", data);
 
-	if (provider_is_connected(data))
+	if (provider_is_connected_or_connecting(data))
 		connman_provider_disconnect(data->provider);
 
 	connman_provider_set_data(data->provider, NULL);
@@ -2182,7 +2193,7 @@ static bool vpn_is_valid_transport(struct connman_service *transport)
 
 static void vpn_disconnect_check_provider(struct connection_data *data)
 {
-	if (provider_is_connected(data)) {
+	if (provider_is_connected_or_connecting(data)) {
 		/* With NULL service ident NULL is returned immediately */
 		struct connman_service *service =
 			connman_service_lookup_from_identifier
-- 
2.39.5

