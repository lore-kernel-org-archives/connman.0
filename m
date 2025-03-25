Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DD1FC0E9
	for <connman@lists.linux.dev>; Tue, 25 Mar 2025 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928598; cv=none; b=iF1oYq2Uv/MJLDpA73BoJ+aZMIWNVnvfcCsxn5NjFla3uCtS+hwCD8aWEatMmp1CMiuZQePadBhD/+LCD/UnrHqNHp3wLkqiyifu+ZzPPibccA/7nKihNE+MIS3xN6AnUZNTDAz9eyxp0datvmAGORxRWN0sZZx6IyyeJAuFKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928598; c=relaxed/simple;
	bh=h2EPrM3m7ko2MwwB9dJvYfSUX8PFUB4lfypReRTOEX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e+RB00SC8HoImzMLeSB2uUXKs1S2kBYHErvsKsejPTegfxesvPYAP+6OWoXbIJgAODCLEPkjfh7PRqIEpDBHbT//O/6D83+YID/HEnYUz/gpOuKHPvYJusXAPzZy2OZ/6rVZsb48C9wZZzfm49crVqpFaN3Ze7elEH1CjvbRJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuCnTKHu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuCnTKHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C56DC4CEE4;
	Tue, 25 Mar 2025 18:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928598;
	bh=h2EPrM3m7ko2MwwB9dJvYfSUX8PFUB4lfypReRTOEX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RuCnTKHurBslrYCa1kcuswteS1pCsqis1vdz4wk+/PoguLf7TP71COxDOUlzpaLQj
	 rESoBPJsMs/A88B+MhgDfSWZq+ioch+CHvYCCglR/9HiOnZgmg2sZOxYXHLywQ6vyw
	 rZsFn/QnmCfTkVnHA94HNqZkaCuT8i6Eob+uyGmo3BFIvMI5rwdy1hZheF0kllBK0O
	 L8ZCoYClwO4UJ59+3Vk+a4oJHQCe3XC4/fuqoW/5LhC+eCHgGlVglkneY55BZ1HHqf
	 dqLSeDXpQL6x3k8EiDCVgskPlzVrTtASa5TpKXgoi5CycYaOCldY8A40Di7z/f2VtZ
	 0B6QwgV6sSWnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEE4A380CFE7;
	Tue, 25 Mar 2025 18:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: connman@lists.linux.dev
List-Id: <connman.lists.linux.dev>
List-Subscribe: <mailto:connman+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:connman+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wispr: Do not pass a negative error status to 'strerror'.
From: patchwork-bot+connman@kernel.org
Message-Id: 
 <174292863452.683880.998586110354786872.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 18:50:34 +0000
References: <049cfab18dd9dd33a8bedcc5766f16ffca27b87d.1742927708.git.gerickson@nuovations.com>
In-Reply-To: <049cfab18dd9dd33a8bedcc5766f16ffca27b87d.1742927708.git.gerickson@nuovations.com>
To: Grant Erickson <gerickson@nuovations.com>
Cc: connman@lists.linux.dev

Hello:

This patch was applied to connman.git (master)
by Denis Kenzior <denkenz@gmail.com>:

On Tue, 25 Mar 2025 11:38:51 -0700 you wrote:
> Fixes: 52546061c590 ("wispr: Refactor 'wispr_portal_web_result' to leverage 'GError'.")
> ---
>  src/wispr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - wispr: Do not pass a negative error status to 'strerror'.
    https://git.kernel.org/pub/scm/network/connman/connman.git/?id=4e1c4469b107

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


