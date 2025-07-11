Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD72E764B
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244074; cv=none; b=gCbY0vFtLEqThYNFCHBBxRPHGKwyfLZh+sv41/D6005BbJVq/WV4Ilcj4eF1oQGgsIZr0HSe5bJP8/s7qj3GN6UroToEBymDa8Bybt/cMIE7V4CeSc9WskKavVSdCGqUadRlD6hdzyvmFZo4T5fT662DU/nAPhNRIVEjKPBowC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244074; c=relaxed/simple;
	bh=Mq0D2v/c/zPi6whT/EEsDBVNPp3aPgOEOZ9eQmP2aNE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZevnXm+ptN+ZccEToyhfc2iMbCOpLszdhwibnCNlkIs+Lob0mrw21FruYnwPTC0LGCBnQmZ1Rg3UX1lvpCgE9JTTGLoGH3Vmwhv5sG0v4lKN//QFU7st1zOkKpG2gNu1EQ1BdwidIG3apq3R5CAEYIIoqbjivzn/BAhlqvo0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=dBpCgbtI; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="dBpCgbtI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZtKKFc4NPP3T+LTZpiARc1EOE5zDgHI+ySveFs0mGNg=; b=dBpCgbtImLEk+iWC4HhP/9CfS9
	FkjwE0UEHOooWsTV/u5yreo72w65sOeKSwwcv2qSFANLGcfsBz7hUTnUSCD8TqqJkmvNloaKyBIsJ
	8fZxhT8m3iRLTiCCy3F3EZlTx84px+qhA8CdD9qDWMZbvR1i5rSbO6q3gnqakXeUvfzeIDHvHDFqE
	MQliKw6GnsIEmwTtaFpO674n/NmPjaCvtKnns2a2PHzkcnLOYWSgSaZt7dStEl76ATBXxgU6fmWHs
	BqvY5zzkrEpf/s8bKip2RzCBELugxelAkW/UyGdDjQQZWsB9evNwjn2AlWNg9Yo06qT+jVWV/O6oE
	yjDRwqLw==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj1-003kbq-09
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:43 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 06/45] provider: Handle VPN configuration and association states
Date: Fri, 11 Jul 2025 17:26:57 +0300
Message-Id: <20250711142736.1757060-7-jussi.laakkonen@jolla.com>
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

