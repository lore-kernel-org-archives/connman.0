Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA53212548
	for <connman@lists.linux.dev>; Wed, 15 Apr 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248141; cv=none; b=cKV02XlJ8i06LxAa/6YnA3EsSKdXJKm+ix8201YBQ60l66ddvaC1i3dwSJklw+Y1rwj8iPYIOyo8miammtDUrSi4rxfRMKlWjnxtS4ltSFLBgk3V0C40RUvXMEVqgMw+nR27UmE9QMoNOmUmHZBGm38FLuBtYm/J0tmrXGiJG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248141; c=relaxed/simple;
	bh=c6ikiZoIf2JTepaxmNtpvmF6568iBJqLgdcm3aOgRZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xg+Gjt/pSkRRwKhcfRE7QjsEITdDVQK5B8pmwfI2dqCwAb9O3kosJiS1QvSr2AwGTBz2hLsNsVoDpf79oY6vLpR+kD0TYiXEb8X1sM5K6OyUvFJ79f2cKWCFK1lr67qigS5G0uRn5W/hrtN9ssuRJZBLcQqAxwEfr/Cqn6ZwgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com; spf=pass smtp.mailfrom=dividat.ch; dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b=Ch1G9RFD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b="Ch1G9RFD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488d2079582so60658395e9.2
        for <connman@lists.linux.dev>; Wed, 15 Apr 2026 03:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat-ch.20251104.gappssmtp.com; s=20251104; t=1776248138; x=1776852938; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oectx4WZQh/0YJ/A9qcopcAFwocPIQdTs1LgDmOdXkM=;
        b=Ch1G9RFDwTiLJIzTx59PVZWRfyGxW5AbexUdTK9QfrHQQ/jA1TqzHnb9ZWs94Zf7Yb
         pKONjtObuqNsN2ZPsU6Jan8pKOpxp+jtq5QFSSls6eEELEIY8ks40h6chMOfs5x8uzF6
         naUYlF5cD2MT7k5M8/VVBwH8iR6pEod3Dl8OhNbmSNQkDn5LPcRj5Y+O7yaC3/ptLYUc
         FyPb1p9kKhK+FR+iSKgvAaGQT59+x84lB6YR4a4t/Sks5AgPu1mPGkdgOuFzHPW1vCl/
         ++ptFgVxhjPDjfbe3v9PGAWbH+CAVNZFeJj0RKc73C0izBDKhfu+iXy7GFFziehS/rna
         fhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776248138; x=1776852938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oectx4WZQh/0YJ/A9qcopcAFwocPIQdTs1LgDmOdXkM=;
        b=tKRO1w1bVR6u/EAhqI7tHjVSjaV/fpHmbsWM/nB5i0nsce7oY8NlcV5p17RE+8Rxiq
         P7J96W/u45ViZ7b7icFR2/abF7ToJIi5wYh9o7KKONg6PgD3Z+Al+xZN1FteE++K1m7/
         RoseY3B0xK6646+4HHJJYwgG8d5y/YlAYBj/8+qXTrBLaKHt0j6uSCG2P4PdH0ToUlnj
         67hhxECfE/WisJDxP3VUAMGbL+q9Mz7sJcOvBwg8IA4IGnMomnrT+Xb6lmQz1fVn6fHe
         Egx6oVAaDHWyRQEo7DTZITTdEFycBz7xRvNjb53ujGe2bFnHgDbDTRXLevKuH10E3sv1
         eaJg==
X-Gm-Message-State: AOJu0Yz5ba1ZjKaVdgqL8J1dRQTKH3tWf+K3p5nmZ7rhMGMdAxgLOtxH
	bJujBIvp+wHOoe+4+3Ske7OjGWQSdZS9xwG7ecVt0DVyoTDrbinqj7lJdmn2+Xy96Fk9JHV1lkX
	W3w0T
X-Gm-Gg: AeBDieuaVPwuvEyRK+74sHp5rHR8R8HKEDavO2VYqt3mWSQyi35j8RuNttqy8h55f+g
	x62c09rEnajt6PD3H7D/M69NUnN3JK8+xsjvltJNpq8s7ZtEWQLFC1FyfGWYfOtS9vCBujIw4aV
	pcNzch6/ZGSt5CQxin/k3RP7/VAgdHL/Z2DhCoPVL7AKA5cvQGD8MbQPbHLn5vYXOkyqH2dWVLn
	WKZsAU0VOcYskbzikCxHR6cO2EwvLpi4GEWHpNmtoN+zCsNN3giMxwg8QcX6BEUQx6Z/knXZS5F
	j7w1yAwECWqBugJAt82Vc9Wk9ogDXApwedbZK5QhgNcYufEr6I/UL4/1YfRgPz43OY5chUgbbHh
	9XuLlzT3Xe2Fmw6nb/kAbb6L77rONpM4pyp0/FsRRg6cMHdDdPrE3SNKX2mXrkme/fqeAU56qT3
	8YoLghZSAOZJASlRM0WG3hqpgt3HJnrLWInWd3YPGvxEB3y+lyEVOhuzkk1luvTwZcCMCO98so6
	7+a+wEZTSftaD5BVD59AfZstz40/OU9W/K0EMCk8DYbCai/AHr7lKc7JK6rBqctdHooM5M7Xg==
X-Received: by 2002:a05:600c:5298:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-488d68820abmr305951855e9.27.1776248138004;
        Wed, 15 Apr 2026 03:15:38 -0700 (PDT)
Received: from sugar.fritz.box ([77.21.195.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1513csm131435235e9.2.2026.04.15.03.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:15:37 -0700 (PDT)
From: Johannes Emerich <johannes@dividat.com>
To: connman@lists.linux.dev
Cc: Johannes Emerich <johannes@dividat.com>
Subject: [PATCH 3/3] wifi: Allow retries for more assoc failure cases
Date: Wed, 15 Apr 2026 12:15:01 +0200
Message-ID: <20260415101501.1048919-4-johannes@dividat.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260415101501.1048919-1-johannes@dividat.com>
References: <20260415101501.1048919-1-johannes@dividat.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously only one specific type of disconnect during association was
deemed retryable -- but a disconnect may happen even due to errors
unrelated to association. Here we widen to allow for more association
errors and allow retry if failure was completely unrelated.
---
 plugins/wifi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 3463fc33..d3a2340e 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -75,6 +75,7 @@
 #define P2P_LISTEN_PERIOD 500
 #define P2P_LISTEN_INTERVAL 2000
 
+#define ASSOC_STATUS_OUT_OF_SEQUENCE 14
 #define ASSOC_STATUS_AUTH_TIMEOUT 16
 #define ASSOC_STATUS_NO_CLIENT 17
 #define LOAD_SHAPING_MAX_RETRIES 3
@@ -2499,10 +2500,24 @@ static bool handle_assoc_status_code(GSupplicantInterface *interface,
 	return FALSE;
 }
 
+/*
+ * Checks whether the wifi has possibly transient failure in association.
+ *
+ * The following cases are seen as indicative of transient failure:
+ *
+ * - Association code is initial value, meaning there was no explicit
+ *   association-related failure. This could mean a deauth occurred during the
+ *   association phase.
+ * - Authentication rejected due to timeout
+ * - Authentication transaction sequence number out of expected sequence
+ *
+ */
 static bool has_transient_assoc_failure(struct wifi_data *wifi)
 {
 	return ((wifi->state == G_SUPPLICANT_STATE_ASSOCIATING) &&
-			wifi->assoc_code == ASSOC_STATUS_AUTH_TIMEOUT);
+			(!wifi->assoc_code ||
+				wifi->assoc_code == ASSOC_STATUS_OUT_OF_SEQUENCE ||
+				wifi->assoc_code == ASSOC_STATUS_AUTH_TIMEOUT));
 }
 
 /*
-- 
2.51.2

