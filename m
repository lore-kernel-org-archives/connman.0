Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A53757EA
	for <connman@lists.linux.dev>; Mon,  2 Sep 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265828; cv=none; b=Xa1AsfwaN4Um6PQBbIjQ49MCHVzyLyv7tuXljEPACrPtcdLC2l3O8GbSrx2298Cf/UVzb+bw70fQIRZEO8oWsQtwyEDyBG7oWutueAqtd8DJhs75Dlw/YZ4oHVFyloBffAs366/rKuPh29qpmb6dW73A8b25g84fFsPeT1e93Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265828; c=relaxed/simple;
	bh=DDMYbHSNNcU4iTu0AFXiarS2UtAJI8ccxbefND15rAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WEKT/tTcYwbe4N2aFS1tqruRfJB5B7/KBuoUgGBexCAWFZJjLT2fuDe8Qr6LZ+6kM7ddF+ySHzEe7wR+7B9MuDBHDI3dJ2WcITwHGnA4uU0mxkXSuugOmRuIkza1ihQ5PBjF2gnBFttm7H/9lTbvIIV7kq6wOOyrgJQecRWPHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDAkdPek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDAkdPek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08EEC4CEC2;
	Mon,  2 Sep 2024 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725265827;
	bh=DDMYbHSNNcU4iTu0AFXiarS2UtAJI8ccxbefND15rAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IDAkdPekrBZCSLWdl3809bYkXQXuuTFaQb0CpTW0fG0FWZe0jvFNHyFR6vfQFkhyP
	 U3U83TY5BLn4pdLbC2Pl3rOu4XCkop/wAZWKQT3m1fuNd4IdZKIoOi2j12gxjB0dT/
	 OFXCOF5NlUeKDJ+8ZE/gzJth5fWsGNIEmxAmEO4Kg1YGm2s5jVDGmtM0hFfmHiLDVp
	 Khjdn9v/gfdQqsdWJd6lMIU7tJ90OzZC4beT918SE6gvZ8EUwgpN+eVIueFdYqXHnm
	 mxnjkJihLoXy0ds1pGUF0SufEOPpTyQiUtV1MJgWUhno+rt6Yg8HJConPmPU5aMxcr
	 yu/U8gYcpxaug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE343822D69;
	Mon,  2 Sep 2024 08:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gdhcp: nul-terminate return for 0 sized option value
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <172526582856.3804050.1879581388641618088.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 08:30:28 +0000
References: <20240819211454.1255654-1-jonah@petri.us>
In-Reply-To: <20240819211454.1255654-1-jonah@petri.us>
To: None <jonah@petri.us>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Mon, 19 Aug 2024 17:14:54 -0400 you wrote:
> From: Jonah Petri <jonah@petri.us>
> 
> In the field I have seen some dhcp servers return a code 252 response
> with a zero length.  In this case, this code has len=0 < optlen=1, in
> which case the returned string never gets terminated.  Using g_malloc0
> causes it to always get zero-terminated.
> 
> [...]

Here is the summary with links:
  - gdhcp: nul-terminate return for 0 sized option value
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=8018165a2172

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


