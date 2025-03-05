Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623E16DC12
	for <connman@lists.linux.dev>; Wed,  5 Mar 2025 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200005; cv=none; b=W6DVLlXMYXjV73rksyNTUiZf5Pn1rJwU8IC6mKgpR9ZpCyQvEJ2sO5BxhwQVG5TMFTxOFwrnanZhlhxyPAGJOn0fW7Suhgy3WJXgcQ/2WVbnbyFLFe7vR5JUQ1SotG5ornmQI9kXwd2g4Fx2q9iV23PwFwIPvOw8z+pQ74RRGLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200005; c=relaxed/simple;
	bh=D6f8YE7C3b0nU/A6Zyh7miAUE1Vu15DLFebpODgDKjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kA3sRQW3Y17uoTXiReAI7EgxX06FlFasLjTOHBJiIqBb0pXVl06WQsCh12h5eE47O2OFiGpvsB73i6TY4zXGGni4V0CaAFpYQElCAHcY3NR7TQZMourzvkoFAkfsARAXhcB+8/TFHYfZa9AXH1vKvdCxO4Q6ZYe250ec1GOSDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o01BIw6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o01BIw6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07850C4CED1;
	Wed,  5 Mar 2025 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741200005;
	bh=D6f8YE7C3b0nU/A6Zyh7miAUE1Vu15DLFebpODgDKjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o01BIw6e0eU6hG8HtcG6f/J6AkAcUITGouPILZH/FYImUiB2WvGoFKxsq2TtugsPX
	 H8nM4mKbvWqzlAiLkHc6dlg/S9ovY0iyt786DeDVUEgnEiVSjf0LT2STPGH4TlSl2v
	 1HJQ4jLRmiuSJzAC+5ju6u6BTS2LHWHy9WP3/3fbJ6BONkGWFu7j6ryh2hJ9pDQVf3
	 El4xXH+1zRsRFxXI74AbL92pvc/VF/TDH5FdMmXh9sFJR+R/K+fnrphe1/6df2uQPb
	 UO8yzsN+WyITkwPQrMyp1/SAjzOd6AVz54ZsSeTcUjRV0OBEAK60PTvIJ4zZSqjApa
	 3bFdRm07EnoKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D61380CEDD;
	Wed,  5 Mar 2025 18:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/15 RESEND] Improve PAC URL Mutation and PAC URL and WISPr
 Proxy Failure Logging
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174120003725.981412.10651872915700343541.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 18:40:37 +0000
References: <20250221155653.760046-1-gerickson@nuovations.com>
In-Reply-To: <20250221155653.760046-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 21 Feb 2025 07:56:38 -0800 you wrote:
> There appear to be a population of premises ISP equipment (some
> possibly correlated with Spectrum Communications in Southern
> California, United States) in which the ISP equipment sporadically and
> incorrectly emits DHCP Option 252 ("Web Proxy Auto-Discovery (WPAD)")
> with an invalid proxy auto-configuration (PAC) URL (such as
> 'http://wpad.lan/wpad.dat'), even when neither the customer nor the
> ISP has such an option actively configured on the equipment.
> 
> [...]

Here is the summary with links:
  - [01/15] service: Add 'service_log_pac' function.
    (no matching commit)
  - [02/15] service: Add 'service_set_pac' function.
    (no matching commit)
  - [03/15] service: Leverage 'service_set_pac' function.
    (no matching commit)
  - [04/15] service: Ensure the PAC URL is set in '__connman_service_set_proxy_autoconfig'.
    (no matching commit)
  - [05/15] service: Document 'service_log_pac'.
    (no matching commit)
  - [06/15] service: Document 'service_set_pac'.
    (no matching commit)
  - [07/15] service: Add 'service_set_proxy_method' function.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=d8fcf6cc0c54
  - [08/15] service: Leverage 'service_set_proxy_method'.
    (no matching commit)
  - [09/15] service: Leverage 'service_set_proxy_method'.
    (no matching commit)
  - [10/15] service: Document 'service_set_proxy_method'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=25e6914c6e46
  - [11/15] service: Document 'service_set_proxy_method_auto_handler'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=1123f398de9f
  - [12/15] service: Document '__connman_service_set_proxy_autoconfig'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=288b28bd2c57
  - [13/15] wispr: Add 'wispr_log_proxy_failure' function.
    (no matching commit)
  - [14/15] wispr: Leverage 'wispr_log_proxy_failure'.
    (no matching commit)
  - [15/15] wispr: Document 'wispr_log_proxy_failure'.
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


