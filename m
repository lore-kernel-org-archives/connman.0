Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B20225D6
	for <connman@lists.linux.dev>; Mon, 18 Nov 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948017; cv=none; b=jjVBrhLgAhEVkiHputjcux5nlMC0Jt8l4Jk+i15+hJE/f/rNTeGeEaUjAVwBddtnvfQoiaoW1dRyt+IW98akcNUOU6qOeZT/ReyvkVQmq+fWxCx1C/JmfOA9QlG7zc5aEm29CYDm9QdFpTsgWzIjkKl8rc3P2or5jd56JD66ZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948017; c=relaxed/simple;
	bh=xshHbH9hdfEz0TD/du8La5XsLFAUD1gNrioQ/pGfjKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xx4P/SQHfpvzUjY+MXvYL9uzIB7xVw4bdG483hKzvXH8T6Y3t2u1scY9/eP08RAVwEmtpQMciNYT1DRQ8f2zquo6QrvLkyXKG+m6p0IJRNLphYb3MDI6Lr7u+F2PLO3CnJOFgn8R2K4jmh08lFWl0OCF/sVfsSD62d7V9DLBFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inS8D2Pi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inS8D2Pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6275C4CECC;
	Mon, 18 Nov 2024 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731948016;
	bh=xshHbH9hdfEz0TD/du8La5XsLFAUD1gNrioQ/pGfjKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=inS8D2PiNno318/xx4K4mJNBJJUAOpg1z8W2pOzn0OnsucT2H3zU/ajSrnYt0EnK1
	 T/H56I73+3FfMbtXfchQhWBJF6FiqKtS3Mv0nyMMPqJvOJhp9IoJJ2XrvkwtLTbirN
	 lJTxk9m7MLr/j9tkRqcNxDw3em1EGKGcD3OHJOgQKxK/Vnig3DxenhjiHuZCZESUnw
	 1WT4SwyZxlHBrIZ7FcdjRFhJ7jXjd7WpEZTrb/OmDuUGV0PWXb4kfE5hlFOW+sTKOJ
	 PHQ31+WkDLIjsonhN9C5yPAQ5MQPVYImsRu5j+IX88juHFGNyeQALrEqljkTdvSKfW
	 Nth3ba1OEayQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7B3809A80;
	Mon, 18 Nov 2024 16:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] inet: fix flags used when deleting routes
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <173194802800.4101201.15688132321165453816.git-patchwork-notify@kernel.org>
Date: Mon, 18 Nov 2024 16:40:28 +0000
References: <20241113182009.139820-1-steve.schrock@getcruise.com>
In-Reply-To: <20241113182009.139820-1-steve.schrock@getcruise.com>
To: Steve Schrock <steve.schrock@getcruise.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 13 Nov 2024 18:20:00 +0000 you wrote:
> When using PreferredTechnologies, default routes may be added and
> deleted multiple times as interfaces of different priorities appear.
> Unfortunately on kernel 6.11 connman is successfully adding routes, but
> it is receiving "Operation not supported (95)" errors when it tries to
> delete those same routes.
> 
> strace shows that connman is passing unexpected flags for RTM_DELROUTE:
>   nlmsg_flags=NLM_F_REQUEST|NLM_F_ACK|NLM_F_BULK|0x400
> 
> [...]

Here is the summary with links:
  - inet: fix flags used when deleting routes
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=b4d7f970e759

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


