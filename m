Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A3435508
	for <connman@lists.linux.dev>; Wed, 12 Aug 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545384; cv=none; b=QaLDoXW6ahgBwjV49DVbmFB5kyKVqdsG4qR/AAk7BSu4v4ANHKdxIoACgl+/VijFOQTPZpgQ8vyDNw0/PQTWLbha7xXCEKHMzkvkSRBfx5fezDBwSnQSGoppK9nbILbcAp9dYect6z+CjhmWrU2UjMN79YbN/Sk8ELUKbJtlgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545384; c=relaxed/simple;
	bh=e6y0oPS9vWZuXAz9mr25al73RJRg/DP3rWYecKxh+W4=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=UsFoUFw6/AuijwkgDceDT3NuYkBd5SRN8HwdO1cPS1hY4Wdhk5ybCC7jphp9fMv1n6U4ctUa5tC9x3pQU1AqiJUPQ5e0ec7XZHNcff6aQUxIkoWbG8FvQdVsHL1EhS62QNbqr9wLqHS9cXNRwq1qL0DfNpLzJeeGwynWLQiIFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=MO8oV0eo; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="MO8oV0eo"
Received: from fews04-sea.riseup.net (fews04-sea-pn.riseup.net [10.0.1.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4hKrdr16xlzDqKW
	for <connman@lists.linux.dev>; Wed, 12 Aug 2026 14:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1786545376; bh=e6y0oPS9vWZuXAz9mr25al73RJRg/DP3rWYecKxh+W4=;
	h=Date:From:To:Subject:From;
	b=MO8oV0eopHpjn7G2mKcLMRMUjspyHktVHMTGPm/pMeb/sFl2DynllsE2NkqICCJD3
	 Ywy6MIMVfmqxgRyvOK1oHkL0r3LG+WALDncU9Wfv41lvvkOsAiHVpJiF5vfrQBDs1Y
	 ho+f501McFeTSa7YVivqQFDj79Ei9Vs3jNwGB7qI=
X-Riseup-User-ID: 01A970679D893371A40ACC67BE16AA23F1AB386C267F0623E49EF3DF1F5DC575
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews04-sea.riseup.net (Postfix) with ESMTPSA id 4hKrdq6yc2z5vN2
	for <connman@lists.linux.dev>; Wed, 12 Aug 2026 14:36:15 +0000 (UTC)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 12 Aug 2026 14:36:15 +0000
From: kasuta@riseup.net
To: connman@lists.linux.dev
Subject: [BUG UPDATE] Wi-Fi vs Ethernet behavior isolated on WireGuard (wg0)
 disconnect leak
Message-ID: <43dd58a734ea77cdbcc6e87003032a11@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello ConnMan Developers,

I am writing to provide critical new diagnostic data regarding the file
descriptor resource leak when paired with out-of-band virtual interfaces
(kernel-space WireGuard wg0 tunnel).

After conducting exhaustive monitoring across multiple devices and
builds (including LibreELEC 12/13 running on x86_64 and Raspberry Pi
3/4/5), I have successfully isolated a massive behavioral divergence
between Ethernet and Wi-Fi connections.

### New Discovery: Wi-Fi vs. Ethernet Behavior
1. Ethernet (Stable with Mitigations): When cycling the WireGuard (wg0)
virtual tunnel while connected via a hardwired Ethernet (eth0)
interface, connmand resource tracking remains entirely flat and stable
once the `--nodnsproxy` flag is applied.

2. Wi-Fi (Aggressive Persistent Leak): When operating over a wireless
connection (wlan0), disconnecting the exact same WireGuard tunnel causes
an immediate, massive surge in file descriptors within the Main Daemon
(connmand). This resource leak persistently accumulates on Wi-Fi even
with modifications active.

Live Telemetry Capture (Wireless Environment):
* VPN Connected (Baseline): Main Daemon (connmand) File Descriptors = 19
* VPN Disconnected (Single Trigger Event): Main Daemon (connmand) File
Descriptors = 91

ConnMan instantly leaked 72 file descriptors in a single disconnect
action on Wi-Fi. It appears that when operating over wireless layers,
ConnMan’s active link/BSSID scanning routines or netlink interface
listeners (nl80211) completely fail to execute proper close() system
calls on tracking handles when a concurrent virtual routing interface
drops out-of-band.

### Deployed Workaround for Embedded Environments (LibreELEC)
For users running this in read-only appliance platforms, I have
implemented a systemd service override drop-in alongside a custom
configuration:

/storage/.config/connman_main.conf:
[General]
OnlineCheckMode=none
OnlineCheckURL=
OnlineCheckInterval=0

Systemd override block:
[Service]
ExecStart=
ExecStart=/usr/sbin/connmand -n
--config=/storage/.config/connman_main.conf --nodnsproxy
LimitNOFILE=4096
LogRateLimitIntervalSec=0

By forcing `OnlineCheckMode=none` and `--nodnsproxy`, we stabilize
Ethernet. However, because the count continuously climbs on Wi-Fi due to
the underlying wireless link tracking leak, capping `LimitNOFILE=4096`
ensures systemd will cleanly terminate and respawn connmand to reclaim
leaked file descriptors before it exhausts the global operating system
limit (1024), preventing total host networking freezes.

This narrows down the root cause to missing resource garbage collection
inside the wireless tracking state machines or netlink route management
loops during out-of-band virtual interface teardowns.

Best regards,
Doemela
