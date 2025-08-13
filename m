Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E927FB2A
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100748; cv=none; b=JS/lWj11Vc6wRDPOM2HBMoUexDr5Izippc/7NJ9ggVaDVpDRzUuxH4Ri9bWQ6Pf7y+vMugj6O2otJP/c6rc5YiCeLySUuI9QUCurkPVdf34V3ak2MrRuDR5U21kdJXSiypxOR+ic+oHlTKxtukNRnt8f3/+jZYZETvg0wn73OiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100748; c=relaxed/simple;
	bh=CLOgx7a3KIO/JZCkvzoEKqQ1Sz1/c+n2OqLBuTWL78E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oGko2oZPJuJTmxv+bMYDvAb06bYulGpABTxbzYFCtq8QHc7fz/1vjyNtpKo+ObHTsDrFRj9e7rIJd0KVtcYUSGS6zw2+WYJCZHetsoTuVsfoJNwc5U0XlfW+R3WrkMIh4HFmUNRhsutwdw4At3bZ5K65biT/asOimCc9AmLLbGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=YdDhenBW; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="YdDhenBW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0QIqjjQFuxN+9pNS3sTxec2Fxr5xqLo66osRJpVUeIw=; b=YdDhenBW9JYwzN4s6ibkGAhPBv
	bFrO9QQ+jZ9jySUm+KLpp9D78x+HheM8a6p8kB+fTeaqhZBz1QCICMxsSvgTozOMlE3rZMWsGqM5W
	kZfaWkfzC9Q2QlvXek7UnqWUZ90aPHp1gsgwbRm6lZe0qZTk8jrG6d6wddhSdVLpHx/7raEdnrBuk
	ybQ4pdAxrp9OO9N8+wEuV52ogoFrK57FmIGf5zjZjkZkmcOgySIJtV4L7TOgOS+Kmk9e8sh9bhPUu
	W89BpY/TEla/Io2st4geYk4CgYo/EhnsYkrQfYs2yrXQY+T3Agbx4AZ7XrQcGc6KU59Q/fjkcCb+6
	e8uemWSw==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCze-009qQa-0b
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:22 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 05/42] provider: Handle VPN configuration and association states
Date: Wed, 13 Aug 2025 18:01:37 +0300
Message-Id: <20250813150214.189282-6-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
References: <20250813150214.189282-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:b275:797e:525b:8df9
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Set the association state when VPN is waiting for user input as an
initial state after connecting the provider. Set the configuration
state (as it is declaced to be the string to connect state in VPN)
accordingly as well. Start VPN connect timeout (starts in configuration
state) with restart option to ensure that the timeout begins from the
last known configuration (connect) state.
---
 include/provider.h | 9 +++++----
 src/provider.c     | 9 ++++++++-
 2 files changed, 13 insertions(+), 5 deletions(-)

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
index 1f0ce10d..d7218420 100644
--- a/src/provider.c
+++ b/src/provider.c
@@ -126,6 +126,9 @@ static int provider_indicate_state(struct connman_provider *provider,
 {
 	DBG("state %d", state);
 
+	/* Connect timeout starts only in configuration state */
+	__connman_service_start_connect_timeout(provider->vpn_service, true);
+
 	__connman_service_ipconfig_indicate_state(provider->vpn_service, state,
 					CONNMAN_IPCONFIG_TYPE_IPV4);
 
@@ -291,9 +294,13 @@ int connman_provider_set_state(struct connman_provider *provider,
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

