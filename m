Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAE16EB76
	for <connman@lists.linux.dev>; Mon,  2 Sep 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266433; cv=none; b=cxGv57BqiBSBqrneu5TRqvC5FkkhZqwLyREjJL+pmNK0qnjpPMFyZBtxGqA/BQm4Ln5Z4rl/d1d+OVENb7fvg0Sambt/cBsse3ZUk+sDftzf92aih8TkYv2on5Nq2pd4VJ8w0lg8M8ZL3BFAmYmm75IKk2gQnV6qoWNa9KVQ8w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266433; c=relaxed/simple;
	bh=VXKCh5f+2q2V9nSq7EdBfd/JLr/Mw4jQId8LoDTPbwM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IDvRa8kZ6f/+FUJie5T95wsbg2lrD/UqGetgK7vFr03fZMDXZAbLigAC44Nc0jwa5LKxRe8IJhbJxYcl3UrjfZvfiVU3NfqhurN3m+11IjdmZHwzV70ZEo2PCj60ZaZ21CG+iv5oobjxWEurUrSRFeT7O2fu6MxB0zJ32iGKl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de7hnj1y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de7hnj1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98424C4CEC2;
	Mon,  2 Sep 2024 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725266432;
	bh=VXKCh5f+2q2V9nSq7EdBfd/JLr/Mw4jQId8LoDTPbwM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=de7hnj1yl7bv+GgQGV5itazSwqXwvE5T58IC70C+NuCowQhh9gzbEGrl4IY6rqR9P
	 Xa1AJYC884lz4lXolFNo1R+JhPsrrDRVzzSFLxkBOGIB8UzE9O0Mqv/4zDoQWoD9Hd
	 DLKL4eSRjYo2+ilruRQT2agbTycBtbD8EbXE+p0RreAjSNX0RJG3d/2vOcgMhdpdWl
	 hlJeAzKsoKPUCdmbshqeCzzXyEsGjlup2vC7CnXVoeE6hHi976IU1As8rC8nGQq1tb
	 s3ewe/MOYcrVXSlS/NhXsxay/EU3p2X/vg03bXroU8BFJtJezaxuu0Ntxgb6R+/cv7
	 XEp6sHdwQk8Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EE03822D69;
	Mon,  2 Sep 2024 08:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dhcp: clear c_gateway and c_prefixlen before remove
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <172526643324.3808725.3638743104633950099.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 08:40:33 +0000
References: <20240826113357.1794-1-sw0312.kim@samsung.com>
In-Reply-To: <20240826113357.1794-1-sw0312.kim@samsung.com>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: connman@lists.linux.dev, denkenz@gmail.com, wangfe@nestlabs.com,
 dh79.pyun@samsung.com

Hello:

This patch was applied to connman.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Mon, 26 Aug 2024 20:33:57 +0900 you wrote:
> Before calling __connman_ipconfig_address_remove(), for specific
> ipconfig->method cases, clear c_gateway and c_prefixlen to
> prevent use-after-free.
> 
> Fixes: d593e995c7c7 ("dhcp: Remove old IP and gateway address")
> ---
>  src/dhcp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Here is the summary with links:
  - dhcp: clear c_gateway and c_prefixlen before remove
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=7a3ca6783ed2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


