Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893C15746F
	for <connman@lists.linux.dev>; Thu,  5 Jun 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135598; cv=none; b=PaoN5S45m1KWAVpo0Zw4IzpOADYZuJ18I6xLgT6gqT2W7SIKLJNw67I5s3thpUML9fUdEw5mai8q2yyt+mHYAqe+KF/FbBKoFExLTsWWcvaHTwa1fnjjafqlTuPe9KLJCdjIUu8Vwkg8P/LCOFFzLpyUwgSEbDgAOjEJQwUmHAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135598; c=relaxed/simple;
	bh=0d1qkmMKq2xJ4zknxe7wcpkus8CsQh1pz/43hZJYFVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qLROQ+PuF7giF3mdnoI+SZpcAt2DZ4grRHtCnm5ur4ehFBplPUx65qn3aThhQge1/Hl32aiGQJRTeznAtutcJYVrivk6CiU12A5jXXeLKHUh8L6qDgd+g6fh39gyJHOqVjGfxiHPgV/vzer+gtyNKMt3fjj5Be/7bxRdcPNToB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxxzoA6U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxxzoA6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1380EC4CEE7;
	Thu,  5 Jun 2025 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749135598;
	bh=0d1qkmMKq2xJ4zknxe7wcpkus8CsQh1pz/43hZJYFVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QxxzoA6U2y4Mog2PtYHvc/K4v24siYSRpHLXF5hu2PIWxgEcofZiF5GAGUHIoKTA1
	 OOnxotvEPHxlXwZ/to9+t3iL+2D5657pZaohW3LrngYN1JJBKQoH5NHPx1ywEVx252
	 7miFHGGt+cb3rxghr8z93IOgOy38J+fUCYbEthWau3ih6/ywv2iZp9jbfAS0XgP9gv
	 rFMC2o29ARp7Xop4bHUMIeIg4kaWJneJ4H+/Zh4wCoik0R2gJY5B+9oAe04BGUewUp
	 tvwA9MKT/qs96izzpUZS8ezIlijHhtAk4FZ7WSOMM5U+mcyXcWegbcpRHwyWanjhLw
	 GLoAxjBupLU1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E4F38111D8;
	Thu,  5 Jun 2025 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/2] Revert "timezone: Fix compare_file comparison in
 timezone checking"
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174913563000.3105947.1904383418942349938.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:00:30 +0000
References: <20250605080336.21824-1-andrea.ricchi@amarulasolutions.com>
In-Reply-To: <20250605080336.21824-1-andrea.ricchi@amarulasolutions.com>
To: Andrea Ricchi <andrea.ricchi@amarulasolutions.com>
Cc: connman@lists.linux.dev, denkenz@gmail.com,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 jussi.laakkonen@jolla.com

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Thu,  5 Jun 2025 10:03:35 +0200 you wrote:
> This reverts commit f20ccd19a62bd01aa117bfc8e7c388d2a16cde05.
> 
> `compare_file` is intended to work with symlinks, enabling
> full and accurate matching between the requested timezone and the zoneinfo
> database.
> ---
>  src/timezone.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v4,1/2] Revert "timezone: Fix compare_file comparison in timezone checking"
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=3da91cef1c1f
  - [v4,2/2] timezone: Replace Localtime file copy with symbolic link
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


