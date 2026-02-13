Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B026A1B9
	for <connman@lists.linux.dev>; Fri, 13 Feb 2026 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017012; cv=none; b=lFAbB3eEDa4wHZzZRWuKnTueUxlW3+ygA1Wgh7srmH3yaKSVKqHsU5jVBzWHMR6SqV8JVWjvVqNKvF+PO+WHU4P5uN5NP1dKtnx6Hy5Vu2FsPP72D216eDBTOspzjVdfc1ZK3UHX8DDHXmWHY2HAP/8RDDQLtEtUv8heDH59ud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017012; c=relaxed/simple;
	bh=3rLaxyhCKvvKDt9uz03+RQ+toywbasX2xMK7dL5Adk0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t8lWNXGbff4kKi/aEctCbx4CzzX6Al104Sh4+zd1jU1FN7vb+ugxJvHSC6HNM7nL5srjngMdWh+3+3pa439ERx3+5ypBqmK/oBOSuR1bRaksqKbwanUlZ/LRtsVOtGCEZQPOVcJMEx8iw/qooK2qU2ZJE1Fqr3grUR6MM9dPe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxbQcNkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxbQcNkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD79C116C6;
	Fri, 13 Feb 2026 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771017011;
	bh=3rLaxyhCKvvKDt9uz03+RQ+toywbasX2xMK7dL5Adk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HxbQcNkw4bpLqnoaJf2HU4rdObq7wDKVCxiWfdC61Vh7jcKkmneoBn24Q6Fx2aYtE
	 2RkAYarU7RQStfKSvWTn1SuL/bEwcnnkRl69r+633O6gUqiQJ0rcemgwEIcGZVBvBv
	 JZDVAEbB//I0gMuzlpVAamaf0oJzxraqvi359WHE1MnZH5dyuap0hqzRb/jgSs/UL1
	 CnTanGeIyDm+vJov/gcQAMu9anWmqyIld+XBjwkGX0QorJpG8ZM752C/PTIDxpIx0T
	 X27qRqnrPB+cK7VPbKto+29aDhe5fhmn1DNJ9LB5JC0ke3Rk+MCssHppaiUTa9SY6b
	 nvySFqpVSMOxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C21063811A44;
	Fri, 13 Feb 2026 21:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] connman: Fix issue with const return value from
 strrchr
 and memchr
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <177101700533.2558751.11198204383154061574.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 21:10:05 +0000
References: <aY3Uu_Zd2b3v26ON@01676446e9f4>
In-Reply-To: <aY3Uu_Zd2b3v26ON@01676446e9f4>
To: Rudi Heitbaum <rudi@heitbaum.com>
Cc: connman@lists.linux.dev, rudi@heitbauum.com

Hello:

This series was applied to connman.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu, 12 Feb 2026 13:25:15 +0000 you wrote:
> When compiling with recent gcc and glibc-2.43 the --Wdiscarded-qualifiers
> warning occurs because with ISO C23, the functions strrrchr qnd memchr
> return pointers into their input arrays now have definitions as macros
> that return a pointer to a const-qualified type when the input argument
> is a pointer to a const-qualified type.
> 
> Rudi Heitbaum (5):
>   vpn: Fix issue with const return value from strrchr
>   vpn-provider: Fix issue with const return value from strrchr
>   gweb: Fix issue with const return value from memchr
>   dundee: Fix issue with const return value from strrchr
>   ofono: Fix issue with const return value from strrchr
> 
> [...]

Here is the summary with links:
  - [1/5] vpn: Fix issue with const return value from strrchr
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=0762b1413f35
  - [2/5] vpn-provider: Fix issue with const return value from strrchr
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=67b1feb08163
  - [3/5] gweb: Fix issue with const return value from memchr
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=105276d27c4f
  - [4/5] dundee: Fix issue with const return value from strrchr
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=30f6841aa797
  - [5/5] ofono: Fix issue with const return value from strrchr
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=31733fbba5e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


