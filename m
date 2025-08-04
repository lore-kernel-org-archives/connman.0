Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E31547D2
	for <connman@lists.linux.dev>; Mon,  4 Aug 2025 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335791; cv=none; b=cu5YYGJerzNET4oeDUmNL9L967WEeZy7NeZjjJoMjPAXlkKmUmjwQNrGNu6E6JzRU4zAEqETKdRj05j7jzdZHylB+Qc4H2al7SuM3ysWz1jlN/0T4CTi4t9N3nU3WLpylqkh4nHgTCumgrnIk8oO5zNWqKLTbZVyZYMk59Pvto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335791; c=relaxed/simple;
	bh=DjmN0NEO9yEDcYf9nicdW54ZtkLSqWZWRAK+HHH7EyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p9UpbXMHuuq+3/3gUH8yqxF+OuMBjU+NLx5C719wDgRG3YchsSsl57jxghkd4TrWF/JhwGLud3gOwUwkfHqyZhn8nV7VD93ZnN+VEb3p+ub4Gp1R/YWsy4tMZQ/HeyFqkckxSiwSliIgRMIqA/Nx7/NlMFwy69NMPO617FuqwjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5Dk1QHD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Dk1QHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0845C4CEE7;
	Mon,  4 Aug 2025 19:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754335790;
	bh=DjmN0NEO9yEDcYf9nicdW54ZtkLSqWZWRAK+HHH7EyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l5Dk1QHDuGeHSThlZN9o+Pxe7/L+Rq5caBNjlo+GAijkOwZc1ytXA8Ui28RE3oKuS
	 ihdM9pBKA5lMZoYEKb8p6CLOpi9oSCoHCfPm6Ve6m2eW8mP7344tgETAXplDTUShpq
	 78GWELde7ggRgZX/6V4dwoYNvbT9VsdZDooGO+xt5dTAAMiHp35zOTDS548UiMYFxS
	 RsAbUc3Y38oNHmsBmBgah41+3SbEKHger3MKGYMyRXKazXg7eq/X4fFxWizA/aq/Gq
	 Hm/9uoqSwdkXE6fcEpqbfTmjg9mAWBnhamFkL/qeASl14qb2IwVvUzPbxdxiEougG/
	 dw448vM6UZJuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9D383BF56;
	Mon,  4 Aug 2025 19:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Fix comparison of services of same preferred type
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <175433580501.1326904.11547972624192042088.git-patchwork-notify@kernel.org>
Date: Mon, 04 Aug 2025 19:30:05 +0000
References: <20250801110412.203290-2-johannes@dividat.com>
In-Reply-To: <20250801110412.203290-2-johannes@dividat.com>
To: Johannes Emerich <johannes@dividat.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri,  1 Aug 2025 13:02:39 +0200 you wrote:
> The service_compare_preferred() function is called twice in
> service_compare(), once with a guard to only use it on services with
> differing types, but once without any such guard. In the latter case,
> when comparing two services of the same preferred technology, it always
> returns -1 because it checks service_a first and exits immediately, when
> one would normally expect that comparison to result in a tie (return
> value 0).
> 
> [...]

Here is the summary with links:
  - Fix comparison of services of same preferred type
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=82ce27e45308

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


