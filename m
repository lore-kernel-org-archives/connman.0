Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B929408
	for <connman@lists.linux.dev>; Wed, 15 Apr 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248138; cv=none; b=uJWXvIvTr5t2eCkk2UwPaUfAB9dDVC7LbvtPSyAHi9Rf95RsSodMG4yncZIbpPBD0YgZXydNAbi3jE9GYvkU25doFY/yPC+pYLya3rPrYYZdoZPm6+pPrtEzABT5stMN3QJskXjBqEHfQLY1Kd8m6cDMHT/STf3Aujhke6xgbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248138; c=relaxed/simple;
	bh=Ue0SFgv7sWbRRHJZyajisn+0MvQrornigHCQ+SjAL78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RLA53AvRY+kL3nETETyujYXknLaGZmQK+YTa2lNpdn9+ANpFU+AyHHAkL7uHE04W7tFJAZZrejgJSW9Q9uHwL3M45XheXwoE/71DkoR0c+qH0rtiWQsXzvhnE/7yHNOIKHQAvNCmU5aClAQ2Ej2ngPdRw4yh4W87pRAVpwaBdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com; spf=pass smtp.mailfrom=dividat.ch; dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b=vaMA/Q80; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=dividat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dividat.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dividat-ch.20251104.gappssmtp.com header.i=@dividat-ch.20251104.gappssmtp.com header.b="vaMA/Q80"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d72875729so2302554f8f.3
        for <connman@lists.linux.dev>; Wed, 15 Apr 2026 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dividat-ch.20251104.gappssmtp.com; s=20251104; t=1776248135; x=1776852935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDjxfvQftOlZ0xIklYPGH95gP5Qe3B+H/nrHYWfBCZQ=;
        b=vaMA/Q80u+FRYX0QB/jgLxflgKaeAbf3dChmOXLhLR+C57fYB4EvdV/tGntteq7ty7
         P11vF7eHeBHE40sRAjwgtMal+ax8JCOlPulPk4KLUwsWHYKzLIpZd1N2TXumZx9LJauD
         TQPdqHYWMfh9NyKomaXNVK5SCnD07EQ8KDD/5fLIt+DKpfG/yvgHL3e/plBMZOppTmD+
         f7of5auf2iY7HxGITPowENrFF/oph04VPVWNIzJFJkzJ3pSJnoMaVN58dVyZgBn3B+8R
         YvtFilbV74JT2H6yPBqvqChFPNFnf/c3ESTzvq+p/ahQrR60AOrMCEW7amH9QmKGhtDo
         HIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776248135; x=1776852935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDjxfvQftOlZ0xIklYPGH95gP5Qe3B+H/nrHYWfBCZQ=;
        b=S87h1TuAy8TsdAE5hOxIzv286jIoRuAE4DwAKOov2+wYQvE0c1HnUQt3h3Io+ApddB
         YXcMYdiy0IfaKlEt2AGL5VO8vZZwcd+uwYxmBlDgkYfDbdjgZUzPjC5mRusnvDX4YnY1
         FWDiJ2VEEuYAYk4uiFjmrNrfHXEbCiNIagCbZ0QCdqN6cpURfkA9LPuaw2xYwzP11ivH
         2DhT1IVC4K+nxtlninGpN7qA4FgSmnz6Atm27Eok17DVPRn3FJrh9iu5792EdqPmzS8/
         JkEPVqjErL0DjPFKlb4bJ1Yu27ArcEWNW6nliHNFtJH3wrNTqrx1qyPXhNsLkt//C6qV
         eWNw==
X-Gm-Message-State: AOJu0YxsSwCOVRqMRXSHctnzbBWGHfyIxFnjM1RLhtE3ro6rMvKilydG
	K3Jk60Qt9gd2bAhUxxLeIVCTPVmiiO6PusUZ495GNSfNP9cQOVo7ismbfd+Xho/EaSS4LnFKQ1u
	4axtJ
X-Gm-Gg: AeBDieu9lwsQIbWiaNv6g8KVW3aZ4QBsPzU4G6QpsMhelNX7itjyuHHMmD2TQoJ2/11
	U4szk4VvRLXnNL0pNs5KnLzX1xWbTsBhP5StvmzS79B8pN2m0/wV9Nv3BQetmtnRH0pWT8VCVOX
	AmREM27tlpGGWrldk8DV5XD4aSsAXJZ4lUJ+JRxAhUcONjsWj1PkgMmEcf5VrTiZL5/a07qbC0d
	fpKyxc7yuWb4jXQyYFSJgwSmqyjxZ1nod4XablkxPF+XeJO8aCvRCI8gFhBnvYtmhkkUwqmQQds
	zLSlR/kkIIYjli08AvZRgz1FWaPwGvx5B3Gams39nUMPJEstPw6Eb6kf5og5ESSHziKE5sBGfuv
	XgHhKT/IlMorHJyeqaL2VgsrSCjPyhxU3K/0YcAo21aD2epI/3LsGSmXuvwViHk/f34+XO0oeFN
	jcJ4T61Itnet+UiHUjLVsKA+juV+02HPZJLqU7wgBo+UlgVhWSQ9WwehjDp7fG6K1Lix73HN1n1
	xqKt1UdoRIOzTS+U96m33XXGTCa60AtDIur6xSdobHshrUV9QJQ2YgBrcdfujSH8RK0LJ/cudX7
	ubvBZd9C
X-Received: by 2002:a05:600c:4504:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-488d6868606mr279590995e9.25.1776248135380;
        Wed, 15 Apr 2026 03:15:35 -0700 (PDT)
Received: from sugar.fritz.box ([77.21.195.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1513csm131435235e9.2.2026.04.15.03.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:15:34 -0700 (PDT)
From: Johannes Emerich <johannes@dividat.com>
To: connman@lists.linux.dev
Cc: Johannes Emerich <johannes@dividat.com>
Subject: [PATCH 0/3] wifi: Forgive transient errors
Date: Wed, 15 Apr 2026 12:14:58 +0200
Message-ID: <20260415101501.1048919-1-johannes@dividat.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our kiosk system built with ConnMan (currently 1.42) and
wpa_supplicant we have observed frequent "dead-end" errors in customer
installations, especially where WPA3-SAE is used. ConnMan has perfectly
functional WiFi services enter an error state and will not automatically
retry them, so manual intervention of some sort is required (reboot or
manual reselection of WiFi).

We were able to identify various cases where ConnMan's wifi plugin gives
up on services prematurely.

Our hundreds-strong customer base has been running our patched version
of ConnMan since mid-December 2025 and reports of WiFi disconnects have
been much reduced in 2026.

Note that our customers are running ConnMan 1.42 with one additional
patch, which is a revert of 289c7fc5c0e64f14463937cf28eabb347700c161. I
don't understand the reasoning behind this commit, which argues that
ConnMan should not explicitly allow retries, because wpa_supplicant
already has a retry logic. Since ConnMan actively prevents
wpa_supplicant from continuing to retry once the service enters an error
state, this reasoning seems flawed. However, since the change has been
in ConnMan since 2014 and seems to have been generally accepted, I don't
assume a patch suggesting to reinstate a general retry mechanism would
be accepted.

Johannes Emerich (3):
  wifi: Extend auth retry mechanism to WPA3-SAE
  wifi: Limit invalid-key to repeated auth failure
  wifi: Allow retries for more assoc failure cases

 plugins/wifi.c | 88 +++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

-- 
2.51.2

