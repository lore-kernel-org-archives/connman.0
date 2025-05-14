Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D76415278E
	for <connman@lists.linux.dev>; Wed, 14 May 2025 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251592; cv=none; b=Psfq10l5lcSGOtIPz5ilRuw4W5SWNHGBVdpqUCzCwdsq51ISZHjClEmSDJooNiK7LsAqnW1IuikWTbmQFx0S19NciIKgGtS3ajvPekw3TBGPRpQ793YMYh5Hfm2gVpg5k/jzTLclL8SOTnMJebwZp1zUG+nqDI7IaDJcBk5nNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251592; c=relaxed/simple;
	bh=VLZVqr/xQrxVpn9dkkcVfDTVzMapyj/t0QVzCJo5JPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MV8lERfMEamSDwrpbh8POFxA0cqPyPCeDJNBQjbTEC/U2++ybCVzdQUtfg5WpIhmhd2Bizc+GqgtCZBxXBM83R+ZA3VQFan7HksBeNN0Q11S1nV7rYr6SUAtcEt/7t9wlbKQPKneucTpkTLpasIfGf42Q8BrhyJtZ6sM8HRHMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCSMyWoN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCSMyWoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52FFC4CEE3;
	Wed, 14 May 2025 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747251591;
	bh=VLZVqr/xQrxVpn9dkkcVfDTVzMapyj/t0QVzCJo5JPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cCSMyWoNrigQL48lSI82SgIjVaFgY+spfaGg9EAHqP95hPIW/fumJH7Ijdxa/K/vK
	 dMH0V4szxpnUfTfaalvbJ9y5fjKjAkLToVFV5zx7+StN1gvr9sDcehECFA/01J7v26
	 v5yQtU34JIHKlVvJRaSfNN3+cH/QUQ6ky5VIkBrJ/aIeTtjsgAa2o1snRXbib+IW+f
	 pUDBwARZGIxv8K7LYyTxK8at7dwnTlJWhr5XEJR/ZnjmXu+ahPAVSg5YZ98QiScdOP
	 z9QLDayBMfAva4R1Q14AFZ6mIsYgUqoaH1WpQrdI3rbbJ2JgyyGf1JOUiPTxcXgiWv
	 2NM3sqTnHhIyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE5380AA66;
	Wed, 14 May 2025 19:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gdhcp: Make DHCP client timeouts suspend-aware
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174725162925.2487906.8682478428110005930.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 19:40:29 +0000
References: <20250513170205.244019-1-simon.holesch@bshg.com>
In-Reply-To: <20250513170205.244019-1-simon.holesch@bshg.com>
To: Simon Holesch <simon.holesch@bshg.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 13 May 2025 19:01:32 +0200 you wrote:
> From: Simon Holesch <simon.holesch@bshg.com>
> 
> When the system is suspended, ConnMan may keep its IP address longer
> than the lease time. This occurs because GLib timeouts use
> CLOCK_MONOTONIC, which pauses during suspend on Linux.
> 
> This patch switches to timeouts based on CLOCK_BOOTTIME, which continues
> to run during suspend.
> 
> [...]

Here is the summary with links:
  - gdhcp: Make DHCP client timeouts suspend-aware
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=5907c281c138

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


