Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D834582FE
	for <connman@lists.linux.dev>; Wed, 12 Aug 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545692; cv=none; b=rMs2eyNz/hR4Ke36anwWM2EXwyRI5q8pyka6JmMbRTdlVDauNIU+PO7w2lsibkpMQFansok3QRLEqFh2rKGPsPk6e75qwSSWLz2vlOHNpDLt+Xa1iZ+iDnedImxgQ+Ui7Gka4yWEPNZuYfUbVnnr22JJCtOxcNvZZlR0i68ux5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545692; c=relaxed/simple;
	bh=JRRtqrYb3AH3/CJwXzxSK2x9cygqxfXaZF1FssDc5kI=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=E1fV9XWHwQ7buQDWWyhdbvm9zoqMf5GbBoEcspGGNSSbVKPLwjLLZBFTKGZjPCA+atQ60DK/21DhaohB2rFIeU4jkX0INF5IqWsoSZiZS/6JSj1xjiLGCHG7tLXG5jEuv7s0CNY4d70phByIrvtO0kV3xcwGaMf8puixwuC4n5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=g7Fj++t9; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="g7Fj++t9"
Received: from fews04-sea.riseup.net (fews04-sea-pn.riseup.net [10.0.1.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4hKrls0WMczDqFv
	for <connman@lists.linux.dev>; Wed, 12 Aug 2026 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1786545689; bh=JRRtqrYb3AH3/CJwXzxSK2x9cygqxfXaZF1FssDc5kI=;
	h=Date:From:To:Subject:From;
	b=g7Fj++t95qoBxeiouGC3lfr65aMwmFZn4BrjxhgNQJWtms0qNJOk3Ljxonbv+K4rj
	 86Q7RgCXFJ5Xqp1wZyx9xvT51fVpX539WfQBSglaQq0dW2Jnj65GTBsj+vlMNuT11B
	 RFLTMQ9ZZ6PxWUn+safN5RRwuHbIjUBFC7zYoUeI=
X-Riseup-User-ID: 5FBD3679150E97255ABF3A674C41298016F35E1376399E3A16DABCCC6CFD8DCC
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews04-sea.riseup.net (Postfix) with ESMTPSA id 4hKrlr5zVwz5vN2
	for <connman@lists.linux.dev>; Wed, 12 Aug 2026 14:41:28 +0000 (UTC)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 12 Aug 2026 14:41:28 +0000
From: kasuta@riseup.net
To: connman@lists.linux.dev
Subject: Re: [BUG UPDATE] Further isolation: Massive Wi-Fi vs Ethernet
 divergence on WireGuard disconnect
Message-ID: <6368c1cf1ddade8d052770691f7bd6e1@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello ConnMan Developers,

Following up on my previous message regarding the WireGuard (wg0)
disconnect trigger, I have conducted further exhaustive testing and
isolated a massive behavioral divergence between Ethernet and Wi-Fi
environments.

### New Discovery: Wi-Fi vs. Ethernet Behavior
1. Ethernet (Stable with Mitigations): When cycling the WireGuard tunnel
while connected via hardwired Ethernet (eth0), resource tracking remains
entirely flat and stable once the `--nodnsproxy` flag is applied.

2. Wi-Fi (Aggressive Persistent Leak): When operating over a wireless
connection (wlan0), disconnecting the exact same WireGuard tunnel causes
an immediate, massive surge in file descriptors within the Main Daemon
(connmand). This leak persistently accumulates on Wi-Fi even with
modifications active.

Live Telemetry Capture (Wireless Environment):
* VPN Connected (Baseline): Main Daemon (connmand) File Descriptors = 19
* VPN Disconnected (Single Trigger Event): Main Daemon (connmand) File
Descriptors = 91

ConnMan instantly leaked 72 file descriptors in a single disconnect
action on Wi-Fi. It appears that under wireless layers, ConnMan’s active
link/BSSID scanning routines or netlink interface listeners (nl80211)
completely fail to execute proper close() system calls when a concurrent
virtual routing interface drops out-of-band.

### Deployed Workaround for Embedded Environments (LibreELEC)
For users running this in read-only appliance platforms (tested on
x86_64 and Raspberry Pi 3/4/5), I have implemented a systemd service
override drop-in alongside a custom configuration to prevent total host
networking freezes:

/storage/.config/connman_main.conf:
[General]
OnlineCheckMode=none

Systemd override block:
[Service]
ExecStart=
ExecStart=/usr/sbin/connmand -n
--config=/storage/.config/connman_main.conf --nodnsproxy
LimitNOFILE=4096
LogRateLimitIntervalSec=0

Capping `LimitNOFILE=4096` ensures systemd will cleanly terminate and
respawn connmand to reclaim leaked file descriptors before it exhausts
the global operating system limit (1024).

This strongly narrows down the root cause to missing resource garbage
collection inside the wireless tracking state machines or netlink route
management loops during out-of-band virtual interface teardowns.

Best regards,
Doemela
