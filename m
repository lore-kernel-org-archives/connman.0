Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD971B80F
	for <connman@lists.linux.dev>; Fri, 26 Jan 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706275827; cv=none; b=QcVF9CXLpdZ40Bf/k2AtYH5QOWGtOo7hOCAd+KPfHqBzeOZ/AgMCTA7i6fX5ELpu/gEZ4Plgb7Ok6soCzMAAzI4Eo8Ez0G099jYJtNCRY9z8CxJ969dlug2Vwmu9uxj2Afo7KEnGBVvn4b6LUEhQTQrlxjRCSegJWZdS3tK9LN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706275827; c=relaxed/simple;
	bh=AvfePNc8+3geX9WAH6hEPnFVqHbwM6KTDIovkGhrsF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qrxShMbXfy9ZjSQQEJpQY+Qew/WdwXOsauEu6OeAv5k6uuyc1HshOJpKnZxMRl16Nuem5xpZljy8aoqVrjTWTXfs2vAJVgG9SaaR0AEOKZR6Wdes80CcEYQkAk0stq+YmeU7TBgBBPAHTTzTsTmA1ij28ZuSRcqFK0CyZ42qV6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1ks8ZCU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1ks8ZCU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E4DDC3277A;
	Fri, 26 Jan 2024 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706275825;
	bh=AvfePNc8+3geX9WAH6hEPnFVqHbwM6KTDIovkGhrsF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j1ks8ZCU0JJk9bQDxmwIsD3vJpWL5Rpxxu82oTcJv8mevU54WSBL96tkjFNaexwAJ
	 RCjtzA9t9XgOZlm5OrZJYNmVGmgXCcaN0QnWV8uYihFqoFBcEwMz5C5oXVLTlHYTpn
	 XC3Nd8lWCwze/ygEShX1Wainp9zohN6rDR9xlFGki1B266Mluh35P4WbQv0IfHlcfH
	 CV0y47iD1BVeqCEGoWi9UU6/KlUfuiX0nyeNoaS251CrbDjLlfM1rYeG6BzsbgdDHd
	 8qcTDTTOxTzeDuG0Mf3jC9SSH585KsDvsPuWj43M29ExbJANriZy/aWd+ETZiL7IS7
	 9MZ9NarX0SBZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A2FAD8C961;
	Fri, 26 Jan 2024 13:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] ofono: Remove support for CDMA
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <170627582556.15735.2786153254118641107.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 13:30:25 +0000
References: <20240125222858.640572-1-denkenz@gmail.com>
In-Reply-To: <20240125222858.640572-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu, 25 Jan 2024 16:28:47 -0600 you wrote:
> oFono 2.2 removed all support for CDMA since most CDMA networks have
> now been shut down.  Remove support for CDMA inside the ofono plugin as
> well.
> ---
>  plugins/ofono.c | 425 +-----------------------------------------------
>  1 file changed, 8 insertions(+), 417 deletions(-)

Here is the summary with links:
  - [v2,1/2] ofono: Remove support for CDMA
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=ff19b5985aaf
  - [v2,2/2] ofono: Don't invoke SetProperty unnecessarily
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=ee0046efd0f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


