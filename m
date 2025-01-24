Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32A1CCEEC
	for <connman@lists.linux.dev>; Fri, 24 Jan 2025 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737745224; cv=none; b=Sq5sgMuf2S0jcc0fYn56E7EEwI0DWHl68QtiUgXwEhsxDwM2k/gID3QQeuvV4UHtbfDIgyAuNbxWyhtg8MLY4wZYcITc79ocxukBL5GEMUracpkjgNk/igbTutOYNzDv7jylEDZXQlmkMQ339+xG2BGFaOYQDgA/1gyLMByQTIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737745224; c=relaxed/simple;
	bh=Mq0D2v/c/zPi6whT/EEsDBVNPp3aPgOEOZ9eQmP2aNE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I298N/Gqo+EOs1EB0Odfgyoies7UrQ9J77xqJxEYgtve4DCD12o9bQ//tgaq2699P99wsvyMcqWdUh2+DlQTZS06mpUoHqNW3zYaAFrIgfRr9CNCSTIDW0bclbl7Rb3+42TKfjAbBV8RjzhsZmG0gnsPTKXvvq6YW3HJnnSozZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=higmS30X; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="higmS30X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZtKKFc4NPP3T+LTZpiARc1EOE5zDgHI+ySveFs0mGNg=; b=higmS30XGELOfPuRe8uJ21K6pz
	lPQgelz+zEYcXDj+Dpjxlpu/ENAogZzrwChly6CH8OOsEuG296dasVujCrrAfOL4X3Q/7zAtJTiw8
	ogWs2ui/9konl0W1Q4JodWd77W0ehTV2Jd0SStO65ux43D3NVFkhsemTn+EVA+jbnZUgvW3qLAFzv
	jvMpApPOk2I37VLNuLMRmGL2OiNEulqUljbAqhFT9t0wlEC6/JI/3uNJToCdCiOtQGIXUPUO4nkq9
	AuUYfy5OSbiM+2xSGKt5vTc7DrsmsiPE1GRiutSKX2A1iLpMcKgxr0wDyYJWtF6aN8LwFs8THGTTX
	XBqmiXEA==;
Received: from [2a10:a5c0:2c1:9f00:b95c:6569:8d10:e7e9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1tbOtI-006LIb-2T
	for connman@lists.linux.dev;
	Fri, 24 Jan 2025 20:58:52 +0200
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 06/11] provider: Handle VPN configuration and association states
Date: Fri, 24 Jan 2025 20:58:40 +0200
Message-Id: <20250124185845.1546384-7-jussi.laakkonen@jolla.com>
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

Set the association state when VPN is waiting for user input as an
initial state after connecting the provider. Set the configuration
state (as it is declaced to be the string to connect state in VPN)
accordingly as well. Start VPN connect timeout in configuration
state with restart option to ensure that the timeout begins from the
last known configuration (connect) state.
---
 include/provider.h |  9 +++++----
 src/provider.c     | 22 +++++++++++++++++++++-
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/provider.h b/include/provider.h
index 3f2e36ad..aac47527 100644
--- a/include/provider.h
+++ b/include/provider.h
@@ -44,10 +44,11 @@ enum connman_provider_type {
 enum connman_provider_state {
 	CONNMAN_PROVIDER_STATE_UNKNOWN       = 0,
 	CONNMAN_PROVIDER_STATE_IDLE          = 1,
-	CONNMAN_PROVIDER_STATE_CONNECT       = 2,
-	CONNMAN_PROVIDER_STATE_READY         = 3,
-	CONNMAN_PROVIDER_STATE_DISCONNECT    = 4,
-	CONNMAN_PROVIDER_STATE_FAILURE       = 5,
+	CONNMAN_PROVIDER_STATE_ASSOCIATION   = 2,
+	CONNMAN_PROVIDER_STATE_CONNECT       = 3,
+	CONNMAN_PROVIDER_STATE_READY         = 4,
+	CONNMAN_PROVIDER_STATE_DISCONNECT    = 5,
+	CONNMAN_PROVIDER_STATE_FAILURE       = 6,
 };
 
 enum connman_provider_error {
diff --git a/src/provider.c b/src/provider.c
index 1f0ce10d..ab4aeafb 100644
--- a/src/provider.c
+++ b/src/provider.c
@@ -126,6 +126,22 @@ static int provider_indicate_state(struct connman_provider *provider,
 {
 	DBG("state %d", state);
 
+	switch (state) {
+	case CONNMAN_SERVICE_STATE_UNKNOWN:
+	case CONNMAN_SERVICE_STATE_IDLE:
+	case CONNMAN_SERVICE_STATE_ASSOCIATION:
+		break;
+	case CONNMAN_SERVICE_STATE_CONFIGURATION:
+		__connman_service_start_connect_timeout(provider->vpn_service,
+								true);
+		break;
+	case CONNMAN_SERVICE_STATE_READY:
+	case CONNMAN_SERVICE_STATE_ONLINE:
+	case CONNMAN_SERVICE_STATE_DISCONNECT:
+	case CONNMAN_SERVICE_STATE_FAILURE:
+		break;
+	}
+
 	__connman_service_ipconfig_indicate_state(provider->vpn_service, state,
 					CONNMAN_IPCONFIG_TYPE_IPV4);
 
@@ -291,9 +307,13 @@ int connman_provider_set_state(struct connman_provider *provider,
 		return -EINVAL;
 	case CONNMAN_PROVIDER_STATE_IDLE:
 		return set_connected(provider, false);
-	case CONNMAN_PROVIDER_STATE_CONNECT:
+	case CONNMAN_PROVIDER_STATE_ASSOCIATION:
+		/* Connect timeout is not effective for VPNs in this state */
 		return provider_indicate_state(provider,
 					CONNMAN_SERVICE_STATE_ASSOCIATION);
+	case CONNMAN_PROVIDER_STATE_CONNECT:
+		return provider_indicate_state(provider,
+					CONNMAN_SERVICE_STATE_CONFIGURATION);
 	case CONNMAN_PROVIDER_STATE_READY:
 		return set_connected(provider, true);
 	case CONNMAN_PROVIDER_STATE_DISCONNECT:
-- 
2.39.5

