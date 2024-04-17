Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321BB17164A
	for <connman@lists.linux.dev>; Wed, 17 Apr 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373229; cv=none; b=MBiroSXS3WA0pcTsAAxz/pI/5bxibainDj05p6pNowjofreQpTGYU7VYc2mZ++Y1O6llh6Z1hGiGlcqUMXbjJ6DS4K6iY3bS7/nPlqa2+9AB7MULK3levC+txYdxmGKqq3dHsiXBOvUjCcwDcuC+dxPUF0SC8uT8CDb/nWtN4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373229; c=relaxed/simple;
	bh=Ur8n/IH4MTPVrsma5AeOUdjzlJ1cYMs5Ens1RY/N0gM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WHosDfquX3qMj9/mPGagfluI9wAzJtCiuNvNw5EFfpsESiL4zR1JVTue3WfrJqqO5+tb+nGTlQalciviEBXxrSXEli9Oojd53W8WxuCuBPe+WHejRKEvfQsQC7FaMh5Ssz2yTG09Y3urLKVEdfbJvDxaxtJcYkzsTbYBBf7wvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyYfWnE/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyYfWnE/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF416C3277B;
	Wed, 17 Apr 2024 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713373228;
	bh=Ur8n/IH4MTPVrsma5AeOUdjzlJ1cYMs5Ens1RY/N0gM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jyYfWnE/+VVZIUvtwYgCBRXZy+VqucR5OzfUZkckUFiyY6hm7Bhz8guLLiWYhaUs5
	 P0pmAQQOYEqV4UwjWDTCrq+BmmyfJqlVuM1gSPgADlq5d+P+ot4juSAGTG0NCwLp2p
	 tYbaEr828WS+ZVfVVThdmpbZmwasVrsGZBENieYDx2C/BPtB/dYpF3/5tPmQSle+hb
	 Hs2QayyV6WSqvze6AlarCh9n0k1LC61Uh/FH1ulwYJ2V3Av95s0nvKDhS1fzWk35Xk
	 5C9PGUCo9sevu1eW+5f7b4FDJ0GN+et/RLPwk7o5O8Isoq2n2hl7Lb864Oh/mdSBJd
	 y/e/ovlCPiOcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C98FDC43616;
	Wed, 17 Apr 2024 17:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] ofono: Add generic method to convert a list of strings to
 flags
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <171337322882.15422.10501354996628032115.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 17:00:28 +0000
References: <20240327194337.2735677-1-denkenz@gmail.com>
In-Reply-To: <20240327194337.2735677-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 27 Mar 2024 14:43:32 -0500 you wrote:
> oFono D-Bus APIs are string based, with several string list based
> properties that convey information that might require tracking.  For
> example:
> 	- Interfaces -> list of interfaces supported
> 	- Features -> list of features supported
> 	- Capabilities -> modem capabilities
> 
> [...]

Here is the summary with links:
  - [1/4] ofono: Add generic method to convert a list of strings to flags
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=7de3a65b33ad
  - [2/4] ofono: Set modem->interfaces earlier
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=43031e8c7b03
  - [3/4] ofono: combine create_device and ready_to_create_device
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=09d819414f46
  - [4/4] ofono: delay device creation until lte settings are provisioned
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=30f1ac870732

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


