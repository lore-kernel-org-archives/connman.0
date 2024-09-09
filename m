Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760812AD00
	for <connman@lists.linux.dev>; Mon,  9 Sep 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865230; cv=none; b=dEm+WfxIRzcsMr5CtYqisZwxCtxAQG5hv6yA2980W7IDyLDiCTpp9NXB7QlgPdKb7VL745jKCNGtT63M2Brv35Y1BnpFoC+zUXH2nIwO6OQlGRosh47Ds/cSWDcgdq4iKX9bg8a5QHBBACa1iqdV18vxsp+Z+Vy/EJCWuOCTDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865230; c=relaxed/simple;
	bh=exVT49M83NuLshY/5X7a9Oe1TM66XAQAe5AMV16M8r8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=anB+nKJVSZaMuzvU9qeyLES0K72jbPj1FLekQDdKuhxqaYGnVMUycLAKF/y+L3U6ihXoUAu+jkHHR29wKO7/hRIZrjOV19RBocaA6EMvnEMa6XEmc7hjwjrJ7YMV83RyXnVSmU3om9HPB+OlAnHWkfi536NT7uMdWFWLlZvFqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIYcAFec; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIYcAFec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CF7C4CEC5;
	Mon,  9 Sep 2024 07:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725865230;
	bh=exVT49M83NuLshY/5X7a9Oe1TM66XAQAe5AMV16M8r8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uIYcAFec7WqSxE0IAWXZxsT4lJO193xYY9dOIV7Cd94pGRIjfoBfhKNrDuVVE7Epi
	 6yBJYNcqTuJxr3mYGs4/bnCjiMuCSUTbHlOdXbGIIqAbnfuOW+yp36H7qlpJ2IAlso
	 mNvb4I8zYW+H4AZW3N1KkNy+FCZ7xNpwBirl85qB7yl+eRImOKGY1OeeMyb9htWXtz
	 7rxDnooJ5B6MuIB352tXCy0LV7Q90TMc5cIeKaKs53t9ZHw2lp2+wD5OLD6MC65nOE
	 W5gHgJsXMJkXTyutdYoX2lzIjaWY0K9S15NqsYSlczmMYdAbXtAUY6WP5jzDdrUrbv
	 6BTHalyxHayVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E913804CAB;
	Mon,  9 Sep 2024 07:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "rtnl: Ignore adding/removing interface to/from
 bridge"
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <172586523102.3348596.18427421353315032895.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 07:00:31 +0000
References: <20240909044515.2863247-1-net147@gmail.com>
In-Reply-To: <20240909044515.2863247-1-net147@gmail.com>
To: Jonathan Liu <net147@gmail.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Mon,  9 Sep 2024 14:45:15 +1000 you wrote:
> This reverts commit 64ba5d457c77ebb65b0a23910d26089973fb6ce7.
> 
> It is causing the wireless interface to remain in AP mode and the tether
> SSID to still be visible after disabling tethering when using
> wpa_supplicant. This can be confirmed with "iw dev wlan0 info" which
> shows "type managed" before enabling tethering, "type AP" after enabling
> tethering and "type AP" after disabling terhering when it should change
> back to "type managed".
> 
> [...]

Here is the summary with links:
  - Revert "rtnl: Ignore adding/removing interface to/from bridge"
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=99d4f2f252db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


