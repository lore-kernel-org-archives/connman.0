Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7825C6E6
	for <connman@lists.linux.dev>; Mon, 14 Apr 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650597; cv=none; b=qXegTcFlGcfiJWyGL8FKgi8AsDNy+84Adc6pPfsjDjSZ3Z20NAOsFKJN0t3ymeK3zR3mUf7lpi2onxsmlhN9/OFbLfcYXXVnA7KsQFkS9fcYd942jdiWsdFdho3vx3xflKuKwK+tYB5H4lKV7skgeK9aJlj98CP1+pxyIyDXmsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650597; c=relaxed/simple;
	bh=1FxUGsNAX2at/Ng0F+g3Z270gdt5KtwspqVtmF7uUYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qhr3L3NaYyvoIUZMBvYFKr7L/9B59XTTy7lWQy95bpgTYPR5k/OSlvNoHnFEUnSxN8zBLqILSSagzVxeJMB1BeH6O2iPvAhWnxVLV/JvWN6EAZj3iRCOcYdwTmVxmBUaqkGIbTRL3sxbw36WqbhM6gOkPIiJ47lL/vK5jtU7Nro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC3YG8pl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC3YG8pl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619FCC4CEEA;
	Mon, 14 Apr 2025 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744650596;
	bh=1FxUGsNAX2at/Ng0F+g3Z270gdt5KtwspqVtmF7uUYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nC3YG8pl1Xbll8wtjX4Q09jNVkWXaT6yJoEiI2S3pF59PwjsRJ8p4EaDQVvg5xZdS
	 sjX0vlyVmL3QzKDM4UmI0DXt3hegiq36pQm9Qp8tjqUGgCIJ89P9mfSXPVandrTzZx
	 UTeHNK82T1msT5FeyhYcWv1f8PuQDX8kCSrZRgdj82oEV2CcXV2fv2oaN83sYyToLy
	 D5R99kP4f7U/XzPv3RIro9FzKGzaVhblIRQqK3XTrzWvmVEkAFsDHFrugoqOGnpCkM
	 hlWGF+62nL3z9xAdbr8KzZ/DEjkCWRfzRpNC/pZN3mInNFvEwYG+0qD5Xvi6tXKxiY
	 A5q48M9WZ1hGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E433822D1A;
	Mon, 14 Apr 2025 17:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/12] Improve WireGuard disconnect, error and hostname lookup
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174465063414.1975856.1463897912309486842.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 17:10:34 +0000
References: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
In-Reply-To: <20250124185916.1546471-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 24 Jan 2025 20:59:04 +0200 you wrote:
> This set of patches improves the WireGuard plugin and adds better error case
> support for the vpn/plugins/vpn.c. This allows also to propagate the errors
> upward and with other changes, allows the shutdown to follow the same process
> as the other VPNs. Alsom fix the PrefixLength use in connmand and in the
> WireGuard plugin by tokenizing the host before getaddrinfo() check.
> 
> First, the basic saving of the WireGuard configuration is done similarly to
> other plugins, as well as to what wg-quick is utilizing.
> 
> [...]

Here is the summary with links:
  - [01/12] wireguard: Add saving of provider properties
    (no matching commit)
  - [02/12] wireguard: Use positive errors for VPN provider connect_cb
    (no matching commit)
  - [03/12] vpn: Fix VPN_FLAG_NO_DAEMON use in error cases
    (no matching commit)
  - [04/12] wireguard: Handle disconnect, error and network errors better
    (no matching commit)
  - [05/12] gresolv: Add generic error for GResolv struct with getter
    (no matching commit)
  - [06/12] vpn-util: Add wrappers for GResolv hostname lookup use
    (no matching commit)
  - [07/12] wireguard: Use GResolv for DNS reresolve to avoid blocking
    (no matching commit)
  - [08/12] vpn: Drop state changes from update_provider_state()
    (no matching commit)
  - [09/12] wireguard: Fix shutdown, ensure one exit and set no agent is used
    (no matching commit)
  - [10/12] vpn: Check if disconnect is implemented before calling in stop_vpn()
    (no matching commit)
  - [11/12] vpn: Fix extracting of PrefixLength D-Bus value
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=813f4d93d153
  - [12/12] wireguard: Tokenize host for getaddrinfo()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


