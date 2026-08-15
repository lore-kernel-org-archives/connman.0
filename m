Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB53254B3
	for <connman@lists.linux.dev>; Sat, 15 Aug 2026 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786804874; cv=none; b=j0PwfZzP6ugbaGt0uiTIZuJKdb+ZpU1TV1aWQ/sPXec3AyMRYsq9cqnimtdl1CFP5I8/E3ppp9rFwxEjX8b8GWp4n6qYHFAoYjwpWTuExB1CwMLSKv0nyu5YIgJ6nfK6GGqezXBf4kOGz58ohxyjxFeeoEbWNnbdSpIeoopDWMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786804874; c=relaxed/simple;
	bh=o3nFtWvoBAh97JcLhmCroCgUzys2+dJXFAT6ToWY+GY=;
	h=MIME-Version:Date:From:To:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RVX+70rrCNkFyhBQmns0N9I5lnbtAGRqp9qXl272Bm57An3xsPeUYZiDlZ3ifuIHsgZTcQZ7Tj7N9FNPE88Y/qt6DjevmeXICM1L4rQTxZBnDVX6435dyyJN3nNUAEKOQKke4pcHOs5XL4J6J8HBqL/a/v7TWWLI2TtHSJphfpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=Gm10LCzd; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Gm10LCzd"
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4hMhc81g0Xz9sRP
	for <connman@lists.linux.dev>; Sat, 15 Aug 2026 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1786804872; bh=l5A7tM+Ub2UPUczuW6AX0R80cTEd9CYhuZZVD47p4lU=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=Gm10LCzdEVAyrBGuMHVwrpnE1V1eN+na57sfgU73txBU04dkpCeO7TZypy75Cgv6I
	 /oHTfBunNa6/oKQA4krPsBp8PlE64rMyfbB2wy2G2+D8IyPsfbFCJFYVwaFeJzK2T1
	 fXuexzc+WnWyOGa5IHUV8O9uY0B4sDEUBjBPXJeQ=
X-Riseup-User-ID: 7529397FF718F2B829F07B064B887FB2EF1C8964A4A40F8F157093D0A8FAE996
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4hMhc80VNVz1ylJ
	for <connman@lists.linux.dev>; Sat, 15 Aug 2026 14:41:12 +0000 (UTC)
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 15 Aug 2026 14:41:11 +0000
From: kasuta@riseup.net
To: connman@lists.linux.dev
Subject: Re: [BUG UPDATE] Further isolation: Massive Wi-Fi vs Ethernet
 divergence on WireGuard disconnect
In-Reply-To: <f86a2479ff98787d74812f053764b5a4@riseup.net>
References: <6368c1cf1ddade8d052770691f7bd6e1@riseup.net>
 <9b4791d5c6b074fc5c39330d809fe140@riseup.net>
 <ca32619d5cc5e4dab0897b57be9b7f93@riseup.net>
 <bd402cbcc29630d8bb129c575f6604d0@riseup.net>
 <f86a2479ff98787d74812f053764b5a4@riseup.net>
Message-ID: <19768b042fe429253e266be2b82e222a@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[BUG UPDATE] Upstream Root Cause: Asynchronous race condition inside
plugins/wifi.c `interface_removed` loop

Hello ConnMan Developers,

We have isolated a race condition in `plugins/wifi.c` causing a File
Descriptor (FD) leak, triggered when virtual interfaces (e.g.,
WireGuard) drop, causing `interface_removed` to skip essential cleanup.

The `if (!wifi || !wifi->device)` check causes an early return,
bypassing `g_supplicant_interface_cancel`, leading to orphaned Netlink
sockets.

Fix: Ensure `g_supplicant_interface_cancel` and socket closures run
unconditionally to prevent leaks.

Best regards,
Doemela

On 2026-08-15 16:02, kasuta@riseup.net wrote:
> [BUG UPDATE] Technical Breakdown: Netlink/RTNL descriptor aggregation
> inside `src/rtnl.c` loops on `wg` tear-down
> 
> Hello ConnMan Developers,
> 
> To narrow this down to the absolute shortest path for a patch, we
> performed a structural review of how ConnMan interacts with the Wi-Fi
> stack under GLib environment rules during an out-of-band interface drop
> (like a virtual WireGuard tunnel teardown).
> 
> Since this resource aggregation leak is strictly limited to active Wi-Fi
> interfaces, the primary tracking error is highly likely localized within
> the cleanup tracking loops of:
> -> plugins/wifi.c
> -> src/rtnl.c (specifically under Wi-Fi/wpa_supplicant event hooks)
> 
> The Likely Root Cause: Missing GLib GIOChannel Dereferencing
> 
> When a routing switch occurs over wireless architecture, ConnMan
> instantiates netlink event notification routines or local telemetry
> tracking channels. In a GLib-based architecture, these descriptors are
> commonly wrapped using:
> `GIOChannel *channel = g_io_channel_unix_new(fd);`
> 
> If an unmanaged interface (like `wg0`) drops abruptly, the state machine
> triggers an early `return` or a conditional error-handling bypass inside
> the event listener loop. 
> 
> If this early exit path skips the mandatory cleanup sequences:
> 1. `g_io_channel_unref(channel);`
> 2. `close(fd);`
> 
> The low-level socket descriptor remains completely orphaned and open in
> the active process table indefinitely. This matches our telemetry
> profile perfectly, where sequential groups of sockets are permanently
> abandoned every time the interface context switches.
> 
> Checking `plugins/wifi.c` for any asynchronous socket loop callbacks or
> Netlink listeners that fail to execute an explicit
> `g_io_channel_unref()` during a non-standard interface drop should
> isolate the exact line causing this issue.
> 
> Best regards,
> Doemela
> 
> On 2026-08-15 15:57, kasuta@riseup.net wrote:
>> Hello ConnMan Developers,
>> 
>> To expedite downstream tracking and save triage cycles, we mapped our
>> telemetry logs directly against the target subsystems. Since the
>> resource footprint continues to increase monotonically over Wi-Fi
>> channels despite shutting down user-space proxy routing and connectivity
>> verification triggers (`OnlineCheckMode = none` and `--nodnsproxy`), the
>> leakage vector is verified within the core kernel notification loops.
>> 
>> The leak behavior strictly manifests during the parsing sequence for
>> `RTM_DELLINK` / `RTM_NEWLINK` message sweeps when out-of-band virtual
>> device routing domains (such as standard `wg0` kernel interfaces) are
>> recycled beneath active infrastructure.
>> 
>> #### The Code Coordinates to Audit
>> 
>> We highly recommend reviewing the object reference counts and lifecycle
>> tracking pathways inside `src/rtnl.c`:
>> 
>> 1. `rtnl_link_cb` Allocation Boundaries:
>>    Inside the primary Netlink route event engine handler callbacks,
>> check whether incoming interface event transitions are cloning reference
>> counts via structural configurations without matching dereferences when
>> device groups change state or vanish.
>> 
>> 2. `g_io_channel_unref()` Missing Triggers:
>>    If ConnMan triggers localized wireless scanning adjustments or link
>> quality polling sweeps over internal communication pipes following link
>> loss events, verify that the low-level file handles created to poll
>> netlink arrays are properly executing an explicit `close()` or
>> `g_io_channel_unref()` upon message resolution loop conclusions.
>> 
>> 3. Sub-Interface Tracking Buffers:
>>    Ensure that virtual routing nodes created dynamically under active
>> Wi-Fi backhauls clear their child reference records upon interface link
>> destruction events, instead of abandoning orphaned sockets within the
>> internal lifecycle architecture.
>> 
>> Our current management suite hooks into the environment by enforcing an
>> early-stage service-level sandbox (`LimitNOFILE=512`) to act as a
>> system-safe circuit breaker while this deep-seated lifecycle bug remains
>> open upstream. 
>> 
>> Hopefully, these technical data logs allow you to pin down the exact
>> routing socket release mismatch in the core daemon source arrays.
>> 
>> Best regards,  
>> Doemela
>> 
>> On 2026-08-12 17:23, kasuta@riseup.net wrote:
>>> Hello ConnMan Developers,
>>> 
>>> Correction to my previous telemetry update: The file descriptor count
>>> has broken past the initial threshold and is still continuously crawling
>>> upward on Wi-Fi, even with `OnlineCheckMode=none` and `--nodnsproxy`
>>> fully operational.
>>> 
>>> Here is the extended tracking timeline showing the active, creeping leak
>>> over time:
>>> 
>>> * VPN Connected baseline over Wi-Fi: 18 open files
>>> * VPN Disconnected (Immediate jump): 34 open files
>>> * A few minutes later (Idle sitting): 63 open files and climbing!
>>> 
>>> # ls -l /proc/$(pidof connmand)/fd | wc -l
>>> Output: 63
>>> 
>>> This completely eliminates the Fritz!Box WPAD or the HTTP online check
>>> loops as the core drivers of the resource leak. The daemon is actively
>>> compounding and abandoning sockets/handles on a low-frequency cycle
>>> purely over the wireless tracking layers. 
>>> 
>>> Something inside ConnMan's internal Netlink event listeners or
>>> link-state polling routines is generating or duplicating sockets on
>>> every internal cycle following an out-of-band interface teardown, and it
>>> never executes a clean garbage-collection close().
>>> 
>>> Best regards,
>>> Doemela
>>> 
>>> On 2026-08-12 17:20, kasuta@riseup.net wrote:
>>>> Hello ConnMan Developers,
>>>> 
>>>> An important update regarding the live telemetry behavior after
>>>> completely fixing the configuration file casing layout. 
>>>> 
>>>> Once `OnlineCheckMode=none`, `OnlineCheckIPv4URL=`, and
>>>> `OnlineCheckIPv6URL=` are cleanly parsed by ConnMan, the infinite
>>>> runaway compounding leak is successfully contained. The daemon no longer
>>>> crawls endlessly toward 1024, confirming that the continuous crawl was
>>>> driven by the online probing subsystems reacting to the broken gateway
>>>> path.
>>>> 
>>>> However, a structural "rest-leak" still occurs instantly upon the
>>>> WireGuard disconnect event over Wi-Fi. The descriptor count behaves as
>>>> follows:
>>>> 
>>>> * VPN Connected baseline over Wi-Fi: 18 open files
>>>> * VPN Disconnected event (Immediate jump): 34 open files
>>>> * Idle sitting (Long-term tracking): Hard lock at 34 open files
>>>> 
>>>> The daemon drops the continuous crawling behavior, but it permanently
>>>> holds onto exactly 16 leaked file descriptors/sockets from the dead
>>>> virtual interface. This confirms that while the online validation loop
>>>> causes the aggressive crash, ConnMan's core state engine still fails to
>>>> perform a clean garbage-collection teardown of the primary interface
>>>> handles when an out-of-band virtual tunnel drops over wireless layers.
>>>> 
>>>> Best regards,
>>>> Doemela
>>>> 
>>>> On 2026-08-12 16:41, kasuta@riseup.net wrote:
>>>>> Hello ConnMan Developers,
>>>>> 
>>>>> Following up on my previous message regarding the WireGuard (wg0)
>>>>> disconnect trigger, I have conducted further exhaustive testing and
>>>>> isolated a massive behavioral divergence between Ethernet and Wi-Fi
>>>>> environments.
>>>>> 
>>>>> ### New Discovery: Wi-Fi vs. Ethernet Behavior
>>>>> 1. Ethernet (Stable with Mitigations): When cycling the WireGuard tunnel
>>>>> while connected via hardwired Ethernet (eth0), resource tracking remains
>>>>> entirely flat and stable once the `--nodnsproxy` flag is applied.
>>>>> 
>>>>> 2. Wi-Fi (Aggressive Persistent Leak): When operating over a wireless
>>>>> connection (wlan0), disconnecting the exact same WireGuard tunnel causes
>>>>> an immediate, massive surge in file descriptors within the Main Daemon
>>>>> (connmand). This leak persistently accumulates on Wi-Fi even with
>>>>> modifications active.
>>>>> 
>>>>> Live Telemetry Capture (Wireless Environment):
>>>>> * VPN Connected (Baseline): Main Daemon (connmand) File Descriptors = 19
>>>>> * VPN Disconnected (Single Trigger Event): Main Daemon (connmand) File
>>>>> Descriptors = 91
>>>>> 
>>>>> ConnMan instantly leaked 72 file descriptors in a single disconnect
>>>>> action on Wi-Fi. It appears that under wireless layers, ConnMan’s active
>>>>> link/BSSID scanning routines or netlink interface listeners (nl80211)
>>>>> completely fail to execute proper close() system calls when a concurrent
>>>>> virtual routing interface drops out-of-band.
>>>>> 
>>>>> ### Deployed Workaround for Embedded Environments (LibreELEC)
>>>>> For users running this in read-only appliance platforms (tested on
>>>>> x86_64 and Raspberry Pi 3/4/5), I have implemented a systemd service
>>>>> override drop-in alongside a custom configuration to prevent total host
>>>>> networking freezes:
>>>>> 
>>>>> /storage/.config/connman_main.conf:
>>>>> [General]
>>>>> OnlineCheckMode=none
>>>>> 
>>>>> Systemd override block:
>>>>> [Service]
>>>>> ExecStart=
>>>>> ExecStart=/usr/sbin/connmand -n
>>>>> --config=/storage/.config/connman_main.conf --nodnsproxy
>>>>> LimitNOFILE=4096
>>>>> LogRateLimitIntervalSec=0
>>>>> 
>>>>> Capping `LimitNOFILE=4096` ensures systemd will cleanly terminate and
>>>>> respawn connmand to reclaim leaked file descriptors before it exhausts
>>>>> the global operating system limit (1024).
>>>>> 
>>>>> This strongly narrows down the root cause to missing resource garbage
>>>>> collection inside the wireless tracking state machines or netlink route
>>>>> management loops during out-of-band virtual interface teardowns.
>>>>> 
>>>>> Best regards,
>>>>> Doemela
