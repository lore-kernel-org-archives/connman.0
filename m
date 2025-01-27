Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC98156F57
	for <connman@lists.linux.dev>; Mon, 27 Jan 2025 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021466; cv=none; b=Xa5AcWpmrQxsIO/6KbAtSCmX13xaT7fOA+U89C2MTTwUaN1rcWJ9xLiNMg1JHk3FsntqPqUzJFthB8E4lsAp3dea1dMugZQPv5WbPixt97b/sjlSRJIadeCjB+noTuDQApafdJnQnyFenz/cQaCc9fRU1MLm31JNs6swSshrMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021466; c=relaxed/simple;
	bh=467W6guEbv+o9ixH5WF3hkqEzAoTd4iM8x+dI6WVkF8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WnLpIW20BYlOn3FH8gNdRGiE8aZzaxP14kEoRmD9RoiLsfmBBeWepcFT7+GasXuRfm8zQTZW2Eo5J36LPZhZMJJ8OXC9EIbBKgHt/QpFBvYPrGAyqz/aKpM1O6zGQ2K/A+HkTc1mEKMlIlkOmJxr7Q6qOhN1YRNylUHJmwc6bzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hawaiienergyconnection.com; spf=pass smtp.mailfrom=hawaiienergyconnection.com; dkim=pass (2048-bit key) header.d=hawaiienergyconnection.com header.i=@hawaiienergyconnection.com header.b=Ub8aqQYD; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hawaiienergyconnection.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hawaiienergyconnection.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hawaiienergyconnection.com header.i=@hawaiienergyconnection.com header.b="Ub8aqQYD"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51e902b58c0so112558e0c.0
        for <connman@lists.linux.dev>; Mon, 27 Jan 2025 15:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hawaiienergyconnection.com; s=google; t=1738021463; x=1738626263; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GMOi0h2wDBuQDUsqRCHwXgGgMCrswFhdJ9xOztukNE0=;
        b=Ub8aqQYD/GJ9ejEYOrcjSrnx+tJpCpp2c4X0MLWiWKoJYskjfGb8l8pL8H3xhHYT4m
         aXjelYi32scpOMQcM5YZ/z+32XP43LtsutcI0F90zmfdgmLpk9MAVal7YoT0ilR/jwVX
         YCFBI3CRpgd1C9Jjy+7Tuf2/k+0FOamtqoaUa8q7fGZO/yxufI8awaz4yePHPY/V+HhN
         VXjKyqahRgb6SCIVPXMUFvrDMNn62j9GxE628lXfSjeBMXmM//UDP6lmxw2ftow1Y1C7
         Ol/3cVgYFTcewA1EJaasx+bnU1l6o6F8BOqBzGT7P7ZkkPOJg8JobeNjY8+H+ClToDWg
         JMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738021463; x=1738626263;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMOi0h2wDBuQDUsqRCHwXgGgMCrswFhdJ9xOztukNE0=;
        b=X1pDomr7x1CDcT0OqlOSiST48PAwOnndHh4VusTKvQ8semddVb59/IKEFvwaK7De2v
         PAWa369LGxAobi93ekqZBQCqxHFz349jXO8yJuqJL+7w430baGCIpdBsb1D5jAOVr+AI
         uSyD4ODxlxZDM0f111SvfQ1emryfNjyqZ2cozzkt7zPK9rSfcz/BjrG5J6Y5oxhRMI6C
         iEHTgDSoLTxqiv6T+Rxt/Mw6s+PrW4M/9Sxtd80yhY3VO2hmXML0WDxrNLWowKnvOcDb
         p48l6n7EbuwaC0CCfNnySCv6lcECF1hAOnc4/nJgo/Khzu8UY4PN8q1QQiALLJ9EXLNG
         AlAQ==
X-Gm-Message-State: AOJu0Yzk0G+1JMK1ocxh/+/4ids5JryMestnVd+u5N4wMeTskLyS3kxh
	PE+V0TQzB5FkDt5UkTyCFNOCiNB51nsPAKinDhb7Iw4eODBqAkTpBGI5LHuRV0I0J4haykNVTSr
	w61BM0V509V2x9hGVJMXWIF762U/VO/wHtNMocEUAyoWywkGjg6A=
X-Gm-Gg: ASbGnctQX+qsj4o4cegK/HLuXQPE8cmaR+6Xbvx8xze8rP5sK1nFqlVvbbneVFASFJy
	DWLbgCsmC1SNyaSn/F9O7nmrOgMghQuKcCWh4SLc7rQukBJElZrjXUAqHsLdqDg==
X-Google-Smtp-Source: AGHT+IHkJXjgpB2flhaPD1ulZWWA/b5puLYSjUM2y/mmFyxvEX/u8D/QesTU+georS0F+GTASIJmOHR5ZY4c/gG0DJ0=
X-Received: by 2002:a05:6122:4982:b0:51e:20de:f9f2 with SMTP id
 71dfb90a1353d-51e20defc67mr20073873e0c.6.1738021463058; Mon, 27 Jan 2025
 15:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Scott Valentine <scottv@hawaiienergyconnection.com>
Date: Mon, 27 Jan 2025 13:44:12 -1000
X-Gm-Features: AWEUYZkoXmGCJ2jZ6k17obm1ZWoB3jYPaheMnFDfn7vEtRix3JONM33oVN1bZtk
Message-ID: <CAMieACZtdeZvvHWJURtZPpZ_pNXPkC-jFTQHwBEKMFNcMMoQgA@mail.gmail.com>
Subject: v1.43 - BUG: Connectivity failure when router provides invalid PAC settings
To: connman@lists.linux.dev
Cc: gerickson@nuovations.com
Content-Type: text/plain; charset="UTF-8"

Apologies for the repeat - I lost the subject line so I am resending.

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
