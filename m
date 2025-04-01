Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314B2054E1
	for <connman@lists.linux.dev>; Tue,  1 Apr 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521398; cv=none; b=JqLHijJYhrJKM2A24cTY9D3Cjq81wLpJfyFGIaStxdcEtnZ5nu9CG3oeuNjxU+VpEK+6TyORI0qXKLWG8rv/6Y5IYtGhS7o13qICsZ9aAVccKIRE6dtJ5Bpkchste3WmcDMM0JKEmTrDFp6xx147P9/026FA14jT4wux60JTE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521398; c=relaxed/simple;
	bh=aiZNmXzLLG7pZpO5DCHv7llk2PkhPx1OZ7moprJm7UA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o7/3iwF3dE3BTAlwLscllOqVcXnk3vz9eDHm/0w/1w6wUI5lxhO4XKq8cvHldso6UgkzZdli/JFjQVePg8RNz/E0/Cuy4SX1bSq7T0wcyka4unSJECCtX14tlfGjlWUaATH7YMBm1oOhCoc4FeNx5jPCCIFAt8yD66ghRPYTtOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kauqVNyG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kauqVNyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9FAC4CEE5;
	Tue,  1 Apr 2025 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743521397;
	bh=aiZNmXzLLG7pZpO5DCHv7llk2PkhPx1OZ7moprJm7UA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kauqVNyGCzoDvkdZKuhWCLMThCgLAMg6//mB/+8NctUfEtjXDQRFJlfdaf173FeRP
	 IhIHqeErmzH0nYOMdcNTGrufKx705ypr8fqOrma84m5PElq3xU4oRVL3MyYCyM81L2
	 d0u6bm1+lBKXWeLEfsiQr+zDDVbKPHWw/lFDKtDv7lJXWPKQYmVR2PTRLOOHkKF0+Y
	 mZog9OKm7p+b1ubirafq/uj0qxElHxN9hZ/jiS2XkpFwdsucwcwo4ZrJJLFqip91T0
	 nuN134UNpaCczOzVtHAdDT/4B8Ai00Xn+svcBOLB1fnNddLR7H+mW6kuWmP1JidL2S
	 GLvVvEoyHmSOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB6380AA66;
	Tue,  1 Apr 2025 15:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Update doc with the actual values from *default_blacklist[]
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174352143402.805208.12465662920525949780.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 15:30:34 +0000
References: <20250331204641.23365-1-javierbassi@gmail.com>
In-Reply-To: <20250331204641.23365-1-javierbassi@gmail.com>
To: Javier Bassi <javierbassi@gmail.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 31 Mar 2025 17:46:41 -0300 you wrote:
> Signed-off-by: Javier Bassi <javierbassi@gmail.com>
> ---
>  doc/connman.conf.5.in | 2 +-
>  src/main.conf         | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - Update doc with the actual values from *default_blacklist[]
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=172bb4f96c3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


