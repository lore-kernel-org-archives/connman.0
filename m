Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C6724FBE7
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179404; cv=none; b=LURSABDIBzadjGXoonR+F1/xkPINRZ0VztNK6lBYmdCRHRbm/26oEwJSYUferxgJvmb61YMakPksBIYpnHAo8nYQeIjcRKgTm9sBz119Bfn8se2mN2985EMq+VOHkpPWrzkdfzE1yPg8IrCGjfXNKdpNxKi/1LmwWdh7bj/OYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179404; c=relaxed/simple;
	bh=ZzhLJrPCRFJ0jTdFz5oyXiaZvZ78M7nL1vKJBGr/I70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pg+wjR7eyewVeEmeE23PPsgerLzqYyctW57dgnHBkYpsGg/0H03aCtiWz14XIbuJKBBm41RPK2hg75R2H+oM6XB/GYivWzS9OE/8KEZ+9PsLlQF9rh+14eDO0UPhv4UHTS23T8FbXT3TdYc4uuYizJN6yR0e25foHKbJDrZllNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2qGX9qb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2qGX9qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4376FC4CEE6;
	Fri, 21 Feb 2025 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740179404;
	bh=ZzhLJrPCRFJ0jTdFz5oyXiaZvZ78M7nL1vKJBGr/I70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P2qGX9qbyRpmNlOOUKxfk0RR9PvdzYg9yz2lnjLiOk61OOocCLLfl8jfUbCeDb/vq
	 1/LDwcApfxOLqXPMYwNvaMAGuwsEiVJinnx7+6taRBbugGI3K2GmatFtS5iFYWbTic
	 5GGclotrc6UXWRaBQQZdTM25fM0Qo/PIoHW9OGkfOlTGCy+U28o5qInFeqQoq6PglR
	 91CjWLf74RJ8UCY7wDpomWVIHwICIw5Mdw9xFFyxZIUWiMGtUGxhfgqWKbqw7CiZVC
	 HDws6GdDcqF4aZYLAMYYjcEcw7gpoUHh5Lw/rHCg2xX6ysFCQe5tN/uaYn1tlGD+G6
	 pdI3cAkO4gQ3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 724A3380CEEC;
	Fri, 21 Feb 2025 23:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gateway: Fix __connman_connection_gateway_add is_vpn6
 calculation.
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174017943499.2232673.9489971763952579801.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 23:10:34 +0000
References: <5e1a105eda4ae36e7a9132140949c569cd02fe02.1740157858.git.gerickson@nuovations.com>
In-Reply-To: <5e1a105eda4ae36e7a9132140949c569cd02fe02.1740157858.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 21 Feb 2025 09:11:10 -0800 you wrote:
> Address a regression introduced in commit 823d5a2a8cc4 ("connection:
> Refactor '__connman_connection_gateway_add'.") in which the 'is_vpn6'
> calculation was inadvertently copied-and-pasted from the 'is_vpn4'
> calculation by correctly using the associated IPv6-related
> 'new_gateway' data members.
> 
> This stops WireGuard and other VPN-related plugins from faulting on
> start-up.
> 
> [...]

Here is the summary with links:
  - gateway: Fix __connman_connection_gateway_add is_vpn6 calculation.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=6f150db75325

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


