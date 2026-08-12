Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873152C08CF
	for <connman@lists.linux.dev>; Wed, 12 Aug 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548057; cv=none; b=TJfC1yTNbV3J+Da+G9iER72LFy3ZQCCyxIwrlo81lsVvwqMyfiBPUUBBNmEOqKnXnNQyw+wHZOGuuMxN01EaNBa6OmUuEpZKq+BfWJgL506kgaBwhkddyyF72NjZcooA80KdxdUpw4MD2Yw2imSbfAcILE7JK5HU0MZ/meW9uzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548057; c=relaxed/simple;
	bh=v5EXY6bcITVWn/U4DSmyDP60D95LlSH096OsbPLwikw=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cnmmMNjKu4N3GA4foF2qlT3ULcVgS/p7MSBXF0DVehHlheu2q5/E1F/z80KO5dvbCI129kfamE8Lh/5CD5G1YytvrWWC6Y0AQWbM1yFAgqwYsxqwYfh1rJ03RDtPaGx+/l5Q7/vufyKWS5dF2/k8Go5M14lH6kjsOyVuVIC/mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=r8zcJSaU; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="r8zcJSaU"
Received: from fews04-sea.riseup.net (fews04-sea-pn.riseup.net [10.0.1.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4hKsdM10NzzDqJF
	for <connman@lists.linux.dev>; Wed, 12 Aug 2026 15:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1786548055; bh=XghCurRfRTa86rYxLvKNLuoJomKU1P+GFGsaI48t6+Q=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=r8zcJSaUgvVK0aGyzwZhXXtIZ+3iTM+1YkLzSbumTViNvstBKZB8yTBtA+1UshRRf
	 WLn5lmA426MRtELTn8kr95iOqwHHCiZzHMG6Mh9odrrEYOADmORVD9yte53JW3v2Al
	 61yFTsWIDou5FWFe1aeblryiTOvVvBJLOZVyuE2E=
X-Riseup-User-ID: 0870E168EA44AB7F5921F3423B3AC559D9F7A100C22630FA483078C1FCFBA77D
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews04-sea.riseup.net (Postfix) with ESMTPSA id 4hKsdL70VMz5vLZ
	for <connman@lists.linux.dev>; Wed, 12 Aug 2026 15:20:54 +0000 (UTC)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 12 Aug 2026 15:20:54 +0000
From: kasuta@riseup.net
To: connman@lists.linux.dev
Subject: Re: [BUG UPDATE] Further isolation: Massive Wi-Fi vs Ethernet
 divergence on WireGuard disconnect
In-Reply-To: <6368c1cf1ddade8d052770691f7bd6e1@riseup.net>
References: <6368c1cf1ddade8d052770691f7bd6e1@riseup.net>
Message-ID: <9b4791d5c6b074fc5c39330d809fe140@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello ConnMan Developers,

An important update regarding the live telemetry behavior after
completely fixing the configuration file casing layout. 

Once `OnlineCheckMode=none`, `OnlineCheckIPv4URL=`, and
`OnlineCheckIPv6URL=` are cleanly parsed by ConnMan, the infinite
runaway compounding leak is successfully contained. The daemon no longer
crawls endlessly toward 1024, confirming that the continuous crawl was
driven by the online probing subsystems reacting to the broken gateway
path.

However, a structural "rest-leak" still occurs instantly upon the
WireGuard disconnect event over Wi-Fi. The descriptor count behaves as
follows:

* VPN Connected baseline over Wi-Fi: 18 open files
* VPN Disconnected event (Immediate jump): 34 open files
* Idle sitting (Long-term tracking): Hard lock at 34 open files

The daemon drops the continuous crawling behavior, but it permanently
holds onto exactly 16 leaked file descriptors/sockets from the dead
virtual interface. This confirms that while the online validation loop
causes the aggressive crash, ConnMan's core state engine still fails to
perform a clean garbage-collection teardown of the primary interface
handles when an out-of-band virtual tunnel drops over wireless layers.

Best regards,
Doemela

On 2026-08-12 16:41, kasuta@riseup.net wrote:
> Hello ConnMan Developers,
> 
> Following up on my previous message regarding the WireGuard (wg0)
> disconnect trigger, I have conducted further exhaustive testing and
> isolated a massive behavioral divergence between Ethernet and Wi-Fi
> environments.
> 
> ### New Discovery: Wi-Fi vs. Ethernet Behavior
> 1. Ethernet (Stable with Mitigations): When cycling the WireGuard tunnel
> while connected via hardwired Ethernet (eth0), resource tracking remains
> entirely flat and stable once the `--nodnsproxy` flag is applied.
> 
> 2. Wi-Fi (Aggressive Persistent Leak): When operating over a wireless
> connection (wlan0), disconnecting the exact same WireGuard tunnel causes
> an immediate, massive surge in file descriptors within the Main Daemon
> (connmand). This leak persistently accumulates on Wi-Fi even with
> modifications active.
> 
> Live Telemetry Capture (Wireless Environment):
> * VPN Connected (Baseline): Main Daemon (connmand) File Descriptors = 19
> * VPN Disconnected (Single Trigger Event): Main Daemon (connmand) File
> Descriptors = 91
> 
> ConnMan instantly leaked 72 file descriptors in a single disconnect
> action on Wi-Fi. It appears that under wireless layers, ConnMan’s active
> link/BSSID scanning routines or netlink interface listeners (nl80211)
> completely fail to execute proper close() system calls when a concurrent
> virtual routing interface drops out-of-band.
> 
> ### Deployed Workaround for Embedded Environments (LibreELEC)
> For users running this in read-only appliance platforms (tested on
> x86_64 and Raspberry Pi 3/4/5), I have implemented a systemd service
> override drop-in alongside a custom configuration to prevent total host
> networking freezes:
> 
> /storage/.config/connman_main.conf:
> [General]
> OnlineCheckMode=none
> 
> Systemd override block:
> [Service]
> ExecStart=
> ExecStart=/usr/sbin/connmand -n
> --config=/storage/.config/connman_main.conf --nodnsproxy
> LimitNOFILE=4096
> LogRateLimitIntervalSec=0
> 
> Capping `LimitNOFILE=4096` ensures systemd will cleanly terminate and
> respawn connmand to reclaim leaked file descriptors before it exhausts
> the global operating system limit (1024).
> 
> This strongly narrows down the root cause to missing resource garbage
> collection inside the wireless tracking state machines or netlink route
> management loops during out-of-band virtual interface teardowns.
> 
> Best regards,
> Doemela
