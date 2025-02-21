Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D517CA17
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180003; cv=none; b=rDCkp3jmiOcTUwyYF54Okf3MkGpA16R6al7KhI7ZGrgNiFQXiIHGrhuaAKocVXXiSZiTXAMTbRyhVlns62shN81JxxiEKx6YsN1cAqfnGurBxwvhUjIwm/wPNBNoGPQ+3Dyv1Brrxah1Qqv5PGRO1QYtE3S32yjdy5jDIHncqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180003; c=relaxed/simple;
	bh=q17W91UAtQazI2gDukb7m5vCe9a2+SLBZJ1vh2yYjf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AcpX3eJNvaBHW+iAJEInU5Hteg6xw9PihErhgN/WBiYRFZu1j05+DZZUbCJ9HG7xQEqsFhatuG1Uzkh5IrjKDHQvgcykIB6q8d621ymzepyIL1nZlXMHgQGcobaRHecbR4iwLF8/0Ewxy6zpxEQpOL4OyMTPncfiFs+7UBKpnEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uh55Bfxq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uh55Bfxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BF1C4CED6;
	Fri, 21 Feb 2025 23:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740180002;
	bh=q17W91UAtQazI2gDukb7m5vCe9a2+SLBZJ1vh2yYjf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uh55Bfxq4OVbn4knz0v45MeScWybYaiCAZArZj+ly7Y/L7v18SZ/W6v7S+M8q2fhL
	 WxdyxueWs3vD4cNzD9WzxO8V6MZ35XjAJZsblco5QDAiLh/c3TzaB7XJ8y59bHBRtU
	 0PrxEVJZ3ynosRbkdE2uGS9+k3/6aINq4+0wW2DMrwx/rpZUcc6XKB47mdTXp3YkTe
	 UKXzFEHc7YpyrKcRWknFKQLwIZ+wKUUJpnIyWib8/v4NuUheGyLM7bruaI7uzeuGN/
	 PnHqbYQJgJoYPzdyLGkGA2v0VUbhGpDESnk36bbOT8+nvCtB2eQA5GpjLwqFWDxdPa
	 oMU86suwOxaNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB412380CEEC;
	Fri, 21 Feb 2025 23:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "Don't add route for invalid dst and gateway address
 combinations"
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174018003349.2234448.16369952823120502676.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 23:20:33 +0000
References: <20250214065426.2697329-1-christianshewitt@gmail.com>
In-Reply-To: <20250214065426.2697329-1-christianshewitt@gmail.com>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: marcel@holtmann.org, denkenz@gmail.com, connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 14 Feb 2025 06:54:26 +0000 you wrote:
> Commit 9eb1772d31b6 ("Don't add route for invalid dst and gateway address
> combinations”) causes a problem regression in WireGuard support through
> the connman-vpn agent. I asssume because the wg0 interface matches the
> definition of "unspecified destination address coupled with unspecified
> gateway” added.
> 
> Routing table with commit 9eb1772d31b6 and WireGuard (wg0) active:
> 
> [...]

Here is the summary with links:
  - Revert "Don't add route for invalid dst and gateway address combinations"
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=d8a634f20de3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


