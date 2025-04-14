Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7B27B4FD
	for <connman@lists.linux.dev>; Mon, 14 Apr 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645796; cv=none; b=gl4hKt07cAtSPlU1f6UnSp7QraYjC6CPkAvi723aF5h6w99+VfiTaiIVSkJEzrTET/7LZdMv+59ITart+CywE6bt5rHsqYIfWbZgXnJhRTNtcUKY69qYho1hpzwbsqVK7i5/tToYs35M4WuKW4cN4MmHMef6z0hW7MYNELZ6WC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645796; c=relaxed/simple;
	bh=Lyeovf12DP9gB8LyKmWdefmoQ2KG7p966B+lh/EfnLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p9ToNbPmxLBmcAXYfbVUOu8/Z6oU4AgdMS76afLw5lbLsD52sQVay2JYVRNDYMKeGhlFalnfPyJ2wC1BaPXv9O62Bv+icirifW1mZqJ7+dhaLOVeAO6wn3jqQZpceiCdU7f0L7ln8COHW5xBdbqI4d+FMn5QR2yybC7AKEItVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVS8JEOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVS8JEOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55684C4CEE2;
	Mon, 14 Apr 2025 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744645796;
	bh=Lyeovf12DP9gB8LyKmWdefmoQ2KG7p966B+lh/EfnLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cVS8JEOaV9BoRaKpzUtWcxDjyRqCwrlReR4u5nMknEXZqWhUHtJ1oUQmSA+lgwtXa
	 VkTndCIPuBVEGq2H7h9xnu27XZr7x174ql938jM9UcijMKuAp7M7cPoL2daqHja9zx
	 hWvycHj/mjDL9z8EwiecfqBLw9SiYNiqc/+e5eTRPhw9ZGkGDNhIdX2Uct1oWtSKAi
	 q9FKE6vwvhSX2nwAmziE+QVMt61cphDiav797meIm7BjlUUx34eDFbbodbuPTystIy
	 1GEiECMtTkBB3dvhV10Zrgvhxt/kDyJhq5bzwVOKFDc9Uq1JZrAHKqpNvAUKOwa2Ay
	 yVmyiwj1FTzYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E483822D1A;
	Mon, 14 Apr 2025 15:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/8] Fix Clang analyzer warnings
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174464583426.1951149.10027413197099765583.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 15:50:34 +0000
References: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
In-Reply-To: <20250410155846.252858-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 10 Apr 2025 18:58:38 +0300 you wrote:
> This set of patches contains fixes to warnings reported by Clang analyzer.
> 
> Jussi Laakkonen (8):
>   openvpn: Fix use of NULL private data.
>   vpn: Check also vpn-driver to avoid NULL ptr dereference.
>   vpn: Avoid using uninitialized prefix_len
>   vpn: Fix mem leak on nameservers
>   ipconfig: Fix Clang garbage value complaints
>   gweb: Do not append NULL body to send buffer
>   dchpv6: Set err to 0 when client creation succeeds
>   vpn: Fix mem leak of gid_list in task setup
> 
> [...]

Here is the summary with links:
  - [1/8] openvpn: Fix use of NULL private data.
    (no matching commit)
  - [2/8] vpn: Check also vpn-driver to avoid NULL ptr dereference.
    (no matching commit)
  - [3/8] vpn: Avoid using uninitialized prefix_len
    (no matching commit)
  - [4/8] vpn: Fix mem leak on nameservers
    (no matching commit)
  - [5/8] ipconfig: Fix Clang garbage value complaints
    (no matching commit)
  - [6/8] gweb: Do not append NULL body to send buffer
    (no matching commit)
  - [7/8] dchpv6: Set err to 0 when client creation succeeds
    (no matching commit)
  - [8/8] vpn: Fix mem leak of gid_list in task setup
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=c6f649376ece

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


