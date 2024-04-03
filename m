Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63241153BF0
	for <connman@lists.linux.dev>; Wed,  3 Apr 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168427; cv=none; b=Qk8110keGL+eA4cj/cuJSCsK89wQiIiSnTqODX9ggv6x0OABVYBQUJQ8MF6pkHtSU816HJQLeUXo8cGcZ4rLiyU5942RQNE0+KfDhopwUlT9esxm9BvfgJNFxw7YoEvFP7hiM+Lb98twqL0RLtXHy7y4qozP7Mca4vOR/ngcD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168427; c=relaxed/simple;
	bh=D/qA/nxpKVlLCy28qB1UXnvgydoYbP2zJ2bG2J88xK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PkTkvlX2wjEPONjelrW6YLwUzTd2URtKQVxfb19U08kcI/dQDBr9ZPDHeM5qQkrtjzqy7MW1cMLxwA91tPeagaqICh0S3F3pSps3jfJgGh/O7+IusWN+zDyAxFcSUcN2vOn5lofSVvLi9JZRVlLEKhoQjdR4Mx6pirwh2sTc/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8iswWJl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8iswWJl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFA62C433B1;
	Wed,  3 Apr 2024 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712168427;
	bh=D/qA/nxpKVlLCy28qB1UXnvgydoYbP2zJ2bG2J88xK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q8iswWJlZ+btJtK4+11Mj0dc9TSiArmlpCsxrfwhh5qkigoCx0CeCtNyO2+1jV9bv
	 p8XEhqqEq/aZhEbpVxIXnEKa1DBQxb4ku6L5p7124j5mzPq/smLHy+07OIhRaU6DII
	 Mq26+D7zywHj8fSB5Ibs0Zd+NzcqJHYy18KxsSqEsfrAoEW8D9pInA+8cdE8BUDDGy
	 xJzSSj7oDrHkHmlSH2083tGyGQNx0huPp56khUNzTHu981zhQlq8uFPaGgcX3CJL9u
	 02bRaKwoWTIuccX97ZlV8ZVivy9am2VAtwntqDZPI4sghrDzcKFGU1kxGm/ZKlyIFY
	 9T+EeW4EGQ3OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E113BD2D0E1;
	Wed,  3 Apr 2024 18:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] set pkt_len when packet is received using L3 listening mode
 so that the ACK can be processed correctly
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <171216842691.25364.9996118230345692931.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 18:20:26 +0000
References: <20240322132455.833-1-john.mark@kistler.com>
In-Reply-To: <20240322132455.833-1-john.mark@kistler.com>
To: John Mark <john.mark@kistler.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 22 Mar 2024 09:24:55 -0400 you wrote:
> The packet length is not set correctly when an IPv4 L3 ACK is received from a
> DHCP server.  This causes the packet to be rejected for having no
> MESSAGE_TYPE option and the lease is not renewed at the T1 point (or any
> subsequent retry).  Instead, the lease gets re-bound at the T2 point.
> 
> ---
>  gdhcp/client.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - set pkt_len when packet is received using L3 listening mode so that the ACK can be processed correctly
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=49b16df36de0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


