Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.39.139.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792864238;
	b=GmbAtrJMpO2azIGCQp0G9UG57fR5+UgTgPgUz8x9ai+FmkaHDWex5eDGCGJVeLnykfx+
	 94bSiyvIp1J/gkGF8rIoMElRRXTPR4aP6rHyOEgUsLZzSbt/nYUMUEnEoJKqzfndnOqxj
	 Wfb9hPA3I6ZnY9bRVLUShuyu+NCx/UoXtL3Ni/qSCwr6BTJeiZJ2cVI69z5yptYtJl8Wu
	 SGUZ+Cw+nsgAf0fbpoQFJqB4y++nkmKavgSLcFzjiwiUJ5m1vdKOycSBmg4XpymMaSL5T
	 seOclc9c4NUFxgYA84LEtmUzVU9/Jg0+i9ivoKfhP2M5Mw7FaATTxo68fBWoZ6x4e8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864238;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:DKIM-Signature:
	 X-Scanned-By;
	bh=9o+SrqCSY19U2mT1k6/dnseAv0S1XCCaymViQ6n9l60=;
	b=kgRAVCfaC60gjpQqJeXuhwJqs38oE70Tv8wPabPyUCeItHBAd/yNPc/D+73Wj4itnFQQ
	 ZODfm7yOrO0UGre8Z7N72n57h/pPnIqQ5pkB8GlwcPU/dn3mLvfhmJ5URd728tJnzdiDF
	 nYAu3qN3T/+wWT7H9lyIKMYHTvYaCx9fZ0+OImE/ixGgKcBMFY1+oOsBEMDmctiiZsvGL
	 EfVBhpIprv6hWBAL1VvOKH5fi5Ev/Ebe8zqWKfLmZoRy3cIi0AlLDrn/n1zpo9SLyrjTe
	 LxcTkXPyL4ZVQyR+hTV9zHW3RzD7E+BwfGXnzMF2KebxRCLEWLmQOE3XIvWjikjIBsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nuovations.com;
	spf=pass smtp.mailfrom=nuovations.com;
	dkim=pass header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=d9KjVmzC;
	arc=none smtp.remote-ip=66.39.139.36
Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E14606A31B
	for <connman@lists.linux.dev>; Sat, 24 Oct 2026 17:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3E14606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nuovations.com header.i=@nuovations.com header.a=rsa-sha256 header.s=pair-202401062137 header.b=d9KjVmzC
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id CB30416005C;
	Sat, 24 Oct 2026 13:50:35 -0400 (EDT)
Received: from ubuntu-aesop (c-73-202-172-31.hsd1.ca.comcast.net [73.202.172.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 53450124C5F;
	Sat, 24 Oct 2026 13:50:35 -0400 (EDT)
From: Grant Erickson <gerickson@nuovations.com>
To: connman@lists.linux.dev
Cc: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Subject: [PATCH 0/2] Fix a regulatory domain use-after-free on device power-on.
Date: Sat, 24 Oct 2026 10:50:31 -0700
Message-ID: <cover.1792863816.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Post: <mailto:connman@lists.linux.dev>
List-Help: <mailto:connman+help@lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
List-Owner: <mailto:connman+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=9o+SrqCSY19U2mT1k6/dnseAv0S1XCCaymViQ6n9l60=; b=d9KjVmzCr1iQKEbIW4Dco5jXyCn0VSOWt1199Oz9uk99UeiefUCa4NwtX67cSPyX+yPViy+DpkwcK7eCr8y/ugJ34m0ckLeEVDhZYyC8+/Krgox5mVVsIOj7EdgUIDWQoOCpZgjsgE9TLcQKAtH+1kOp22pn2HfsLFsxNZWg49/AHhtl1rvqi/IqIUhXiBoj8ipnWUEOILAdPVf4Gdztcezedvj6W1MzQ2b6H/+LDI0rEtZ4O1F9KXR/T2+N7Bf7lHFmP449M4MYtfU/dg1MkRLxjrXUzgz2nQ775/4v1elMhfQk4VPfFljka16M6zQXD3b/c4/KGIaBPDbIohGu1Q==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Since fe9307c987a0 ("device: Setup regdom when powering up to maintain
consistency"), powering on a Wi-Fi device reapplies the technology's
stored regulatory domain by passing 'technology->regdom' itself down to
wpa_supplicant. gsupplicant keeps that pointer, without copying it,
until the asynchronous 'Country' property set completes, and then hands
it back to the callback, which reaches 'connman_technology_regdom_notify'.
That function frees 'technology->regdom' and then duplicates 'alpha2'
from the string it has just freed.

On a 32-bit ARM device whose regulatory domain is set from the cellular
network by the oFono plugin, connmand built with AddressSanitizer aborts
on every Wi-Fi 'connmanctl disable' followed by 'connmanctl enable':

    ERROR: AddressSanitizer: heap-use-after-free on address 0x75324210
    READ of size 3 at 0x75324210 thread T0
    0x75324210 is located 0 bytes inside of 3-byte region
    freed by thread T0 here:
        #1 connman_technology_regdom_notify src/technology.c:299
        #2 __connman_technology_notify_regdom_by_device src/technology.c:1150
        #3 connman_device_regdom_notify src/device.c:1101
        #4 wifi_regdom_callback plugins/wifi.c:2060
        #5 country_result gsupplicant/supplicant.c:3715
        #6 property_set_reply gsupplicant/dbus.c:359

The read, from gdb at the abort, is the 'g_strdup' at
src/technology.c:300, in the same call. The request that carried the
pointer came from 'connman_device_set_powered', by way of
'connman_device_set_regdom', 'wifi_set_regdom' and
'g_supplicant_interface_set_country'.

Patch 1 is the fix: gsupplicant owns a copy of 'alpha2' for the life of
each 'Country' set request. That also covers two related cases in which
the string is freed by a call other than the one that reads it: a new
regulatory domain arriving, through 'connman_technology_set_regdom',
while a power-on request is outstanding; and the timezone module, which
frees its 'alpha2' right after passing it to
'connman_technology_set_regdom'.

Patch 2 makes 'connman_technology_regdom_notify' safe when 'alpha2' is
the technology's own 'regdom'. On its own, it stops the crash above but
not those two cases, so it is defense-in-depth rather than an
alternative to patch 1.

Grant Erickson (2):
  gsupplicant: Own a copy of 'alpha2' for the life of a 'Country' set.
  technology: Make 'connman_technology_regdom_notify' alias-safe.

 gsupplicant/supplicant.c | 9 ++++++---
 src/technology.c         | 9 ++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.52.0

