Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F381F3D53
	for <connman@lists.linux.dev>; Mon,  7 Apr 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038597; cv=none; b=NyhDjvxgFhXQcvcypShsPujz6Izt/Dn3T/lh2Oxhq1MNp1+NP44PDpkm9K+pHd/PBMgK10sJNw6Vmcf0tmIH8NlNBFP2nB56HUSmeGBS8gXbaTX3CzYudi8r8YKdSGDE7cGTxE4W0HXeTM1w4kVN/H9nvtBqAU2fBylLaC3Fjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038597; c=relaxed/simple;
	bh=3z3Yb/ShJbTetMXjMNS5s4dTY9ycdRoiSdjiN0iFQ0c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=McyrI3H1hNfqmpyCU7f/gffVJ8Sy48HFbhYMxIHBP5mnsq5EimIZ6nNU7BwEBES56E553t8Szfvm9QxpGyrhp26cNbtr+A/AL/ElK3X8ivm/0/uc26IB8OYhoYVhqlYhmixJJekHCIMEQkQ+mYY0SZlWMbzcmBRpRxG9XILWniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyU+vsxS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyU+vsxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E492C4CEDD;
	Mon,  7 Apr 2025 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744038596;
	bh=3z3Yb/ShJbTetMXjMNS5s4dTY9ycdRoiSdjiN0iFQ0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QyU+vsxSOUSbyjgPk5+iOlWguWh3KbI84v3mcvXW8/yJi/H8d7+ne7kzl5EFpRWdO
	 ZRT30WKw6cBx9pWquzc19cFBJHArrogJU45kNkMzrhTsq+HEnbA3Y4rtRnMhnoiFik
	 tzm1VnuA6qWrpvjbcOKMsBZpV3rwptoyA//a9DS1KCx4NTGNMLyIr0LLRck0GD6Rx0
	 UrEh2sMkYR0eokRq+XtY8mRyrPBy3vMMfYzOhlXjL9J15+OtfHFoEa0MPLhmbFmJwa
	 NoIePeigl8pra/NHN/TD/LLiNXIfDEH3XSboCXJZAfjSbI3TNp6Iv/uIRXMM5wqLWD
	 Uo5zM3M95JPog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC6F03804CAE;
	Mon,  7 Apr 2025 15:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gdbus: fix double free
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174403863377.1054842.10738052759065282623.git-patchwork-notify@kernel.org>
Date: Mon, 07 Apr 2025 15:10:33 +0000
References: <20250405020929.754988-2-cwee@tesla.com>
In-Reply-To: <20250405020929.754988-2-cwee@tesla.com>
To: Colin Wee <cwee@tesla.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Sat, 5 Apr 2025 02:09:55 +0000 you wrote:
> These are freed later in filter_data_free.
> 
> Signed-off-by: Colin Wee <cwee@tesla.com>
> ---
>  gdbus/watch.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - gdbus: fix double free
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=96dbccb35e00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


