Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9C2288D5
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332191; cv=none; b=iXCS+7Q0eAoHTJ6u5El0AlwIXnZ0DN6i+A8Sg9USt2KhpCDKLDQsV8f4xqUC0/h+pRsBX1q35i5DuPKazDUF3UqbGewsNj6H1swFGz2Eks1JqoAv5S4Cw00bEl03rB+ssZcqj2f0pv5NQ/LcBgRO0wI9j+iKccLZCwKf5/rlsxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332191; c=relaxed/simple;
	bh=8dpeDCteXYLjgGkoJIrBGSTERck8X5GLDBjiXMTqd/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D8HMQj3CxcI22qLbhfSY2C4na0PbinfB4HM/E8BoCpc9FcPP8TWYme/cLGDsvD85/U4QOOzjWy+B0WwcrWaiBvVVcXcZq0tprvmjzWVUt6uajlGoq9DQthVoIOVJHXhXGNXUlFMZ31dOfN/nPi7sGJyQrtDlRfbBG/oxhKR8IRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdKkMBIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdKkMBIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFB3C4CEE7;
	Mon,  4 Aug 2025 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754332191;
	bh=8dpeDCteXYLjgGkoJIrBGSTERck8X5GLDBjiXMTqd/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GdKkMBIc3TwY9NB40QIhzhpoWIYmxIJPDX2slbYi9QX/Oe2N+0+YqDEvg++ttpju/
	 tjtRKUSbTIcTZZUBh36BxUvXO4fCqm6womJtTSRMdchDoVWxH7WBTuJDzijbthxq2v
	 2aHaRfx4Qh8K3z9IpfYWfQNsPb36c8rArzJG7Z2NFl8LUEJP/m2P9ngyAY0GouTrhe
	 pdXH4CaClOwOooX6P5t7m5MID2sP7xnb++SNuK5Ruv9Y8zmhravzClY2zj6ky9rPfs
	 XZZKzOmniPQ/y0HdtunYlSXgyDgWfb51QgGca96e98W8ODziaam6GYNCsDqQz+fe+X
	 HI8P+evDn0lwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC8383BF56;
	Mon,  4 Aug 2025 18:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Generalize Default Enabled Technologies
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <175433220550.1311883.12320384387712514908.git-patchwork-notify@kernel.org>
Date: Mon, 04 Aug 2025 18:30:05 +0000
References: <20250728223217.3991877-1-gerickson@nuovations.com>
In-Reply-To: <20250728223217.3991877-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 28 Jul 2025 15:32:14 -0700 you wrote:
> Since nearly the beginning of connman, it has behaved such that the
> Ethernet technology is enabled (that is, powered) by
> default. Currently, this is hard-coded behavior into
> src/technology.c:technology_load.
> 
> However, if a different or additional technology is desired, there has
> historically been no way to achieve this via configuration.
> 
> [...]

Here is the summary with links:
  - [1/3] main: Introduce 'DefaultEnabledTechnologies' setting.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=007f9262a11c
  - [2/3] technology: Leverage 'DefaultEnabledTechnologies' setting.
    (no matching commit)
  - [3/3] doc: Document the 'DefaultEnabledTechnologies' setting.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=efd671b00fbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


