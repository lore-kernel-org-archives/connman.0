Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8E18E20
	for <connman@lists.linux.dev>; Thu, 11 Jul 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720728632; cv=none; b=Hi8yD2ds6MQSpa5kmFxu4TKB/HS8NJ1sAIentI/iwJ9WllS1/hwcRujePM3oGyExbk8dcRxJ7TW9NcC/KP/lGtf0nyL0HmzZC/iQ66WGdOs3+2SJggbxojM7J0oDEh9baXTZY+JLYNP8Ehh6xto7E5atjevEHSkhztIsKzjHoM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720728632; c=relaxed/simple;
	bh=7j2ed0V+2SvI4lDPZ0A53iwK2qyr3uKydWyNMKehrKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V8Ky28WRqg08Wp6nOdu4b4giaZZ21CaBbAUWw+kEeVjYiWZjk3wFuPVtxTNX5xS7/RlI6nKJTcHuUYc8MPbmRWtlx+p3T1AjOCb3wlyWFcjEv+vY9rL7xNL4RSB0Qxv/GIKloP/Y2eS+3kfg/dZozHFohZnMdEIGgcUBeBXiEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuibFg0T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuibFg0T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1625BC32786;
	Thu, 11 Jul 2024 20:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720728632;
	bh=7j2ed0V+2SvI4lDPZ0A53iwK2qyr3uKydWyNMKehrKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MuibFg0TEIDK8XU8+E8CfjjR9eyhvEhmScecwNJ5FiYVOYCK0/9MXKDdJ5cluEEFN
	 +rK42shXplG8YEovzaLqfKgIi9WGz7DaGlABUyG0Qs8N7Nx5kwSE7OEJrtkSANsG+r
	 wMuzNhOljL7fiOiskkMVA+eM7G3jEm2fOAysBjhyFp+T2IjB7prEoJSLirjX99mhDg
	 GcihGxLn0uhN71b89jCQSKOO+6MuoOg/yZyw18yl2r/waz/VUOAo22O3+QERjetkMe
	 v3jyrAC6efDLv3aOgx0jkoPg5faoPi/V4SbNBYj5iqXKl5mF5Kg5DIbgKoHaTlY1fO
	 dT3N+OwEUbvUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03E95C43468;
	Thu, 11 Jul 2024 20:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] .gitignore: add tools/ip6tables-test utility
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <172072863201.20734.10513385157208095940.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 20:10:32 +0000
References: <20240705035028.57697-1-alex@shruggie.ro>
In-Reply-To: <20240705035028.57697-1-alex@shruggie.ro>
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri,  5 Jul 2024 06:50:28 +0300 you wrote:
> I botched a patch with this.
> Adding 'tools/ip6tables-test' to make this less likely to happen again.
> Link:
>    https://lore.kernel.org/connman/20240704204732.56553-1-alex@shruggie.ro/
> 
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - .gitignore: add tools/ip6tables-test utility
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=d14cb05a5fe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


