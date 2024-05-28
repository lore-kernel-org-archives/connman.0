Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A0171E53
	for <connman@lists.linux.dev>; Tue, 28 May 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912481; cv=none; b=EciEaODPzHc4j95xyGxHPrkkKMpYMGwYmMH/UTDWjhQa+GKSxO3iX50tvBNYQa0gwHHjGUXPpjtHgLdVOVtsOf3ZqCg2liPsFP698iMmcj5UrTOJ+7zNuhOhiS8M0Kz0qtZAyG8kD6lFjZmv/HX+nUibsB8+hE+NSdcC8c04qwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912481; c=relaxed/simple;
	bh=ansmg4iYOHZj4AfwtLlyRxNkSHGxaVEvcprWTUkZvpM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lobdNo9fKZm9uWMJHUHEU8gVRTcOdarYN4YzCG3hcShVEtJ0ia7Su7xiV2Qq3CaxJkeQnO1q64DezLLFvzacjX+z77s46Jr+ARWT6Pa2QByOuYfRe1XELtWPrKny8AZDzERnz4qlkf1bMHwCHjvbiEjj6EtoMAbQw1RRNuRvw3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHIYTJSV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHIYTJSV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7961DC32786;
	Tue, 28 May 2024 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716912480;
	bh=ansmg4iYOHZj4AfwtLlyRxNkSHGxaVEvcprWTUkZvpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kHIYTJSV7hqvGV6uzV+lZ6+PfDwZQlxc/CMZDxZSw/Wh2tVrl/il6hqkRwmk274ZA
	 Eu7nNCkkFzBZo4ZruI2vJQlNbeyLBzwNQLLD4bT98VEMlOusrfXUyxlDbEcJLQqW+2
	 8qt+n996Dre8thLe6LMtSF5FLqV3XWVp6fcGynKXLTLL0uXqzAzUc4IE4pZlW+i+Yg
	 hO/K4WuLXNV71ejxtFoZyRxDDXFxgZRzoIuXNGNlTLMdIxzJuHcSXtfNhxbyXwQe3x
	 0ab1n9yMLokvEDWbrs+edxHXjV0LINF3MzCz3VjJ2hekSYHTDEpBeYa7gfjbNIzH/U
	 BmT+r+LlsC8CQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AC14C4361C;
	Tue, 28 May 2024 16:08:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Prevent a short allocation by checking upper_length
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <171691248042.21901.1557767893499663439.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 16:08:00 +0000
References: <20240510235325.3625167-2-cwee@tesla.com>
In-Reply-To: <20240510235325.3625167-2-cwee@tesla.com>
To: Colin Wee <cwee@tesla.com>
Cc: marcel@holtmann.org, connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 10 May 2024 23:53:30 +0000 you wrote:
> From: Craig Young <cryoung@tesla.com>
> 
> ---
>  gdhcp/client.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - Prevent a short allocation by checking upper_length
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=281e352c4c43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


