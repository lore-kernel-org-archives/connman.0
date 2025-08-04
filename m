Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B41E47B7
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320191; cv=none; b=GHX9pmkceS70HAznYGqTakXNRwPYpowFbN1l+kESsTGHLBglKA4x53Go34q1jMDAGqpS1hm5d9ciH49dOfSAqpSE1GXtsJJSCwlRzzEyoKWsSgAyPXkMsVESsZqKQaedWx4oIcgf131pFV6baCLARU1saGTePL4t07GPYZpIzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320191; c=relaxed/simple;
	bh=mI2HmabFKdwWVwugpoDga0wb3+VYJhf9Bchxk7smOpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CUILm6TF873f3EY/0uGVsE+uOAsrKM6gZbzya79ZQlhj0fVK94DgOjKPJdC+CfThgaUC3ISsSPHyR1kOjhuTeksxm8JqUfhOxWjRibtJJV9t8gjWG7g1+amp2VZKwZxt/ZE7GOo1n+UlhqJ8HUNr4YQ90u1QCHzzp+GGPmXGt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ibl/easm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ibl/easm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCF6C4CEE7;
	Mon,  4 Aug 2025 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754320191;
	bh=mI2HmabFKdwWVwugpoDga0wb3+VYJhf9Bchxk7smOpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ibl/easm2hyIVo1UqzdFvkU6YLb2jxo7yeD++MFj5lhVA79X1pz5JnY7dQk0AxwyD
	 RksFuT/YGprvL9vTMl2Owx0cjnh2h7grpOYlIrBUd5JCYfmrIcGdtNj8SDz1ZO1u16
	 KaAkgDaN60HVNMLUfb4ZXUFQdI/shn/gdw81ps9ZwcznnHqDUm20r3gFaLEbJKYDQe
	 s/+n28WmLW77XOLr2oUPARDeriruizi1XEbnczhTXelFMCUeWLpHKprwuJXh0pCqMp
	 zonvpfQ8hob+t8mlx7xGeXmHr2hkNjDjvX+WJQ1m9F8sWFuWO/1aO2NLMxMrRvpV8J
	 5vZc7Y0aApPGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1A5383BF56;
	Mon,  4 Aug 2025 15:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/11] Add association state for VPNs
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <175432020576.1223670.18397678423426427737.git-patchwork-notify@kernel.org>
Date: Mon, 04 Aug 2025 15:10:05 +0000
References: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
In-Reply-To: <20250124185845.1546384-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 24 Jan 2025 20:58:34 +0200 you wrote:
> This patch set adds the association state also for the VPNs. This state is to
> indicate that the VPN is waiting for VPN agent to provide input given by user.
> In this state service.c must not do connect timeout checks as the timers for
> both differ in length, default being 120s for connect timeout and 300s for VPN
> agent dialog timeout.
> 
> In order to facilitate this change the association state had to be implemented
> also for VPNs. It is common state for services and like with services the
> association state for VPNs preceeds the configuration state (on VPN side
> connect state). Both vpn.c plugins on connmand and vpnd side require changes
> to accommodate this state. When the VPN agent succeeds in getting the input
> from the user the state transitions from association to connect (configuration)
> state and, thus, requires no specific changes to VPN plugins.
> 
> [...]

Here is the summary with links:
  - [01/11] agent: Cancel agent request on NoReply D-Bus error
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=01c10f2ce960
  - [02/11] vpn-provider: Use association state for VPN agent input wait
    (no matching commit)
  - [03/11] vpn: Add association state before connect state
    (no matching commit)
  - [04/11] vpn-agent: Do connect state transition after input dialog check
    (no matching commit)
  - [05/11] service: Explicit VPN connect timeout, ignore in VPN agent wait
    (no matching commit)
  - [06/11] provider: Handle VPN configuration and association states
    (no matching commit)
  - [07/11] vpn: Add support for association state, add state getter
    (no matching commit)
  - [08/11] vpn: Check if connecting when setting state or disconnecting
    (no matching commit)
  - [09/11] vpn: Add VPN agent use callback for plugins
    (no matching commit)
  - [10/11] vpn-provider: Transition to CONNECT state with agentless VPNs
    (no matching commit)
  - [11/11] doc: Update VPN documentation for association state
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


