Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3384185E64
	for <connman@lists.linux.dev>; Mon,  2 Sep 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266431; cv=none; b=gFKhmsfKww07O7yIWgXOA3eSkobuBqJVyslGHI45C6mEsM0dcvefOq8XXH+MlttEOy/SYfgF89JRinss4YRdeOYzfVqoy9iUiFa2cw/oJQl/8Eur2ziuGyhuPocrNvlg/UdxcfD1TnanHseFAaPjXg1vsmtAZZGPnP2gbxLcg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266431; c=relaxed/simple;
	bh=qXB39jpf4a7WLWbT+Zf+9MnA8wEZTYtNNgVV/WQrFOk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s89Q5zKbK/P5ty+3ao3L/Rcs04khAbreeZ0davZG1RYcx63B0Y5Geare/BRqQSv/xt8g6D/bPjN7Pmwlso/9enpGw3lLvp32kISylDKmtp71AgDcasackMzM+t+oFt+3JrbJurrqmRf1suCDCyWEPcRHTHa80Cdgvm8gHTUHUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHhngqhA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHhngqhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54833C4CEC2;
	Mon,  2 Sep 2024 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725266431;
	bh=qXB39jpf4a7WLWbT+Zf+9MnA8wEZTYtNNgVV/WQrFOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BHhngqhAgMinsVXjyNCoOaftcTr8eo4+tSYz3y5+jAZy0zH0aWqUIyuKgYssXjJWE
	 ElnJW8+cz0Zp1Va5pdxBevwNTIOknkNAWiKKrDJ4N0vwK1CEQY9WcC33wAsrJS/wOq
	 1R1U1lw8lM0yM9Y9bSVLnckXQJacBq3Xnzu8iklVfaU3RHnOpVWqLyBEZPJb95cPfP
	 QqIU8iyBYjk+HEN9xf+2E0wXRjgXsnOm0pYFiS87E7gq+U8eICpN/VOhPgIvyAlDWS
	 2D1dB61F1y23Jfrht4tO/jYp4EVacQwTYqqUCLaItfMoBSigolO1WVCvzv4R8s8iMM
	 2eCaeioWCUhSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE83822D69;
	Mon,  2 Sep 2024 08:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] End connection if connection failure and no agent
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <172526643199.3808725.5933946355389984637.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 08:40:31 +0000
References: <20240220101139.36171-1-c.ronco@kerlink.fr>
In-Reply-To: <20240220101139.36171-1-c.ronco@kerlink.fr>
To: Christophe Ronco <c.ronco@kerlink.fr>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Tue, 20 Feb 2024 11:11:38 +0100 you wrote:
> I have a modem that is not able to reactivate a context just after a disconnection (I have an error in AT+CGDCONT in this case). Some seconds later, connection is possible.
> 
> With connman 1.39, here is what happens when I disconnect and reconnect corresponding connman service:
> 
> root@klk-zcel-030030:~ # date; connmanctl disconnect cellular_206018060790006_context1; date; connmanctl connect cellular_206018060790006_context1; date
> Tue Feb 20 10:00:19 UTC 2024
> Disconnected cellular_206018060790006_context1
> Tue Feb 20 10:00:19 UTC 2024
> Error /net/connman/service/cellular_206018060790006_context1: Input/output error
> Tue Feb 20 10:00:20 UTC 2024
> 
> [...]

Here is the summary with links:
  - [1/1] service: End connection if connection failure and no agent
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=d927365c3e84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


