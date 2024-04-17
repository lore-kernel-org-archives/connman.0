Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D5172796
	for <connman@lists.linux.dev>; Wed, 17 Apr 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373829; cv=none; b=m8gq8RNtvWxFe8R1iVQL4yoXJ197doQTTPIzyvvC9R+k54Rm4egK+eJFZiQIQrw/RdTWKeJjUs+DC+lpk5ht1Vm2p2CfyyWkvnEmBAJfXEFrre2kg/g2wpdIIUnlEOeytU153cUNmcPP1pwuTLENEoL+loYdwH1lfgnqbXoSLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373829; c=relaxed/simple;
	bh=n4+x8NnS56GnW9a0uLjxiq4lvpV/ds0ECg9UABulIsw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X2qHICL/TNBw0CmyMvxutn8eKefV+aRNHCvxl3fQ9jO8tNcBhJSeKrMySVF5n5IUZVc7IFW49yIU8iJfRAn06zAVprV3+lqe1ZOaKVRQIFlcb9umBuwnpny0PQpenUTe2zf4alo31dQtjm2GlOzb+mUN+aWTmTOdmUC500pXVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9GNc67S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9GNc67S"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49CF0C3277B;
	Wed, 17 Apr 2024 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713373829;
	bh=n4+x8NnS56GnW9a0uLjxiq4lvpV/ds0ECg9UABulIsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l9GNc67S8RUxfrcejVMPHX0vhR5MfKoY2G/ihnT1Ys1arUJi+MhxaT6mTZCJpVO8T
	 XomGIw/ygmxW/ncKtGi5ZyyfVlbx3qnA/nvruyH8YaydKZeJ4xYrzAJQb2vYj9U8Pj
	 LdBUs2M5sYyAbat1zjjrLzsVea/aFOBr0/z5OQTvyr4OrTNswJVxe6Bf0GB038ax4S
	 dZWT9ZAlRo5L/aTqujLp2Y1v1OadXpSz0yFKudkcLkQt/aLd5j5pMHoB7hHUCSTN2J
	 6L9V4savW5vBikcc20W2SQmRyns0X8D0ZcUWgXG3fHCA4gGtowAkSWmkdyK9XptgP8
	 QAAn3JgYdnQvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33A85C43616;
	Wed, 17 Apr 2024 17:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Ignore network devices used by NBD
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <171337382920.22342.888508822004834786.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 17:10:29 +0000
References: <20240308143630.2195695-1-l.stelmach@samsung.com>
In-Reply-To: <20240308143630.2195695-1-l.stelmach@samsung.com>
To: =?utf-8?q?=C5=81ukasz_Stelmach_=3Cl=2Estelmach=40samsung=2Ecom=3E?=@ci.codeaurora.org
Cc: connman@lists.linux.dev, m.szyprowski@samsung.com,
 k.lewandowsk@samsung.com

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri,  8 Mar 2024 15:36:30 +0100 you wrote:
> Add support for ignoring devices used by NBD to mount root the same way
> ConnMan ignores devices used for NFS roots. nbdroot= nbddev= parameters
> are used by Debian and Tizen initramfs scripts to configure NBD for
> mounting as root device.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> 
> [...]

Here is the summary with links:
  - Ignore network devices used by NBD
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=45185bd4df16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


