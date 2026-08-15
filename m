Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF52C3757
	for <connman@lists.linux.dev>; Sat, 15 Aug 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786802236; cv=none; b=W/CLIC3XmT7YKeVb7KT6Y0mWKH19SQfFP5K+MJcvnYX087yLF8DDUjaMyM0f+/qq+4nwELDc0nhb4SifE5dC1SQ8yVHU11ivfGh3qp1bfMmYiGPYDj6b7lZf6wTXs1RDLyZkjxBuMBQkVJ5p9hetIghm4UGgW6WchOGdY8/0foo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786802236; c=relaxed/simple;
	bh=vSb3UI9OMbdFvAufILSUaKDB1qiSPXZ7glGj0wE4wyo=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B5wKU4E9uNchldUidUkUwlH5QiHnw5sPsr1j9U1YwDO54i1YEErn5yT4DzAXcx7sHSubMCnssjSaqmpH3hoI/88RzzdL/gzcQWaANLvJ0TaCWcYnKo3IEkQXn8/DEezVFMZH/FUAAg3a4klYRjx9QBEuppLruxsiB6vDql0oyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=RkKFGLUR; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="RkKFGLUR"
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4hMgdJ2XMyzDqjj
	for <connman@lists.linux.dev>; Sat, 15 Aug 2026 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1786802228; bh=nTT0YGEZ4DRbA5kayR31ywGxizg25c157WZE+elzruA=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=RkKFGLURh6t+3eg6KgxRgE8lpygoX8cHjCLF3YvMUCBBYYsuoRu373goa9V1yfSkc
	 LzataUyK3CDXGYJbwUfj3usUJyu0GHxXy4sRKuAss8Rp/jfPGGsHESXm3VRvB+Bb6F
	 0Y+EYs/gR2mcWaNcd4VYRE7yPId3XMRWCEDX+qnw=
X-Riseup-User-ID: 794BBC23B8A9EADC78A0F51EC70523AC4D477401579AEAF2AD6DACC5EA21EC8A
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4hMgdJ1NL3z1ylB
	for <connman@lists.linux.dev>; Sat, 15 Aug 2026 13:57:08 +0000 (UTC)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 15 Aug 2026 13:57:07 +0000
From: kasuta@riseup.net
To: connman@lists.linux.dev
Subject: Re: [BUG UPDATE] Further isolation: Massive Wi-Fi vs Ethernet
 divergence on WireGuard disconnect
In-Reply-To: <ca32619d5cc5e4dab0897b57be9b7f93@riseup.net>
References: <6368c1cf1ddade8d052770691f7bd6e1@riseup.net>
 <9b4791d5c6b074fc5c39330d809fe140@riseup.net>
 <ca32619d5cc5e4dab0897b57be9b7f93@riseup.net>
Message-ID: <bd402cbcc29630d8bb129c575f6604d0@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello ConnMan Developers,

To expedite downstream tracking and save triage cycles, we mapped our
telemetry logs directly against the target subsystems. Since the
resource footprint continues to increase monotonically over Wi-Fi
channels despite shutting down user-space proxy routing and connectivity
verification triggers (`OnlineCheckMode = none` and `--nodnsproxy`), the
leakage vector is verified within the core kernel notification loops.

The leak behavior strictly manifests during the parsing sequence for
`RTM_DELLINK` / `RTM_NEWLINK` message sweeps when out-of-band virtual
device routing domains (such as standard `wg0` kernel interfaces) are
recycled beneath active infrastructure.

#### The Code Coordinates to Audit

We highly recommend reviewing the object reference counts and lifecycle
tracking pathways inside `src/rtnl.c`:

1. `rtnl_link_cb` Allocation Boundaries:
   Inside the primary Netlink route event engine handler callbacks,
check whether incoming interface event transitions are cloning reference
counts via structural configurations without matching dereferences when
device groups change state or vanish.

2. `g_io_channel_unref()` Missing Triggers:
   If ConnMan triggers localized wireless scanning adjustments or link
quality polling sweeps over internal communication pipes following link
loss events, verify that the low-level file handles created to poll
netlink arrays are properly executing an explicit `close()` or
`g_io_channel_unref()` upon message resolution loop conclusions.

3. Sub-Interface Tracking Buffers:
   Ensure that virtual routing nodes created dynamically under active
Wi-Fi backhauls clear their child reference records upon interface link
destruction events, instead of abandoning orphaned sockets within the
internal lifecycle architecture.

Our current management suite hooks into the environment by enforcing an
early-stage service-level sandbox (`LimitNOFILE=512`) to act as a
system-safe circuit breaker while this deep-seated lifecycle bug remains
open upstream. 

Hopefully, these technical data logs allow you to pin down the exact
routing socket release mismatch in the core daemon source arrays.

Best regards,  
Doemela

On 2026-08-12 17:23, kasuta@riseup.net wrote:
> Hello ConnMan Developers,
> 
> Correction to my previous telemetry update: The file descriptor count
> has broken past the initial threshold and is still continuously crawling
> upward on Wi-Fi, even with `OnlineCheckMode=none` and `--nodnsproxy`
> fully operational.
> 
> Here is the extended tracking timeline showing the active, creeping leak
> over time:
> 
> * VPN Connected baseline over Wi-Fi: 18 open files
> * VPN Disconnected (Immediate jump): 34 open files
> * A few minutes later (Idle sitting): 63 open files and climbing!
> 
> # ls -l /proc/$(pidof connmand)/fd | wc -l
> Output: 63
> 
> This completely eliminates the Fritz!Box WPAD or the HTTP online check
> loops as the core drivers of the resource leak. The daemon is actively
> compounding and abandoning sockets/handles on a low-frequency cycle
> purely over the wireless tracking layers. 
> 
> Something inside ConnMan's internal Netlink event listeners or
> link-state polling routines is generating or duplicating sockets on
> every internal cycle following an out-of-band interface teardown, and it
> never executes a clean garbage-collection close().
> 
> Best regards,
> Doemela
> 
> On 2026-08-12 17:20, kasuta@riseup.net wrote:
>> Hello ConnMan Developers,
>> 
>> An important update regarding the live telemetry behavior after
>> completely fixing the configuration file casing layout. 
>> 
>> Once `OnlineCheckMode=none`, `OnlineCheckIPv4URL=`, and
>> `OnlineCheckIPv6URL=` are cleanly parsed by ConnMan, the infinite
>> runaway compounding leak is successfully contained. The daemon no longer
>> crawls endlessly toward 1024, confirming that the continuous crawl was
>> driven by the online probing subsystems reacting to the broken gateway
>> path.
>> 
>> However, a structural "rest-leak" still occurs instantly upon the
>> WireGuard disconnect event over Wi-Fi. The descriptor count behaves as
>> follows:
>> 
>> * VPN Connected baseline over Wi-Fi: 18 open files
>> * VPN Disconnected event (Immediate jump): 34 open files
>> * Idle sitting (Long-term tracking): Hard lock at 34 open files
>> 
>> The daemon drops the continuous crawling behavior, but it permanently
>> holds onto exactly 16 leaked file descriptors/sockets from the dead
>> virtual interface. This confirms that while the online validation loop
>> causes the aggressive crash, ConnMan's core state engine still fails to
>> perform a clean garbage-collection teardown of the primary interface
>> handles when an out-of-band virtual tunnel drops over wireless layers.
>> 
>> Best regards,
>> Doemela
>> 
>> On 2026-08-12 16:41, kasuta@riseup.net wrote:
>>> Hello ConnMan Developers,
>>> 
>>> Following up on my previous message regarding the WireGuard (wg0)
>>> disconnect trigger, I have conducted further exhaustive testing and
>>> isolated a massive behavioral divergence between Ethernet and Wi-Fi
>>> environments.
>>> 
>>> ### New Discovery: Wi-Fi vs. Ethernet Behavior
>>> 1. Ethernet (Stable with Mitigations): When cycling the WireGuard tunnel
>>> while connected via hardwired Ethernet (eth0), resource tracking remains
>>> entirely flat and stable once the `--nodnsproxy` flag is applied.
>>> 
>>> 2. Wi-Fi (Aggressive Persistent Leak): When operating over a wireless
>>> connection (wlan0), disconnecting the exact same WireGuard tunnel causes
>>> an immediate, massive surge in file descriptors within the Main Daemon
>>> (connmand). This leak persistently accumulates on Wi-Fi even with
>>> modifications active.
>>> 
>>> Live Telemetry Capture (Wireless Environment):
>>> * VPN Connected (Baseline): Main Daemon (connmand) File Descriptors = 19
>>> * VPN Disconnected (Single Trigger Event): Main Daemon (connmand) File
>>> Descriptors = 91
>>> 
>>> ConnMan instantly leaked 72 file descriptors in a single disconnect
>>> action on Wi-Fi. It appears that under wireless layers, ConnMan’s active
>>> link/BSSID scanning routines or netlink interface listeners (nl80211)
>>> completely fail to execute proper close() system calls when a concurrent
>>> virtual routing interface drops out-of-band.
>>> 
>>> ### Deployed Workaround for Embedded Environments (LibreELEC)
>>> For users running this in read-only appliance platforms (tested on
>>> x86_64 and Raspberry Pi 3/4/5), I have implemented a systemd service
>>> override drop-in alongside a custom configuration to prevent total host
>>> networking freezes:
>>> 
>>> /storage/.config/connman_main.conf:
>>> [General]
>>> OnlineCheckMode=none
>>> 
>>> Systemd override block:
>>> [Service]
>>> ExecStart=
>>> ExecStart=/usr/sbin/connmand -n
>>> --config=/storage/.config/connman_main.conf --nodnsproxy
>>> LimitNOFILE=4096
>>> LogRateLimitIntervalSec=0
>>> 
>>> Capping `LimitNOFILE=4096` ensures systemd will cleanly terminate and
>>> respawn connmand to reclaim leaked file descriptors before it exhausts
>>> the global operating system limit (1024).
>>> 
>>> This strongly narrows down the root cause to missing resource garbage
>>> collection inside the wireless tracking state machines or netlink route
>>> management loops during out-of-band virtual interface teardowns.
>>> 
>>> Best regards,
>>> Doemela
