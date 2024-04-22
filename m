Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7980616D4E4
	for <connman@lists.linux.dev>; Mon, 22 Apr 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826228; cv=none; b=pLMziuYUzEfktuApcxx+KCWk5SOFKEydxhxD3Ya+xtB8i3sji+y4QcdQmmB3gjck53yq7ejxxXpX2A5LhMKyrLgF12ncmVQBpLC/e2SJ7wOxwEwAjq3UnTwIZ+xnNVu21UXrkcw53YXnARdz5MZoxLOXYHjnupR8e4ZsckyH8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826228; c=relaxed/simple;
	bh=7rsN1dUlCkC8V9nYJUhtglVeeSztslWUwz2MawP+Who=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EfjcMJT1bQ+7yhhEG9a98D1kmTIl3sLIXcqfdfKVbHJXDheEbGIVhwpwI0bazxKPrYMWf44rJu3q2qhg0Vh5sMfo14V1ktZY7N3+jaVHEaz+bP1fpaQ9PDZiyuKR6U3L79ms1cU6zeUcNG3B2/lWc4cnrQMltFcEjWLeao0Vxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpeOAv6K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpeOAv6K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27330C32782;
	Mon, 22 Apr 2024 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713826228;
	bh=7rsN1dUlCkC8V9nYJUhtglVeeSztslWUwz2MawP+Who=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RpeOAv6KbLaKUCe2yJmQh86j7YOzjwS7x1h8JX5VW11SgYhrxlvUJRwlmHkv/Msuz
	 ECx+Ij+hynBGpUlXwvzoJpUIHIccNiDxYdzx1HGB6RQRXhTLoURvym62kC4/4/DhxY
	 JkautWEc6FEA9pqN5yu5ub6OAxZwPzIOWugPwr6e3kVlyvn8PDxbj3z8oxkthofCA4
	 pmP8wMx6ndh+KC4iS50dUVnstXmpY80n/ka+hP8IDMS5hS9ZsSWhcqzvBnYZA51TjS
	 HzvrvXGrPfvc/kvwsoKbeXNlUQTtD7h+nLaLx0Q35uH9VV9DyrpIMs7pjVpFvxNcNO
	 ruId6nJUyAcAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11616C433A2;
	Mon, 22 Apr 2024 22:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dnsproxy: Fix cached ttl update
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <171382622806.8811.11491387747740242977.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 22:50:28 +0000
References: <20240422193805.123689-1-bfukano@gmail.com>
In-Reply-To: <20240422193805.123689-1-bfukano@gmail.com>
To: Brian Fukano <bfukano@gmail.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 22 Apr 2024 12:38:05 -0700 you wrote:
> This bug was exposed after fixing the signedness comparison warnings
> found in dnsproxy.c update_cached_ttl() consistently comes up two
> bytes short when processing the last record.
> ---
>  src/dnsproxy.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [v2] dnsproxy: Fix cached ttl update
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=3ba031745fe0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


