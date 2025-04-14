Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7A25C6E6
	for <connman@lists.linux.dev>; Mon, 14 Apr 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650598; cv=none; b=oRjC6j8uUaVN97Ssf4PK9gOkBBoOTrYbX+C8DvNd5wVRVsASSu6bKAld67Lt9RsnDHE/7+kAdE2Xh6Pj5B1FZUkGccp/2sZ3cwi7wigfpVtE6q+Ppn13KLYOlHhcu76l9d4bPsuyRzS203/s3ynN0ZNreU84y4trJF4K18gXANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650598; c=relaxed/simple;
	bh=CyT6BxUgB+nLLLro7ucdexRN9gl0r8kfUVgGbobc/OU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=us1v0AYjxasl5NNPMjpuwyABn3ZKj5/B7keaXomqTUyBekR+hZUfdRV2LUnzOcEUy4p4oJqswkN0/5Jc4RSsmG4trY3ZIcLmk6cLnT6R20NyvT8z11bZ2qFvezZOTOohL1FHRLVXYBjLuRtim6pDUKbFkr8KlzfAlOSSIwD48J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zmt1CZQY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zmt1CZQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2934C4CEE2;
	Mon, 14 Apr 2025 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744650597;
	bh=CyT6BxUgB+nLLLro7ucdexRN9gl0r8kfUVgGbobc/OU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zmt1CZQYBSsLBjRFmR4semPgowKe3sfhd76yu0/TAAUlRm+cG3CO+tndVrNg2fMIR
	 e+5SAW5P3LyXi5hMCOPZBlGfaR8CuT9lKBL1vK3dNxp1FRrWq8hLATqjEQ0bl2+Wiz
	 EOWkB+lKX9DBPU/VOblfYlHpplsbVvdReVZsgBPWSaNCmPRweq4oLdyh0Birq/IgZg
	 Mpc9Rw0BIT3VRBn47/ulcXRu7aJXmDf1SUC/fC5dhXFKJYVEmw6ga2QS4nJAoSoMCs
	 CZU+QMSCUDeZx/jjiszD0EdgJhFMJ11Lxo7URbDwE5a03/X3kGmWAAabVYzWE6OoZ7
	 dQOzTvK8uF1mQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAB4F3822D1A;
	Mon, 14 Apr 2025 17:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] vpn: Fix extracting of PrefixLength D-Bus value
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174465063549.1975856.14763575822342429552.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 17:10:35 +0000
References: <20250414161015.358056-1-jussi.laakkonen@jolla.com>
In-Reply-To: <20250414161015.358056-1-jussi.laakkonen@jolla.com>
To: Jussi Laakkonen <jussi.laakkonen@jolla.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 14 Apr 2025 19:10:15 +0300 you wrote:
> The PrefixLength value is stored as a DBUS_TYPE_BYTE, and is an unsigned
> char, thus should be read as such. This fixes crash when trying to read
> the value into a char*.
> ---
>  plugins/vpn.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - vpn: Fix extracting of PrefixLength D-Bus value
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=813f4d93d153

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


