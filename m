Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958C235042
	for <connman@lists.linux.dev>; Wed,  9 Jul 2025 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082783; cv=none; b=MBFPUQ85NEPDRzr4hNMS8+xagqaLAm9HLzxNaa1RzWaxaDfy9ITWH7wzFy2ZgMADx0waJTEgNdJMdpjj9+29LQ64puG4D2J4y8y+5kRiJWh9EgHyzOmcKoSnuwMdGDnfUy7skdytmMgvRMBwTeTSKrEKpXfDUOFR426sYValzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082783; c=relaxed/simple;
	bh=HC6QVz2pB6NyWU9xSBczxpBCJt3yEUuhPc4SxT0bmDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rHYOyvJHlhXOP4dFCgDsT4yiJh/uLvfmfG7FrUhLaliO9Qld0nucEIJ7zHBIVuHqeiVyXrwXImfS2cTXLsf/u4nXEHD7aM4eZp0xkCuwOs1/YE0g3EEHUNOWIye+pDY18ZdTqM2Fu028CGTvghofxaNoEVasvw9KCVz6MiTUgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODAQDRjK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODAQDRjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49E4C4CEEF;
	Wed,  9 Jul 2025 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752082782;
	bh=HC6QVz2pB6NyWU9xSBczxpBCJt3yEUuhPc4SxT0bmDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ODAQDRjKya0tdlJfRyIcGOQqEagF60OEI48KXePPlA1LTiuNQuPsD5Y/HJZ/AaPYf
	 y5TYU9d6hbbwcABm5gU3UmsxkASoyRHmqbrxoWLh3EekGpN0PMdapY+kZst45HJixe
	 42AacqvVZRI3sWAdySlrOiYwaoFIghm8PUbWo7aOVPAGDesgGX8Z/I5V5SQY26niLI
	 u/ECqDrRqesa8MxCvwSsLEDwDm/1nVn9iO9Us0xE4Gf+TvuXfAkDxb/DnxlUuhMhEj
	 KorFhGTWukz7mKrECAW5nc0Sab4nJXEiMfV0vZtlZyrjKB/cu23QXDKbrtla3VR5G7
	 r6aRumGwWDuxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6B619380DBEE;
	Wed,  9 Jul 2025 17:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] client: Add missing newlines on error messages
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <175208280527.799524.3754462689516979652.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 17:40:05 +0000
References: <20250703191344.990213-1-jaeyoon.jung@lge.com>
In-Reply-To: <20250703191344.990213-1-jaeyoon.jung@lge.com>
To: None <jaeyoon.jung@lge.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri,  4 Jul 2025 04:13:44 +0900 you wrote:
> From: Jaeyoon Jung <jaeyoon.jung@lge.com>
> 
> This adds missing newlines at the end of some error messages.
> ---
>  client/commands.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - client: Add missing newlines on error messages
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=d1e56402d8cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


