Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1303258CD8
	for <connman@lists.linux.dev>; Thu, 15 May 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331996; cv=none; b=NC2O8BgpQZf9CUc5Q4XT8v1XKRrCyY9ENjNYf7l4dPKVg2sn60GdAbWKAqZiyBPTbyvYwO3pJCcxYV28PAWZ7it25/2rCP4dTvsLpQBU9TYFjoabsBqRehv5pMkMYk1ONj4eWXssU7n1tUYJLNgQyHLdJ3RvQ7vAs9N7rYqnK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331996; c=relaxed/simple;
	bh=q6ZlgRQa1t1XsWL6ZqPXT8oXSxG1B8JxEWdyxEcPZO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oq3SJwRkvII7+3Xp800O0h47fSdo3ZAfds0a+ZZ7DCOSE8QMQQuhbwjzITuXYFalECcnf++sa/Fsk8+Dr+lcZs/vKPXGvHP8masTSwlCbBKujHsN3NLNWmABprDM+blsreHbgbnQOm3Pgpv/kubM8d6NkHF2H27nUugG1FjS3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/RDC4G9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/RDC4G9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6354CC4CEE7;
	Thu, 15 May 2025 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747331995;
	bh=q6ZlgRQa1t1XsWL6ZqPXT8oXSxG1B8JxEWdyxEcPZO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r/RDC4G9HPCU7ssMazSYdCI2S0f9o0miSD/YQ0rDFFmLJ4EUUe4X7/x43Cv6kvrNB
	 1ZyY7bBr41mG8d9ieY8etDT7XDeyP5zeu5bOL4Vekr92LMsYECewA+NcBzx8IojH6u
	 ikE5CtX2Gbrws1RWefaZIyPjO2YaNCHsOP4KpoeMA4PMM7xWJUtDjH2vfi7i+XH1sV
	 2jRCaRy20XB5nqwF4CmRDeLi6ZYazeUvRfhjBCkPZIAWbO4M8LKVlZ9QZZ8aaPI3oW
	 PhN8rCBSmEtbUbYd0bqkNzlc3OBOyGYKVLyzSesjjy5aMwKid5d3d4bXGjREhV5yam
	 cTQjmro92T7MA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE733806659;
	Thu, 15 May 2025 18:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] timezone: Fix compare_file comparison in timezone checking
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174733203227.3197602.14987796731625791551.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 18:00:32 +0000
References: <20250515114409.1456854-1-michael@amarulasolutions.com>
In-Reply-To: <20250515114409.1456854-1-michael@amarulasolutions.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: connman@lists.linux.dev, denkenz@gmail.com,
 linux-amarula@amarulasolutions.com, andrea.ricchi@amarulasolutions.com

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 15 May 2025 13:44:09 +0200 you wrote:
> The original condition incorrectly returned -1 when the real path and the
> provided pathname matched, due to a flawed use of `g_strcmp0`. This patch
> corrects the logic to return 0 (success) when the paths match, ensuring
> proper file comparison behavior.
> 
> Signed-off-by: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> 
> [...]

Here is the summary with links:
  - [V2] timezone: Fix compare_file comparison in timezone checking
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=f20ccd19a62b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


