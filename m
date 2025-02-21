Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8017CA17
	for <connman@lists.linux.dev>; Fri, 21 Feb 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180001; cv=none; b=hz3Ct0ye5gNwMwqSJqzvBQNJeLU3W6SYaQdO3OqZUpKrq5iovzn2ABUqIxyE8N8lZTlag4olWZ2Rh3QeHEK3YUDmTW3/EwK5RaKdDyIj/Tb5H3kshGE5PfY0KVgtbyuq18u23pLyV0ZAeG1Odgk2giUY0pXAQDj3O/mAwt5rV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180001; c=relaxed/simple;
	bh=4XURyUTD8OV74SIZ4n+IY1+7BFXH9zggJHOk+VKC3i4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sAMG9OYRY+hhIuV7Bek1TkaFfyMN8iqIuby/8J1OTuv3Wn/F//lKhdZt3JRR0L2NJ3ukLGabQKDGT1rastEsv2o5itwPQIhQkBTJ/NRP3Anu2+YKHu0V0ocUGnw++VyRX6+opgvPBATblXFV0XHV3MUFhwZ5AFMe9fVXdm7tES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azjct+vm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azjct+vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E21CC4CED6;
	Fri, 21 Feb 2025 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740180001;
	bh=4XURyUTD8OV74SIZ4n+IY1+7BFXH9zggJHOk+VKC3i4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Azjct+vmbG7niR7VSObW/vUnplAQOi3b3SIQq72+3I47JYlHnmdE+bpAmuEyp3LCr
	 uWqMvmzVWIk1gARNMeqHCVGm2tSkO2R7/xkBKUBg8IikJP/B2jNhkOggxy/HdOzb0m
	 dKDsaiYnxgfJxF2v6aNBXzY+qF9rpjNtxFPSZrvyW+QThnYmql/C+H7mYa3CEjBRcN
	 +hcxPtIAPH3BvoK+LhXtS4dLVw7XfSVk4BrgppqI2A+pXhG6pmUA+GM92YzSfB/bDD
	 qo91PQjWsCZ7/7p8weyv8ieBb9IRre/EGQudyQqtQnSyReF3LBAogX+n0UV/rJiNT4
	 O4ugskN4ckNCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71CB4380CEEC;
	Fri, 21 Feb 2025 23:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1 RESEND] main: Log configuration file used rather than
 'MAINFILE'.
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174018003225.2234448.6524825829557705470.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 23:20:32 +0000
References: <20250221155731.760102-1-gerickson@nuovations.com>
In-Reply-To: <20250221155731.760102-1-gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Fri, 21 Feb 2025 07:57:31 -0800 you wrote:
> When using the -c <FILE> or --config=<FILE> command line options,
> Connection Manager warning-level log and DBG messages incorrectly
> report 'main.conf' rather than the actually configuration file being
> used.
> 
> This corrects this by passing the actual configuration file path,
> whether the default or specified via '-c' or '--config', through to
> both 'check_config' and 'parse_config'.
> 
> [...]

Here is the summary with links:
  - [1/1,RESEND] main: Log configuration file used rather than 'MAINFILE'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=3f586b6cdb60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


