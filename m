Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E31DB55D
	for <connman@lists.linux.dev>; Mon, 27 Jan 2025 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021299; cv=none; b=EatVVW8RSmgKDGX8mSW6wnFmZFMiMkis4xrWpN+TCCrpGr6P4GTRZrmAQVaAroqGgqjchkQh+964i/EJ9OCY7wS4UpRylT1uby5s6BjYLrT0J4RHWoAehoOGeJ3jgiQEoa3uZm+GT/bOZEn4QTAeFUxlxVLB9hcrdQKqmEWrT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021299; c=relaxed/simple;
	bh=zH9HNKviU8Kmgx2c11w5FhKq2Gtf4paV1NchdxSkmls=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q+PEzvuoPCBghf8bf3P8Na9tBhPTskv7P6Lj7ePvltonKpufZu1yU6CgjIJsHkbrAeCqOPv6AuKM4pmAKco+Inz4wgJHjZtiaG6ZdnBgw55X77JnBQ0JTCvI60WtGQ1b1SXAebZR0iUl4KkI3jvYyXaY4qXC+akqkydskbNpNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hawaiienergyconnection.com; spf=pass smtp.mailfrom=hawaiienergyconnection.com; dkim=pass (2048-bit key) header.d=hawaiienergyconnection.com header.i=@hawaiienergyconnection.com header.b=Q4P9TTop; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hawaiienergyconnection.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hawaiienergyconnection.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hawaiienergyconnection.com header.i=@hawaiienergyconnection.com header.b="Q4P9TTop"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51873bc7377so1547321e0c.1
        for <connman@lists.linux.dev>; Mon, 27 Jan 2025 15:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hawaiienergyconnection.com; s=google; t=1738021296; x=1738626096; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+AZgLIBoBqy/5G/qq+IgGzeYum4vTltnaj+K9ns5Z+s=;
        b=Q4P9TTopHP7vKTe4olPlkXrh1WAahR7Fn4ghtzOp+S0H+3z71ob900/+5zYJfc7LQg
         9nT8/D7HzZj/ydBlCOCAITkk6bgeJJyGLZM/u92KMCWGBf1SxKzMBqqSZXi/YfKAOuQo
         yG+CGMAGFANWfyXO7hstuuz/Rg3RC5DToWd0wOqidH0w2XFlB8mD8Ub6g8ywTeuve9No
         bW4noHZjJXEuXepl3ZYcj2z53nVuQSqNP/jKHYOk4/QNs67UzsncSRQfMPa41YDqfhF2
         BB1p7AdxS30YM7+TxGMsXYaWvWxf/6c0l4VKtfYAcPVgZLIGB/rM+BztnpSDMltmI2FD
         CshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738021296; x=1738626096;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+AZgLIBoBqy/5G/qq+IgGzeYum4vTltnaj+K9ns5Z+s=;
        b=Nx2JVimPLudmRCozKTFHD+qpWf9rfSOn6ISXtRpb7HMuBIbz5Mp8Yi+PZk00RFnf/p
         niMcSXJxr/FN7OQOV92SouP1GrbvxF257a5H/9DkRQw8NKdKpWVCGcRbFv+2OKxjnoo5
         gCMje30O6R+jhjhspvnSDSr4VHK+OkLG6oXVr1qqFv5dCrz7KU9TMeFn30RCY4xV73r2
         rO4uOZCRS5rui31ICG8Ru8xTU40ToUxYioFzKJkRJ00WTgxK+rcm1E6hnEidIlHSu7f3
         Sw8IRFwl11ZqbM0+AaOZtV2+Y6Jy3NcTz6zbrhBzjbDuoPcQYWL4SSvl5KrOobwc6mq9
         5nxw==
X-Gm-Message-State: AOJu0YwQq3IxX0zfFdazj+CmbcnHPFBBewEqLh7PpD8pWI+LaSg9hTGJ
	oWHYDmgt9S0bL2jYKQqH3hWo3p3M+FIJtVozEy38LQ1KHQWKR9KWNQwewp1PCFlwxUphdjjpjav
	Ci5TXmFOtfbKpjbMRoqJXnwc2bEFwESrNPygSyZmSO2efnTzQb9k=
X-Gm-Gg: ASbGncue/MAiqibPw6QIdpHFy/gYArUyK4U4zVPnWIArMS5VQlqout4mp1phvMDxia0
	zDRy/iWZ0Y+98SF384D/66P5l7GuTRXQlV7lod0K0AYQP+5NE12FA0TvCAu5tqg==
X-Google-Smtp-Source: AGHT+IEIABB7uw84G+HSpWyVFMsqaanzfD11znsq+eF3A9KeKvLvWiaSCUmlB8jOa9gQzkHgk6BA2wYg0Ve1ndATwTY=
X-Received: by 2002:a05:6122:8c3:b0:51c:baa4:122a with SMTP id
 71dfb90a1353d-51d5b26cb5cmr36992673e0c.5.1738021295926; Mon, 27 Jan 2025
 15:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Scott Valentine <scottv@hawaiienergyconnection.com>
Date: Mon, 27 Jan 2025 13:41:25 -1000
X-Gm-Features: AWEUYZlxmuHwQyIbjH8Pq0R_pUupFsEpq8gDU6iXCioIL2wWMKNzreF1CZMzdNE
Message-ID: <CAMieACadCW0Fw60Hpf9mOT17iAgSVkZRYa_6QjGyAy62y0USPA@mail.gmail.com>
Subject: 
To: connman@lists.linux.dev
Cc: gerickson@nuovations.com
Content-Type: text/plain; charset="UTF-8"

While testing an upgrade from v1.33 to v1.43, we experienced an issue
where some of our devices were failing to establish internet
connectivity, while the older version of connman had no problems.

We have identified the source of the issue as a buggy proxy
configuration from the ISP provided router. Specifically, these are
Hawaiian Telecom provided Zyxel wireless routers. The router DHCP
server supplies a PAC URL option with essentially an empty value of
[0x0a, 0x0d, 0x00], as well as a domain name option of "home".

This ultimately results in a call to __connman_wpad_start() with an
invalid configuration that should not succeed (I think?), but does
(due to the hostname also being set by the DHCP server), even though
the PAC URL is null.

WPAD then calls __connman_service_set_proxy_autoconfig() which results
in the following broken configuration for the service proxy:
            dict entry(
               string "Proxy"
               variant                   array [
                     dict entry(
                        string "URL"
                        variant                            string
"http://wpad.home/wpad.dat"
                     )
                     dict entry(
                        string "Method"
                        variant                            string "auto"
                     )
                  ]
            )

I believe the correct fix for this could be to check the PAC URL
either before starting WPAD, or within __connman_wpad_start(), the
latter requiring a getter for the service->pac property. N.B. I don't
really know much of anything about WPAD or PAC.

For now, I can work around the issue with a small patch to force the
proxy method to "direct" in service.c: check_proxy_setup, but I'm not
super confident that this is the best approach:

diff -uNrp old/src/service.c new/src/service.c
--- old/src/service.c   2024-09-01 23:34:15.000000000 -1000
+++ new/src/service.c   2025-01-27 13:11:52.713053125 -1000
@@ -1731,8 +1731,18 @@ static bool check_proxy_setup(struct con
         * to AUTO with an empty URL.
         */

-       if (service->proxy != CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN)
+       DBG("proxy %d, config %d, pac %s", service->proxy,
service->proxy_config,
+                       service->pac);
+
+       if (service->proxy != CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN) {
+               if ((service->proxy == CONNMAN_SERVICE_PROXY_METHOD_AUTO) &&
+                               (service->pac == NULL)) {
+                       DBG("OVERRIDING PROXY METHOD");
+                       connman_service_set_proxy_method(service,
+                               CONNMAN_SERVICE_PROXY_METHOD_DIRECT);
+                }
                return true;
+       }

        if (service->proxy_config != CONNMAN_SERVICE_PROXY_METHOD_UNKNOWN &&
                (service->proxy_config != CONNMAN_SERVICE_PROXY_METHOD_AUTO ||


Mahalo!
-Scott V.
