Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B418FC9F
	for <connman@lists.linux.dev>; Fri, 14 Feb 2025 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567405; cv=none; b=c7QrvDpXN+LAQy8HpALxAiJ86+mtqLEpwLJ8tOjH6Rt/OiNDH4lsE21qs4edT7fo9op50ydZd1+kePCUABULsZxKeWl1VdteigykK4F/3/Ft16w4GT/KdWkyG+Fllnm9zMANXMoH88vDbjyDj9+yol6A3USVpArHb6fY6vwa4vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567405; c=relaxed/simple;
	bh=RJkMPMT7FT5G6aYmBzAAgZ4KmrhVRzu68JW+kjTyhic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rkJZWNLNJvLs4UbPdP6qSneUmRxLYy/LWbnFQ8EuwHss0fLdKsZT0+Wn9I7B7TlLcS94qefUEIUL2ja1EsC3V9dtoYOhI0vJExo58rVrdEXb1HXzGZf8JHqEO/gS399zC2opsvevT9m8zrdexdSe/L3+FI0oml/F1lHFQliAvZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM8GksqG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM8GksqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7684C4CED1;
	Fri, 14 Feb 2025 21:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739567404;
	bh=RJkMPMT7FT5G6aYmBzAAgZ4KmrhVRzu68JW+kjTyhic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SM8GksqGsoZfoUfn3AI04EQapkjQibspGZhp+gPp0xrYDLAXV7STMwein6whrv5ew
	 Ml+fi/Fl5S2u/Uv61mnrEMwk+ZqjJ/kEU7K+JfntJI9Gh94dYExgiVT6Qq9g//FYs3
	 zRCLE4eQTItvn5b2RmpW6KYmwC2jny5E/SkBo9Ji886OzE3WAONn/IULikR743JY88
	 hk3mK+lq0GryKBkL9hlw8xCsf6JTf/OeRe21s5hkI/KzpIY5q11AJDIp6Azqoh8jhi
	 L2tgVshYO0lVpaVN90v6bs1y6VWiArlVhoWrlzckizvkscT3Udswo+wHRJLN5rTXwU
	 mMMHr3y95Usbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71868380CEE8;
	Fri, 14 Feb 2025 21:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] ofono: Make the oFono Plugin Modem Interface Order
 Tolerant
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <173956743395.2105498.1128439275348409089.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 21:10:33 +0000
References: <cover.1739403363.git.gerickson@nuovations.com>
In-Reply-To: <cover.1739403363.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 12 Feb 2025 15:39:29 -0800 you wrote:
> This addresses and closes #135 by providing a secondary opportunity to
> send D-Bus request to get Connection Manager interface properties and
> contexts at the successful closure of 'try_create_device' since the
> primary opportunity in 'modem_update_interfaces' is missed in the
> following test case:
> 
>     # connmanctl disable cellular
>     # /etc/init.d/connman stop
>     # /etc/init.d/ofono stop
>     # rm -rf /var/lib/ofono/*
>     # rm -rf /var/lib/connman/cellular*
>     # /etc/init.d/ofono start
>     # /etc/init.d/connman start
>     # connmanctl enable cellular
> 
> [...]

Here is the summary with links:
  - [1/4] ofono: Add additional 'DBG' statements.
    (no matching commit)
  - [2/4] ofono: Use goto error-handling semantics in 'add_cm_context'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=36154342e546
  - [3/4] ofono: Documentation: Add comment about entry condition for 'context_changed'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=00e7dc2d528f
  - [4/4] ofono: Provide a secondary opportunity to get CM props and contexts.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=0b091dd8fc8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


