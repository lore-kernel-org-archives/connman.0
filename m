Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFF1D1300
	for <connman@lists.linux.dev>; Tue, 19 Nov 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038018; cv=none; b=d4aPRUDn+jd1WQlJfc2FzJ2cSDjcBIxbcUQt2iW8ZLSFJwgpagFd+26P8P7nIotLGUnTHH4gBlCOgGPaf/bUvAJaGmV2jxOMwjQ6aKCIG/ZdivNLrn1zbuCpEKfLm8s6n6uku/1ZVDSaBVUQ4jIuBAKIXV5twduhhiFRHt6E9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038018; c=relaxed/simple;
	bh=dO/ye/xFZrZ6uS+iiV7WJxSfZXjYwR8yBwNIwFYDUhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NTtdaC/VwwvaMhh4Oc50lRzZefExpr0yJIIdUXtYmu0Cp7S6EGgKIASo13qJOx81nROzk8x6+okFT+avMim/+ZqTMpAdwVnm5uGKJ6RTE9h9UZCBI3rxktTL2nzMrTvCtle0oqRAYdW9Hx1TbI9Ft/m4rIBraW9RrC+jJIEqdss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5jIHzlO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5jIHzlO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26196C4CECF;
	Tue, 19 Nov 2024 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038018;
	bh=dO/ye/xFZrZ6uS+iiV7WJxSfZXjYwR8yBwNIwFYDUhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P5jIHzlOcsMGk8yGXBfX2YwCffbvPi/OlZSK+8LbKwuCEK1idxxbLpaDunTcgc7Xw
	 vEM079AnlY1s1y0vW/sANk+zjmQLJqDvVm+7PLWnYs5VIj85BlNuBtrtBOE20IfZKB
	 IXAQI46J9RoLo/9b+WvMG5/XIRDhYvaGLE0vXYREjRvn3NuKR42P/bhGlTBxCX58Jd
	 6u2UGex1U9tdRvr80Sbew7tyk+TiysSA/crBeKwuaPIIrvUs8r1GDewgnF1z/lm2AD
	 KZcT7OoWdntGkVu1gZNZ3PKwEcvwA/TfQ0l12Kg2C+AEU/4e+2NtepFxsZn0/SwTwz
	 jZLKRlFynOCKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD333809A80;
	Tue, 19 Nov 2024 17:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] treewide: Fix typo in ARPHRD_PHONET_PIPE
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <173203802975.627755.2739079479416033800.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 17:40:29 +0000
References: <20241118163344.57123-1-denkenz@gmail.com>
In-Reply-To: <20241118163344.57123-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 18 Nov 2024 10:33:31 -0600 you wrote:
> This was spelled as 'ARPHDR', but should be 'ARPHRD'
> ---
>  src/rtnl.c     | 8 ++++----
>  vpn/vpn-rtnl.c | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)

Here is the summary with links:
  - treewide: Fix typo in ARPHRD_PHONET_PIPE
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=263e151fcfb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


