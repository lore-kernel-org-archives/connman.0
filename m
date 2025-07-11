Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07632E7BD1
	for <connman@lists.linux.dev>; Fri, 11 Jul 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244077; cv=none; b=nx2g16ULr/G8MWscXna/dmR5Rjg37aw0GQATldibg48Z2Y6wSdHL+j7FbiVfJO6cqJpRT0ZnTOGlY1pfZP/uOzOmoFffXjQmrP4H9WUO8dHcNQ5vYip+1grjyJ6StrBWNNaIHHcMUn3GZWZu6LXdc5Z2SgLBuGJtXeeQP+jJCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244077; c=relaxed/simple;
	bh=+owRKTCdUue3tQuu1OknlyhLlCRu69xFWS0WXyvZqZM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VI9cIipTUlZrQX7ijLWGVqFs9OOZC8nUWArNAfUspdjSSAApsFjJ7MQGbEAzJXBxZ05AFzbQgQbmkZjJxiz4AcQPMsg4mtarPSsRNqBLndKyYMnoalSBeVcE72maTGnTWrBpAUQozhAQR3hoLqclCbuLMSkGxOLW/V3AYkbLkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=zsJKZEe9; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="zsJKZEe9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=keaFWRJX51KwOFbAIo/HETAAXunPOfNwvycf8FLe4V4=; b=zsJKZEe9E88gF/MEEN5k3Soksu
	8i/jXOCazD3MFHC6joElBNNymSZXmwgCeMBWUBn78Ko2/Tw+0kJHvCWQ9KQeZ8mGXXq9XJ3BtWFX8
	/e699BqCR17Owl6kJhgJ2ZY5+nMquwUDhAOrYSXODU8a8Pei0Ueg+ujvOhYHKUR4fM+OklU66Wa6L
	bGRLGAinb29cnpqys5+HW9Iup6T4ERU8XeNuyUdbCBKCDgR0yLo8kz//G0i/R0qC/Q4QI9ZMD3D3D
	wGbnTARpDLH+lr+ffjfGLMdc3icQfQB22zTySYhMMYgBiXEJlErVCvglNCt62Ani5rF+an+bxZ0mq
	dgwRtyig==;
Received: from [2a10:a5c0:37:6500:7901:7c96:5fcf:719b] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1uaEj2-003kbq-1C
	for connman@lists.linux.dev;
	Fri, 11 Jul 2025 17:27:44 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 35/45] service: handle also EALREADY in service_connect()
Date: Fri, 11 Jul 2025 17:27:26 +0300
Message-Id: <20250711142736.1757060-36-jussi.laakkonen@jolla.com>
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

---
 src/service.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/service.c b/src/service.c
index 9fd8fdb1..28e6192c 100644
--- a/src/service.c
+++ b/src/service.c
@@ -9945,16 +9945,19 @@ static int service_connect(struct connman_service *service)
 	else
 		return -EOPNOTSUPP;
 
-	if (err < 0) {
-		if (err != -EINPROGRESS) {
-			__connman_service_ipconfig_indicate_state(service,
+	switch (err) {
+	case 0:
+	case -EALREADY:
+	case -EINPROGRESS:
+		break;
+	default:
+		__connman_service_ipconfig_indicate_state(service,
 						CONNMAN_SERVICE_STATE_FAILURE,
 						CONNMAN_IPCONFIG_TYPE_IPV4);
-			__connman_service_ipconfig_indicate_state(service,
+		__connman_service_ipconfig_indicate_state(service,
 						CONNMAN_SERVICE_STATE_FAILURE,
 						CONNMAN_IPCONFIG_TYPE_IPV6);
-			__connman_stats_service_unregister(service);
-		}
+		__connman_stats_service_unregister(service);
 	}
 
 	return err;
-- 
2.39.5

