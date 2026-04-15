Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7802F6577
	for <connman@lists.linux.dev>; Wed, 15 Apr 2026 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252213; cv=none; b=YZ8FkySFhiRxHYVzBfAAQ/4ZRiZIplhORzvtA19Y59VSkhzKOwxOU9zeRUeaePlKpdv9gbBku7+NniHIN6asFJP41+zhVddy4+c4WNsP/8Rd8P9u7OOynQaKyIbrN3zf/ND0WFmb71x2T7RzdHoJL4sNUQ4s1S3WwKAtG/ig/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252213; c=relaxed/simple;
	bh=6oSV+I/KhzbJdaEknQt1rLkNLlMLpMWqBAArtSg4o84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lwFbs+HT2LMIXu1LTAy2JDHIJgZ3ym/Um9bHgFsUmFHArBCS6GJBxaR8LGmw1O7r6UGaKpo3Mshq5zJWaqB7gpUr9b5zlZJxUn8U5hczk5Nk0eedDo8FZEKK0GGCR0bLU4QkNWmHpdns/WwupOjLKbhKFb0DjqBNtr81ME/RFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com; spf=pass smtp.mailfrom=dividat.ch; dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b=dg9QMQqr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b="dg9QMQqr"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d70b3e159so1589776f8f.0
        for <connman@lists.linux.dev>; Wed, 15 Apr 2026 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat-ch.20251104.gappssmtp.com; s=20251104; t=1776252210; x=1776857010; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SivvhjKqyci/V3TV7M6dFbA19EgmzRxvfeL2A9RXxC4=;
        b=dg9QMQqrcS6BjxspnTlM7f9biBQUJ5KurbLg7bSWYcKhMWhrNhe/tJEF2EaxvscaBc
         7VBUjCDVGrgMDbRSsIDusiVh3CS1RcyFbDAB5GEPDio3xjGzP9B0Jc9a221l/cIW3UPe
         XB0Zo0F1akeKLsdHoNsq9Wo+BHSes1L+lnx1wHlKPVR0z+9SmV07QLF7E/lWQg7YY34w
         3wN52/KyqOoDqohOuUhos7/ZWN9LJf27aur4GHJisASTbJsFdE12rTNePA8lhd6bYAo9
         9APsDu3VpYUZshKUhk10/LSBmTm9qrLS0lB71Q58Ojn1XwaIO5YMHPZNZC9jihTGX8wm
         7d2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252210; x=1776857010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SivvhjKqyci/V3TV7M6dFbA19EgmzRxvfeL2A9RXxC4=;
        b=ENX4DdJvn6IejA2g+nijKEnhlCackoU1MB2h+WfbJ+Z0I9n4Uo4PdnplPr1O2x3uGa
         LUWu2EIxuHj8jjlICORH21Y1wD108Bc/WB6Lpe9w11Uoff/jkCX1zxKLZolRegXGGoZY
         IL7HS9rTVT/RCOBo4U7tYjdOcIB1Wccu+qEAYHCvHupT6q91Sk2pic6+Aw4qfPkp1qJB
         Oq6z8kH/vJPqQiwfM0eyvO7eOgT1Xfet4CgjAV4WPzTBko3gSnisISmrDwcfc70wdTDD
         BLO0VP6ebifxi+AESC3Vj92Y3mPuWKTfAJtwuUm0uHbY0WyBz7txEhFvXfwWEdP25Y3B
         nU8w==
X-Gm-Message-State: AOJu0YwqpPJ0RxhMJA9Nz2ahEgaDHOwS5n96iou3uQHR0yK56vlwaiPF
	mTbNn28SX5yrrg81ZADx2nov6yzZV+rbUwE9DMJ/idJIk8J4Raakaacgs7GnMW1QMs6CG4jZIcw
	BQstk
X-Gm-Gg: AeBDievBQHxGQYwbsVDLE4GNbOH0Y7mglXiWfk65xuvQOb8gOVacO15Veov5rkuLgLV
	1VsceRIphK84yXnp4st2JsqOaB1c0yJHOkqK8QLijsStk3vwii6BmZK2Q/tDKrqEVYBhvDp6uoO
	B8+EoiFUFuqNGboAZ2Nc5L/VrLGb2jFNHuVI9aWchBwax3ASvSmm+dvDd6X2JQNoPwPdOs+Sk6r
	OBRNEGUJr+Vno0kW33URiRcu8t0pANRi5KlbBypkzHTpzKU4teHJ2z3a/d1SkvlUaoDyBTLH7Xk
	UdgvO6cAMHFrCm+AT35gOJHKYl4Lft0PzSAOsnTgZXGEUPhTsv1+masm5Cdx9cQzgmLDXLCPJZC
	gAUiXVKfUJc3BiA0lmDggeREFvrCnI2pKr86SDVaX/2oePDDwPelnJuh+2CA/374MpizgA6U4dN
	mf3KHc8FlITdEJ4HHsCc74LFXpjirVsfvZtgkmPiYmKFqCyTV25jd2KKGq33nvPQOc0d+I7yXgL
	7foydqyrWuWhFblEdrGhEfeEK4pI+7v4yoApMBdY6A9fwF5+aXvGMoJc6IvBErHTT//EPchoQ==
X-Received: by 2002:a05:600c:800f:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-488d67b8d81mr288512955e9.5.1776252210284;
        Wed, 15 Apr 2026 04:23:30 -0700 (PDT)
Received: from sugar.fritz.box ([77.21.195.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f208451bsm37915065e9.14.2026.04.15.04.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:23:29 -0700 (PDT)
From: Johannes Emerich <johannes@dividat.com>
To: connman@lists.linux.dev
Cc: Johannes Emerich <johannes@dividat.com>
Subject: [PATCH 0/1] service: Prevent link-local default routes
Date: Wed, 15 Apr 2026 13:22:57 +0200
Message-ID: <20260415112258.1076252-1-johannes@dividat.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our kiosk system built with ConnMan typically uses two simultaneous
Ethernet connections, one to an input device using a link-local address,
one to some network providing Internet access. In most cases ConnMan
reliably uses the Internet-bound network as the default service, but if
the network is slow to respond to DHCP requests for some reason, both
Ethernet services end up with link-local addresses initially. In this
case, ConnMan may choose the local-only connection as default service
and stick with that choice even when the other service receives a good
IP and gateway via DHCP later. In such cases, the device will never
configure a usable default route.

We have been running a similar patch on top of ConnMan 1.42 with
hundreds of customer installations without issue.

After porting the patch to ConnMan 2.0, we ran our VM-based automated
tests to verify that late configured services are chosen as default
service over link-local services, and they also pass for 2.0.

Johannes Emerich (1):
  service: Demote IPv4 link-local services

 src/service.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

-- 
2.51.2

