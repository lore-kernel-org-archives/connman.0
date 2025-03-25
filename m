Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BA263F3A
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925009; cv=none; b=mKpYQgXPO2A8bCv0QkbiCa751/ZyLKkVTLJfFR/eFpAEdLVy1b2xyFASBPKFZlN5pJ3KZ3ZZQaA/T44q2SSocUSYQRNXSauYYWfr3PL6s8y8wR5OCmwUGNGSYX9TuAerYGExnObqJMbE/3JRdR4S0icToqIWca3+eWgjIy8AqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925009; c=relaxed/simple;
	bh=7WrrmZhw7v5KEmH6++XWHb//5LeeFjPYdFZig416bpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y2pC5KvA8j9Ssd1+Tn0HNNlROJysKDdC4AGzfNvuikj6N2zFRvVeFaWRuCwVIFf25Jsq1zOkxVwtmH5Xpov87zqZEw9kl+O7NvZJrwKizpQ7h33jzf71OMXLXGXuPRZYHdkZFnnFoHidbBAzeoxBMLwN4fptUtFsjcPkKiWxEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPiN4bCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPiN4bCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4D9C4CEE4;
	Tue, 25 Mar 2025 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742925008;
	bh=7WrrmZhw7v5KEmH6++XWHb//5LeeFjPYdFZig416bpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cPiN4bCrKoE1lSpnVGFqRQ1b8geFwV0garB/G6BrRfWEBHKL/B9D4RcyYoq+MDKW7
	 BrCzE5gy457uNK0q++U7dO5Pb37wdWtP/bIMmW7WpRgHj2H3nHb3zuCCNJxa/Z61eW
	 F2omrBU0f5oWgdp3tRNYlR2/vlPADjrwIihYG3I1i3ykHUCaE5iKM7YpSTTEdZrUui
	 O435dieI1d01i+9RmB1HKmDbwyZdcubOMmUwwrgaxZLQpFPH4y7qHF/mEeWKyuIuiB
	 OFDDGGPFJ0TYYYa5+yGsXdCSFojJ/tYIAZFe61y/LrjLlhvLbVVOegpUTLiCj2XFAI
	 h6GxyRXPTMylg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED0B8380CFE7;
	Tue, 25 Mar 2025 17:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/5] Close Two GWeb Request "Bookend" Failure "Holes"
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174292504451.665771.15938204625260900860.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 17:50:44 +0000
References: <cover.1742919926.git.gerickson@nuovations.com>
In-Reply-To: <cover.1742919926.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 25 Mar 2025 09:27:43 -0700 you wrote:
> There existed, prior to this set of changes, two "holes" in the
> finalization of web request sessions that can (for example, in a client
> such as WISPr) leave one or both of IPv4 and IPv6 "online" HTTP-based
> Internet reachability checks "dangling" and non-renewing such that an
> expected active, default network service failover does not occur when
> it should.
> 
> [...]

Here is the summary with links:
  - [v5,1/5] wispr: Refactor 'wispr_portal_web_result' to leverage 'GError'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=52546061c590
  - [v5,2/5] wispr: Document 'wispr_portal_web_result_failure'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=cfbddc9490f6
  - [v5,3/5] wispr: Document 'wispr_portal_web_result_success'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=7e97e93f57b9
  - [v5,4/5] wispr: Document 'wispr_portal_web_result'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=e09d3137ce8f
  - [v5,5/5] wispr: Add an optional 'message' parameter to '__connman_wispr_cb_t'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=300daeb9829f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


