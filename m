Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220317164B
	for <connman@lists.linux.dev>; Wed, 17 Apr 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373229; cv=none; b=gsEQ2exwaoLYem34brQMxYLQrXr7KORFaiFF/cVVo1JNakoOxGBzDeAuez7umz6lwSNxaQhZ7pH/REP5NaXBAkjOBDwtkNUYWXZVF+7RfkbjHVQs/vwkOAirTFjRLGvkkeUJgB9J5JF+tCiztTDXllNIbsCiBAE2lXnEzkLUG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373229; c=relaxed/simple;
	bh=Ih6gRpvYH9B4tGn3L9+j51lUixTf7Zq6x01rKAYF1v0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q1Wc2pu5iNTmPknh96RJ/+ee7N2hJHzOZnOrB62bqwoXT1hCdWYpsgHl+531WM5qjA4BlbQRe0nA+/HV3c1X47m9BaTP5YHXbzvxChkf6vmQB7lp4Nshm05jWg7rMrCslDwry60LFLRqvUr4Z0PZNPEl2JjuqveHDvvvZckIWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOP6B1Gq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOP6B1Gq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E28FEC32782;
	Wed, 17 Apr 2024 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713373228;
	bh=Ih6gRpvYH9B4tGn3L9+j51lUixTf7Zq6x01rKAYF1v0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vOP6B1GqDx54JlvWxvvcj2MBEdYrscSeW1bBQlzcnh/VvMrd942UFTOF+EXI0JRUH
	 JN0GoariEwJpb0TlT3TIEfu4ngEu97Di87OtH7ARkB3G51WA0ylJNw0s94p7LgYZLR
	 QJNpwOXq8Z+NNGojQAQHY5+VlfbJVr1oBnMl/+a0rZvukP6QxGcHN1UFXnr9Sf94Zy
	 xC0I+DSiHVjyeroX2O57aP4xBcTPWAr3jrhARzbsjmDueq0IORxuYUjGF+tUlkVMFJ
	 CoGYfL7EF7QdkeaeQi/gMNq8RXuoyRPPrulzSP7nutZYKA/EAKRiqNV36TGsGmpuLX
	 m5Dir4RJc6u9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3015C43619;
	Wed, 17 Apr 2024 17:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gdhcp: Allow client to work on veth devices
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <171337322886.15422.6918055217435129267.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 17:00:28 +0000
References: <20240417162243.3373629-1-denkenz@gmail.com>
In-Reply-To: <20240417162243.3373629-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Wed, 17 Apr 2024 11:22:24 -0500 you wrote:
> veth devices do not compute a checksum over the entire message.  They
> simply pre-compute the pseudo-header portion and include this in the
> checksum field.  Support such devices by computing the partial checksum.
> If the partial checksum matches, accept the packet.
> ---
>  gdhcp/client.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Here is the summary with links:
  - gdhcp: Allow client to work on veth devices
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=1d064a14ce45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


