Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB023B611
	for <connman@lists.linux.dev>; Wed, 13 Aug 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098991; cv=none; b=FzjwaWFw8MmmH0BRTm6EZadFlp8o+HbCTxlAD4XIOngRU6VBIP+h+bFQ0qCpqQgEn/SwV0XQyn9fLtQ2gSU86bYMWT2ZIFxnigHOV8A3uPlzBUWfka+qyEPrMGSWFczBuWLdw46YYWQ7oZgwHpK80r2eANqoMUfAw5hrdCGe+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098991; c=relaxed/simple;
	bh=3iKAZGlGbRNKFClc7q5nErfS7ZJBHvArt1nD6qB3e9I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BMP8G3WVKidBRZECtqEAdja9Q4cw0pEL2WIEGuCaYg76qpIYNBlQBkLUiIS2a/F4l9QejEOAHyUA070VGzbVDaP58zd/+PRt+JTtC2q/5bd5p/gkrULlKzjlNS7OA2x/WL1Dy0bMnsPe5LoRJt0PYgzRg1pJK3fSpDV35RMWg0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=DC6YUW3h; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="DC6YUW3h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e8y6mpChTZw6VMD3KVWD31igdEjVpGQ6F+L+BPHcj8s=; b=DC6YUW3h50kiKUIxrdN98TOtrW
	s/bq/FGfnXnzadA4/T7JW0bR1bonHBp9TQB7a7INEEj5kvgbyz3+ljqqfsV9+0dTDuDGCALBpKEu5
	b8487W2bvne7iQuNAmkwOW8T7Iqk/E6DRxISt5VEU4FQ9RrlVQhOWQmMohKWfNvTId9MB6gfcyHES
	7FUxihwQkk0YGhaBtBGalUTW3tHgUQMtPmlpbObcuL3Aqz11+I76e/Xqv8/EAmYVywGzA+/aGFC97
	TQVh6ktg1BRZ4T3xZj5TdE/RFBjWngXGa7ceXCzvqUaLHgUhr41qUwhjNVenAcqO9fE+rBxgbZZY/
	T+kvi/hg==;
Received: from [2a10:a5c0:37:6500:b275:797e:525b:8df9] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1umCzf-009qQa-1Q
	for connman@lists.linux.dev;
	Wed, 13 Aug 2025 18:02:23 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH v2 33/42] service: handle also EALREADY in service_connect()
Date: Wed, 13 Aug 2025 18:02:05 +0300
Message-Id: <20250813150214.189282-34-jussi.laakkonen@jolla.com>
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

---
 src/service.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/src/service.c b/src/service.c
index 28e82c81..73f777f3 100644
--- a/src/service.c
+++ b/src/service.c
@@ -9950,16 +9950,19 @@ static int service_connect(struct connman_service *service)
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

