Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA22C0F8C
	for <connman@lists.linux.dev>; Wed, 15 Apr 2026 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248140; cv=none; b=TDobcxGJCnxMftNGdkKpP89oGdUYpTVqeUKv4FnB7gwgjeX86Vhs9UDOgimJCDDDrRRaZbikpVZLmE+1XdJuf9hIwjBEjVDjLqtiK87mj1NL90OyMYdv9VnVNC1rdz0zGR1uj7dgS6A5P5g2n6Z4m2P+IEwVtIeyxIrun73a9tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248140; c=relaxed/simple;
	bh=UIuN30htjqxqSOteMXahK5gFl7fR0dEhnck8IRjNse8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDldAseeZtNVkLb2wITW4y6ELyarCM5Cb2iwID63+fVReouxO1edFAU7YcJAidP2p6K0Q72EK2Fev4kXKlDoureRHXh10K8Cv3G5p2D3oUyvXue//5kBQ20zg/zFkRh4M0nUBU9yxcu5pWaldX+cMgnDpN8HtbiAMELjMildD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com; spf=pass smtp.mailfrom=dividat.ch; dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b=m3COwUlT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b="m3COwUlT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso80172105e9.2
        for <connman@lists.linux.dev>; Wed, 15 Apr 2026 03:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat-ch.20251104.gappssmtp.com; s=20251104; t=1776248137; x=1776852937; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0wNRM5eOl2d/xuGRNlIoWJD9zfEnyMpcujqhqFNvq4=;
        b=m3COwUlTweIQxIKDR+zkfTOiQrdFdRXbhl27ppNbPIFkenxQa5YXM3aEgfw5IJXVZi
         9zXeSunx/L7G06US4oFYgSImT2KEOXuiPrLqIEJV9vNv5aBaDXOalFDusC0+eU6SLgL6
         pt/0VbuMNsGRpr7At9x9EPGynLqI0gHNQ+oaIfntC4wVHAhNAUGGM8JE3zPMIFjVzn72
         E6CD82lTEATkvSUhpOCR/nkL+qH+AIpmk6/8eliGtLT2jBUeYgYSFBRKDcvZoPPoJqam
         NC1VwyMRkh7qkj1Zvn+aS2VjW6sK0pLlJCmg4MyVaAvfQRwIrB5B98OK2KlVJkMa+3qZ
         jYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776248137; x=1776852937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0wNRM5eOl2d/xuGRNlIoWJD9zfEnyMpcujqhqFNvq4=;
        b=IPE/Q8WVaKP9FHwsne5PDsyfwpHWQ2s1jvfjwzLqNMRujzZVH1S8PeRUaCcXKf2J5J
         BXlfXX9F2iWkyOK/gzSEAfjmWPOTqRhTNcpviUM/8Sc7P7/TsK0y0JKeszlUYrjZn/Rg
         fUqAMFrrBm7rTQUSLZ02kRVd9oD8BH/QL1W79WcA52f+VeLt29kzvTqVODULk4pEf6Jt
         ARRyE9QFPQrh/waodJDGCysjr4vwLh1XIc6LUqVzePW4RM2wmYhPSqwT9faI/0Fyqx8J
         InOrqsB1lPtwMZ4Zu3xHKYKKAQXFre5ZdqXtQ/CKLaWcABqOK7F046+zGBqoI6X5Teo6
         H8pQ==
X-Gm-Message-State: AOJu0Yxl1jhQXS/hrb6ZUEPqWIB5IuiFz5Te5i1rGCoIODdYbCcsMI6q
	dLk6qBn4UoNh4T7Kjo+zpIv2Et5ShZcf2qehUrrSIkb+XNCRd3+QqSluoL+IqiJDQRvrGUPFRFD
	WsimM
X-Gm-Gg: AeBDiet3Z1w352eT+uEECtf1k/JpvWBBhNP8NGW7195T/WRpYchywVm5Ljg0uh/9r9T
	sH5h5NJ7sUhulKLpGyX2An59KcIXuzZv43WEBeXZ9PmHamA7hGznB2iHfj+HY9OSEe/mFitcx2b
	VXnIxZZMclk1FPADP6ruzhlG3yXFfGNRsjO0bFiDVyO41AuXKW2NfYCKky+Do8urkPRgBBXchYS
	F99iZO/ogGopm55Bav1Oym2oQNFDcoMfkhU4kBc2VnYKGeyIPIXzn9F9Nn5jOhiXFZ24VzckWaQ
	6OLcRsBVatyeD9Qzj/3hZLVuVSVf4q8pLQ2HI+TA15nGbYr3EmVQ/9+8VNYsYUIwivnYcW7p4Uu
	u2ulkaUozErywjkH47IKpB1YS/T0jzdTF/7zM/BrmpVByGCszHRBdXFGw9cXfuJvrsXTDDutZsV
	7Dfey9L3mU4MgHNOpmWQg8b67Cw1uVl6NlTWMTDp0k/gmQwFk6K9ni5zoVr3BPpNkFW9ebKsHXL
	ERCyQ92w4baZiMhJvKCt2F/1xLK4EfLMa8q7l8/gJtz2g6/aftj9wXJNd7p1rCjb5g7/OXj1Fff
	piZdCXq3
X-Received: by 2002:a05:600c:3b24:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-488d687adb3mr302361085e9.24.1776248137030;
        Wed, 15 Apr 2026 03:15:37 -0700 (PDT)
Received: from sugar.fritz.box ([77.21.195.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1513csm131435235e9.2.2026.04.15.03.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:15:36 -0700 (PDT)
From: Johannes Emerich <johannes@dividat.com>
To: connman@lists.linux.dev
Cc: Johannes Emerich <johannes@dividat.com>
Subject: [PATCH 2/3] wifi: Limit invalid-key to repeated auth failure
Date: Wed, 15 Apr 2026 12:15:00 +0200
Message-ID: <20260415101501.1048919-3-johannes@dividat.com>
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

The previous mechanism in handle_4way_handshake_failure() would set
invalid-key for any "retryable" failure scenario once retries were
exhausted. This means that failure during association could also lead to
a service being marked as invalid-key.
---
 plugins/wifi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index a260872f..3463fc33 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2546,7 +2546,10 @@ static bool handle_retryable_connection_failures(GSupplicantInterface *interface
 	}
 
 	wifi->retries = 0;
-	connman_network_set_error(network, CONNMAN_NETWORK_ERROR_INVALID_KEY);
+
+	/* Repeated authentication failure implies an invalid key. */
+	if (is_auth_failure)
+		connman_network_set_error(network, CONNMAN_NETWORK_ERROR_INVALID_KEY);
 
 	return false;
 }
-- 
2.51.2

