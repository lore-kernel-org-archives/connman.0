Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6370831
	for <connman@lists.linux.dev>; Fri, 14 Feb 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549404; cv=none; b=j2+6GUtu66wFCYKtr42eGVmb6nMptWospdvht/0/vAJVWSH6tKu38oRdCyGZGVcvAOS78S2G0IdAMbcRBl5XgoHekY4hx+a45yhMEqoZSg65FxkJLaBoDyo6wFmOVIQMSxEpwAwLCGqvTCHLcIOR+I2i4D4xobctJnDQWG6tIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549404; c=relaxed/simple;
	bh=fxZArunRK81xr/x77FjgIWtSl3Wtdcaaqrl7RLv0VcE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nh/tsvQHgGtZ6DdcGbzwT/rK3d1I6/A514J7lyyy+2Uj+ogx1FtXL3qXXDAmqvthSQd21y6aoWc0KladgHQHGYpBfUAeM4ApGV9407hX53y54eGmhen7bbBKOY3LVOHlUxUlDSZbCewwT++/6OkfNmAjd4tI/fSDe7VaNTB//W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md9kSo7i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md9kSo7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43B7C4CED1;
	Fri, 14 Feb 2025 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739549403;
	bh=fxZArunRK81xr/x77FjgIWtSl3Wtdcaaqrl7RLv0VcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=md9kSo7idYCUjk9agHa9Dzjb3LQlQTyueu9HTquz+7pfhsLe4ukZ2RJctNK+U643E
	 wGzmX3o7kJkMc4iFRyimzJGy/aZ4QrikMcuGbYWJDn1Kx0ajzAk9VbmNn9sParN3p+
	 tc7WEjHofO5/lXdmObo1qDt04Z3oZmxgmlQ+MzvMANoaNjYQrHDZDCA/R9CgBPuagm
	 HBk8uPWEH2pkycuFrI7SU4yL8jkUiIPLmDKcxF+oy+VEkoOfgtiX04HBLY4nELHWGb
	 VVp/47Jfij3v1cBy66daQAATaS0nRuYnr6AMelIgEWQoDRm/0eFirIRvQ2VEu5MnEq
	 ZjNSEHSeM95PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71483380CEE8;
	Fri, 14 Feb 2025 16:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] ofono: Correct conditional in 'cm_get_contexts_reply'.
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <173954943327.2026081.8395656267051370196.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 16:10:33 +0000
References: <cover.1739203086.git.gerickson@nuovations.com>
In-Reply-To: <cover.1739203086.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This series was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Mon, 10 Feb 2025 07:59:47 -0800 you wrote:
> At the appropriate moment in the oFono plugin lifecycle, it gets and
> evaluates contexts from a given Cellular modem. Depending on the
> HNI/MCC+MNC and the network operator, there may be one or more such
> contexts, each with a different type.
> 
> Within 'cm_get_contexts_reply', each received context is iterated on,
> evaluating each for the type 'internet' by calling
> 'add_cm_context'. If the context is not of type 'internet',
> 'cm_get_contexts_reply' should continue to iterate until all contexts
> are exhausted or a matching context is found.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] ofono: Correct conditional in 'cm_get_contexts_reply'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=28a7ce1595a1
  - [v2,2/2] ofono: Document 'add_cm_context'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=d543e126896f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


