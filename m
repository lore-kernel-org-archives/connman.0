Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550732B130
	for <connman@lists.linux.dev>; Thu, 30 Jul 2026 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785398640; cv=none; b=NNAbYYQ6hhjDe93NZCMOHzMOsRhN5GJR1rNhLTVT9VHGGp3b/BXzFw8WUroQlhr3ZNp8QekEfCryK+F6BqPM6TqpzlDU8PO2LCgETEIeQUWxRD4FYH89jldcvgd1kSQoHQ0Qj66CF6boOjo+O1D1sCqCaB5yuXLp2Ln64EkffNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785398640; c=relaxed/simple;
	bh=Qk0kv+sm5rSGQRNHzMi7DmyEnr6lVepS/VGsP5s73mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqzxs3nkX6jR/Rhm3w+5uoFSbyt26dUuFEDy/f3OvrwwOq+LmHtGRVGOqm7JttF6dtLri6+1pkhyndFQAc0PUpF7WxPBtFcI/nGQLEB5XhriBYYmPvPQ+OPpvKc9KDl+vwCpgeiw7OJosr1Cm86qlHcOUsgSTj7XrMVkntNoFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=GXyZ2iZ0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GXyZ2iZ0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so16074425e9.2
        for <connman@lists.linux.dev>; Thu, 30 Jul 2026 01:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1785398637; x=1786003437; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cn/PkhSyXGNN3qhhfR0hb4LUYaa5uag1rwNcU8I1O7s=;
        b=GXyZ2iZ0rLGDj+RUK4HoSwVlByOCvF2yRZcPVHqtNFgCLBTCYox7JKexc6+tyjnXzk
         hlSE9PpzLZjHL4w8/OTBuLwTxJYAwQiuc5dLMuRHRdGpGGH3ZKVR97sWk1Img19CN7vq
         cKnwyikV3jo08Jtxi6t3x3E1MslYrT/MA+gZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785398637; x=1786003437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cn/PkhSyXGNN3qhhfR0hb4LUYaa5uag1rwNcU8I1O7s=;
        b=kL98ZjEyDKMiTkP9+N8rDk7puH8beLN7uFhyj8+MRLFn8v40ECFbKVcxZ7o660tC5O
         SWMuOcohXZymbN4E0NlyNnJoGr8zKdpG6ujMWb4sU5zl4rqFNMHByaJsOl6CYptE6+jm
         kE+i4jMuPRUX0X9Ie1q1jpPGr7am5E5+EstZzbPqLT3WVKC9Hc7Fu41CvI9JoRPh8OCn
         fDGEMHX9vslRwVm679EBvsSiPkGaLCGgfvOobMe1P3AADhgYa5BD0zF12+FPGHDpVYeE
         eRqTIW/5GPkisTHe1PkmbzHlzbms1oWKJ+8XBXOu12BFZlfqCFGy+D6VBr2mP3sfEWVp
         3/2A==
X-Gm-Message-State: AOJu0YykNgLJ7HzkVX28XQwak4I81EA4m3cmnTzRwbFgdCtkz/Hn7nvY
	m5j7hKWYhrLEenJuKCyj+s0BcAcwIVBH7jKhzIw+M2KUm+0RpQcpVis36sSj1gAEE4imOcvIKGf
	VtKzc7V8=
X-Gm-Gg: AR+sD12b/vPxkbvmjecxue+UNrSBamHWK00qd87BTxCPeedZYnSeJD94ssAJgBN0QkQ
	LPoTJLBxdoNkTvWmb5+H2Q6z/JRtYrqfR+YV1zyEOOQUSFRLw9VMWsSEgWJ/DUmFEZsQ7ikhqPj
	UnRXgKxXFNDi9+x7SElqXJvLwhik1CsEXW2/j3G0XdmJR9RkvZEVbBWFV06IDD6ztJ1nvIhe/4Q
	3BhuT7Xu8ffqz4NGcvL9ol7mNivTWKSAg83Zd20mHM5cAq7qwA1dSsz6LjJNy8B604ORgcHgLba
	AwtHW0IIT5FXzMAJ+3ma3MIK3pwWRsydXIcI7Diq5ZPdCAbGxnvw0RMhyCoifQOLzWGYGXruKEf
	/aNfiyiBV5y2BJFFIc60mvLbFgEXi+xF+RMUYzuPDOtZZoFBIt6WvJpvgNT8XWyY7y/o6ZMbe5y
	Fm+WMVasxHQq6HZHOGdQ5FB/Q/ktPOpBNc/Bx/259gbAdtBuP4Ar4Y9WB+SaonmhrvI1W0FnI7a
	iK9twPxCHbI99WDQOjFxfQtqksaV7kpFkxqBPpgjRi48B1cQDNKboQDtzNktrGDVpphqcfCAeh8
	eONzLyf62ZfzqbQxPdEJvvCKfQbYs96B3IHHGmpMuGgH9lEmxMyADaL0NqVqRgJ85uQDq8D11fg
	+elBXB4gZwyXjjirG24MX1ePPB+OFb84abAZVvw==
X-Received: by 2002:a05:600c:524d:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-49800e76529mr19997865e9.15.1785398637113;
        Thu, 30 Jul 2026 01:03:57 -0700 (PDT)
Received: from rcc-ThinkPad-P14s-Gen-5.amarulasolutions.com (host-87-10-44-220.retail.telecomitalia.it. [87.10.44.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011f4eb7sm39143975e9.6.2026.07.30.01.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:03:56 -0700 (PDT)
From: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
To: connman@lists.linux.dev
Cc: denkenz@gmail.com,
	marcel@holtmann.org,
	Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Subject: [PATCH] wifi: Retry association timeouts on non-favorite services
Date: Thu, 30 Jul 2026 10:03:54 +0200
Message-ID: <20260730080354.48266-1-andrea.ricchi@amarulasolutions.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit dccfb13a5195 ("wifi: Detect invalid key with 4-way handshake
offloading") routed 802.11 status code 16, an association that timed out
waiting for the AP to answer, into handle_4way_handshake_failure(). It
noted that "the status code 16 is relatively generic, so this can lead to
false positives".

Those false positives are unrecoverable for a service that is not a
favorite yet. handle_4way_handshake_failure() only retries favorites, so
a network that has never been joined gets a single association attempt,
and one AP that fails to answer is reported to the user as a wrong
passphrase.

That was not always the case. Commit e0a27dece6b3 ("wifi: Try only twice
when connecting to a non-favorite service") kept two attempts for
non-favorites. Commit 289c7fc5c0e6 ("gsupplicant: Rely on wpa_supplicant
retry mechanism") then dropped them, on the grounds that wpa_supplicant
manages its own retries and duplicating them in connman only delays
reporting a wrong passphrase.

That reasoning holds for a real 4-way handshake failure, but not for an
association timeout, because connman does not let wpa_supplicant retry.
After the rejection wpa_supplicant is ready to recover on its own
(abridged):

  CTRL-EVENT-ASSOC-REJECT bssid=00:00:00:00:00:00 status_code=16
  Added BSSID 1c:0b:8b:4a:b2:4d into ignore list, ignoring for 10 seconds
  Another BSS in this ESS has been seen; try it next
  Consecutive connection failures: 1 --> request scan in 100 ms

but handle_4way_handshake_failure() returns false, the network is
disabled some ten milliseconds later and the recovery never runs:

  No enabled networks - do not scan

This is easy to hit on a multi-AP ESS, where wpa_supplicant ranks
candidates by estimated throughput rather than signal and may pick a weak
5 GHz BSS over a much stronger 2.4 GHz one of the same network.

Retry an association timeout regardless of the favorite flag. The retry
budget is unchanged, and the second attempt runs while wpa_supplicant
still ignores the unresponsive BSSID, so it lands on a different BSS. A
real 4-way handshake failure keeps the favorite check: there the
passphrase was tested and retrying would only delay reporting a wrong
key, which is what that commit set out to avoid.
---
 plugins/wifi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/plugins/wifi.c b/plugins/wifi.c
index 9ce7b5a3..52fe8f86 100644
--- a/plugins/wifi.c
+++ b/plugins/wifi.c
@@ -2499,6 +2499,12 @@ static bool handle_assoc_status_code(GSupplicantInterface *interface,
 	return FALSE;
 }
 
+static bool assoc_timed_out(struct wifi_data *wifi)
+{
+	return wifi->state == G_SUPPLICANT_STATE_ASSOCIATING &&
+			wifi->assoc_code == ASSOC_STATUS_AUTH_TIMEOUT;
+}
+
 static bool handle_4way_handshake_failure(GSupplicantInterface *interface,
 					struct connman_network *network,
 					struct wifi_data *wifi)
@@ -2506,8 +2512,7 @@ static bool handle_4way_handshake_failure(GSupplicantInterface *interface,
 	struct connman_service *service;
 
 	if ((wifi->state != G_SUPPLICANT_STATE_4WAY_HANDSHAKE) &&
-			!((wifi->state == G_SUPPLICANT_STATE_ASSOCIATING) &&
-				(wifi->assoc_code == ASSOC_STATUS_AUTH_TIMEOUT)))
+			!assoc_timed_out(wifi))
 		return false;
 
 	if (wifi->connected)
@@ -2519,7 +2524,14 @@ static bool handle_4way_handshake_failure(GSupplicantInterface *interface,
 
 	wifi->retries++;
 
-	if (connman_service_get_favorite(service)) {
+	/*
+	 * An association that timed out waiting for the AP to answer never
+	 * reached the 4-way handshake, so the passphrase was never involved.
+	 * Retry those regardless of the favorite flag: wpa_supplicant keeps the
+	 * unresponsive BSSID in its ignore list for a few seconds, so the next
+	 * attempt lands on a different BSS of the same ESS.
+	 */
+	if (assoc_timed_out(wifi) || connman_service_get_favorite(service)) {
 		if (wifi->retries < FAVORITE_MAXIMUM_RETRIES)
 			return true;
 	}
-- 
2.53.0

