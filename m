Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE718784C
	for <connman@lists.linux.dev>; Thu, 24 Oct 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758629; cv=none; b=YD3h4NAsq53LUtBk8cHhaK4OhIElWiGLMpivnChNzuBQ7TI0DkCBBSouRiMQwyllEX2rexOGuXdJ/zgl5mRws8tZTlWvwr07YAdJrLud9i+KQug3F9ONNmh9J6PLVC5ignZdtZCgmodDeq1Nk4nC4/EJMr9m1NiPFojPVLW2txw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758629; c=relaxed/simple;
	bh=mtEuoywUb3UVIBGLPWns4EJBc3w5BW0LGQTbAQ3rxsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UUUkZtS49UrJJiPge4b9k0fLt+MjiKiHUDzsrWLc2IBper+rW0yMC23NpP+Eru643bnCQwEruM3oSOJBMqEmW38PC8hT20UIul3aj3J1dgFsurqSiKR/bIGuzJCp1PYTY/WGy5R/iScsIjz/AifYzmviRV2t4hUqPCA8onJjCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4Yd+nRR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4Yd+nRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F67C4CECC;
	Thu, 24 Oct 2024 08:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729758629;
	bh=mtEuoywUb3UVIBGLPWns4EJBc3w5BW0LGQTbAQ3rxsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t4Yd+nRRkBh3KHl/5P/8ywEvqXa5YACEsYQxHkbn9enVvJZB5ZYUN3+EQnDY1klrn
	 GM+CyLPhCG1M+/6ZZRPSuLBTE7znVyst8DZJihvhLfC3o8YRMHv/dKRJTf5jAZ99qe
	 fcorDYJz7P/pSPYYj4h2wdevETtA6zEd3UocVoujyOnFmK1wtQNJQd5ubfXBpB8UBA
	 DGbK/6wJvSryVFC8OYv/x2Oy1tjoEcfDYqD8omu3NWUzxALhmyt/qjE9XUVLAPtBS7
	 AnuBFoxVyk6LZhLLQFz8H5Ae/ShM4xj+yRFYdTdRRixwkuZLaKGd8dno/2zKN3xsPW
	 25+u6rBHlVF3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB44C380DBDC;
	Thu, 24 Oct 2024 08:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gsupplicant: fix ASAN issue
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <172975863578.2156559.17786231623863336750.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 08:30:35 +0000
References: <20241021225738.3057955-1-ram.subramanian@getcruise.com>
In-Reply-To: <20241021225738.3057955-1-ram.subramanian@getcruise.com>
To: Ram Subramanian <ram.subramanian@getcruise.com>
Cc: connman@lists.linux.dev, chris.johnson@getcruise.com

Hello:

This patch was applied to connman.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Mon, 21 Oct 2024 15:57:38 -0700 you wrote:
> The problem is `bss` and `bss->path` can be used after being freed, in
> this line:
> 
>   g_hash_table_replace(bss_mapping, bss->path, interface);
> 
> This is because the following call:
> 
> [...]

Here is the summary with links:
  - gsupplicant: fix ASAN issue
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=6bd975925b22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


