Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B19176AC3
	for <connman@lists.linux.dev>; Mon,  2 Sep 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266430; cv=none; b=CulnwKcjC6sDfMlAJLsL6MT9GKkRkkIJMdEj19715ChcJAk83ND2GsnkDHNPvkzlRnBocv5G1QNDsOXZ9IJLo2t1oN0TL0EUx668IXUIP/qNq/qV+t7uSDX0dOrDcHADzGimSQ77wUJhIOgVFXbV6YYDODIS9hWN2s+/OhfhrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266430; c=relaxed/simple;
	bh=2nVvTUStWe1uBpaiswUn667XrSMyN//F9klbFu3aqRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aue4k/eI2r+AutYKp5oeWKUm4REh82s1b3XjQpZYJ+Vxkm9okGQRmNgoPLmEyydH+Ai8aDEhsPwtIp6GXuju2VgSsVKt6PEDWBbCErCNmpG8ZubaWwa3MZYHdyR4yMG1h2zxEf1cm77iEPlWXrZc1uSG+UofiHuet++Aafluy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+aFNBWT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+aFNBWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DD8C4CEC2;
	Mon,  2 Sep 2024 08:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725266430;
	bh=2nVvTUStWe1uBpaiswUn667XrSMyN//F9klbFu3aqRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S+aFNBWT9bzOv+RS7yEHgU/Yg17MWPVYbCixVi9pz/iI1zsVLJdHnPV9qFTETW3Ag
	 7jB+vChZQVlkzmJcEF3Pblp22J+NQ0PCLR35CxybdK2CDOQmLy4Ig/mp06Al3paOff
	 p6RZ/VOzPF1BQ1+I6u90RMlHdW+H8ST0J1iabSMCqxKFYP2aaCXAOMa/3V6wq+vghM
	 88TgTTtjQPIDIE/SrbRKB3c2HqnisFyFnFlE2M9I3dK++AWwb3yvESY27eQBmWuUfl
	 n3+D3DZHXw3okM8nH/XIxf7yi0YnEDNhvKev5dJAirsmF53wNWzEvnfw63pIA7i5VH
	 /TIYTYZdxW8ZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2D13822D69;
	Mon,  2 Sep 2024 08:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Use a log identity always valid while logging
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <172526643049.3808725.13551694848126049024.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 08:40:30 +0000
References: <20240222232326.1677146-1-christian.meusel@posteo.de>
In-Reply-To: <20240222232326.1677146-1-christian.meusel@posteo.de>
To: Christian Meusel <christian.meusel@posteo.de>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Thu, 22 Feb 2024 23:23:25 +0000 you wrote:
> I encountered garbled and changing log identifiers from connmand 1.42
> running on Yocto Kirkstone.
> 
>     Feb 09 02:40:18 foo time[590]: Connection Manager version 1.42
>     Feb 09 02:40:18 foo time[590]: ../connman-1.42/src/dbus.c:__connman_dbus_init()
>     Feb 09 02:40:18 foo time[590]: ../connman-1.42/src/main.c:parse_config() parsing main.conf
>     Feb 09 02:40:18 foo time[590]: Online check disabled by main config.
>     Feb 09 02:40:19 foo U[590]: ../connman-1.42/src/inotify.c:__connman_inotify_init()
>     Feb 09 02:40:19 foo U[590]: ../connman-1.42/src/technology.c:__connman_technology_init()
> 
> [...]

Here is the summary with links:
  - [1/1] log: Use a log identity always valid while logging
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=8bd6504f449f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


