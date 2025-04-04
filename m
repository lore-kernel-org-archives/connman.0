Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC81F3D45
	for <connman@lists.linux.dev>; Fri,  4 Apr 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787194; cv=none; b=CYuB3g39k1fkkaRb6XrkX3st+bqVmWLap8sSE7iirLiEY9BPkY75ITk4HuJAj5CeKw2gd/DXZj7sz/Dhrf42Xk67+KN8eiJzgm07VIj9MyN5Pnl//qyaQkeO0ckqvzjBJk2IN/x8EylX3vvCsPX2HRetf5uOWJWBwucoxxayFnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787194; c=relaxed/simple;
	bh=NeMZq/aNgjTOzfZcT2UsM95p3yDE7qb9uteB2XVrFpc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WiZwMOlDfjkkxpnC1jexmLddx9tMjfq0+r+ALmMoj9zxkMH47nJXXX0w4uP5MF2Rdt2KfyUS9kGy6Ms/jWINBzWZ5gf1thvk+EEwGeiJDQruogrJFj7LhO13UnxAAaT9RuGjHXktfjIrfKPDRs1e1H33j9J6szooHTdTc7wXUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXpbwX+J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXpbwX+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFE5C4CEE8;
	Fri,  4 Apr 2025 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743787194;
	bh=NeMZq/aNgjTOzfZcT2UsM95p3yDE7qb9uteB2XVrFpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SXpbwX+J/lEX3HlTbaKBQQInWCl2j9W7y54JELGLKmA9ujg9WX3xBuvELRzDNe144
	 FD0CsK3ORWBNvkj0/KrZmKeQvjiFyYc5Pd2Hj45pTABp/JcYUadYQGD9yDa0lG6r/d
	 agjrr5fejlrQGPkAivPridGuEDGISouQKE5B0BcTCKtbs+VQAliHaLSl4sYAdB4pdx
	 62JjAf5gWXJMzenCNnfYPcD47yUEOyN3TSWVH6oLBQVlgebJswauOPNInIPnZNF9lm
	 LMogvnulJ98BZ8l8ng3QrTaO1Qc1idSKlR6ZBPMW5hX4cjMwqLhGy99vQ7M2+8PB60
	 Fvm4M9irEN63A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CFC3822D28;
	Fri,  4 Apr 2025 17:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] main: Add 'veth' to the default blacklist
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174378723129.3337090.17836215523957049825.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 17:20:31 +0000
References: <20250403185301.178832-1-javierbassi@gmail.com>
In-Reply-To: <20250403185301.178832-1-javierbassi@gmail.com>
To: Javier Bassi <javierbassi@gmail.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu,  3 Apr 2025 15:53:01 -0300 you wrote:
> Connman conflicts with Docker, breaking networking, as explained
> and fixed in 9eb1772d31b6f ("Don't add route for invalid dst
> and gateway address combinations"). However, that fix was reverted
> in d8a634f20de3 due to conflicts with WireGuard.
> 
> This approach is simpler and does not conflict with the WireGuard
> daemon, as tested in https://github.com/moby/moby/issues/49653
> 
> [...]

Here is the summary with links:
  - main: Add 'veth' to the default blacklist
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=b412b726e4df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


