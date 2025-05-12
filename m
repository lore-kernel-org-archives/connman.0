Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62D2980A6
	for <connman@lists.linux.dev>; Mon, 12 May 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076993; cv=none; b=DhxdwbwzBu5LA9QRKxxyKgfhrzmTdjtZdEwCI0IQE7NS2EtIszeIiSWxa3ijo+sgZuvviGbZdCumkFtjEybNu7O2rNJwHw+oZdO8pLp8Ki0dqvsi726R4DUGz95Rjf6sji2+cS/lIgF/3vv8QcUs+itKwxxcE9E6K9m7vWI/Z3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076993; c=relaxed/simple;
	bh=LLf6huxHbdV4liYejLvwQhgL/2nVx1yz3LRISELZjNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S0f0X6RRDxSpRcOje1reFlrHB+O1oRzzzAlCYF6IZLQKeY+pbjcxh+rwGkzdwCmSYwg5zRcfdZbwpxrqZFcMTKQnmLZQPx6f5qYHjZZyV3XNkwZl8zM5ii4mPBAtxioVNyroay7x8WqM2F0yF1FuGYuOEymOU8AgUB4HxeaxhLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc4GmGeK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oc4GmGeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B19C4CEE7;
	Mon, 12 May 2025 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747076992;
	bh=LLf6huxHbdV4liYejLvwQhgL/2nVx1yz3LRISELZjNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oc4GmGeKl6QyIz5esATex1O/k72PD+JSGzMGYvqbwG5NhTjmKt/29Jv1tvAg6m164
	 /BXLpbOHlwpm55H91W28RdO0unHzztIbjzhSGLbBTAqs9S+CBMm3Qj03pXv6D0iW78
	 srjlE1IkrxdCGvDELtxbobwqmyUH3JzlOuurGBSPjs7F1ONf+xNu6PyZeWGtNNNJCg
	 tfRfD/e0jj54M9wDYTXmctFhfbkFCbuuJzMIUE1NxFYXtuweLccsD4RADc9kAue7uN
	 G+A2AIWr5qeTC7BejrdGsTmATamkep2F39rMvinfkEHXbnd5RILGyW9DugMwPpNh4r
	 XcwV/RTnB7hzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE839D6555;
	Mon, 12 May 2025 19:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dnsproxy: Address CVE-2025-32366 vulnerability
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174707703001.1056012.6904138934231238966.git-patchwork-notify@kernel.org>
Date: Mon, 12 May 2025 19:10:30 +0000
References: <20250512084818.411262-1-michael@amarulasolutions.com>
In-Reply-To: <20250512084818.411262-1-michael@amarulasolutions.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev, denkenz@gmail.com,
 linux-amarula@amarulasolutions.com, ioerts@kookmin.ac.kr

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 12 May 2025 10:48:18 +0200 you wrote:
> From: 신윤제(학부생-소프트웨어전공) <ioerts@kookmin.ac.kr>
> 
> In Connman parse_rr in dnsproxy.c has a memcpy length
> that depends on an RR RDLENGTH value (i.e., *rdlen=ntohs(rr->rdlen)
> and memcpy(response+offset,*end,*rdlen)). Here, rdlen may be larger
> than the amount of remaining packet data in the current state of
> parsing. As a result, values of stack memory locations may be sent
> over the network in a response.
> 
> [...]

Here is the summary with links:
  - dnsproxy: Address CVE-2025-32366 vulnerability
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=8d3be0285f1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


