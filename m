Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584092;
	b=dB6MNIxhyjz484CPAzWqnE+GrF+cyNC5rjDl+jziaY9v2YgukiKJ1V9FyU1HXR7Eo+jm
	 wpsKWWdenLJe6nYCCf+GJlti8frw6JHRrPAdUAQnGFB3ctVobtCKV/oOQrezXPKap9/Pu
	 8/MoLZBV7Rsj7UuH09zEQOl5nTSXKmHdStsy4RKf3G7jOQaFy8L8fvj5sH5KBx6JgWvQO
	 ko1oM0Ugk0afwvVc7mJtDoa6Gg6KcLARkMyoHzJI7R9Gf8osL9oqRO6ZgQ3Yueje2uwFq
	 In/k+qAQttpq39Dg7l1jPYBSuRCnARvA+HlfbtBNhVrqlND/9NIP8ocbf6jIq9l3dpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584092;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=gzDOroWBdE6XFkaxlqkT5zzrZDLCIng5jWEs4rHVdVk=;
	b=yhuEEIpP295L5Hf2ScO7akn53q15Rr4pM5rUWMlnniLA0w9AhkdCwPyFurIJcKcDGJ4q
	 mn2rEbHKiVAl5mY9hMXJmVxZpXvHz710t2q7O8dhpn9wtFvgxW8uSulUmY8Ep3/qWyjCL
	 +wEtyRpN7JxAY0uhO1S+zIkb0By9PxPomwKcCFfjpP68DFlt/VVTwLBCGiG21JPW6KYOv
	 xTN3FrocXBEl1D9Yigie/r1fN56EZGXGf40evvXOP1N3fhfehDkxzJkAp2q7j8LawdnkG
	 POfazsUg4b0l3lGmnpkDjBsnmNBl9+nSRMdAKReGCXKz+t5/yxsKFN1Wp5RenLKOHoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMLGB2gP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F184606A32E
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMLGB2gP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794584092;
	b=vL9Es8M8mg5xLQh34hFKmIC/bbGBcF6oba7VrV320NmahyHiSJmxJoZW5ZocM/X5dCgu
	 GFcoZ2cblQGK1RxZmostBMdEbnzHA9tUjIdF0g7WfAugMpRdJeE6C+yrBlUpJl9Mzh//c
	 faQD+WGLw+q+u/6xhOQdZt1Ynb+CCtY7J2zy95fPzKxrIDya5Ou9OxfCDNFRhOqJsdzsI
	 zQ3tZ76YBVbt1xNVHQfB4LcLAzCTrJUfUe2KhUT/zBP+rsf+RSyDA17DBq5FZRCGF8a/N
	 WFVGx1J/IDWv6wCdg1uyhcMpyZbGPJmR/WCEMNTq6DfV5qwgtwwDQQq/gNmkWH7RKpg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794584092;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=gzDOroWBdE6XFkaxlqkT5zzrZDLCIng5jWEs4rHVdVk=;
	b=Xpt+hLjP+2+4bMGnx2NUR2fK8iy6sbYdYn/SK6fgg2bvWc5A7zP/UO9hfQ2bG5ZT/Jjx
	 DrHQFqJrk0aPPU7sor4Nxfl8JeINOJmoFrlBIOsrlkDF1qNom8lGiCmRXiJa/0I11+9pj
	 reZRRLN3vOGCElSZdSw5spQBA9S/ov9WSHFRqBVcZmDYoiAEwqnImsBGhuCHha8br94Xs
	 dQcBjyJ8M9ce7BBbKUJDLmkum+e3sw8/uJ1i3RzCOVRoB8/M0ZzZrrWveshveayY/8Oel
	 JAt2A7dgOM2vS50e3fhMzLrFBvb2eGnIyDAqIYOaQpMHHH90SAdXx6RlV7aDQiWSh7A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B6C091F000C4
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584092;
	bh=gzDOroWBdE6XFkaxlqkT5zzrZDLCIng5jWEs4rHVdVk=;
	h=From:Subject:Date:To:Reply-To;
	b=aMLGB2gPOccWu7m9Cquooy5ADRNTBv/cf04dAktIh+ofp3pbYgC6rd7cgwm7/L4Z8
	 JPWhPOmWP/mCR3JaMNywSoLccPS8fHpT8y+eTWI3ZOJ5zpHBfVIhYQZfsFon0k4THo
	 EZyCXn2OEYLP3JplfHepD24beGyZAsrrkadFqKt141YpdyPyFzyOGsKz9oruLSEduL
	 QctE1z6jjnqmGGg8F7N+ffUVsNqHApVrXq5L0fkmfC2uAhqOfE0LSjgnW0UraXByl8
	 L6+KkcUbLr6EEcJIFF74RCrS+mKh1amrOLx9Dc2oz+JaPO6oDnPp6X3Bb9QZ0v9W3J
	 qrTrZmyc1jMjQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3108047811
	for <connman@lists.linux.dev>; Fri, 13 Nov 2026 15:34:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_COLIN_via_B4_Relay?= <devnull+bigbob.fun.gmail.com@kernel.org>
Subject: [PATCH 0/7] openconnect: Fix GlobalProtect authentication,
 reconnect and split routes
Date: Fri, 13 Nov 2026 16:34:50 +0100
Message-Id: <20261113-openconnect-gp-fixes-v1-0-1f7f6922d88f@gmail.com>
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABou92oC/x3LQQqAIBBA0avErBvIQoWuEi1immw2o2hEEN49a
 fn4/BcKZ+ECc/dC5luKRG0wfQd0bhoYZW+GcRidMWbCmFgpqjJdGBIe8nBBbydLnqw7dgdtTZn
 /0M5lrfUDK3AYmmYAAAA=
To: connman@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794584090; l=2284;
 i=bigbob.fun@gmail.com; s=20261113; h=from:subject:message-id;
 bh=EFshlAO7+Q6jxcB9wR4fbD3C3/tlBTEQaI4mKje+WMw=;
 b=SdVZd3+7ZlUU4lH5iCbIgmO2SD6E/Lq3ZRYnrb81TxSKZZb/pyUJ7/eK9nOEVAwfrzOuSmLLW
 1xaLTMWn3fEB+FJI0HRnrqXh2OeUNG7RXY/Iu/OV1zrpBEMABE5QrDU
X-Developer-Key: i=bigbob.fun@gmail.com; a=ed25519;
 pk=MoY1DAn0hlhveZhsN9JyLnuWS/CGqJHTad4MaTL8HgY=
X-Endpoint-Received: by B4 Relay for bigbob.fun@gmail.com/20261113 with
 auth_id=1512
X-Original-From: =?utf-8?q?St=C3=A9phane_COLIN?= <bigbob.fun@gmail.com>
Reply-To: bigbob.fun@gmail.com

This series fixes the OpenConnect plugin with a Palo Alto GlobalProtect
gateway (AuthType userpass, built-in authentication of connman-vpnd), the
handling of openconnect's own reconnection after a suspend, and split
routes pushed by the gateway.

1. The protocol was only given to the openconnect process started after
   authentication: the built-in authentication always used AnyConnect,
   POSTed to /gateway and got 404 from a GlobalProtect gateway.
2. "attempt-reconnect" and "reconnect" from the vpnc-script were handled
   as a disconnect: the provider was torn down while openconnect was
   still running, leaving an orphaned process.
3. GlobalProtect names its password field "passwd": an empty password
   was sent...
4. ...and the rejected credentials were resubmitted in a tight loop
   (~50 times), which can lock an account.
5. Split routes without a gateway (CISCO_SPLIT_INC_*) were never
   signalled to connmand.
6. _MASKLEN was matched as _MASK, so IPv4 netmasks became "16", "32"...
7. The username was never offered again in the credentials request.

Tested on a phone running a ConnMan 1.40 based build (Sailfish OS) against
a GlobalProtect gateway with MFA: login from the native UI, several
reconnections after suspend, 25 split routes installed with the right
netmasks. This series is the same change ported to current master; it
builds without warnings here but was not run on master itself.

---
Stéphane COLIN (7):
      openconnect: Set protocol before obtaining the cookie
      openconnect: Do not treat reconnect reasons as disconnect
      openconnect: Fill the GlobalProtect "passwd" form field
      openconnect: Limit repeated credential forms
      vpn-provider: Signal routes without gateway
      openconnect: Do not take _MASKLEN for _MASK in split routes
      openconnect: Offer the username again on the next login

 vpn/plugins/openconnect.c | 53 ++++++++++++++++++++++++++++++++++++++++-------
 vpn/vpn-agent.c           |  3 ++-
 vpn/vpn-provider.c        |  7 ++++++-
 3 files changed, 53 insertions(+), 10 deletions(-)
---
base-commit: 9e46e4a021cd8566b942d1a72b41b14a0a58f506
change-id: 20261113-openconnect-gp-fixes-7535c7c56fd6

Best regards,
-- 
Stéphane COLIN <bigbob.fun@gmail.com>


