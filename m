Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCC15A864
	for <connman@lists.linux.dev>; Thu, 15 May 2025 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331994; cv=none; b=eqe/IrG9JfEu2o0d53ZnCPCtAukCIH8ferGi0aTmrOTdYNivt89RuUS4NZcMEdw1e571vQYgU0hKvXKc/QSQYTfcNg9liH5cnpclSKZwQxUojYOz+ezt5KwkTmCi7J+6VDeI7tDo4wnRCOPotn7+SpIdYjbgh7a4Y+g8ywWmwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331994; c=relaxed/simple;
	bh=Cu5ZaUQsVfdsUNuLehHpn7bkBaA5yUgNTmIUYHxScm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YnqP7cbcttg/4pDy1H8y3qiw4+pAZzh/lgfg1fy1pXU5mEZ3MuZu1qyvN41QcikHPV2t1JJB11rDhFm6RGSibhDT+SNud4KnVCOQjxKe5udU0OTu8AvswK5BtbtkwDLvuN8JH+S6ihGHr8P5KRTHHk9s19gCDDPIeUW4Zx8XIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi+w9Dya; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi+w9Dya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5F0C4CEE7;
	Thu, 15 May 2025 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747331993;
	bh=Cu5ZaUQsVfdsUNuLehHpn7bkBaA5yUgNTmIUYHxScm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fi+w9DyaZsERIxT7CD5sdxY+GWTPIb6pifZzruOg6by3Z2ayERr+TuG+i57+1N8yk
	 gBH3+7RuLnqSh9GhiOLF+C4dDKR05LsFIX1WEXC8Wp5/qI0rzicqvxtfA5UQEGSuD7
	 XgUCfgh/sZamKjSMtvxNFBjxnalXSQWc8q2E1YcvBdjlt7OpbHqkT5h/vvqSVA4ESf
	 lRWDyjEs4Vc1wtGBQpR6PUIUYqHuPV/wHSUF08qKezub5vXYWpKhN6p0LLd1+OQBOu
	 f71lyDteZQJOfVDK/0K6nFf8nr+QYEp1zLuBtyuiqffubn5rxNlRMWXH/gGzrp46cu
	 ICCUoGoFew8OQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D863806659;
	Thu, 15 May 2025 18:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gsupplicant: Set MFP optional and key_mgmt for PSK
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174733203101.3197602.10955771808754623744.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 18:00:31 +0000
References: <20250515132447.1681494-1-sven.dembianny@bshg.com>
In-Reply-To: <20250515132447.1681494-1-sven.dembianny@bshg.com>
To: Dembianny@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Sven (GDE-EDSD7) <Sven.Dembianny@bshg.com>
Cc: connman@lists.linux.dev, sven.dembianny@bshg.com

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu, 15 May 2025 15:24:47 +0200 you wrote:
> From: Sven Dembianny <sven.dembianny@bshg.com>
> 
> This replaces 23b09a8a and enables MFPC independent of AP setting which
> is needed for WFA certification, see "Wi-Fi CERTIFIED Protected
> Management Frames Test Plan v1.9.pdf", 3.3.2 "STAUT requirements".
> 
> Additionally key_mgmt is set independent of AP because roaming between
> APs with different AKM, e.g. WPA2 -> WPA3 is not working, since WPA-PSK
> is still set from first connection.
> 
> [...]

Here is the summary with links:
  - gsupplicant: Set MFP optional and key_mgmt for PSK
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=5e73b55e00b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


