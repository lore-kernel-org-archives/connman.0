Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8D3EBF3F
	for <connman@lists.linux.dev>; Fri, 13 Feb 2026 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771017610; cv=none; b=Lnt/oPpBpx6L6xB3GtxHgMAYwcK+XFOtk61e3BuElV11ZDYU5llt0ATCy3ptA9j1ATp+wmKujI1KCUvAdHO//Gkoo2UsZmoPY/OIJxTlz0RxtuSTdr65C5TS4N/nltenTmpJQSM/DZDpYL+y6sXhe7XNmvJZT0ru67II0uAmuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771017610; c=relaxed/simple;
	bh=6T+xgHEUxVkwn7WF/gy5qCTDpYOaR02PYBwpf+/KQcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RUL3fQt9qhkR18FZBMQoHd1ds1q2SpTPX+fXBCPbEP6PSQ3hb059CgZOLv2BNR+COwcoEPwgEJ0Noqyw2mT6TTXX2+Vc3N+EVnRT1KE/7b0SCw/8E+HE7SeQSg7xkFteeHK3Ls0yDcvj2Rt/11/3kT93UWTgBgXvYtuTcNBiTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7yhFp05; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7yhFp05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CE6C116C6;
	Fri, 13 Feb 2026 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771017610;
	bh=6T+xgHEUxVkwn7WF/gy5qCTDpYOaR02PYBwpf+/KQcw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g7yhFp05HruR7r0TwNtJ/ZTyu46WhEWUtsAnf3fk4C1qMUvvZaOTfzkyaJFFTOG69
	 vUztPP3nFOEkFXyBOQ5YMLTLUFv1bhJc9L6ADqjdD7DECdVDMKmu0KYiKlieE7+4du
	 O/Drpx0U2WTJE2hZeZAXm+022+vs/8IjsbsJ4vtoYta9WuupjKY0MtxkJwMd1r6L+M
	 RnqW7vwO8sdFX7OQdw3H2n4mYrult75HleND+DmLl0kifxM1PLUSrDwfBBS5Su3Cip
	 qAOa5hgsZzumi+SJfUmStdPGl1PDevH0wSu3WC6KOCEjj7nJuX7loj5ue9SXWnP049
	 KgPE4OzyrqzjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 480D93811A44;
	Fri, 13 Feb 2026 21:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] systemd-resolved: Use DNS servers of the default
 service
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <177101760408.2561319.13668260346791736034.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 21:20:04 +0000
References: <20260126125906.37683-1-jussi.laakkonen@jolla.com>
In-Reply-To: <20260126125906.37683-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Mon, 26 Jan 2026 14:59:00 +0200 you wrote:
> Register to get the notifies about the default service, service state
> and offline mode changes. When default service changes set it as
> default route in resolved, revert other links' status and flush the cache
> so only the default service's DNSs are used. This brings the similar
> behavior that is is in dnsproxy.c, and prevents leaking of DNS queries
> outside VPNs as well. Thus, effectively making only the DNS servers of
> the default online service to be used.
> 
> [...]

Here is the summary with links:
  - [v2] systemd-resolved: Use DNS servers of the default service
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=9e46e4a021cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


