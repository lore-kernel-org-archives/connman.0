Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812F1F0991
	for <connman@lists.linux.dev>; Thu, 10 Apr 2025 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302791; cv=none; b=TlwXnIVGeGe3IilWjGhPvwkte526FiDpRk01el/cezAcxjm/vPt1ocIe5TIVPtioaaMBMkliYUI1SybJ2W2nsr5cqlZZteUQ9/enB1vU7Tj9K7hFbQLeiofChom8qu3pxl0h/33VvWNkuOLp/qApUPaZubnS6aBBy8Oz6olbQJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302791; c=relaxed/simple;
	bh=JcCogZpcN/ef2az8CHVckjE4CAMr1wwZeDBvyh95OX8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E1wnvpq8BShrHr5AIhwStMP82n/+XNReOBfSH3f5/7aB/IbGhGOahAm7XoF8v6amH6CuRMkul+uJmLduCVtiIHb0w1LgoUYCap8rGEemBS5B41BITJShos8wKfdkm0W1MqCDBDo933HbE4xzaWmcifFwprv7ewvdm1PY2wX51N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=17Cb9qRX; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jolla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="17Cb9qRX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OdAZc8Mebrr//7ZNZplq1xCHLGkGvb5EgEGg24Gme6g=; b=17Cb9qRXAJESEsje8+0hvImai0
	Ac0WCkiaQn5yBYz7AnOeL7/Um2dCQ4Z02UkQuxtWn+axDtZeGWOuQoYweGzUIoj5+9oW2hu2CPXuO
	jqPO/iE1NG+RP+QPVwpswSK3Pr5XBDqOqE6p9vZwvsQxG2zbqQJUAOVCcraSUKSIAj9fv37jUQSBa
	8j7N3ehFxa1ImXkZQyXD5jBZ8BxM4eq6ns6wryuJReZXjtw15tm1/HOR3HIM04oWG+bSANWdSmaL0
	0k0id5O+qwRthHofg+o8IyALhgYQc5fCd8I7czX2VxXZU97nQfICGF40z7Hh8O0hggeO3hhikOW0h
	R/hSWJ2g==;
Received: from [2a10:a5c0:37:6500:604d:112d:4f8c:3578] (helo=jl-x230.local)
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jussi.laakkonen@jolla.com>)
	id 1u2uIp-004Gb9-0H
	for connman@lists.linux.dev;
	Thu, 10 Apr 2025 18:58:55 +0300
From: Jussi Laakkonen <jussi.laakkonen@jolla.com>
To: connman@lists.linux.dev
Subject: [PATCH 4/8] vpn: Fix mem leak on nameservers
Date: Thu, 10 Apr 2025 18:58:42 +0300
Message-Id: <20250410155846.252858-5-jussi.laakkonen@jolla.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a10:a5c0:37:6500:604d:112d:4f8c:3578
X-SA-Exim-Mail-From: jussi.laakkonen@jolla.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

Fix Clang analyzer complaint about mem leak on nameservers.
---
 plugins/vpn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/vpn.c b/plugins/vpn.c
index 9664c82f..9e6e26bf 100644
--- a/plugins/vpn.c
+++ b/plugins/vpn.c
@@ -472,8 +472,10 @@ static int extract_nameservers(DBusMessageIter *array,
 		DBG("[%d] %s", i, nameserver);

 		nameservers[i] = g_strdup(nameserver);
-		if (!nameservers[i])
+		if (!nameservers[i]) {
+			g_strfreev(nameservers);
 			return -ENOMEM;
+		}

 		nameservers[++i] = NULL;

--
2.39.5

