Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628B198822
	for <connman@lists.linux.dev>; Wed,  5 Mar 2025 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200005; cv=none; b=ZEyp4lw9FvhdAY6mrXn3vv2fypBo21O8Cj7oqd7jO2TmRLs2TiLNCh9nLGQSV0qTmnbkL49cKydzbNlbAPN/7E59YrYyI8LEfE/CjVPl8Ab+kH6gf1MXUmfdgDXGYtW3P0ODa+/XZDK5vYVxaCShW+TTqfnvd786Vvrc/PyyQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200005; c=relaxed/simple;
	bh=wFf25xlwqoLrPpjDJ7PFEh94Cw6HHFfJQA6LcX4FiMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YXLMfbjoehEMK7vTqlEOFRSDLpqPV9WxYyRnxs9WBTrL/99bsYNRnHV3A7ktJxqzFk69F01GC6FE52yuuexgmYK3b+1cJUom1j7ph7SZhRgCZu1LJaHJR7w/71IZJVHfh4UYTaeER9ajJfj60zVSDbh7++3JKa8+AgpDF8cVaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKZhos6y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKZhos6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A61C4CEE0;
	Wed,  5 Mar 2025 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741200005;
	bh=wFf25xlwqoLrPpjDJ7PFEh94Cw6HHFfJQA6LcX4FiMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZKZhos6yxuZ97ctp/Tjz059nRfYVbhDcx0Jf5YEmoN7EKfRpyiSLJtp0NEsZMtb2M
	 g3m57LN0IB3FEOzMFI9bjn2cJCnHrSL4IA/yb2Mh1nVlyLhFO6Ff66o0JD98w0wdvD
	 K5FFe6flWH9uaFrkUS5QLIFCEX1ETWgsgHENaEA/A3OrHk3RvZsd0jNfIyaB6Z9IKt
	 n7ETsiMnG8Qk5uTYrGTTXLZLVDHUuw4Lbld1xSYp3Fgny3Bl81tHDNHbFUF7QOJGU1
	 NEoM84HIHCvFTHE1x9pBWg8njEgkNvQDV2rHiqzFhd//RMW/frGH1B4PaAlujy6YNK
	 fPUww8F2kO7NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC5E380CEDD;
	Wed,  5 Mar 2025 18:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/7] Improve PAC URL Mutation and PAC URL Logging
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174120003848.981412.15641095322029821129.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 18:40:38 +0000
References: <cover.1741121901.git.gerickson@nuovations.com>
In-Reply-To: <cover.1741121901.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue,  4 Mar 2025 13:02:58 -0800 you wrote:
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
  - [1/7] service: Leverage 'service_set_pac' function.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=eb65e1e3fb88
  - [2/7] service: Add 'service_set_proxy_method' function.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=d8fcf6cc0c54
  - [3/7] service: Refactor 'connman_service_set_proxy_method'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=bf532b3cceb9
  - [4/7] service: Refactor '__connman_service_set_proxy_autoconfig'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=5488cd6dcaa8
  - [5/7] service: Document 'service_set_proxy_method'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=25e6914c6e46
  - [6/7] service: Document 'service_set_proxy_method_auto_handler'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=1123f398de9f
  - [7/7] service: Document '__connman_service_set_proxy_autoconfig'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=288b28bd2c57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


