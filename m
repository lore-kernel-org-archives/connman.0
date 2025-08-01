Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52337160
	for <connman@lists.linux.dev>; Fri,  1 Aug 2025 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046359; cv=none; b=pu2z3EbJlsMuCZjUTq2tCy4Y/HZIQiCPXvCWx3Zw9YBMwui+H72zhMjrQz0ouMYzkqQEH2edxIqtu6Iw6m5TyGRDXsJ+tisJ2aq4DF+t+VI3olqvjsvL8kR6lbFYqZQoANu7VsskEeunvpgHTB4TQjXUSRa41yrgP7soTZ6lt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046359; c=relaxed/simple;
	bh=1grb30ykf2hBmXIvkLmZ+VayJfFV/vE6dR4uu2w4Vis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4aHA5bJkPPVU8N/kkZO3P/7YMnR56tFuAjoKBXU7V7gQArr5ifrpVXTsFJfnEhLb/pW7sUPM7pJXYsQnxoHT0x3K7dNy3eFyjRsX9WUUgHln7Vtc0HQACQCkS6imFk0WN6Ew34BpUhCYvJJljVqZz8XLq9i+NsejwEFSXdulVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com; spf=pass smtp.mailfrom=dividat.ch; dkim=pass (2048-bit key) header.d=dividat-ch.20230601.gappssmtp.com header.i=@dividat-ch.20230601.gappssmtp.com header.b=ztfdgMWA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dividat-ch.20230601.gappssmtp.com header.i=@dividat-ch.20230601.gappssmtp.com header.b="ztfdgMWA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45610582d07so13740325e9.0
        for <connman@lists.linux.dev>; Fri, 01 Aug 2025 04:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat-ch.20230601.gappssmtp.com; s=20230601; t=1754046355; x=1754651155; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dM+YGEJIOFtK8ipp/hjDSp8ZeQJhiCtadw4gRYqh5XM=;
        b=ztfdgMWAxmW0u0abt96F6RyoHbnpQMZBsZEba6M1hv/lq+jrr3Vndsn/qxqzF51Rt2
         gPWoPqA3oXQW+phwXdheTdNJAPgNJ+53MuQX5BzEvs9BmdAUN5J/oQLb3XmkJyP+SXYe
         3NM0cRSm1hLu43+kuUeSqA9W262LhICQdW0Rhyx/EmZrsVGbMXBfzj7BCIu48tnU+IWK
         Um7yhllF0dqvSG6NscxfaLTO4SaF3rCYKtaNkfmuZJyVP8eOZBy31vyM9kvv2yox6zRe
         XwGmiJpj0QEbiJJ9FlKFI/kPxJluE6QEm2WRk8v4bnmhpNLpGp6mXQYSm/ckvencPYrs
         psoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046355; x=1754651155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dM+YGEJIOFtK8ipp/hjDSp8ZeQJhiCtadw4gRYqh5XM=;
        b=qYmHTThvZ57G/yEimWOr0EH9bkvrwKk84dFxa3MViCwtUYAMFbloE06ULWNzx9zAmd
         sdj2UE48GlW4Z4qYilsERR0cVH9ADd4lQxwpIEKruAHWAMy3S2TVotwwlQR6HlgZyrao
         jaZYlQP2gORfJyToLuKHrpNP/YFueb190on032+KvYJG2fup599f86yAX5o9itrkvla1
         8gAuHQYEQ55xhDw/3h54FjDUqjKzGWosGL/SFBFx4DgacbbqyMMx+0SnSB7tM+kFuqxn
         kozfb4dXu2mWVY5FjIlqHPEWo5xosvs1BNZ9+L4cPEsomcoHA2pIfrDBoGZxYw+z3x4z
         znQg==
X-Gm-Message-State: AOJu0YwbSnELz+m6PVKAx6/vRvRH5283rSw9ViSpdMNIomCZXe2n8mw5
	KiSCfxnTgpZmYr1yRvpKXhWq+KIkm+6F/9/xvDShI52uLZ/dl/iMPGiby7OMWvk3pZgG6+cfydS
	dMG5X
X-Gm-Gg: ASbGncvxmjmlbv4TwkIFZPOzhlOXNo0lCeKHsXSEaaW+HCmIkCOQy4u07KzBIqqoiwF
	nZn43F1tJyUhTmkur8u9aKIJBaq3Xlrj7L3hS4zFfrYCJO7a9iR/UrdzonQ7FQTqXo5YOEiu6g7
	OmzIc96763tg9ExFwCACREtW+2XG7kXphj6AqbHWXHOzRakjkg1x5dMRFcc4TW095rm5jd+hobX
	ZnGqQuV1VRBzvGcGLieJ58053PYWHRAIX3TbNp0tObYZEcQV31fl5DjHn02vjlMfehayoaLiici
	1697u5FfgXnubjD3NmjFa1MZ/PZFCjTFuTxfyVoMxvDZIQMPClbTJD3fdrkENRd6ID0V6Rhje46
	HsURhOezcDi5pRu5OpAIr4Woc6yYeAqd7EzdhsQ==
X-Google-Smtp-Source: AGHT+IEUtRteyrU0QF7dv84HhPfDTJKL/nJRw7MMgPOPQhbPs/o3JQKRI4515Vg8cyCml4o/nu5fEw==
X-Received: by 2002:a05:600c:1d9e:b0:456:db0:4f3d with SMTP id 5b1f17b1804b1-45892bd2043mr95420975e9.24.1754046355257;
        Fri, 01 Aug 2025 04:05:55 -0700 (PDT)
Received: from sugar.fritz.box ([77.21.195.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536acc9sm103116905e9.6.2025.08.01.04.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:05:54 -0700 (PDT)
From: Johannes Emerich <johannes@dividat.com>
To: connman@lists.linux.dev
Cc: Johannes Emerich <johannes@dividat.com>
Subject: [PATCH] Fix comparison of services of same preferred type
Date: Fri,  1 Aug 2025 13:02:39 +0200
Message-ID: <20250801110412.203290-2-johannes@dividat.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250801110412.203290-1-johannes@dividat.com>
References: <20250801110412.203290-1-johannes@dividat.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The service_compare_preferred() function is called twice in
service_compare(), once with a guard to only use it on services with
differing types, but once without any such guard. In the latter case,
when comparing two services of the same preferred technology, it always
returns -1 because it checks service_a first and exits immediately, when
one would normally expect that comparison to result in a tie (return
value 0).

This causes the parent service_compare() function to terminate its
comparison early instead of applying appropriate tie-breakers like
online status, Strength or Name. The result is an unstable sort order
that depends on the initial order of services.

This patch adds a condition to service_compare_preferred() so that
the preference logic is only applied to services of different types,
without relying on calling contexts to make such checks.

I ran into this issue when reading sources to understand how ConnMan
would sort two connected Ethernet services, when one is 'online' and one
is 'ready' and 'ethernet' is in the preferred technologies list. It
seems that their online state would in fact not matter at all, instead
the service that happened to appear first in the list would win.

The issue may have been introduced in
31d9ce64a06743cc69b92c47a36e5ace0f9cb030, when
service_compare_preferred() was extracted from its original context in
which the comparison was only applied to services of unequal types.

Signed-off-by: Johannes Emerich <johannes@dividat.com>
---
 src/service.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/service.c b/src/service.c
index f73f42eb..d5869b14 100644
--- a/src/service.c
+++ b/src/service.c
@@ -8299,9 +8299,9 @@ static gint service_compare_vpn(const struct connman_service *a,
  *                         to compare by its technology type with the
  *                         @a PreferredTechnologies priority list.
  *
- *  @retval   0  If the @a PreferredTechnologies configuration is empty
- *               or if neither service type matches a technology type
- *               in the @a PreferredTechnologies list.
+ *  @retval   0  If neither service type appears in the
+ *               @a PreferredTechnologies list (including when
+ *               it is empty), or if the two service types are equal.
  *  @retval  -1  If @a service_a type matches a technology type
  *               in the @a PreferredTechnologies list and should sort
  *               @b before @a service_b.
@@ -8317,7 +8317,7 @@ static gint service_compare_preferred(const struct connman_service *service_a,
 	int i;
 
 	tech_array = connman_setting_get_uint_list("PreferredTechnologies");
-	if (tech_array) {
+	if (tech_array && service_a->type != service_b->type) {
 		for (i = 0; tech_array[i]; i++) {
 			if (tech_array[i] == service_a->type)
 				return -1;
-- 
2.47.2

