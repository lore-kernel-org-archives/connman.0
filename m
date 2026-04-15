Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736903101B9
	for <connman@lists.linux.dev>; Wed, 15 Apr 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252214; cv=none; b=ODVTIvKScb4ZQJF1YYMwhRa/IsbixQvL/TYFWuDNXns4iOgsmG+yzD8+SjczXIIMSpJ42wPsfSwwv1Ep/RNsCPS3jX446U64X0lAFj5qIPmMK47C0L2bKfFObjYs+1x/bi6To3QEaMNBoEejaNH+f2A9Th+HUFx0ODcKb9gGBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252214; c=relaxed/simple;
	bh=6/WsroaTybkMU+o/EWCUBIrZJoUaJnGM0p2TgLC4lI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jf/e4V4q2AxerxEwqL8Y0L60SC57mKmYWgtLAfOoZupJ/3SgTunSgO02N5k8TICYeHyynIgvwMCZS+aufvA9F8meZ42Rae6geE5hU5j+uMo+ekHjRapV/QNwd9zokyO3//ot0GEVNcK3RREQhkva+yOm+81c4C1kqbIWZcC0JWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com; spf=pass smtp.mailfrom=dividat.ch; dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b=x5CSL6NF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b="x5CSL6NF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4888375f735so66016535e9.3
        for <connman@lists.linux.dev>; Wed, 15 Apr 2026 04:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat-ch.20251104.gappssmtp.com; s=20251104; t=1776252212; x=1776857012; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzhyrbW2m64boK9HKPYUtHTW5WB+PDkj6EwsUuKR6E0=;
        b=x5CSL6NFVfzHXZiZ0XvaPV+PAp0/JRSxQV6UI83eQRfWNRpl9pubzL9KE5ehPqCZw5
         o08wD41vQtPcsF0N92XQzMtzJR2SMfTbwqYRAbcuFAHMkq3OlhJbjQKFPBJlihxLDquk
         1N+d/WmPONkwDx9y/Up6lNAkQ+90WwcOu5Y9z/qlMh1qLfaDKZ4Wgmx5omWT1gkZ+Kof
         /bsrPIvseWeGAjwQPjJxEoxHm2Dw9pcXaVaZPa6q9p/7UAbWhsoVFW57p8KMoHzScWg7
         CRrmowFq72ZBqk0bOea/PMp/r0A38idpdb9U5CIKpZe5m7F6WN/sWTsMTtUYR6beOhyI
         WUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252212; x=1776857012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lzhyrbW2m64boK9HKPYUtHTW5WB+PDkj6EwsUuKR6E0=;
        b=byUgjOw302/npoN3toT/locIrdAc4h1HqQuvt59dowyLfXNxLjcMvZsuynvqgjX9PV
         2tvzm+cODcRzU9hndErN6Vc4TosM7iYmyoeYo11sgEqYaZBbbQuaBn81hUhHV+9Xmofk
         FxnVbRNc8XRIuXZJVJhLWqa0erpePKgGamczCKMhIrvRM737ojciIlkgUrKqWfM1UCht
         q+riA2ZOfbs9VpeNQpOAIbV3se0rSA7UdZeFzr3rMkPwUKdBmbxjMMjy5pEuGe9VXWx3
         Dk2db9tP20isE1y+xdjixBs9SGY4sdKUKTNjM2h86RTELJyMaXHUU4upGpW3l6GIdtTc
         2ADg==
X-Gm-Message-State: AOJu0Yz2y1X0TQot4UNXc2C/LAS6GpvYr5j3Ju+9lc1+WeFshXRUKHNk
	ePpXVaDAxFxU+bP9upfmiRm9QOal9o0XmGb4Pxqp8O/3kMpnIRuAK1UvvRd3SYNuUx2wOKfgSi1
	XoIJY
X-Gm-Gg: AeBDiesxiure2UKSpEmkxWxwzPHKObFfCaWgxaPCu5RYK9JOHLGej5JHK6l0BCEThgN
	YhwYZm0SiFAQ0fm85V/GdxQDxC0iKDqMh12J7o9COjMX3J5Zd4jj5fN4ZxPZqIiYpW6xRaqCFYB
	Hw9tEOWCOovuJArG1cqW1URpZ6AM1E11z5PNF83zrUQ16fqwZcP+l2TuJfH3JSQ+U5AS2S+zvNk
	gy+AhFdgdCm2xEKjwo178nNng6vqAYjg2zD29Iquo36rry7C5F8A40jbv86IIIixyY5f0kXhUkb
	mk5zHuzSkmJAt+gkgalfwMjIqsp0FhkFosR7lZcBmiYRLTcfDvAXdIl8RYYwsNVkKBQ3w4admJs
	kWgRtVRDzazX/Ett1X6V5DxVJ6PTyyX5cG4bRCasP6HEUnDwJv85UgQ38jZk+3Rxt7BZ20a21oR
	mMRuHte9Zy9YO4HM0nQYiwtF/L9lBPi1fkt1Y8eH7p9OG4Ca0FTIwQMSegeW9HK9iz7rtT5g+iQ
	wPF+Kzdfr1HvGj8DTnkjx2cWJjVG+iL554K12Vm2jhBsNDlyNT4nwn1GOXQAHYUrcNhKJtOTA==
X-Received: by 2002:a05:600c:64cf:b0:485:b6dd:5066 with SMTP id 5b1f17b1804b1-488d67ce664mr283388085e9.7.1776252211325;
        Wed, 15 Apr 2026 04:23:31 -0700 (PDT)
Received: from sugar.fritz.box ([77.21.195.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f208451bsm37915065e9.14.2026.04.15.04.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:23:30 -0700 (PDT)
From: Johannes Emerich <johannes@dividat.com>
To: connman@lists.linux.dev
Cc: Johannes Emerich <johannes@dividat.com>
Subject: [PATCH 1/1] service: Demote IPv4 link-local services
Date: Wed, 15 Apr 2026 13:22:58 +0200
Message-ID: <20260415112258.1076252-2-johannes@dividat.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260415112258.1076252-1-johannes@dividat.com>
References: <20260415112258.1076252-1-johannes@dividat.com>
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current default configuration, ConnMan is less robust in
operating dual Ethernet than it could be, and may get stuck in what is
very obviously a dead-end, assigning the default route to a link-local
service. We observed that no default route is even installed when
ConnMan chooses an LLA service as default.

This patch teaches ConnMan to give IPv4 link-local services lower
priority than READY/ONLINE services using another ipconfig method (e.g.
DHCP). This seems like a useful heuristic to apply directly in ConnMan,
given that link-local services are never suitable for configuring the
default route.

This criterion is considered relatively late in the comparison hierarchy
so that

- online services still win over ready services,
- ready services still win over failed-online-check services,
- preferred technologies still win over less preferred (which may be
  questionable, but also in line with current treatment of preferred
  technologies).

As link-local configured services are in READY state and remain in
READY state when receiving an address via DHCP, updating the comparison
function alone is not sufficient, we also need to add a new trigger for
re-sorting the service list when the IP address changes.

The chosen trigger here is address_updated(), which is called both when
the ipconfig method is changed manually as well as when the ipconfig
changes bottom up when DHCP becomes active again after the IP device had
fallen back to link-local/AUTO.

Considerations for this choice of re-sorting trigger:

- Suitability: Triggering on address updates seems appropriate given
  that we are ultimately interested in connectedness, not the ipconfig
  method alone. We want to prefer READY DHCP services in particular, not
  just any service for which DHCP is currently used but has not yieled
  an IP.
- Frequency: relatively low, compared with trigger from
  __connman_service_update_from_network() which triggers on average
  every 3 seconds on my laptop

Why to introduce this sorting criterion in addition to online checks:

Online checks with one-shot mode do not handle this case (though we
initially thought it would). The check will fail for the LLA service and
it will stay in READY. But this does not cause the service to be demoted
in one-shot mode and so it may remain default service. The other, good
service never gets the chance to run an online check and "prove" itself
to be ONLINE. We ran practical tests to confirm that in the described
scenario the LLA service remains default service even with one-shot
online checking enabled.

We have confirmed that the continuous online check successfully
recovers from accidental use of the LLA service as default service, but
requires some compromises:

- Requires running additional public infrastructure to work behind
  firewalled networks (which may block ConnMan's probe hosts)
- Need to balance quick detection of LLA scenario with low chance of
  false positives on regular network services (tuning timing and failure
  threshold parameters)
---
 src/service.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/service.c b/src/service.c
index d5869b14..85193a9f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -1161,6 +1161,18 @@ static bool is_idle(enum connman_service_state state)
 	return false;
 }
 
+static bool is_ipv4ll(const struct connman_service *service)
+{
+	enum connman_ipconfig_method method4;
+
+	if (!service || !service->ipconfig_ipv4)
+		return false;
+
+	method4 = __connman_ipconfig_get_method(service->ipconfig_ipv4);
+
+	return (method4 == CONNMAN_IPCONFIG_METHOD_AUTO);
+}
+
 static int nameservers_changed_cb(void *user_data)
 {
 	struct connman_service *service = user_data;
@@ -4108,6 +4120,9 @@ static void address_updated(struct connman_service *service,
 		connman_service_get_identifier(service),
 		type, __connman_ipconfig_type2string(type));
 
+	SERVICE_LIST_SORT();
+	__connman_gateway_update();
+
 	if (is_connected(service->state) &&
 			connman_service_is_default(service)) {
 		nameserver_remove_all(service, type);
@@ -8444,6 +8459,22 @@ static gint service_compare(gconstpointer a, gconstpointer b)
 			return 1;
 	}
 
+	/*
+	 * Prefer configured IPv4 address over auto/link-local IP.
+	 * "online" services would already have won against "ready".
+	 */
+	if (state_a == CONNMAN_SERVICE_STATE_READY &&
+			state_b == CONNMAN_SERVICE_STATE_READY) {
+		bool a_is_link_local = is_ipv4ll(service_a);
+		bool b_is_link_local = is_ipv4ll(service_b);
+
+		if (!a_is_link_local && b_is_link_local)
+			return -1;
+
+		if (a_is_link_local && !b_is_link_local)
+			return 1;
+	}
+
 	/*
 	 * If at this point the services are still comparing as
 	 * equivalent, then use favorite status, giving priority to @a a
-- 
2.51.2

