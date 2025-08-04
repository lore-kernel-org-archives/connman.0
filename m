Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138D1F4CBE
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320194; cv=none; b=d6QP/8BjnIuZ8GhN8lAq8U7MI3cZf97W5+hOcVE8hvc5BCNirP5vOTnOua/gcBb6K8aa9B54F607aX0ywWVU/VcAWbadxDkrM0eoIBufGCUQKXuQ+TnoMhwBp/FSZLXBY4fkGi2lwuI2pKTaKOdv5oPjka+6ZhlHvIqmR7/NmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320194; c=relaxed/simple;
	bh=0uR7tGN18/WIejjg56y2Qr/rprHiWM2FllSiI/sHW0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nRYn6PLq+M2yeEhZvW3ZVwetBXSJSes18nfF5Bdr8knxwHnCEQpeoQc1ISXPpqiHBxZrU/3BJXD3YLqVyEwbDh254yjENf5WFoDpwT5yT/rG/zMj/g6HCfsHenkLhM8Odizmo7aRw+1yFFdBj+IzQXSAjg9QeWZGacQaDGW3r30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA4mLKYW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA4mLKYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51476C4CEE7;
	Mon,  4 Aug 2025 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754320193;
	bh=0uR7tGN18/WIejjg56y2Qr/rprHiWM2FllSiI/sHW0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pA4mLKYWmvec/6y1fKaGrmqhK38/l9ucon/FnZZ+h9gGrTsMh1PCjZluMb7xuoqf0
	 yBNGf5R/jabcpuq+O/7ktTH+1IbPOYVGfA2u3ppt3uVrEA/Mo1YOpBVdx1HtrCmmek
	 1/+myhSeZJr1mVv8yys7nha4AbN0YG57Hf5FFtBji1/1WT+t79R9d1t37/MId5Md8e
	 0t/xqgLVvSovTtjwmk+ThOkkdepexhbeNBr+BHku/HQUy+odGlYNefNEkj6V5REjws
	 qnb59fmTq3TiPRhLg/op6EevKWJm4wP22nSjt7eQFgt0IUwqigtrYhp8wZeCIH2Uc/
	 j+RfvZDAMPW0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD99383BF56;
	Mon,  4 Aug 2025 15:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/46] VPN association state, dual IP support and WG fixes
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <175432020743.1223670.11544345566042738457.git-patchwork-notify@kernel.org>
Date: Mon, 04 Aug 2025 15:10:07 +0000
References: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
In-Reply-To: <20250711142736.1757060-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 11 Jul 2025 17:26:51 +0300 you wrote:
> This patch set (1) adds the association state also for the VPNs, (2) implements
> dual IP support for VPNs and (3) contains fixes for Wireguard address,
> especially for FQDN handling. This is a combination of all three improvements
> for the sake of testing them together.
> 
> (1): association state for VPNs
> The association state is to indicate that the VPN is waiting for VPN agent to
> provide input given by user. In this state service.c must not do connect
> timeout checks as the timers for both differ in length, default being 120s for
> connect timeout and 300s for VPN agent dialog timeout.
> 
> [...]

Here is the summary with links:
  - [01/45] agent: Cancel agent request on NoReply D-Bus error
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=01c10f2ce960
  - [02/45] vpn-provider: Use association state for VPN agent input wait
    (no matching commit)
  - [03/45] vpn: Add association state before connect state
    (no matching commit)
  - [04/45] vpn-agent: Do connect state transition after input dialog check
    (no matching commit)
  - [05/45] service: Explicit VPN connect timeout, ignore in VPN agent wait
    (no matching commit)
  - [06/45] provider: Handle VPN configuration and association states
    (no matching commit)
  - [07/45] vpn: Add support for association state, add state getter
    (no matching commit)
  - [08/45] vpn: Check if connecting when setting state or disconnecting
    (no matching commit)
  - [09/45] vpn: Add VPN agent use callback for plugins
    (no matching commit)
  - [10/45] vpn-provider: Transition to CONNECT state with agentless VPNs
    (no matching commit)
  - [11/45] doc: Update VPN documentation for association state
    (no matching commit)
  - [12/45] wireguard: Add saving of provider properties
    (no matching commit)
  - [13/45] wireguard: Use positive errors for VPN provider connect_cb
    (no matching commit)
  - [14/45] vpn: Fix VPN_FLAG_NO_DAEMON use in error cases
    (no matching commit)
  - [15/45] wireguard: Handle disconnect, error and network errors better
    (no matching commit)
  - [16/45] gresolv: Add generic error for GResolv struct with getter
    (no matching commit)
  - [17/45] vpn-util: Add wrappers for GResolv hostname lookup use
    (no matching commit)
  - [18/45] wireguard: Use GResolv for DNS reresolve to avoid blocking
    (no matching commit)
  - [19/45] vpn: Drop state changes from update_provider_state()
    (no matching commit)
  - [20/45] wireguard: Fix shutdown, ensure one exit and set no agent is used
    (no matching commit)
  - [21/45] vpn: Check if disconnect is implemented before calling in stop_vpn()
    (no matching commit)
  - [22/45] wireguard: Tokenize host for getaddrinfo()
    (no matching commit)
  - [23/45] util: Add address family set/get/reset helpers
    (no matching commit)
  - [24/45] vpn-provider: Add support for dual-IP VPNs
    (no matching commit)
  - [25/45] provider: Add support for dual-IP VPNs
    (no matching commit)
  - [26/45] vpn: Add support for dual-IP VPNs
    (no matching commit)
  - [27/45] wireguard: Support both IPv4 and IPv6 address
    (no matching commit)
  - [28/45] inet: Expose __connman_inet_is_any_addr() for plugins to use
    (no matching commit)
  - [29/45] wireguard: Set split routing based on AllowedIPs
    (no matching commit)
  - [30/45] Revert "vpn: Remove unused __vpn_provider_check_routes"
    (no matching commit)
  - [31/45] vpn-provider: Allow to add complete routes and to remove routes
    (no matching commit)
  - [32/45] wireguard: Add routes for other than any addresses
    (no matching commit)
  - [33/45] wireguard: Fix string list parsing and IP tunneling
    (no matching commit)
  - [34/45] wireguard: Treat initial connect failure as unreachable host
    (no matching commit)
  - [35/45] service: handle also EALREADY in service_connect()
    (no matching commit)
  - [36/45] vpn-provider: Make daemonless VPNs to connect when connmand is online
    (no matching commit)
  - [37/45] vpn: Implement getter for the flags set by the VPN
    (no matching commit)
  - [38/45] vpn-provider: Delay connect of daemonless VPNs until connmand is online
    (no matching commit)
  - [39/45] wireguard: Rework hostname resolve, split code and do not resolve IP
    (no matching commit)
  - [40/45] vpn-util: Add wrapper for adding a namerver for GResolv
    (no matching commit)
  - [41/45] service: Send the DNS servers of VPN's transport when VPN is ready
    (no matching commit)
  - [42/45] vpn-provider: Add support for set/get "TransportNameservers"
    (no matching commit)
  - [43/45] wireguard: Add option for using transport nameservers for DNS reresolve
    (no matching commit)
  - [44/45] wireguard: Fix FQDN by using the resolved IP as the gateway
    (no matching commit)
  - [45/45] provider: Add the VPN nameserver routes when connected
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


