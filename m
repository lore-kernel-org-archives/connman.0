Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B715AACF
	for <connman@lists.linux.dev>; Mon, 22 Apr 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826228; cv=none; b=f6/4axAUYneTzTZCfVa/5S1SP+X06KYBCZYrZ+N1wDRYID+wYKApqXIyAb730VzPXxz0M9Yzghvr9Z5rIY7IXC9yVRyqNTNrgdDeAGvwbBEn4EnXvezdySvzkp3IHmAG+9OEL6ixLzw5XwR5XUtwEcy/VSSsViN7pYjeHZE9dN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826228; c=relaxed/simple;
	bh=itMsza62DF2wepmsIbN8VNqll00G+WMc5b4QjoJKCDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TsyhaLSy89cEg/wA/FjF1fbD7101XSSViD13wcOeoXLuLbGb1fzvwzhPjkp45OQ0PKvWup7wLy+BdD/Wyyx+6WYbsay8h7aEUUQftmG+Whb23XwNgfWU0RVi0awSNyIjb3n6uGSerD1tsr+BBjWZhm6nwW/lMzNyLWmCuqoUQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSYzzIr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSYzzIr0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B40DC3277B;
	Mon, 22 Apr 2024 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713826228;
	bh=itMsza62DF2wepmsIbN8VNqll00G+WMc5b4QjoJKCDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bSYzzIr0+6rlA2victF8fXI1NE5TeciHwEyMVnvUb0x5APwzsMTeJPstUA0Q9f1pC
	 yo0zMDA8B3a35lZtQChKjTbGefL2hESI5gQlLtBhsTw+bVBIbbyDV5+L58nByzws5m
	 CVe2f402p6MEAX0pos6auCsBdTc1IJUPZpe/dXqWE2pZJt6gtXdxXU0/y2G4SR3TVS
	 3alC97L6hz3SdsJh6+z+nhX54txl3lsltnfzwKMJfNXmSbcgB9AVvfTWWhg8bUNrUL
	 0/cc38U3eWi+vwevenJtIDsnqbc9TdoGKqgD2L7eFJImZcUzb+5YGhBSHA5vqHcSNX
	 2aKkBqjKybMFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09FAEC43440;
	Mon, 22 Apr 2024 22:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] iwd: set network to connected if it is already
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <171382622803.8811.4566236071092520527.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 22:50:28 +0000
References: <20240418201151.624654-1-ram.subramanian@getcruise.com>
In-Reply-To: <20240418201151.624654-1-ram.subramanian@getcruise.com>
To: Ram Subramanian <ram.subramanian@getcruise.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 18 Apr 2024 13:11:51 -0700 you wrote:
> Without this, connman will wait for a "Connected" signal from iwd, which
> is only emitted when iwd connects to a network. If it is already
> connected by the time create_network() is run, that network will be
> stuck in limbo.
> ---
>  plugins/iwd.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - iwd: set network to connected if it is already
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=be1767db744b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


